# Spam Classifier on AWS (minimal, beginner version)

Streamlit (front end) → FastAPI (API) → S3 (back end storage), all on **one small EC2 server**.
Everything is done with the AWS CLI in the VS Code terminal.

```
 Your browser ──► [ EC2 server ]
                   ├─ Streamlit  (port 8501)  front end
                   └─ FastAPI    (port 8000)  API  ──► S3 bucket (model + data)
 Your laptop ──(AWS CLI upload)──────────────────────► S3 bucket
```

| Piece | What it is | Why |
|---|---|---|
| Front end | Streamlit | Simple UI, pure Python |
| API | FastAPI | Receives text, runs preprocessing + model, returns spam/ham |
| Back end | S3 bucket + EC2 server | S3 stores code/model/data; EC2 runs the apps |
| Permissions | IAM role on the server | Server can read S3 without any keys stored on it |

## Project structure

```
spam-nlp-aws/
├── README.md
├── requirements.txt
├── spam_nlp_preprocessing.ipynb   # training notebook
├── data/spam_dataset.csv
├── models/                        # tfidf_vectorizer.joblib, naive_bayes_model.joblib
├── api/                           # FastAPI (main.py, preprocess.py)
├── frontend/app.py                # Streamlit
└── aws/                           # trust-policy.json, user-data.sh (server setup script)
```

> If you re-train in the notebook, copy the 2 new `.joblib` files into `models/`.
> `requirements.txt` pins `scikit-learn==1.8.0`. If your notebook used another version, change it to match `pip show scikit-learn`.

---

## 1. Install the AWS CLI

Open VS Code → **Terminal → New Terminal** (this opens PowerShell on Windows, zsh on Mac).

**Windows (PowerShell)**
```powershell
winget install -e --id Amazon.AWSCLI
```
(Or: `msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi`)

**Mac (zsh)**
```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg ./AWSCLIV2.pkg -target /
```
(Or with Homebrew: `brew install awscli`)

**Close the terminal and open a new one**, then check:
```bash
aws --version
```

---

## 2. Create the virtual environment

Python 3.11 or newer is needed.

### Windows (PowerShell): with the security policy fix

PowerShell blocks activation scripts by default. Allow them **for this terminal only** (safest):
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
python -m venv venv
.\venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
```
To allow it permanently for your user instead (so you don't repeat the first line):
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

### Mac (zsh/bash)
```bash
python3 -m venv venv
source venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
```

You should see `(venv)` at the start of the terminal line. In VS Code also pick the interpreter:
`Ctrl/Cmd+Shift+P` → **Python: Select Interpreter** → choose the one inside `venv`.

---

## 3. Test locally first (no AWS yet)

Use two terminals, both with the venv activated, from the project root.

**Terminal 1: API**
```bash
cd api
uvicorn main:app --reload --port 8000
```
Open http://localhost:8000/docs to try the API.

**Terminal 2: UI**
```bash
cd frontend
streamlit run app.py
```
Open http://localhost:8501. Stop both with `Ctrl+C`.

---

## 4. Create the IAM user and run `aws configure`

Do this once in the AWS web console (not with the root account):

1. Console → **IAM → Users → Create user** → name `cli-user`.
2. **Attach policies directly**: `AmazonEC2FullAccess`, `AmazonS3FullAccess`, `IAMFullAccess`.
   (For a learning account, `AdministratorAccess` also works. Delete this user's keys when finished.)
3. Open the user → **Security credentials → Create access key → Command Line Interface (CLI)**.
4. Copy the **Access key ID** and **Secret access key** (the secret is shown only once).

Now in the terminal:
```bash
aws configure
```
```
AWS Access Key ID [None]:      <paste access key id>
AWS Secret Access Key [None]:  <paste secret key>
Default region name [None]:    us-east-1
Default output format [None]:  json
```
Then:
```bash
aws configure set cli_pager ""
aws sts get-caller-identity
```
The last command should print your account ID. If it does, you are connected.

> Never put the keys in code, GitHub, or screenshots.

---

## 5. Deploy to AWS

Run these **from the project root** (the folder that contains `README.md`), with the venv active.
Order matters. All commands are single-line, so they work in both PowerShell and Mac/Linux, except Step 0.

### Step 0: Set the bucket name (shell-specific, do it in the same terminal for all steps)

**Windows (PowerShell)**
```powershell
$BUCKET = "spam-nlp-$(aws sts get-caller-identity --query Account --output text)"
$BUCKET
```
**Mac (zsh/bash)**
```bash
BUCKET="spam-nlp-$(aws sts get-caller-identity --query Account --output text)"
echo $BUCKET
```
If you open a new terminal later, run Step 0 again. Do not rename the bucket: the server script builds the same name itself.

### Step 1: Create the S3 bucket and upload everything
```bash
aws s3 mb s3://$BUCKET
aws s3 cp models s3://$BUCKET/models --recursive
aws s3 cp data s3://$BUCKET/data --recursive
aws s3 cp api s3://$BUCKET/app/api --recursive --exclude "__pycache__/*"
aws s3 cp frontend s3://$BUCKET/app/frontend --recursive --exclude "__pycache__/*"
aws s3 cp requirements.txt s3://$BUCKET/app/requirements.txt
aws s3 ls s3://$BUCKET --recursive
```
The last command lists what was uploaded (you should see `models/`, `data/`, `app/`).

### Step 2: Create the IAM role (lets the server read S3)
```bash
aws iam create-role --role-name spam-nlp-ec2-role --assume-role-policy-document file://aws/trust-policy.json
aws iam attach-role-policy --role-name spam-nlp-ec2-role --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
aws iam create-instance-profile --instance-profile-name spam-nlp-profile
aws iam add-role-to-instance-profile --instance-profile-name spam-nlp-profile --role-name spam-nlp-ec2-role
```
Wait about 15 seconds so AWS finishes creating the role.

### Step 3: Create the firewall (security group)
```bash
aws ec2 create-security-group --group-name spam-nlp-sg --description "spam nlp app"
aws ec2 authorize-security-group-ingress --group-name spam-nlp-sg --protocol tcp --port 8501 --cidr 0.0.0.0/0
```
Port 8501 (Streamlit) is open to the internet. Port 8000 (FastAPI) stays **closed**: Streamlit talks to it inside the server.

*Optional, to see the FastAPI docs page:* find your IP at https://checkip.amazonaws.com, then
```bash
aws ec2 authorize-security-group-ingress --group-name spam-nlp-sg --protocol tcp --port 8000 --cidr YOUR_IP/32
```

### Step 4: Launch the server
```bash
aws ec2 run-instances --image-id resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64 --instance-type t3.micro --iam-instance-profile Name=spam-nlp-profile --security-groups spam-nlp-sg --user-data file://aws/user-data.sh --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=spam-nlp-server}]" --count 1
```
This starts a small Amazon Linux server. On first boot, `aws/user-data.sh` installs Python, downloads your code from S3, installs the packages and starts FastAPI + Streamlit automatically.

> **Windows tip:** `aws/user-data.sh` must use **LF** line endings. Open it in VS Code, look at the bottom-right: if it says `CRLF`, click it and choose `LF`, save, then continue.

### Step 5: Open the app

Get the public IP:
```bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=spam-nlp-server" "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].PublicIpAddress" --output text
```
Wait **4 to 6 minutes** (the server is installing packages), then open:

```
http://<PUBLIC_IP>:8501
```
Use `http`, not `https`. If the page says it cannot reach the API, wait another minute and retry.

Check progress or errors any time (first command gives the instance ID, then paste it into the second):
```bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=spam-nlp-server" --query "Reservations[].Instances[].InstanceId" --output text
aws ec2 get-console-output --instance-id i-xxxxxxxx --latest --output text
```
Look for the line `DEPLOY FINISHED` near the end.

### Updating the code later
Edit files, re-run the `aws s3 cp` lines from Step 1, then delete the server (Cleanup, first command) and re-run Step 4. The IP will change.

---

## 6. Troubleshooting

| Problem | Fix |
|---|---|
| `Invalid IAM Instance Profile name` in Step 4 | Wait 15-30 seconds after Step 2 and run Step 4 again |
| `VPCIdNotSpecified` / no default VPC | Your account has no default VPC: in the console open **VPC → Actions → Create default VPC**, then retry Step 3 |
| `BucketAlreadyExists` | Someone has this name; unlikely because it includes your account ID. Check `$BUCKET` is set (Step 0) |
| Page does not open | Wait 6 minutes; check you used `http://IP:8501`; check Step 3 ran; check console output for errors |
| `DEPLOY FINISHED` never appears and `bad interpreter` errors | CRLF line endings in `user-data.sh` (see the Windows tip) |
| `Unable to locate credentials` | Run `aws configure` again |
| PowerShell: `running scripts is disabled` | Run the `Set-ExecutionPolicy` line in section 2 |

---

## 7. CLEANUP: delete everything that costs money

Run when you are done. **A running server is charged by the hour**, so do not skip this. (Run Step 0 first if this is a new terminal.)

```bash
aws ec2 terminate-instances --instance-ids $(aws ec2 describe-instances --filters "Name=tag:Name,Values=spam-nlp-server" "Name=instance-state-name,Values=pending,running,stopped,stopping" --query "Reservations[].Instances[].InstanceId" --output text)
aws ec2 wait instance-terminated --filters "Name=tag:Name,Values=spam-nlp-server"
aws ec2 delete-security-group --group-name spam-nlp-sg
aws s3 rb s3://$BUCKET --force
aws iam remove-role-from-instance-profile --instance-profile-name spam-nlp-profile --role-name spam-nlp-ec2-role
aws iam delete-instance-profile --instance-profile-name spam-nlp-profile
aws iam detach-role-policy --role-name spam-nlp-ec2-role --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
aws iam delete-role --role-name spam-nlp-ec2-role
```

Verify nothing is left (both should show no running instance and no `spam-nlp` bucket):
```bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=spam-nlp-server" "Name=instance-state-name,Values=pending,running,stopped" --query "Reservations[].Instances[].InstanceId" --output text
aws s3 ls
```

Finally, remove the access keys (console → **IAM → Users → cli-user → Security credentials → Delete access key**), or delete the user. Then clear them from your laptop:
```bash
aws configure set aws_access_key_id ""
aws configure set aws_secret_access_key ""
```

Tip: in the console open **Billing → Budgets** and create a small budget (for example $5) so AWS emails you if something is left running. Also check **EC2 → Instances** in the region you used to confirm it is empty.

## What costs money (this setup)
- EC2 `t3.micro` server: billed per hour while it exists (a few cents per day; check current pricing for your region and free-tier credits).
- Public IPv4 address on the server: small hourly charge.
- 8 GB disk attached to the server: removed when the server is terminated.
- S3: a few KB stored, effectively free, but deleted in cleanup anyway.
- IAM roles/users and security groups are free.

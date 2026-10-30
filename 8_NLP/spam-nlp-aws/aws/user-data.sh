#!/bin/bash
# Runs ONCE as root when the EC2 server first boots. Log: /var/log/user-data.log
exec > >(tee -a /var/log/user-data.log) 2>&1
set -x

# 1. Find our region and bucket name
TOKEN=$(curl -sX PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 300")
export AWS_DEFAULT_REGION=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/region)
ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
BUCKET="spam-nlp-$ACCOUNT"

# 2. Small server (1 GB RAM) -> add 1 GB swap so pip does not run out of memory
fallocate -l 1G /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile

# 3. Install Python 3.11 and download our code from S3
dnf install -y python3.11 python3.11-pip
mkdir -p /opt/app
aws s3 sync "s3://$BUCKET/app" /opt/app
cd /opt/app
python3.11 -m venv venv
./venv/bin/pip install --no-cache-dir -r requirements.txt
chown -R ec2-user:ec2-user /opt/app

# 4. Run FastAPI (port 8000) and Streamlit (port 8501) as services that restart on reboot
cat > /etc/systemd/system/spam-api.service << UNIT
[Unit]
Description=Spam FastAPI
After=network-online.target

[Service]
User=ec2-user
WorkingDirectory=/opt/app/api
Environment=BUCKET=$BUCKET
Environment=AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
ExecStart=/opt/app/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
UNIT

cat > /etc/systemd/system/spam-ui.service << UNIT
[Unit]
Description=Spam Streamlit UI
After=spam-api.service

[Service]
User=ec2-user
WorkingDirectory=/opt/app/frontend
Environment=API_URL=http://localhost:8000
ExecStart=/opt/app/venv/bin/streamlit run app.py --server.port 8501 --server.address 0.0.0.0 --server.headless true --browser.gatherUsageStats false
Restart=always

[Install]
WantedBy=multi-user.target
UNIT

systemctl daemon-reload
systemctl enable --now spam-api spam-ui
echo "DEPLOY FINISHED"

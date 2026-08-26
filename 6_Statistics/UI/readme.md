# 1. Create the virtual environment in project root
python3 -m venv venv

# 2. Activate the virtual environment
source venv/bin/activate

# 3. Upgrade pip and install requirements
pip install --upgrade pip
pip install -r 6_Statistics/UI/"requirements(1).txt" langchain-core langchain-community

# 4. Navigate into the UI folder and launch the app
cd 6_Statistics/UI
streamlit run app.py

--------
## Windows 

# 1. Bypass PowerShell script policy (if blocked)
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

# 2. Create the virtual environment
python -m venv venv

# 3. Activate the virtual environment
.\venv\Scripts\Activate.ps1

# 4. Upgrade pip and install requirements
python -m pip install --upgrade pip
pip install -r 6_Statistics/UI/"requirements(1).txt" langchain-core langchain-community

# 5. Navigate into the UI folder and launch the app
cd 6_Statistics\UI
streamlit run app.py
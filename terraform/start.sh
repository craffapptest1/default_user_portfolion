#!/bin/bash
set -e

echo "Current working directory is: $(pwd)"
pwd

# Navigate to the parent directory of the script
cd "$(dirname "$0")/.."
echo "Current working directory is: $(pwd)"
pwd

# Activate the virtual environment
source venv/bin/activate

echo "Current working directory is: $(pwd)"
pwd

# Upgrade pip and install dependencies
pip3 install --upgrade pip
pip3 install fastapi uvicorn

echo "Current working directory before installation: $(pwd)"
pwd

pip3 install -r ./backend/requirements.txt

echo "Current working directory after installation: $(pwd)"
echo "ls after installation: $(ls)"

cd backend
echo "ls after cd to the backend: $(ls)"

echo "Current working directory before running: $(pwd)"
pwd

# Set Python path
export PYTHONPATH="${PYTHONPATH}:$(pwd)"

# Start the FastAPI server
python -m uvicorn main:app --host 0.0.0.0 --port 8080

#!/bin/bash
set -e
echo "Current working directory is: $(pwd)"
pwd
cd "$(dirname "$0")/.."
echo "Current working directory is: $(pwd)"
pwd
# Activate the virtual environment
source /app/venv/bin/activate
echo "Current working directory is: $(pwd)"
pwd
# Upgrade pip and install dependencies
pip3 install --upgrade pip
pip3 install fastapi uvicorn
echo "Current working directory is boefore installtion: $(pwd)"
pwd
pip3 install -r ./backend/requirements.txt
echo "Current working directory is after installion: $(pwd)"
pwd
cd app/backend
echo "Current working directory is beofore running: $(pwd)"
pwd
uvicorn main:app --host 0.0.0.0 --port 8080

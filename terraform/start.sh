#!/bin/bash
set -e

cd "$(dirname "$0")/.."

# Activate the virtual environment
source /app/venv/bin/activate

# Upgrade pip and install dependencies
pip3 install --upgrade pip
pip3 install fastapi uvicorn
pip3 install -r ./backend/requirements.txt
cd app/backend
uvicorn main:app --host 0.0.0.0 --port 8080

#!/bin/bash
set -e

echo "=== FastAPI Debug Script ==="
echo "Current directory: $(pwd)"

# Navigate to the app directory
cd /app

# Activate virtual environment
source venv/bin/activate

# Check Python version
echo "Python version: $(python --version)"

# Check if main.py exists and its structure
echo "=== Checking main.py ==="
if [ -f "backend/main.py" ]; then
    echo "main.py exists"
    echo "First 20 lines of main.py:"
    head -20 backend/main.py
else
    echo "ERROR: main.py not found in backend directory"
    exit 1
fi

# Check for FastAPI app object
echo "=== Checking for FastAPI app object ==="
cd backend
python -c "
try:
    import main
    print('main.py imports successfully')
    if hasattr(main, 'app'):
        print('app object found in main.py')
        print(f'App type: {type(main.app)}')
    else:
        print('ERROR: No app object found in main.py')
except Exception as e:
    print(f'ERROR importing main.py: {e}')
    import traceback
    traceback.print_exc()
"

# Check dependencies
echo "=== Checking key dependencies ==="
python -c "
import sys
try:
    import fastapi
    print(f'FastAPI version: {fastapi.__version__}')
except ImportError as e:
    print(f'ERROR: FastAPI not installed: {e}')

try:
    import uvicorn
    print(f'Uvicorn version: {uvicorn.__version__}')
except ImportError as e:
    print(f'ERROR: Uvicorn not installed: {e}')
"

# Try to start the server with more verbose output
echo "=== Attempting to start server with debug info ==="
export PYTHONPATH="${PYTHONPATH}:$(pwd)"
python -c "
import sys
sys.path.insert(0, '.')
try:
    from main import app
    print('Successfully imported app from main')
    print(f'App object: {app}')
except Exception as e:
    print(f'Failed to import app: {e}')
    import traceback
    traceback.print_exc()
"

echo "=== Trying uvicorn with verbose logging ==="
python -m uvicorn main:app --host 0.0.0.0 --port 8080 --log-level debug --reload

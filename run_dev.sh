#!/bin/bash


# Vai nella directory del progetto
cd ~/Scrivania/mediacms/mediacms || exit

# Attiva il virtualenv
source ../venv/bin/activate

# Lancia Django in background
echo "🔵 Avvio Django..."
# Check if any process is listening on port 8000
pids=$(lsof -ti :8000)

if [ -n "$pids" ]; then
    echo "Port 8000 is in use by the following processes: $pids"

    # Kill all processes using port 8000
    echo "Killing processes with PIDs: $pids"
    kill -9 $pids

    echo "Processes killed."
else
    echo "Port 8000 is not in use."
fi

# Start Django server
python3 manage.py runserver &

#-------

# Lancia Celery
echo "🟢 Avvio Celery..."
celery -A cms worker --loglevel=info

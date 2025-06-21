#!/bin/bash

#server-stats.sh
#This script gathers and displays server performance stats

#Funnction for Total CPU usage
cpu_usage() {
    echo "=== CPU Usage ==="
    # Use top in batch mode, match the Cpu line, then show user/system/idle
    top -bn1 \
      | grep "Cpu(s)" \
      | awk '{printf "User: %s%%, System: %s%%, Idle: %s%%\n", $2, $4, $8}'
}

# Function for Memory usage
memory_usage() {
    echo "=== Memory Usage (MB) ==="
    # Use free -m for simplicity; print used and total
    free -m \
      | awk 'NR==2 { printf "Used: %sMB / %sMB (%.1f%%)\n", $3, $2, $3/$2*100 }'
}

echo "Starting performance stats collection"
cpu_usage
memory_usage
echo "Collection Complete"

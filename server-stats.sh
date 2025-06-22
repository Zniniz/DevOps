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
    echo "=== Memory Usage ==="
    # Use free -m for simplicity; print used and total
    #Gives All the memory usage, by Mem and by Sawp
    # Only getting the memory row
    #Printf for formatting, .2f for 2 digits after the comma, %% Adding percentage sign, $COLUMN

    free -m \
	    | grep Mem \
	    | awk '{printf "%.2f%% Free memory utilized\n",($4/$2)*100}'
    free -m \
	    | grep Mem \
	    | awk '{printf "%.2f%% Used memory utilized\n",($3/$2)*100}'
}

echo "Starting performance stats collection"
cpu_usage
memory_usage
echo "Collection Complete"

#!/bin/bash

#server-stats.sh
#This script gathers and displays server performance stats

# awk - input read line by line, each line is split into a field

# $NF - number of field

#Funnction for Total CPU usage
cpu_usage() {
    echo ""
    echo "=== CPU Usage ==="
    echo ""
    # Install sysstat if not already, $NF takes the last percentage which is the idle (% of CPU not being used)
    mpstat | awk '/all/ {print 100 - $NF "% used"}'
    echo ""
    echo "###########################################################"

}

# Function for Memory usage
memory_usage() {
    echo ""
    echo "=== Memory Usage ==="
    # Use free -m for simplicity; print used and total
    #Gives All the memory usage, by Mem and by Sawp
    # Only getting the memory row
    #Printf for formatting, .2f for 2 digits after the comma, %% Adding percentage sign, $COLUMN
    echo ""
    free -m \
	    | grep Mem \
	    | awk '{printf "%.2f%% Free memory utilized\n",($4/$2)*100}'
    free -m \
	    | grep Mem \
	    | awk '{printf "%.2f%% Used memory utilized\n",($3/$2)*100}'
    echo ""
    echo "###########################################################"
}

# Function for Disk usage
disk_usage() {
    echo ""
    echo "=== Disk Usage ==="
    echo ""
    df -h | awk '$NF=="/"{printf "Total: %s\nUsed: %s\nFree: %s\nUsage: %s\n", $2,$3,$4,$5}'
    echo ""
    echo "###########################################################"  
}

# Function for top 5 CPU usage
top5_cpu() {
    echo ""
    echo "=== Top 5 CPU Usage ==="
    # ps - process status, -A ou -e - select all process currently running, -o - specify which column to print
    # pid - Process ID, ppid - Parent pid, cmd - command/name used to launch the process
    echo ""
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
    echo ""
    echo "###########################################################"
}
# Function for top 5 Memory usage
top5_memory() {
    echo ""	
    echo "=== Top 5 Memory Usage ==="
    echo ""
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6
    echo ""
    echo "###########################################################"
}

# Function for os version
os_version() {
   echo ""
   echo "=== OS Version ==="
   echo ""
   uname -a
   echo ""
   echo "###########################################################"

}

# Function for uptime
uptime_load() {
   echo ""
   echo "=== Uptime ==="
   echo ""
   uptime -p
   echo ""
   echo "###########################################################"

}
# Function for logged in attempts
logged_in() {
   echo ""
   echo "=== Logged in Users: ==="
   echo ""
   who
   echo ""
   echo "###########################################################"

}

# Function for failed logins
failed_logins() {
   echo ""
   echo "=== Failed logins ==="
   echo ""
   if [ -x "$(command -v lastb)" ]; then
     sudo lastb | head -10
   else
     echo "Command 'lastb' not found or not executable."
   fi
   echo ""
   echo "###########################################################"

}



echo ""
echo "Starting performance stats collection..."
echo ""
cpu_usage
memory_usage
disk_usage
top5_cpu
top5_memory
os_version
uptime_load
logged_in
failed_logins
echo ""
echo "Collection Complete..."
echo ""

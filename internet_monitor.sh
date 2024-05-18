#!/bin/bash

LOG_FILE=/home/gkns/internet_monitor/downtime.log
#LOG_FILE=~/Desktop/downtime.log

log() {
    local message=$1
    local timestamp=$(date +"%d-%b-%Y  %H:%M:%S")
    local log_message="[$timestamp] - $message"
    echo $log_message
    echo $log_message >> "$LOG_FILE"
}

check_connectivity() {
    if ping -c1 ping.funet.fi &> /dev/null; then
        return 0
    elif ping -c1 google.com &> /dev/null; then
        return 0
    elif ping -c1 facebook.com &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Variables to track downtime
downtime_start=""
downtime_in_progress=false

log "------------------START/RESTART------------------"
while true; do
    if ! check_connectivity; then
        if [ "$downtime_in_progress" = false ]; then
            downtime_start=$(date +'%s')
            log "Internet is DOWN."
            downtime_in_progress=true
        fi
    else
        if [ "$downtime_in_progress" = true ]; then
            downtime_end=$(date +'%s')
            downtime_duration=$(( downtime_end - downtime_start ))
            log "Connectivity is restored. Downtime was for $downtime_duration seconds"
            downtime_in_progress=false
        fi
    fi

    sleep 5
done
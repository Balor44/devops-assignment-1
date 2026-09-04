#!/bin/bash

LOG_FILE="$(dirname "$0")/logs/toolkit.log"
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}


threshold="$1"
path="${2:-/}"   # if no second argument given, default to "/"

# Check that threshold was actually given, and is a whole number 1-100
if [[ -z "$threshold" ]] || ! [[ "$threshold" =~ ^[0-9]+$ ]] || (( threshold < 1 || threshold > 100 )); then
    log "Error: Invalid threshold input provided"
    echo "Error: threshold must be a whole number between 1 and 100" >&2
    exit 2
fi

# Get disk usage percentage for the given path
usage=$(df -P "$path" | awk 'NR==2 {print $5}' | tr -d '%')
log "Checked disk usage for path $path: ${usage}% (threshold: ${threshold}%)"
echo "Disk usage for $path: ${usage}%"

if (( usage >= threshold )); then
    log "WARNING: Disk usage has reached or exceeded the threshold for $path."
    echo "WARNING: usage has reached or exceeded the threshold (${threshold}%)"
    exit 1
else
    log "OK: Disk usage is safe for $path."
    echo "OK: usage is below the threshold (${threshold}%)"
    exit 0
fi
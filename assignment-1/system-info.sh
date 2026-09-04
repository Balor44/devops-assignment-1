#!/bin/bash

LOG_FILE="$(dirname "$0")/logs/toolkit.log"
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "System information check executed by $(whoami) on $(hostname)"
echo "=== System Information ==="
echo "Hostname: $(hostname)"
echo "Current user: $(whoami)"
echo "Date/time: $(date)"
echo "Operating system: $(uname -o)"
echo "Kernel version: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "Current directory: $(pwd)"

echo ""
echo "--- CPU Info ---"
lscpu | grep -E "Model name|CPU\(s\):"

echo ""
echo "--- Memory Info ---"
free -h
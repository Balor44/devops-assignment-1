#!/bin/bash

threshold="$1"
path="${2:-/}"   # if no second argument given, default to "/"

# Check that threshold was actually given, and is a whole number 1-100
if [[ -z "$threshold" ]] || ! [[ "$threshold" =~ ^[0-9]+$ ]] || (( threshold < 1 || threshold > 100 )); then
    echo "Error: threshold must be a whole number between 1 and 100" >&2
    exit 2
fi

# Get disk usage percentage for the given path
usage=$(df -P "$path" | awk 'NR==2 {print $5}' | tr -d '%')

echo "Disk usage for $path: ${usage}%"

if (( usage >= threshold )); then
    echo "WARNING: usage has reached or exceeded the threshold (${threshold}%)"
    exit 1
else
    echo "OK: usage is below the threshold (${threshold}%)"
    exit 0
fi
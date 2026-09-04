#!/bin/bash


host="$1"
port="$2"


if [[ -z "$host" ]]; then
    echo "Error: you must supply a hostname or IP address" >&2
    exit 2
fi


echo "=== Network Check for $host ==="


# Resolve the hostname to an IP
resolved=$(getent hosts "$host" | awk '{print $1}')
if [[ -z "$resolved" ]]; then
    echo "Could not resolve $host" >&2
    exit 1
fi
echo "Resolved address: $resolved"


# Basic connectivity check (one ping, 2 second timeout)
if ping -c 1 -W 2 "$host" > /dev/null 2>&1; then
    echo "Ping: reachable"
else
    echo "Ping: unreachable"
fi


echo ""
echo "--- Network Interfaces ---"
ip addr show


# Optional port check
if [[ -n "$port" ]]; then
    if ! [[ "$port" =~ ^[0-9]+$ ]] || (( port < 1 || port > 65535 )); then
        echo "Error: port must be a number between 1 and 65535" >&2
        exit 2
    fi
    if timeout 2 bash -c "echo > /dev/tcp/$host/$port" 2>/dev/null; then
        echo "Port $port: open"
    else
        echo "Port $port: closed or unreachable"
    fi
fi


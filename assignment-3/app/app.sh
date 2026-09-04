#!/bin/bash
show_help() { echo "Usage: app.sh {system-info|check-host <host>|check-port <host> <port>|help}"; }


system_info() {
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
}


check_host() {
    local host="$1"
    [[ -z "$host" ]] && { echo "Error: host required" >&2; exit 2; }
    getent hosts "$host" || { echo "Could not resolve $host" >&2; exit 1; }
}


check_port() {
    local host="$1" port="$2"
    [[ -z "$host" || -z "$port" ]] && { echo "Error: host and port required" >&2; exit 2; }
    [[ "$port" =~ ^[0-9]+$ ]] && ((port >= 1 && port <= 65535)) || { echo "Error: invalid port" >&2; exit 2; }
    timeout 2 bash -c "echo > /dev/tcp/$host/$port" 2>/dev/null && echo "Port $port open" || echo "Port $port closed"
}


case "$1" in
    system-info) system_info ;;
    check-host) shift; check_host "$@" ;;
    check-port) shift; check_port "$@" ;;
    help|"") show_help ;;
    *) echo "Unknown command: $1" >&2; show_help; exit 2 ;;
es-ac

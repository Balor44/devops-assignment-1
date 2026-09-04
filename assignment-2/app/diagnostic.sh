#!/bin/bash


show_help() {
  echo "Usage: diagnostic {system|network <host>|disk|help}"
}


show_system() {
  echo "Hostname: $(hostname)"
  echo "Uptime: $(uptime -p)"
  free -h
}


show_disk() {
  df -h
}


check_network() {
  local host="$1"
  if [[ -z "$host" ]]; then
    echo "Error: host required" >&2
    exit 2
  fi
  ping -c 1 -W 2 "$host" && echo "Reachable" || echo "Unreachable"
}


case "$1" in
  system) show_system ;;
  disk) show_disk ;;
  network) shift; check_network "$@" ;;
  help) show_help; exit 0 ;;
  "") show_help; exit 2 ;;
  *) echo "Unknown command: $1" >&2; show_help; exit 2 ;;
esac


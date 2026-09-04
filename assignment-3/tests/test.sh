#!/bin/bash
pass=0; fail=0
check() {
  local desc="$1"
  local expected="$2"
  shift 2
  "$@" > /dev/null 2>&1
  local actual=$?
  if [[ "$actual" == "$expected" ]]; then
    echo "PASS: $desc"
    ((pass++))
  else
    echo "FAIL: $desc (expected $expected, got $actual)"
    ((fail++))
  fi
}


check "help" 0 ./app/app.sh help
check "system-info" 0 ./app/app.sh system-info
check "invalid command" 2 ./app/app.sh bogus
check "check-host missing host" 2 ./app/app.sh check-host
check "check-host valid" 0 ./app/app.sh check-host google.com
check "check-port missing port" 2 ./app/app.sh check-port google.com
check "check-port non-numeric" 2 ./app/app.sh check-port google.com abc
check "check-port out of range" 2 ./app/app.sh check-port google.com 99999
echo "Results: $pass passed, $fail failed"
[[ $fail -eq 0 ]]


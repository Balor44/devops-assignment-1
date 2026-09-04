#!/bin/bash
pass=0
fail=0


check() {
  local desc="$1"
  local expected_exit="$2"
  shift 2
  "$@" > /dev/null 2>&1
  actual_exit=$?
  if [[ "$actual_exit" == "$expected_exit" ]]; then
    echo "PASS: $desc"
    ((pass++))
  else
    echo "FAIL: $desc (expected exit $expected_exit, got $actual_exit)"
    ((fail++))
  fi
}


check "help command" 0 docker run --rm diagnostic-tool help
check "system command" 0 docker run --rm diagnostic-tool system
check "disk command" 0 docker run --rm diagnostic-tool disk
check "invalid command fails" 2 docker run --rm diagnostic-tool bogus


echo ""
echo "Results: $pass passed, $fail failed"
[[ $fail -eq 0 ]]


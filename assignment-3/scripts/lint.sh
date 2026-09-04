#!/bin/bash
set -e
echo "Checking required files exist..."
for f in app/app.sh scripts/lint.sh scripts/build.sh tests/test.sh Dockerfile; do
  [[ -f "$f" ]] || { echo "Missing: $f" >&2; exit 1; }
done
echo "Checking Bash syntax..."
for f in app/*.sh scripts/*.sh tests/*.sh; do
  bash -n "$f" || { echo "Syntax error in $f" >&2; exit 1; }
done
echo "Lint passed."


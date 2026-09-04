#!/bin/bash
set -e


docker build -t devops-tool .
docker run --rm devops-tool help
docker run --rm devops-tool system-info


# Temporarily disable set -e to check for the expected error exit code
set +e
docker run --rm devops-tool bogus
exit_code=$?
set -e


if [ $exit_code -eq 0 ]; then
    echo "Error: Expected failure on invalid command, but got exit code 0" >&2
    exit 1
fi


echo "Build and smoke tests passed."


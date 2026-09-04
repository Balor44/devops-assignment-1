#!/bin/bash
set -e
docker build -t devops-tool .
docker run --rm devops-tool help
docker run --rm devops-tool system-info
docker run --rm devops-tool bogus; [[ $? -ne 0 ]] || { echo "Expected failure on invalid command"; exit 1; }
echo "Build and smoke tests passed."


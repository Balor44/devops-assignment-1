# Assignment 2: Containerized Linux Diagnostic Tool


## Overview
This project packages Bash diagnostic scripts and a mini command router into a lightweight Alpine Linux container so that it runs consistently across any machine using Docker.


## Project Structure
- app/diagnostic.sh: Mini command router handling routing for system info, disk usage, network checks, and help.
- app/health-check.sh: A basic health-check script verifying CLI functionality.
- Dockerfile: Recipe for building the Alpine-based container image with core utilities.
- compose.yaml: Docker Compose configuration for simplified local execution.
- test.sh: Automated test script verifying expected exit codes and outputs.


## How to Run
1. Build the Docker image:
   docker build -t diagnostic-tool .


2. Run commands via Docker:
   docker run --rm diagnostic-tool system
   docker run --rm diagnostic-tool disk
   docker run --rm diagnostic-tool help


3. Run automated tests:
   ./test.sh


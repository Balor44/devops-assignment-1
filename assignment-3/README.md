# Assignment 3: Containerized Diagnostic Tool with CI/CD Pipeline


## Overview
This project expands on the containerized diagnostic tool by adding automated code linting, automated testing suites, container build verification, and a continuous integration (CI) pipeline using GitHub Actions.


## Project Structure
- assignment-3/app/app.sh: Core command router for system info, hostname resolution, and port checks.
- assignment-3/scripts/lint.sh: Static analysis script checking file existence and Bash syntax using bash -n.
- assignment-3/scripts/build.sh: Automated build script handling Docker compilation and smoke tests.
- assignment-3/tests/test.sh: Test suite validating exit codes and command outputs.
- .github/workflows/ci.yml: GitHub Actions workflow file executing the validate, test, and docker pipeline.


## How to Run Locally
1. Make all scripts executable:
   chmod +x assignment-3/scripts/*.sh assignment-3/app/*.sh assignment-3/tests/*.sh


2. Run the linter:
   ./assignment-3/scripts/lint.sh


3. Run the test suite:
   ./assignment-3/tests/test.sh


4. Run the build and smoke tests:
   ./assignment-3/scripts/build.sh


## CI/CD Pipeline
GitHub Actions automatically runs three sequential stages on every push and pull request:
1. Validate: Runs lint.sh to verify syntax and file layout.
2. Test: Runs test.sh to ensure command correctness.
3. Docker: Runs build.sh to compile the container and run smoke tests.


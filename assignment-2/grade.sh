#!/bin/bash
echo "=== Starting Assignment 2 Mock Grader ==="
fail=0


check_pass() { echo "✅ PASS: $1"; }
check_fail() { echo "❌ FAIL: $1"; ((fail++)); }


# 1. Check required files
echo "--- Checking Project Structure ---"
for f in README.md app/diagnostic.sh app/health-check.sh Dockerfile compose.yaml .dockerignore test.sh; do
  [[ -f "$f" ]] && check_pass "$f exists" || check_fail "$f is missing"
done


# 2. Check executable permissions
echo "--- Checking Permissions ---"
for script in app/diagnostic.sh app/health-check.sh test.sh; do
  [[ -x "$script" ]] && check_pass "$script is executable" || check_fail "$script is not executable"
done


# 3. Check Bash syntax
echo "--- Checking Bash Syntax ---"
for script in app/diagnostic.sh app/health-check.sh test.sh; do
  bash -n "$script" 2>/dev/null && check_pass "$script syntax is valid" || check_fail "$script has syntax errors"
done


# 4. Check Docker Build
echo "--- Checking Docker Build ---"
if docker build -t diagnostic-tool . > /dev/null 2>&1; then
  check_pass "Docker image built successfully"
else
  check_fail "Docker image failed to build"
fi


# 5. Check Docker Container Commands
echo "--- Checking Container Commands ---"
docker run --rm diagnostic-tool help > /dev/null 2>&1
[[ $? -eq 0 ]] && check_pass "help command executes successfully" || check_fail "help command failed"


docker run --rm diagnostic-tool system > /dev/null 2>&1
[[ $? -eq 0 ]] && check_pass "system command executes successfully" || check_fail "system command failed"


# 6. Check Invalid Command Handling (Should exit 2)
echo "--- Checking Error Handling ---"
docker run --rm diagnostic-tool bogus_command > /dev/null 2>&1
[[ $? -eq 2 ]] && check_pass "Invalid command exits with code 2" || check_fail "Invalid command did not return exit code 2"


# 7. Check Docker Compose Configuration
echo "--- Checking Docker Compose ---"
if docker compose run --rm diagnostic help > /dev/null 2>&1; then
  check_pass "Docker Compose runs successfully"
else
  check_fail "Docker Compose execution failed"
fi


# 8. Check Student Test Suite
echo "--- Checking Student test.sh ---"
if ./test.sh > /dev/null 2>&1; then
  check_pass "Student test suite (test.sh) passed"
else
  check_fail "Student test suite (test.sh) failed"
fi


# 9. Basic Git History
echo "--- Checking Git History ---"
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  commit_count=$(git rev-list --count HEAD 2>/dev/null || echo 0)
  if (( commit_count >= 5 )); then
    check_pass "Git history has 5 or more commits ($commit_count)"
  else
    check_fail "Git history has fewer than 5 commits ($commit_count)"
  fi
else
  check_fail "Not a git repository"
fi


echo ""
if [[ $fail -eq 0 ]]; then
  echo "🎉 All mock checks passed! (Note: Instructor may run additional manual tests)"
else
  echo "⚠️  $fail check(s) failed. Review the output above."
fi
exit $fail


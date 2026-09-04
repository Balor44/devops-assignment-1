#!/bin/bash
echo "=== Starting Assignment 1 Mock Grader ==="
fail=0


check_pass() { echo "✅ PASS: $1"; }
check_fail() { echo "❌ FAIL: $1"; ((fail++)); }


# 1. Check required files
echo "--- Checking Files ---"
for f in system-info.sh disk-check.sh network-check.sh README.md logs/.gitkeep; do
  [[ -f "$f" ]] && check_pass "$f exists" || check_fail "$f is missing"
done


# 2. Check executable permissions
echo "--- Checking Permissions ---"
for script in system-info.sh disk-check.sh network-check.sh; do
  [[ -x "$script" ]] && check_pass "$script is executable" || check_fail "$script is not executable"
done


# 3. Check Bash syntax
echo "--- Checking Syntax ---"
for script in system-info.sh disk-check.sh network-check.sh; do
  bash -n "$script" 2>/dev/null && check_pass "$script syntax is valid" || check_fail "$script has syntax errors"
done


# 4. Check Disk Argument Validation (Exit code 2 for invalid)
echo "--- Checking Disk Validation ---"
./disk-check.sh abc > /dev/null 2>&1
[[ $? -eq 2 ]] && check_pass "disk-check.sh handles invalid input (exit 2)" || check_fail "disk-check.sh fails to catch invalid input"


# 5. Check Network Validation (Exit code 2 for invalid/missing)
echo "--- Checking Network Validation ---"
./network-check.sh > /dev/null 2>&1
[[ $? -eq 2 ]] && check_pass "network-check.sh handles missing host (exit 2)" || check_fail "network-check.sh fails to catch missing host"


# 6. Basic Git History (Checks for at least 5 commits)
echo "--- Checking Git History ---"
if [[ -d ".git" ]]; then
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


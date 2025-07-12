# Lab 7: GitOps Fundamentals Lab

### Task 1: Git State Reconciliation

**Scripts and commands:**

# 1. Verify the script is executable
ls -l reconcile.sh
# Output:
# -rwxrwxrwx 1 anntorkot anntorkot 211 Jul 12 12:44 reconcile.sh

# 2. Run reconciliation with no drift (no output expected)
./reconcile.sh

# 3. Simulate drift and run reconciliation again
echo "version: 2.0" > current-state.txt
./reconcile.sh
# Sample output:
# Sat Jul 12 12:47:47 MSK 2025 - DRIFT DETECTED! Reconciling..

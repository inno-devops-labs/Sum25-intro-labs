# **GitOps Fundamentals Lab**

---

## **Task 1: Git State Reconciliation**

**Objective**: Simulate how GitOps operators continuously synchronize cluster state with Git

1. **Initialize repository**:

Input:
```bash
mkdir gitops-lab && cd gitops-lab
git init
```
Output:
```bash
Initialized empty Git repository in /home/justsomedude/gitops-lab/.git/
```


2. **Create desired state**:

Input
```bash
echo "version: 1.0" > desired-state.txt
git add . && git commit -m "Initial state"
```
Output
```bash
[master (root-commit) 8f06082] Initial state
 1 file changed, 1 insertion(+)
 create mode 100644 desired-state.txt
```

3. **Simulate live cluster**:

Input:
```bash
cp desired-state.txt current-state.txt
```
Copy succeeded
```bash
justsomedude@DESKTOP-VD06QG9:~/gitops-lab$ ls
current-state.txt  desired-state.txt
```

4. **Create reconciliation script**:
```bash
#!/bin/bash
# reconcile.sh
DESIRED=$(cat desired-state.txt)
CURRENT=$(cat current-state.txt)
   
if [ "$DESIRED" != "$CURRENT" ]; then
echo "$(date) - DRIFT DETECTED! Reconciling..."
cp desired-state.txt current-state.txt
fi
```

Input
```bash
justsomedude@DESKTOP-VD06QG9:~/gitops-lab$ touch reconcile.sh
# Add content via a text editor
justsomedude@DESKTOP-VD06QG9:~/gitops-lab$ cat reconcile.sh
#!/bin/bash
# reconcile.sh
DESIRED=$(cat desired-state.txt)
CURRENT=$(cat current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
echo "$(date) - DRIFT DETECTED! Reconciling..."
cp desired-state.txt current-state.txt
fi
```

5. **Trigger manual drift**:

Input
```bash
echo "version: 2.0" > current-state.txt # Simulate manual cluster change
```
Changes made:
```bash
justsomedude@DESKTOP-VD06QG9:~/gitops-lab$ cat current-state.txt
version: 2.0
```

6. **Run reconciliation**:

Input
```bash
chmod +x reconcile.sh
./reconcile.sh # Should detect and fix drift
```
Ouput
```
Sat Jul 12 21:26:28 MSK 2025 - DRIFT DETECTED! Reconciling...
```

7. **Automate reconciliation**:

Input
```bash
watch -n 5 ./reconcile.sh # Runs every 5 seconds
```

### Example of autoreconciliation:

Every time I make changes, within next 5 seconds the cmd window flashes following:
```
Every 5.0s: ./reconcile.sh                                                     DESKTOP-VD06QG9: Sat Jul 12 21:28:34 2025
Sat Jul 12 21:28:34 MSK 2025 - DRIFT DETECTED! Reconciling...
```
So as long as `watch` is running, it tries to reset back to the desired state.

---

## **Task 2: GitOps Health Monitoring**

**Objective**: Implement health checks for configuration synchronization

1. **Create health check script**:

```bash
#!/bin/bash
# healthcheck.sh
DESIRED_MD5=$(md5sum desired-state.txt | awk '{print $1}')
CURRENT_MD5=$(md5sum current-state.txt | awk '{print $1}')

if [ "$DESIRED_MD5" != "$CURRENT_MD5" ]; then
echo "$(date) - CRITICAL: State mismatch!" >> health.log
else
echo "$(date) - OK: States synchronized" >> health.log
fi
```

Created file manually

2. **Make executable**:

```bash
chmod +x healthcheck.sh
```

Added executable flag

3. **Simulate healthy state**:

Input:
```bash
./healthcheck.sh
cat health.log # Should show "OK"
```
Output
```bash
Sat Jul 12 21:33:18 MSK 2025 - OK: States synchronized
```

4. **Create drift**:

```bash
echo "unapproved change" >> current-state.txt
```

5. **Run health check**:

Input:
```bash
./healthcheck.sh
cat health.log # Now shows "CRITICAL"
```

Output:
```
Sat Jul 12 21:33:18 MSK 2025 - OK: States synchronized
Sat Jul 12 21:34:28 MSK 2025 - CRITICAL: State mismatch!
```

### Additional logs

```bash
justsomedude@DESKTOP-VD06QG9:~/gitops-lab$ cat health.log # Now shows "CRITICAL"
Sat Jul 12 21:33:18 MSK 2025 - OK: States synchronized
Sat Jul 12 21:34:28 MSK 2025 - CRITICAL: State mismatch!
justsomedude@DESKTOP-VD06QG9:~/gitops-lab$ ./reconcile.sh
Sat Jul 12 21:36:07 MSK 2025 - DRIFT DETECTED! Reconciling...
justsomedude@DESKTOP-VD06QG9:~/gitops-lab$ ./healthcheck.sh
justsomedude@DESKTOP-VD06QG9:~/gitops-lab$ cat health.log
Sat Jul 12 21:33:18 MSK 2025 - OK: States synchronized
Sat Jul 12 21:34:28 MSK 2025 - CRITICAL: State mismatch!
Sat Jul 12 21:36:12 MSK 2025 - OK: States synchronized
```

---

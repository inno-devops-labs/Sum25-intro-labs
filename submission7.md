# **GitOps Fundamentals Lab**

This lab teaches core GitOps principles by simulating key workflows using only Linux command-line tools.

---

## **Task 1: Git State Reconciliation**

**Objective**: Simulate how GitOps operators continuously synchronize cluster state with Git

1. **Initialized repository**:

   ```bash
   mkdir gitops-lab && cd gitops-lab
   git init
   ```

2. **Created desired state**:

   ```bash
   echo "version: 1.0" > desired-state.txt
   git add . && git commit -m "Initial state"
   ```

3. **Simulated live cluster**:

   ```bash
   cp desired-state.txt current-state.txt
   ```

4. **Created reconciliation script with name `reconcile.sh`**:

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

5. **Triggered manual drift**:

   ```bash
   echo "version: 2.0" > current-state.txt # Simulate manual cluster change
   ```

6. **Runned reconciliation**:

   ```bash
   chmod +x reconcile.sh
   ./reconcile.sh # Should detect and fix drift
   ```

7. **Automated reconciliation**:

   ```bash
   watch -n 5 ./reconcile.sh # Runs every 5 seconds
   ```

    **Output:**

    ```bash
    Every 5,0s: ./reconcile.sh                                                            gleb: Wed Jul  9 21:31:39 2025

    Ср 09 июл 2025 21:31:39 MSK - DRIFT DETECTED! Reconciling...
    ```

### Explanation
This script mimics a GitOps reconciliation loop by comparing the live system state to the desired Git state. When a mismatch is detected, it automatically restores the correct state.

---

## **Task 2: GitOps Health Monitoring**

**Objective**: Implement health checks for configuration synchronization

1. **Created health check script**:

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

2. **Done executable**:

   ```bash
   chmod +x healthcheck.sh
   ```

3. **Simulated healthy state**:

   ```bash
   ./healthcheck.sh
   cat health.log# Should show "OK"
   ```

   **Output:**
   ```bash
   Ср 09 июл 2025 21:36:00 MSK - OK: States synchronized
   ```

4. **Created drift**:

   ```bash
   echo "unapproved change" >> current-state.txt
   ```

5. **Runned health check**:

   ```bash
   ./healthcheck.sh
   cat health.log# Now shows "CRITICAL"
   ```

   **Output:**
   ```bash
   Ср 09 июл 2025 21:36:00 MSK - OK: States synchronized
   Ср 09 июл 2025 21:37:13 MSK - CRITICAL: State mismatch!
   ```

### Explanation

The script logs whether the current state matches the desired one using `md5sum`. This represents a basic integrity check often implemented in GitOps systems to detect unauthorized or accidental changes.

---

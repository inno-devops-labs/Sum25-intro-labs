# **GitOps Fundamentals Lab - Submission**

## **Task 1: Git State Reconciliation**

### **Implementation and Results**

**Step 1: Initialize repository**
```bash
mkdir gitops-lab && cd gitops-lab
git init
```
**Output:**
```
Initialized empty Git repository in /home/luzinsan/Documents/Sum25-intro-labs/gitops-lab/.git/
```


**Step 2: Create desired state**
```bash
echo "version: 1.0" > desired-state.txt
git add . && git commit -m "Initial state"
```
**Output:**
```
[master (root-commit) 9f9ddc4] Initial state
 1 file changed, 1 insertion(+)
 create mode 100644 desired-state.txt
```

I created the desired state file with version 1.0 and committed it to Git. This represents the declarative configuration that our "cluster" should maintain.

**Step 3: Simulate live cluster**
```bash
cp desired-state.txt current-state.txt
```

**Step 4: Create reconciliation script**

```bash
cat > reconcile.sh << 'EOF'
#!/bin/bash

DESIRED=$(cat desired-state.txt)
CURRENT=$(cat current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
echo "$(date) - DRIFT DETECTED! Reconciling..."
cp desired-state.txt current-state.txt
fi
EOF
```

This script implements the core GitOps reconciliation loop - it compares the desired state with the current state and automatically fixes any drift by copying the desired state over the current state.

**Step 5: Trigger manual drift**
```bash
echo "version: 2.0" > current-state.txt
```

**Analysis:** I simulated manual intervention in the cluster by changing the current state to version 2.0, creating a drift from the desired state (version 1.0).

**Step 6: Run reconciliation**
```bash
chmod +x reconcile.sh
./reconcile.sh
```
**Output:**
```
Sat Jul 12 04:50:41 PM MSK 2025 - DRIFT DETECTED! Reconciling...
```

**Analysis:** Perfect! The reconciliation script detected the drift between desired state (version 1.0) and current state (version 2.0) and automatically corrected it. This demonstrates the self-healing capability of GitOps systems.

**Step 7: Verify reconciliation**
After running the reconciliation script, I verified that the states were synchronized by running it again:
```bash
./reconcile.sh
```
**Output:** (No output - states are synchronized)

**Analysis:** The absence of output confirms that the reconciliation was successful and no drift exists between the desired and current states.

---

## **Task 2: GitOps Health Monitoring**

### **Objective**
Implement health checks for configuration synchronization using MD5 checksums.

### **Implementation and Results**

**Step 1: Create health check script**

```bash
cat > healthcheck.sh << 'EOF'
#!/bin/bash

DESIRED_MD5=$(md5sum desired-state.txt | awk '{print $1}')
CURRENT_MD5=$(md5sum current-state.txt | awk '{print $1}')

if [ "$DESIRED_MD5" != "$CURRENT_MD5" ]; then
echo "$(date) - CRITICAL: State mismatch!" >> health.log
else
echo "$(date) - OK: States synchronized" >> health.log
fi
EOF
```

**Analysis:** This script uses MD5 checksums to compare file contents, which is more reliable than simple text comparison and mimics how real GitOps operators validate state consistency.

**Step 2: Make executable and test healthy state**
```bash
chmod +x healthcheck.sh
./healthcheck.sh
cat health.log
```
**Output:**
```
Sat Jul 12 04:52:14 PM MSK 2025 - OK: States synchronized
```

**Analysis:** The health check correctly identified that the states are synchronized after the previous reconciliation. The timestamp shows when the check was performed.

**Step 3: Create drift and test detection**
```bash
echo "unapproved change" >> current-state.txt
./healthcheck.sh
cat health.log
```
**Output:**
```
Sat Jul 12 04:52:14 PM MSK 2025 - OK: States synchronized
Sat Jul 12 04:52:47 PM MSK 2025 - CRITICAL: State mismatch!
```

**Analysis:** Excellent! The health monitoring system successfully detected the unauthorized change I made to the current state file. The log shows the progression from a healthy state to a critical state mismatch, with timestamps indicating when each check occurred.

---

## **Key Concepts Demonstrated**

| Task | GitOps Principle | Real-World Equivalent |
|------|------------------|------------------------|
| 1 | Continuous Reconciliation | Argo CD/Flux sync loops |
| 2 | Health Monitoring | Kubernetes operator status checks |

# Lab 07

## Task 1

```bash
(base) ➜  DevOpsFundamentals git:(lab07) ✗ mkdir gitops-lab && cd gitops-lab
   git init
Initialized empty Git repository in /Users/makharev/Studying/DevOps/DevOpsFundamentals/gitops-lab/.git/
```

```bash
(base) ➜  gitops-lab git:(main) echo "version: 1.0" > desired-state.txt
   git add . && git commit -m "Initial state"
[main (root-commit) 17aa82e] Initial state
 1 file changed, 1 insertion(+)
 create mode 100644 desired-state.txt
```

```bash
(base) ➜  gitops-lab git:(main) cp desired-state.txt current-state.txt
```

Created `reconcile.sh`.

```bash
(base) ➜  gitops-lab git:(main) ✗ echo "version: 2.0" > current-state.txt
(base) ➜  gitops-lab git:(main) ✗ chmod +x reconcile.sh
```

```bash
(base) ➜  gitops-lab git:(main) ✗ ./reconcile.sh 
Tue Jul 29 19:53:14 MSK 2025 - DRIFT DETECTED! Reconciling...
```

```bash
(base) ➜  gitops-lab git:(main) ✗ watch -n 5 ./reconcile.sh
```

A `reconcile.sh` script continuously monitors for drifts between a `desired-state.txt` and a `current-state.txt`, automatically reconciling by updating the `current-state.txt` to match the desired state when a difference is detected.

## Task 2

Created `healthcheck.sh` script.

```bash
(base) ➜  gitops-lab git:(main) ✗ chmod +x healthcheck.sh
(base) ➜  gitops-lab git:(main) ✗    ./healthcheck.sh
   cat health.log # Should show "OK"
Tue Jul 29 20:00:29 MSK 2025 - OK: States synchronized
```

```bash
(base) ➜  gitops-lab git:(main) ✗ echo "unapproved change" >> current-state.txt
```

```bash
(base) ➜  gitops-lab git:(main) ✗    ./healthcheck.sh
   cat health.log # Now shows "CRITICAL"
Tue Jul 29 20:00:29 MSK 2025 - OK: States synchronized
Tue Jul 29 20:01:18 MSK 2025 - CRITICAL: State mismatch!
```

The healthcheck confirms "OK" when `desired-state.txt` and `current-state.txt` are synchronized, but reports "CRITICAL" immediately after an "unapproved change" is manually introduced to `current-state.txt`, indicating a detected drift.

# GitOps Fundamentals Lab

## Task 1: Git State Reconciliation

Output after first run of `reconcile.sh`:
```sh
Thu Jul 10 18:16:47 MSK 2025 - DRIFT DETECTED! Reconciling...
```

Output after running the shell script every 5 seconds (empty because no changes to the files are introduced):
```sh
Every 5.0s: ./reconcile.sh                                                                                 WINDOWS-G08A8RF: Thu Jul 10 18:48:27 2025
```

## Task 2: GitOps Health Monitoring

Output looks like this:
```sh
Thu Jul 10 22:35:35 MSK 2025 - OK: States synchronized
Thu Jul 10 22:36:28 MSK 2025 - OK: States synchronized
Thu Jul 10 22:37:44 MSK 2025 - CRITICAL: State mismatch!
```
The OK is duplicated because I had `reconcile.sh` running in the background after adding "unapproved change" to `current-state.txt` first. So the background script fixed that change before I had a chance to manually run `healthcheck.sh`. After I stopped this background process, the expected critical error was logged.
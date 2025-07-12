# Lab 7: GitOps Fundamentals

## Task 1: Git State Reconciliation

  ### Initialize repository

  ```bash
  danilandreev@Danils-MacBook-Air ms24-sum25-devops % mkdir gitops-lab && cd gitops-lab && git init
  Initialized empty Git repository in /Users/danilandreev/Documents/Projects/ms24-sum25-devops/gitops-lab/.git/
  ```

  ### Create desired state

  ```bash
  danilandreev@Danils-MacBook-Air gitops-lab % echo "version: 1.0" > desired-state.txt
  danilandreev@Danils-MacBook-Air gitops-lab % git add . && git commit -m "Initial state"
  [main (root-commit) e89b21a] Initial state
  1 file changed, 1 insertion(+)
  create mode 100644 desired-state.txt
  ```

  ### Simulate live cluster

  ```bash
  danilandreev@Danils-MacBook-Air gitops-lab % cp desired-state.txt current-state.txt
  ```

  ### Create reconciliation script

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

  ### Trigger manual drift

  ```bash
  danilandreev@Danils-MacBook-Air gitops-lab % echo "version: 2.0" > current-state.txt
  ```

  ### Run reconciliation

  ```bash
  danilandreev@Danils-MacBook-Air gitops-lab % chmod +x reconcile.sh && ./reconcile.sh
  Tue Jul  8 14:41:39 MSK 2025 - DRIFT DETECTED! Reconciling...
  ```

  ### Automate reconciliation

  I don't have `watch` installed, so I run the script in a simple loop:

  ```bash
  danilandreev@Danils-MacBook-Air gitops-lab % while :; do ./reconcile.sh; sleep 5; done
  Tue Jul  8 14:44:15 MSK 2025 - DRIFT DETECTED! Reconciling...
  ```

## Task 2: Health Monitoring

  ### Create health check script

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

  ### Make executable

  ```bash
  danilandreev@Danils-MacBook-Air gitops-lab % chmod +x healthcheck.sh
  ```

  ### Simulate healthy state

  ```bash
  danilandreev@Danils-MacBook-Air gitops-lab % ./healthcheck.sh
  danilandreev@Danils-MacBook-Air gitops-lab % cat health.log
  Tue Jul  8 14:54:08 MSK 2025 - OK: States synchronized
  ```

  ### Create drift

  ```bash
  danilandreev@Danils-MacBook-Air gitops-lab % echo "unapproved change" >> current-state.txt
  ```

  ### Run health check

  ```bash
  danilandreev@Danils-MacBook-Air gitops-lab % ./healthcheck.sh
  danilandreev@Danils-MacBook-Air gitops-lab % cat health.log
  Tue Jul  8 14:54:08 MSK 2025 - OK: States synchronized
  Tue Jul  8 14:56:13 MSK 2025 - CRITICAL: State mismatch!
  ```

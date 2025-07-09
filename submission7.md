# Solution to Lab 7

by Dmitry Beresnev <d.beresnev@innopolis.university>

The tasks are done under **Linux Fedora 42**

## Task 1: Git State Reconciliation

**Command:**

```bash
mkdir gitops-lab && cd gitops-lab
git init
```

**Output:**

```bash
Initialized empty Git repository in /home/dsomni/studying/gitops-lab/.git/
```

**Command:**

```bash
echo "version: 1.0" > desired-state.txt
git add . && git commit -m "Initial state"
cp desired-state.txt current-state.txt
# creation of reconcile.sh
echo "version: 2.0" > current-state.txt
chmod +x reconcile.sh
./reconcile.sh
watch -n 5 ./reconcile.sh
```

**Output:**

```bash
Wed Jul  9 06:00:39 PM MSK 2025 - DRIFT DETECTED! Reconciling...
```

## Task 2: GitOps Health Monitoring

**Command:**

```bash
# creation of healthcheck.sh
chmod +x healthcheck.sh
./healthcheck.sh
cat health.log
```

**Output:**

```bash
Wed Jul  9 06:06:48 PM MSK 2025 - OK: States synchronized
```

**Command:**

```bash
echo "unapproved change" >> current-state.txt
./healthcheck.sh
cat health.log
```

**Output:**

```bash
Wed Jul  9 06:06:48 PM MSK 2025 - OK: States synchronized
Wed Jul  9 06:07:49 PM MSK 2025 - CRITICAL: State mismatch!
```

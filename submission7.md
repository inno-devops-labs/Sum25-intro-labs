# **Task 1: Git State Reconciliation**

## 1. **Initialize repository**:

Repo initialized in standart git way

```bash
$ mkdir gitops-lab && cd gitops-lab
$ git init
```

## 2. **Create desired state**

Some info wrtiien to a file

```bash
$ echo "version: 1.0" > desired-state.txt

$ ls
desired-state.txt

$ cat desired-state.txt
version: 1.0

# This staff caused by dualboot and usage of single git dir from both systems
$ git add . && git commit -m "Initial state"
fatal: detected dubious ownership in repository at '/Data/File_Storage/University/Inno/DevOps_Sum25/gitops-lab'
To add an exception for this directory, call:

        git config --global --add safe.directory /Data/File_Storage/University/Inno/DevOps_Sum25/gitops-lab

# So i have to do that proposed
$ git config --global --add safe.directory /Data/File_Storage/University/Inno/DevOps_Sum25/gitops-lab

```

## 3. **Simulate live cluster**
Here we saved our state as state to monitor and maintain (probably it was more convenient to firstly create the current state and only thenn set it as desired. But I thought about it just after made all the stuff)

```bash
$ cp desired-state.txt current-state.txt

$ cat desired-state.txt 
version: 1.0
```

## 4. **Create reconciliation script**

Here i placed the script to a file `reconcile.sh`:

```sh
#!/bin/bash
# reconcile.sh
DESIRED=$(cat desired-state.txt) # Content of file in desired state
CURRENT=$(cat current-state.txt) # Content of file in current state

# If there is some changes made in current state, then we make reconciliation (here we simply replace changed file with file containing desired state)
if [ "$DESIRED" != "$CURRENT" ]; then
echo "$(date) - DRIFT DETECTED! Reconciling..."
cp desired-state.txt current-state.txt
fi
```

## 5. **Trigger manual drift**
Then we trigger the manual drift (like, simply changing the content of file)

```bash
echo "version: 2.0" > current-state.txt # Simulate manual cluster change
```

## 6. **Run reconciliation**
Then we trigger check by usage of newly created script

```bash
$ chmod +x reconcile.sh
peter@peter-pc:/Data/File_Storage/University/Inno/DevOps_Sum25/gitops-lab$ ./reconcile.sh # Should detect and fix drift
Пт 11 июл 2025 22:08:16 MSK - DRIFT DETECTED! Reconciling...
```

And... It works! Like state changed back to desired

```bash
$ cat desired-state.txt 
version: 1.0

$ cat current-state.txt 
version: 1.0
```

## 7. **Automate reconciliation**

In a very simple way we can automate the process.

In a first terminal i ran:

```bash
$ watch -n 5 ./reconcile.sh

Every 5,0s: ./reconcile.sh
```

And in the second i changed the `current-state.txt` file:

```bash
$ echo "Absolute trash" > current-state.txt && cat current-state.txt
Absolute trash

$ cat current-state.txt 
Absolute trash

$ cat current-state.txt 
Absolute trash

$ cat current-state.txt 
Absolute trash

$ cat current-state.txt 
version: 1.0
```

As we can see reconciliation made successfully

Output in a first terminal:

```bash
Every 5,0s: ./reconcile.sh

Пт 11 июл 2025 22:15:43 MSK - DRIFT DETECTED! Reconciling...
```

# **Task 2: GitOps Health Monitoring**

## 1. **Create health check script**:

Sctript created

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

## 2. **Make executable**:

Then I made it executable

```bash
$ chmod +x healthcheck.sh

$ ls -la healthcheck.sh 
-rwxrwxrwx 1 root root 314 июл 12 15:53 healthcheck.sh
```

## 3. **Simulate healthy state**:

```bash
$ ./healthcheck.sh

$ cat health.log # Should show "OK"
Сб 12 июл 2025 15:55:20 MSK - OK: States synchronized

```
There is no cahnges in monitored file, so output as expected

## 4. **Create drift**:

Then i write some "unapproved change" (lol) to the state file

```bash
$ echo "unapproved change" >> current-state.txt
```

## 5. **Run health check**:

```bash
$ ./healthcheck.sh
$ cat health.log # Now shows "CRITICAL"

Сб 12 июл 2025 15:55:20 MSK - OK: States synchronized
Сб 12 июл 2025 15:58:17 MSK - CRITICAL: State mismatch!
```

So this way we can monitor the unapproved changes in monitord files (but it's better to use more convenient instruments )
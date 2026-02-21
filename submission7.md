## **Task 1: Git State Reconciliation**

1. **Initialize repository**:

   ```bash
   mkdir gitops-lab && cd gitops-lab
   git init
   ```
   вывод:
   
```
user@ubuntu:~$ mkdir gitops-lab && cd gitops-lab
user@ubuntu:~/gitops-lab$ git init
hint: Using 'master' as the name for the initial branch. This default branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint: 
hint: 	git config --global init.defaultBranch <name>
hint: 
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint: 
hint: 	git branch -m <name>
Initialized empty Git repository in /home/user/gitops-lab/.git/
```

3. **Create desired state**:

   ```bash
   echo "version: 1.0" > desired-state.txt
   git add . && git commit -m "Initial state"
   ```
   вывод:
   
```
user@ubuntu:~/gitops-lab$ git add . && git commit -m "Initial state"
[master (root-commit) 8bf5a80] Initial state
 1 file changed, 1 insertion(+)
 create mode 100644 desired-state.txt
```
4. **Run reconciliation**:

   ```bash
   chmod +x reconcile.sh
   ./reconcile.sh # Should detect and fix drift
   ```
   вывод:
   
```
user@ubuntu:~/gitops-lab$ cp desired-state.txt current-state.txt
user@ubuntu:~/gitops-lab$ nano reconcile.sh
user@ubuntu:~/gitops-lab$ echo "version: 2.0" > current-state.txt
user@ubuntu:~/gitops-lab$ chmod +x reconcile.sh
user@ubuntu:~/gitops-lab$ ./reconcile.sh
Сб 12 июл 2025 06:47:07 UTC - DRIFT DETECTED! Reconciling...
```

5. **Automate reconciliation**:

   ```bash
   watch -n 5 ./reconcile.sh # Runs every 5 seconds
   ```
![reconcile](/img/11.png)

## **Task 2: GitOps Health Monitoring**

![reconcile](/img/12.png)

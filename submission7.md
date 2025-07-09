# Лабораторная работа: Основы GitOps


## Задание 1: Согласование состояния с Git

```
user@user-VirtualBox:~$ mkdir gitops-lab && cd gitops-lab
user@user-VirtualBox:~/gitops-lab$ git init
Initialized empty Git repository in /home/user/gitops-lab/.git/
user@user-VirtualBox:~/gitops-lab$ git add . && git commit -m "Initial state"
[master (root-commit) 67330d5] Initial state
 1 file changed, 1 insertion(+)
 create mode 100644 desired-state.txt
user@user-VirtualBox:~/gitops-lab$ cp desired-state.txt current-state.txt
user@user-VirtualBox:~/gitops-lab$ sudo nano reconcile.sh
```
- Добавил строку в скрипт.
```
#!/bin/bash
# reconcile.sh
DESIRED=$(cat desired-state.txt)
CURRENT=$(cat current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
    echo "$(date) - DRIFT DETECTED! Reconciling..."
    cp desired-state.txt current-state.txt
else
    echo "$(date) - OK: No drift detected."
fi
```

```
user@user-VirtualBox:~/gitops-lab$ echo "version: 2.0" > current-state.txt
user@user-VirtualBox:~/gitops-lab$ sudo chmod +x reconcile.sh
user@user-VirtualBox:~/gitops-lab$ ./reconcile.sh
Ср 09 июл 2025 10:24:15 MSK - DRIFT DETECTED! Reconciling...
user@user-VirtualBox:~/gitops-lab$ watch -n 5 ./reconcile.sh
Every 5,0s: ./reconcile.sh                                                                                                     user-VirtualBox: Wed Jul  9 10:41:49 2025
Ср 09 июл 2025 10:41:49 MSK - OK: No drift detected.
```


## Задание 2: Мониторинг состояния (Health Monitoring)

```
user@user-VirtualBox:~/gitops-lab$ sudo nano healthcheck.sh

#!/bin/bash
# healthcheck.sh
DESIRED_MD5=$(md5sum desired-state.txt | awk '{print $1}')
CURRENT_MD5=$(md5sum current-state.txt | awk '{print $1}')

if [ "$DESIRED_MD5" != "$CURRENT_MD5" ]; then
echo "$(date) - CRITICAL: State mismatch!" >> health.log
else
echo "$(date) - OK: States synchronized" >> health.log
fi

user@user-VirtualBox:~/gitops-lab$ sudo chmod +x healthcheck.sh
user@user-VirtualBox:~/gitops-lab$ ./healthcheck.sh
user@user-VirtualBox:~/gitops-lab$ cat health.log
Ср 09 июл 2025 11:04:26 MSK - OK: States synchronized
user@user-VirtualBox:~/gitops-lab$ echo "unapproved change" >> current-state.txt
user@user-VirtualBox:~/gitops-lab$ ./healthcheck.sh
user@user-VirtualBox:~/gitops-lab$ cat health.log
Ср 09 июл 2025 11:04:26 MSK - OK: States synchronized
Ср 09 июл 2025 11:05:11 MSK - CRITICAL: State mismatch!
```

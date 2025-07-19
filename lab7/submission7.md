# Lab 7: GitOps Fundamentals

## Task 1: Git State Reconciliation
┌──(root㉿kali)-[/opt/Sum25-intro-labs]
└─# mkdir lab7
                                                                                                                                   
└─# cd lab7                 
                                                                                                                                   
└─# git init 
------
Initialized empty Git repository in /opt/Sum25-intro-labs/lab7/.git/

└─# echo "version: 1.0" > desired-state.txt
└─# git add . && git commit -m "Initial state" 
└─# cp desired-state.txt current-state.txt

### create file - reconcile.sh
└─# echo "version: 2.0" > current-state.txt                                                                                                                                                      
└─# chmod +x reconfile.sh  
### Run file reconcile
└─# watch -n 5 ./reconfile.sh

Fri Jul 11 11:31:15 AM +05 2025 - DRIFT DETECTED! Reconciling...

## Task 2: Health Monitoring
### create file health.sh
#!/bin/bash
# health.sh
DESIRED_MD5=$(md5sum desired-state.txt | awk '{print $1}')
CURRENT_MD5=$(md5sum current-state.txt | awk '{print $1}')

if [ "$DESIRED_MD5" != "$CURRENT_MD5" ]; then
    echo "$(date) - CRITICAL: State mismatch!" >> health.log
else
    echo "$(date) - OK: States synchronized" >> health.log
fi

### run file
└─# chmod +x healt.sh 
└─# ./healt.sh
└─# cat  health.log
Fri Jul 11 11:44:00 AM +05 2025 - OK: States synchronized

### Create drift 
└─# echo "unapproved change" >> current-state.txt
### Run health check
└─# cat  health.log 
Fri Jul 11 11:44:00 AM +05 2025 - OK: States synchronized
Fri Jul 11 11:44:41 AM +05 2025 - CRITICAL: State mismatch!


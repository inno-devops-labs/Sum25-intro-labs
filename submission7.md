# Credentials

The work is done by M24-RO student  
Anton Kirilin  
a.kirilin@innopolis.university 

# Task 1

I proceed with all the steps presented in the lab task:  

- init repo  

- create desired state  

- simulate the live cluster (creating the current state)  

- Create reconciliation script  

- simulate manual drift  

- run reconcile
```sh
:~/Sum25-intro-labs/gitops-lab$ chmod +x reconcile.sh
./reconcile.sh # Should detect and fix drift
Sat Jul 12 13:30:34 MSK 2025 - DRIFT DETECTED! Reconciling...
```

- automate reconciliation
```sh
Every 5.0s: ./reconcile.sh                                                                                                             abobalaptop: Sat Jul 12 13:31:35 2025
```

# Task 2

Now I proceed with the other steps  

- create the bash script (copypaste actually)  

- change mode to executable  

- simulate
```sh
:~/Sum25-intro-labs/gitops-lab$ ./healthcheck.sh
cat health.log
Sat Jul 12 13:54:35 MSK 2025 - OK: States synchronized
```  

- create drift  

- check the health
```sh
:~/Sum25-intro-labs/gitops-lab$ ./healthcheck.sh
cat health.log
Sat Jul 12 13:54:35 MSK 2025 - OK: States synchronized
Sat Jul 12 13:56:08 MSK 2025 - CRITICAL: State mismatch!
```

So basically I(we?) localy simulated how the gitops works. Nothing really to add
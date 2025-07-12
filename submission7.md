# Lab 7

## Git State Reconciliation

```
mkdir gitops-lab && cd gitops-lab
git init
```

```
echo "version: 1.0" > desired-state.txt
git add . && git commit -m "Initial state"
```

```
Enter passphrase: 
[master (root-commit) 52f79a7] Initial state
 1 file changed, 1 insertion(+)
 create mode 100644 desired-state.txt
```

```
cp desired-state.txt current-state.txt
```

```
code reconcile.sh
```

```
#!/bin/bash
# reconcile.sh
DESIRED=$(cat desired-state.txt)
CURRENT=$(cat current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
echo "$(date) - DRIFT DETECTED! Reconciling..."
cp desired-state.txt current-state.txt
fi
```

```
echo "version: 2.0" > current-state.txt
```

```
chmod +x reconcile.sh
./reconcile.sh 
```

```
Fri Jul 11 06:23:08 PM CEST 2025 - DRIFT DETECTED! Reconciling...
```

```
watch -n 5 ./reconcile.sh
```

```
Every 5.0s: ./reconcile.sh                  Ubuntu-2404-noble-amd64-base: Fri Jul 11 18:23:37 2025
```


## GitOps Health Monitoring

```
code healthcheck.sh
```

```
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

```
chmod +x healthcheck.sh
```

```
./healthcheck.sh
cat health.log
````

```
Fri Jul 11 06:24:52 PM CEST 2025 - OK: States synchronized
```

```
echo "unapproved change" >> current-state.txt
```

```
./healthcheck.sh
```

```
Fri Jul 11 06:24:52 PM CEST 2025 - OK: States synchronized
Fri Jul 11 06:25:45 PM CEST 2025 - CRITICAL: State mismatch!
```

# Lab 7 - gitops

Timur Nugaev

Running under MacOS Silicon, so some commands can be diff from the lab's

---

## Task 1 - git state reconciliation

```bash

aladdinych@MacBook-Pro-Timur FD-labs % mkdir gitops-lab && cd gitops-lab

aladdinych@MacBook-Pro-Timur gitops-lab % git init
Initialized empty Git repository in /Users/aladdinych/dev/iu-fd/FD-labs/gitops-lab/.git/
```

```bash
aladdinych@MacBook-Pro-Timur gitops-lab % echo "version: 1.0" > desired-state.txt
git add . && git commit -m "Initial state"

[main (root-commit) f5af8c3] Initial state
 1 file changed, 1 insertion(+)
 create mode 100644 desired-state.txt

```

```bash
aladdinych@MacBook-Pro-Timur gitops-lab % cp desired-state.txt current-state.txt
```

```bash
aladdinych@MacBook-Pro-Timur gitops-lab % cat > reconcile.sh << 'EOF'
#!/bin/bash
DESIRED=$(cat desired-state.txt)
CURRENT=$(cat current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
  echo "$(date -u '+%a %b %d %T UTC %Y') - DRIFT DETECTED! Reconciling..."
  cp desired-state.txt current-state.txt
fi
EOF
```

```bash
chmod +x reconcile.sh

```

```bash
echo "version: 2.0" > current-state.txt

```

```bash
aladdinych@MacBook-Pro-Timur gitops-lab % ./reconcile.sh

Sat Jul 12 15:21:03 UTC 2025 - DRIFT DETECTED! Reconciling...
```

```bash
brew install watch

...

success
```

```bash
watch -n 5 ./reconcile.sh

Every 5.0s: ./reconcile.sh                                                                                                                                                                 MacBook-Pro-Timur.local: 18:24:39
                                                                                                                                                                                                               in 0.015s (0)



```

To test in another terminal i run this:

```bash
echo "version: 2.0" > current-state.txt

```

i still can't see anything happening on the 'watch' terminal, so ill modify the script a bit to see if anything happens:

```bash
#!/bin/bash
DESIRED=$(<desired-state.txt)
CURRENT=$(<current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
  echo "$(date -u '+%a %b %d %T UTC %Y') - DRIFT DETECTED! Reconciling..."
  cp desired-state.txt current-state.txt
else
  echo "$(date -u '+%a %b %d %T UTC %Y') - OK"
fi

```

and i switch to 'watch' emulation instead, but it shouldn't matter too much:

```bash
aladdinych@MacBook-Pro-Timur gitops-lab % while true; do
  ./reconcile.sh
  sleep 5
done

```

This is what i see when i do `echo "version: 3.0" > gitops-lab/current-state.txt` in the other terminal (the one without the `watch` in it):

```bash
Sat Jul 12 15:28:08 UTC 2025 - OK
Sat Jul 12 15:28:13 UTC 2025 - OK
Sat Jul 12 15:28:18 UTC 2025 - OK
Sat Jul 12 15:28:23 UTC 2025 - OK
Sat Jul 12 15:28:28 UTC 2025 - OK
Sat Jul 12 15:28:33 UTC 2025 - OK
Sat Jul 12 15:28:38 UTC 2025 - OK
Sat Jul 12 15:28:43 UTC 2025 - DRIFT DETECTED! Reconciling...
Sat Jul 12 15:28:49 UTC 2025 - OK
Sat Jul 12 15:28:54 UTC 2025 - OK
Sat Jul 12 15:28:59 UTC 2025 - OK
Sat Jul 12 15:29:04 UTC 2025 - OK
Sat Jul 12 15:29:09 UTC 2025 - OK
Sat Jul 12 15:29:14 UTC 2025 - OK
Sat Jul 12 15:29:19 UTC 2025 - OK
```

---

## Task 2 - gitops health monitoring


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

```bash
chmod +x healthcheck.sh
```

```bash
aladdinych@MacBook-Pro-Timur gitops-lab % ./healthcheck.sh
cat health.log                  
Sat Jul 12 18:36:46 MSK 2025 - OK: States synchronized
Sat Jul 12 18:36:54 MSK 2025 - OK: States synchronized
```

```bash
echo "unapproved change" >> current-state.txt
```

```bash
aladdinych@MacBook-Pro-Timur gitops-lab % ./healthcheck.sh
cat health.log                      
Sat Jul 12 18:36:46 MSK 2025 - OK: States synchronized
Sat Jul 12 18:36:54 MSK 2025 - OK: States synchronized
Sat Jul 12 18:37:19 MSK 2025 - CRITICAL: State mismatch!
```

UPD: i remove .git in the subdir (gitops-lab to be able to commit that as well)
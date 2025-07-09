## LAB 7
Nikita Yaneev n.yaneev@innopolis.unversity

### Task 1

1

**Input** 

```
mkdir gitops-lab && cd gitops-lab
git init
```

2.

**Input:** 

```sh
echo "version: 1.0" > desired-state.txt
git add . && git commit -m "Initial state"
```

**Output:**

```bash
sumnios@Nikita:~/gitops-lab$ echo "version: 1.0" > desired-state.txt
sumnios@Nikita:~/gitops-lab$ git add . && git commit -m "Initial state"
[master (root-commit) 6e61dbe] Initial state
 1 file changed, 1 insertion(+)
 create mode 100644 desired-state.txt
```

3. 

**Input:** 

```sh
cp desired-state.txt current-state.txt
```

4. 

**Input:**

```sh
sumnios@Nikita:~/gitops-lab$ touch reconcile.sh
sumnios@Nikita:~/gitops-lab$ vi reconcile.sh
```


**Code in reconcile:** 
```sh
DESIRED=$(cat desired-state.txt)
CURRENT=$(cat current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
echo "$(date) - DRIFT DETECTED! Reconciling..."
cp desired-state.txt current-state.txt
fi
```


5.

**Input:**

```sh
echo "version: 2.0" > current-state.txt
```

6. 
**Input:**

```sh
chmod +x reconcile.sh
./reconcile.sh
```

**Output:**

```sh
sumnios@Nikita:~/gitops-lab$ chmod +x reconcile.sh
sumnios@Nikita:~/gitops-lab$ ./reconcile.sh
Wed Jul  9 17:56:45 MSK 2025 - DRIFT DETECTED! Reconciling...
```

7.

**Input:**

```sh
watch -n 5 ./reconcile.sh
```

**Output:**

```sh
Every 5.0s: ./reconcile.sh                                                    Nikita: Wed Jul  9 18:05:05 2025
Every 5.0s: ./reconcile.sh                                                    Nikita: Wed Jul  9 18:05:10 2025
```


### Task 2 

1.
**Input:**

``` sh
sumnios@Nikita:~/gitops-lab$ touch healthcheck.sh
sumnios@Nikita:~/gitops-lab$ vi healthcheck.sh
```
**Code:**
```sh
DESIRED_MD5=$(md5sum desired-state.txt | awk '{print $1}')
CURRENT_MD5=$(md5sum current-state.txt | awk '{print $1}')

if [ "$DESIRED_MD5" != "$CURRENT_MD5" ]; then
echo "$(date) - CRITICAL: State mismatch!" >> health.log
else
echo "$(date) - OK: States synchronized" >> health.log
fi
```

2. 

**Input:**

```sh
chmod +x healthcheck.sh
```

3.

**Input:**

```sh
./healthcheck.sh
cat health.log
```

**Output:**

```sh
sumnios@Nikita:~/gitops-lab$ ./healthcheck.sh
sumnios@Nikita:~/gitops-lab$ cat health.log
Wed Jul  9 18:07:24 MSK 2025 - OK: States synchronized
```

4. 

**Input:**
```sh
echo "unapproved change" >> current-state.txt
```

5. 
**Input:**
```sh
./healthcheck.sh
cat health.log
```

**Output:**
```sh
sumnios@Nikita:~/gitops-lab$ echo "unapproved change" >> current-state.txt
sumnios@Nikita:~/gitops-lab$ ./healthcheck.sh
sumnios@Nikita:~/gitops-lab$ cat health.log
Wed Jul  9 18:07:24 MSK 2025 - OK: States synchronized
Wed Jul  9 18:07:40 MSK 2025 - CRITICAL: State mismatch!
```
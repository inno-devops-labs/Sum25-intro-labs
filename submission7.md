## 1. Git State Reconciliation
### 1. Initializing repository:
```sh
mkdir gitops-lab && cd gitops-lab
git init
```
### 2. Creating desired state:
```sh
echo "version: 1.0" > desired-state.txt
git add . && git commit -m "Initial state"
```
### 3. Simulating live cluster:
```sh
cp desired-state.txt current-state.txt
```
### 4. Creating reconciliation script:
```sh
#!/bin/bash
# reconcile.sh
DESIRED=$(cat desired-state.txt)
CURRENT=$(cat current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
echo "$(date) - DRIFT DETECTED! Reconciling..."
cp desired-state.txt current-state.txt
fi
```
### 5. Triggering manual drift:
```sh
echo "version: 2.0" > current-state.txt # Simulate manual cluster change
```
### 6. Running reconciliation:
```sh
chmod +x reconcile.sh
./reconcile.sh # Should detect and fix drift
```
### 7. Automating reconciliation:
```sh
watch -n 5 ./reconcile.sh # Runs every 5 seconds
```
Output:
```sh
Fri Jul 11 22:52:04 RTZ 2025 - DRIFT DETECTED! Reconciling...
```

## 2. GitOps Health Monitoring
### 1. Creating health check script:
```sh
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
### 2. Making executable:
```sh
chmod +x healthcheck.sh
```
### 3. Simulating healthy state:
```sh
./healthcheck.sh
cat health.log
```
Output:
```sh
Sat Jul 12 15:27:13 RTZ 2025 - OK: States synchronized
```
### 4. Creating drift:
```sh
echo "unapproved change" >> current-state.txt
```
### 5. Running health check:
```sh
./healthcheck.sh
cat health.log
```
Output:
```sh
Sat Jul 12 15:27:13 RTZ 2025 - OK: States synchronized
Sat Jul 12 15:28:25 RTZ 2025 - CRITICAL: State mismatch!
```

Выводы:
1. Создан скрипт `healthcheck.sh` для сравнения хешей состояний;
2. При первом запуске выявлено синхронизированное состояние;
3. Создан дрейф конфигурации добавлением строки в `current-state.txt`;
4. Запущена повторная проверка, выявившая расхождение.

**Это важно, поскольку заранее позволяет обнаруживать проблемы и фиксирует несанкционированные изменения, и даже минимальное расхождение будет немедленно обнаружено.**
## **Task 1: Git State Reconciliation**

For simplicity, a script was created that does the following:

| Number | Action | Description |
|-------|----------------------------------|-----------------------------------------------------------------------------|
| 1 | Initialize the repository | Creates the gitops-lab directory, changes into it, and initializes a new Git repository |
| 2 | Create the desired state | Creates a desired-state.txt file with the contents version: 1.0 and commits it to the repository |
| 3 | Simulate a running cluster | Copies the contents of desired-state.txt to current-state.txt, simulating the current state |
| 4 | Create a reconciliation script | Generates a reconcile.sh file that will be used to reconcile the state |
| 5 | Run Manual Drift | Modifies the current-state.txt file to simulate a manual change of cluster state |
| 6 | Run Reconcile | Makes the reconcile.sh script executable and runs it to detect and fix drift |
| 7 | Automate Reconcile | Runs automatic reconciliation every 5 seconds using the watch command |
| 8 | End Script | Writes a message about the end of the script execution and the location of the log file |

The script itself:

```
#!/bin/bash

LOG_FILE="gitops_simulation.log"

log() {
    echo "$(date) - $1" >> "$LOG_FILE"
}

log "Инициализация репозитория..."
mkdir gitops-lab && cd gitops-lab || { log "Ошибка при переходе в каталог."; exit 1; }
git init || { log "Ошибка инициализации репозитория."; exit 1; }

echo "version: 1.0" > desired-state.txt
git add . && git commit -m "Начальное состояние" || { log "Ошибка при коммите."; exit 1; }
log "Создано желаемое состояние."

cp desired-state.txt current-state.txt || { log "Ошибка копирования желаемого состояния в текущее."; exit 1; }
log "Симулированное текущее состояние создано."

cat << 'EOF' > reconcile.sh
#!/bin/bash
LOG_FILE="../gitops_simulation.log"
DESIRED=$(cat desired-state.txt)
CURRENT=$(cat current-state.txt)

if [ "$DESIRED" != "$CURRENT" ]; then
    echo "$(date) - ОБНАРУЖЕН ДРЕЙФ! Согласование..." >> "$LOG_FILE"
    cp desired-state.txt current-state.txt
    echo "$(date) - Текущее состояние обновлено." >> "$LOG_FILE"
else
    echo "$(date) - Состояние синхронизировано." >> "$LOG_FILE"
fi
EOF

echo "version: 2.0" > current-state.txt
log "Состояние кластера изменено вручную."

chmod +x reconcile.sh
./reconcile.sh

log "Запуск автоматического согласования каждые 5 секунд..."
watch -n 5 ./reconcile.sh &

log "Скрипт завершен. Логи доступны в файле $LOG_FILE."
```

Results of the work:

```
vboxuser@xubu:~/test$ tree
.
├── gitops-lab
│   ├── current-state.txt
│   ├── desired-state.txt
│   ├── gitops_simulation.log
│   └── reconcile.sh
├── gitops_simulation.log
└── gitops_simulation.sh

1 directory, 6 files
vboxuser@xubu:~/test$ cat gitops_simulation.log 
Вс 06 июл 2025 17:16:41 +03 - Инициализация репозитория...
Вс 06 июл 2025 17:16:41 +03 - ОБНАРУЖЕН ДРЕЙФ! Согласование...
Вс 06 июл 2025 17:16:41 +03 - Текущее состояние обновлено.
Вс 06 июл 2025 17:16:41 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:16:46 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:16:52 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:16:57 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:17:02 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:17:07 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:17:12 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:17:17 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:17:22 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:17:27 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:17:32 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:17:37 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:17:42 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:17:47 +03 - Состояние синхронизировано.
Вс 06 июл 2025 17:17:52 +03 - Состояние синхронизировано.
vboxuser@xubu:~/test$
vboxuser@xubu:~/test$ cat gitops-lab/gitops_simulation.log 
Вс 06 июл 2025 17:16:41 +03 - Создано желаемое состояние.
Вс 06 июл 2025 17:16:41 +03 - Симулированное текущее состояние создано.
Вс 06 июл 2025 17:16:41 +03 - Состояние кластера изменено вручную.
Вс 06 июл 2025 17:16:41 +03 - Запуск автоматического согласования каждые 5 секунд...
Вс 06 июл 2025 17:16:41 +03 - Скрипт завершен. Логи доступны в файле gitops_simulation.log.
vboxuser@xubu:~/test$ 
```

## **Task 2: Monitoring GitOps performance**

For ease of use, a script was written:

```
#!/bin/bash

LOG_FILE="health.log"

if [ ! -f desired-state.txt ]; then
    echo "Создание файла desired-state.txt"
    echo "version: 1.0" > desired-state.txt
fi

if [ ! -f current-state.txt ]; then
    echo "Создание файла current-state.txt"
    cp desired-state.txt current-state.txt
fi

if [ ! -f desired-state.txt ]; then
    echo "$(date) - ERROR: Файл desired-state.txt не найден!" >> "$LOG_FILE"
    exit 1
fi

if [ ! -f current-state.txt ]; then
    echo "$(date) - ERROR: Файл current-state.txt не найден!" >> "$LOG_FILE"
    exit 1
fi

DESIRED_MD5=$(md5sum desired-state.txt | awk '{print $1}')
CURRENT_MD5=$(md5sum current-state.txt | awk '{print $1}')

if [ "$DESIRED_MD5" != "$CURRENT_MD5" ]; then
    echo "$(date) - CRITICAL: State mismatch!" >> "$LOG_FILE"
else
    echo "$(date) - OK: состояния синхронизированы" >> "$LOG_FILE"
fi

cat "$LOG_FILE"
```

Results of the work:

```
vboxuser@xubu:~/test$ ./healthcheck.sh
   
Создание файла desired-state.txt
Создание файла current-state.txt
Вс 06 июл 2025 17:27:35 +03 - OK: состояния синхронизированы
vboxuser@xubu:~/test$ tree
.
├── current-state.txt
├── desired-state.txt
├── healthcheck.sh
└── health.log

0 directories, 4 files
vboxuser@xubu:~/test$ cat current-state.txt 
version: 1.0
vboxuser@xubu:~/test$ cat desired-state.txt 
version: 1.0 
```

Let's replace the content in desired-state.txt with "version: 2.0".

Results of the work:

```
vboxuser@xubu:~/test$ cat desired-state.txt 
version: 2.0
vboxuser@xubu:~/test$ ./healthcheck.sh
Вс 06 июл 2025 17:27:35 +03 - OK: состояния синхронизированы
Вс 06 июл 2025 17:29:40 +03 - CRITICAL: State mismatch!
vboxuser@xubu:~/test$ 
```

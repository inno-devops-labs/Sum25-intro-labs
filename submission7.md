# Лабоараторная работа 7 Git-OPS 

## Синхронизация состояния 

Создал новый гит реп и добавил туда нужные два файла из задания. Скрипт - 

    #!/bin/bash
    DESIRED=$(cat desired-state.txt)
    CURRENT=$(cat current-state.txt)

    if [ "$DESIRED" != "$CURRENT" ]; then
        echo "$(date) - DRIFT DETECTED! Reconciling..."
        cp desired-state.txt current-state.txt
    fi

при изменении заданного файла и запуске скрипта детектит это и исправляет 

    Sat Jul 12 21:04:03 RTZ 2025 - DRIFT DETECTED! Reconciling...

То же самое при постоянном запуске 

    watch -n 5 ./reconcile.sh
    Every 5,0s: ./reconcile.sh

    Sat Jul 12 21:07:42 RTZ 2025 - DRIFT DETECTED! Reconciling...

## Heath check 

Пишем скрипт проверки 

    #!/bin/bash
    DESIRED_MD5=$(md5sum desired-state.txt | awk '{print $1}')
    CURRENT_MD5=$(md5sum current-state.txt | awk '{print $1}')

    if [ "$DESIRED_MD5" != "$CURRENT_MD5" ]; then
        echo "$(date) - CRITICAL: State mismatch!" >> health.log
    else
        echo "$(date) - OK: States synchronized" >> health.log
    fi

после отработки скрипта

    Sat Jul 12 21:13:06 RTZ 2025 - OK: States synchronized

при этом если испортить файл 

    Sat Jul 12 21:14:35 RTZ 2025 - CRITICAL: State mismatch!

    


### Задача 0: Экспорт изображения
**Выполненные команды:**
```powershell
docker pull ubuntu:latest
docker save -o ubuntu_image.tar ubuntu:latest

PS C:\Users\123> docker pull ubuntu:latest
latest: Pulling from library/ubuntu
Digest: sha256:89ef6e43e57cb94a23e4b28715a34444de91f45bd410fce3ce00819f86940a9c
Status: Image is up to date for ubuntu:latest
docker.io/library/ubuntu:latest
```


PS C:\Users\123> docker save -o ubuntu_image.tar ubuntu:latest
PS C:\Users\123> docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

PS C:\Users\123> docker run -it --name ubuntu_container ubuntu:latest
root@dea75a1350f9:/# exit
exit

PS C:\Users\123> docker rmi ubuntu:latest
Error response from daemon: conflict: unable to delete ubuntu:latest (must be forced) - container dea75a1350f9 is using its referenced image 89ef6e43e57c

PS C:\Users\123> docker images ubuntu:latest --format "Размер образа: {{.Size}}"
Размер образа: 117MB

PS C:\Users\123> Write-Output "Размер архива: $([math]::Round($size, 2)) MB"
Размер архива: 28.36 MB


**Результаты измерений:**
- Размер образа в Docker: `117 MB`
- Размер .tar-файла: `28.36 MB`

**Объяснение различий:**
Размер архива значительно меньше виртуального размера образа, потому что:
1. `docker save` использует эффективное сжатие при упаковке слоёв
2. Виртуальный размер включает метаданные и служебную информацию Docker
3. Архив содержит только пользовательские данные без служебных структур



### Задача 1: Основные операции с контейнерами

**1. Размер образа Ubuntu:**  
`117 MB`

**2. Ошибка при удалении образа:**
```powershell
Error response from daemon: conflict: unable to delete ubuntu:latest (must be forced) - container dea75a1350f9 is using its referenced image 89ef6e43e57c
```

**Объяснение ошибки:**  
Docker запрещает удаление образов, если:
- Существуют зависимые контейнеры (даже остановленные)
- Другие образы наследуют от него
- Образ используется в работающем контейнере


### Задача 2: Настройка изображения

**Выполненные команды и вывод:**
```powershell
# Запуск Nginx контейнера
PS> docker run -d -p 80:80 --name nginx_container nginx
c3c98ecb7406ad558cc5d25394e6a7d49dc4beb655bfa1eb13d34269a82f217f

# Создание HTML-файла
PS> @'
<html>
<head><title>The best</title></head>
<body><h1>website</h1></body>
</html>
'@ | Set-Content index.html

# Копирование файла в контейнер
PS> docker cp index.html nginx_container:/usr/share/nginx/html/
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/

# Создание кастомного образа
PS> docker commit nginx_container my_website:latest
sha256:05de269f20fe3644dbd5a60190d89915a68f0cb95a854275352a93f100eb160f

# Удаление оригинального контейнера
PS> docker rm -f nginx_container
nginx_container

# Запуск нового контейнера
PS> docker run -d -p 80:80 --name my_website_container my_website:latest
4d0a8def0e92a52f6f5f41fa63e47b5d3907dc7274559d96cdeae609cdb4abf8

# Проверка работы веб-сервера
PS> curl http://localhost

StatusCode        : 200
StatusDescription : OK
Content           : <html>
                    <head><title>The best</title></head>
                    <body><h1>website</h1></body>
                    </html>
```

**Анализ изменений изображения:**
```powershell
PS> docker diff my_website_container
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
C /run
C /run/nginx.pid
```

**Объяснение вывода docker diff:**
Вывод показывает файлы и директории, изменённые в процессе работы контейнера:
1. **C** - Changed (изменённый файл/директория)
2. **Пути изменений**:
   - `/etc/nginx/conf.d/default.conf` - основной конфигурационный файл Nginx
   - `/run/nginx.pid` - PID-файл процесса Nginx
   - Сопутствующие директории (`/etc`, `/run`) - служебные пути

### Задача 3: Контейнерная сеть

**Выполненные команды и вывод:**
```powershell
# 1. Создание сети
PS> docker network create lab_network
8e34675c561befb3b5fe92bd2448cbef39e8ad89df9ef7767a79dcd4c0fcdbe2

# 2. Запуск первого контейнера
PS> docker run -dit --network lab_network --name container1 alpine ash
24cf90902ba17218ba76530e80005f1b818445b1650ffc74298ebbb2894e3d48

# 3. Запуск второго контейнера
PS> docker run -dit --network lab_network --name container2 alpine ash
34b2f52b35c61e1e46f1dbc3e758220c86e057115afc46cc1ed702e7fb307cb1

# 4. Проверка соединения между контейнерами
PS> docker exec container1 ping -c 3 container2
PING container2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.054 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.046 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.047 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.046/0.049/0.054 ms
```

**Объяснение работы внутреннего разрешения DNS в Docker:**
1. **Автоматическое разрешение имён:**
   - Контейнеры в одной пользовательской сети могут обращаться друг к другу по имени
   - Docker автоматически создаёт DNS-записи для каждого контейнера

2. **Принцип работы:**
   - При создании сети (`lab_network`) Docker развёртывает встроенный DNS-сервер
   - При запуске контейнера с параметром `--name` его имя регистрируется в DNS
   - Запрос `container2` преобразуется в IP-адрес `172.18.0.3`

# Также можно проверить, что DNS работает в обе стороны: 
PS C:\Users\123> docker exec container2 ping -c 3 container1
PING container1 (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: seq=0 ttl=64 time=0.037 ms
64 bytes from 172.18.0.2: seq=1 ttl=64 time=0.049 ms
64 bytes from 172.18.0.2: seq=2 ttl=64 time=0.047 ms

--- container1 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.037/0.044/0.049 ms


### Задача 4: Устойчивость объема

**Выполненные команды:**
```powershell
docker volume create app_data
docker run -d -v app_data:/usr/share/nginx/html --name web nginx
docker cp index.html web:/usr/share/nginx/html/
docker stop web && docker rm web
docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
curl localhost
```

**Результаты:**
1. Том успешно создан: `app_data`
2. Данные скопированы в том: `Successfully copied 2.05kB`
3. После пересоздания контейнера веб-сервер вернул:
   ```html
   <html>
   <head><title>The best</title></head>
   <body><h1>website</h1></body>
   </html>
   ```
   с кодом статуса `200`

**Объяснение принципа сохранения данных:**
Данные сохраняются благодаря:
- Независимому жизненному циклу томов Docker
- Разделению данных контейнера (эфемерных) и пользовательских данных (том)
- Автоматическому подключению тома к новой файловой системе контейнера

# 1. Создание тома
PS> docker volume create app_data
app_data

# 2. Запуск контейнера с томом
PS> docker run -d -v app_data:/usr/share/nginx/html --name web nginx
17e62b2d7b07eded5fd090967bf237f90e13c8fccd120cbd0c57c562d30b47dc

# 3. Копирование файла в том
PS> docker cp index.html web:/usr/share/nginx/html/
Successfully copied 2.05kB to web:/usr/share/nginx/html/

# 4. Остановка и удаление контейнера
PS> docker stop web
web
PS> docker rm web
web

# 5. Запуск нового контейнера с тем же томом
PS> docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
ef40ba690af0a9d7bf1b4eaa13ee223f11df465d53ae3ef11f6d2c8aaebf80f1

# 6. Проверка сохранности данных
PS> curl localhost

StatusCode        : 200
Content           : <html>
                    <head><title>The best</title></head>
                    <body><h1>website</h1></body>
                    </html>

### Задача 5: Проверка контейнера

**Выполненные команды и вывод:**
```powershell
# 1. Запуск контейнера Redis
PS> docker run -d --name redis_container redis
2d8001455dffadbbda85d6d72087576a1d7328285c6678796ae049622ca8d323

# 2. Попытка установки утилит (не удалась)
PS> docker exec redis_container apk add procps
OCI runtime exec failed: exec failed: unable to start container process: exec: "apk": executable file not found in $PATH: unknown

# 3. Проверка процессов через docker top
PS> docker top redis_container
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
999                 1347                1328                0                   09:32               ?                   00:00:00            redis-server *:6379

# 4. Получение IP-адреса
PS> docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
172.17.0.4
```

**Объяснение результатов:**
1. Официальный образ Redis основан на Debian, а не Alpine (поэтому `apk` недоступен)
2. Команда `docker top` показала:
   - Основной процесс: `redis-server *:6379`
   - PID: 1347
   - Пользователь: 999 (специальный пользователь для Redis)
3. IP-адрес контейнера: `172.17.0.4`

**Сравнение `docker exec` и `docker attach`:**
| Команда          | Назначение                                                                 | Пример использования                          | Преимущества                        | Недостатки                  |
|------------------|----------------------------------------------------------------------------|-----------------------------------------------|-------------------------------------|-----------------------------|
| **`docker exec`** | Запуск новой команды в работающем контейнере                               | `docker exec redis_container redis-cli ping`  | Безопасен для основного процесса    | Требует установленных утилит|
| **`docker attach`** | Подключение к основному процессу контейнера                                | `docker attach redis_container`               | Прямой доступ к выводу процесса     | Может завершить контейнер   |

Проверка работы Redis:
PS C:\Users\123> docker exec redis_container redis-cli ping
PONG

### Задача 6: Операции по очистке

# 1. Проверка использования диска до очистки
PS> docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          12        5         6.16GB    5.706GB (92%)
Containers      6         5         151.6kB   12.29kB (8%)
Local Volumes   9         2         1.711GB   1.711GB (99%)
Build Cache     30        0         165.5kB   165.5kB

# 2. Создание 3 остановленных контейнеров
PS> docker run --name temp1 alpine echo "hello"
hello
PS> docker run --name temp2 alpine echo "hello"
hello
PS> docker run --name temp3 alpine echo "hello"
hello

# 3. Создание двух dangling-образов
PS> docker build -t temp-image .  # Dockerfile: FROM alpine; RUN echo "test" > /test.txt
# ... вывод сборки ...
PS> docker rmi temp-image
Untagged: temp-image:latest
Deleted: sha256:b0124b201331c3acef628ea806faddbefd74a07a7812d477d92431b90b22c50b

PS> docker build -t temp-image2 .
# ... вывод сборки ...
PS> docker rmi temp-image2
Untagged: temp-image2:latest
Deleted: sha256:766be497f0554534f097b3db4f9ef6b2140534c0f9a472a9c3475e15a054b36c

# 4. Очистка остановленных контейнеров
PS> docker container prune -f
Deleted Containers:
c859a411e3b1..., 00a5e37d8eab..., 9f8d51d9ad5c..., dea75a1350f9...
Total reclaimed space: 24.58kB

# 5. Очистка неиспользуемых образов
PS> docker image prune -a -f
Deleted Images:
# ... список удалённых образов ...
Total reclaimed space: 1.841GB

# 6. Проверка использования диска после очистки
PS> docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          4         4         590.5MB   245.3MB (41%)
Containers      5         5         139.3kB   0B (0%)
Local Volumes   9         2         1.711GB   1.711GB (99%)
Build Cache     33        0         314.8MB   314.8MB


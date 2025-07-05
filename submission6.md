## 0. Image Exporting
```sh
docker image inspect ubuntu:latest --format '{{.Size}}'
```
78118302
```sh
stat -c %s ubuntu_image.tar
```
80642560  

78.1 MB vs 80.6 MB: Docker показывает эффективный размер слоёв образа, тогда как .tar файл представляет собой полную распакованную версию с дополнительными метаданными архива. Из-за этого наблюдаем увеличение размера на 2.5 MB

## 1. Core Container Operations
### 1. List Containers
```sh
docker ps -a
```
```
CONTAINER ID   IMAGE         COMMAND    CREATED       STATUS                   PORTS     NAMES
cfb2d8de5e06   hello-world   "/hello"   2 hours ago   Exited (0) 2 hours ago             romantic_northcutt
```
### 2. Pulling Ubuntu Image
```sh
docker pull ubuntu:latest
```
```
latest: Pulling from library/ubuntu
Digest: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
Status: Image is up to date for ubuntu:latest
docker.io/library/ubuntu:latest
```
Image size:
```sh
docker images
```
```
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
ubuntu        latest    f9248aac10f2   2 weeks ago    78.1MB
hello-world   latest    74cc54e27dc4   5 months ago   10.1kB
```
### 3. Running Interactive Container
```sh
docker run -it --name ubuntu_container ubuntu:latest
```
```
root@ab35eca539d9:/# exit
exit
```
### 4. Removing Image
```sh
docker rmi ubuntu:latest
```
Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container ab35eca539d9 is using its referenced image f9248aac10f2

Образ нельзя удалить, пока существует связанный контейнер (даже в остановленном состоянии).

## 2. Image Customization
### 1. Deploying Nginx
```sh
docker run -d -p 80:80 --name nginx_container nginx
```
Проверка:
```sh
curl localhost
```
```
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
### 2. Customizing Website
Создан HTML файл:
```
<html>
<head>
<title>The best</title>
</head>
<body>
<h1>website</h1>
</body>
</html>
```
```sh
docker cp index.html nginx_container:/usr/share/nginx/html/
```
### 3. Creating Custom Image
```sh
docker commit nginx_container my_website:latest
```
### 4. Removing Original Container
```sh
docker rm -f nginx_container
```
Проверка удаления:
```sh
docker ps -a
```
```
CONTAINER ID   IMAGE           COMMAND       CREATED        STATUS                    PORTS     NAMES
ab35eca539d9   ubuntu:latest   "/bin/bash"   19 hours ago   Exited (0) 19 hours ago             ubuntu_container
cfb2d8de5e06   hello-world     "/hello"      21 hours ago   Exited (0) 21 hours ago             romantic_northcutt
```
### 5. Creating New Container
```sh
docker run -d -p 80:80 --name my_website_container my_website:latest
```
### 6. Testing Web Server
```sh
curl http://127.0.0.1:80
```
```
<html>
<head>
<title>The best</title>
</head>
<body>
<h1>website</h1>
</body>
</html>
```
### 7. Analyzing Image Changes
```sh
docker diff my_website_container
```
```
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
C /run
C /run/nginx.pid
```
**C (Changed)** означает, что данные элементы были изменены по сравнению с исходным образом. Директории помечены как изменённые из-за модификации файлов внутри них.

## 3. Container Networking
### 1. Creating Network
```sh
docker network create lab_network
```
Проверка:
```sh
docker network ls
```
```
NETWORK ID     NAME          DRIVER    SCOPE
29f0d47f8355   bridge        bridge    local
b7c5e348bc7c   host          host      local
cc85c8bc609b   lab_network   bridge    local
5c52dc5c47c0   none          null      local
```
### 2. Running Connected Containers
```sh
docker run -dit --network lab_network --name container1 alpine ash
docker run -dit --network lab_network --name container2 alpine ash
```
### 3. Testing Connectivity
```sh
docker exec container1 ping -c 3 container2
```
```
PING container2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.052 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.055 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.098 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.052/0.068/0.098 ms
```
**DNS-резолвинг в Docker**
1. Встроенная DNS-система:
   - Docker автоматически запускает встроенный DNS-сервер при создании пользовательской сети;
   - DNS-сервер интегрирован в docker-engine (не требует отдельной конфигурации).

2. Автоматическая регистрация:
   - При подключении контейнера к сети:
     - Docker регистрирует имя контейнера в DNS;
     - Сопоставляет имя с IP-адресом контейнера в сети;
   - Процесс происходит мгновенно без ручного вмешательства.

3. Особенности работы:
   - Работает только в пользовательских сетях (не в сети по умолчанию "bridge");
   - Не требует редактирования файлов /etc/hosts;
   - Поддерживает автоматическое обновление при перезапуске контейнеров.

## 4. Volume Persistence
### 1. Creating Volume
```sh
docker volume create app_data
```
### 2. Running Container with Volume
```sh
docker run -d -v app_data:/usr/share/nginx/html --name web nginx
```
### 3. Modifying Content
```sh
docker cp index.html web:/usr/share/nginx/html/
```
Successfully copied 2.05kB to web:/usr/share/nginx/html/
### 4. Verifying Persistence
```sh
docker stop web && docker rm web
```
```sh
docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
```
Проверка:
```sh
curl http://localhost
```
```
<html>
<head>
<title>The best</title>
</head>
<body>
<h1>website</h1>
</body>
</html>
```

## 5. Container Inspection
### 1. Running Redis Container
```sh
docker run -d --name redis_container redis
```
### 2. Inspecting Processes
```sh
docker exec redis_container ps aux
```
```
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
redis          1  0.2  0.4 147312 18048 ?        Ssl  10:46   0:03 redis-server *:6379
root         251 33.3  0.1   8092  4096 ?        Rs   11:11   0:00 ps aux
```
### 3. Network Inspection
```sh
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
```
172.17.0.3
### 4. ```docker exec``` vs ```docker attach```: differences
| Команда           | `docker exec`                                      | `docker attach`                                   |
|-------------------|---------------------------------------------------|--------------------------------------------------|
| **Назначение**    | Выполнить новую команду в работающем контейнере.  | Присоединиться к основному процессу (PID 1) контейнера. |
| **Влияние**       | Не влияет на основной процесс контейнера.         | Прямое взаимодействие с основным процессом.      |
| **Сессии**        | Можно запускать множество команд параллельно.     | Только одна активная сессия.                     |
| **Безопасность**  | Безопасно (не затрагивает работу приложения).     | Рискованно (может завершить основной процесс).   |
| **Выход**         | Завершение команды не останавливает контейнер.    | CtrlC остановит основной процесс и контейнер.   |

**Использование `docker exec`:**
- диагностика (просмотр процессов, проверка логов, анализ сетевых соединений);
- администрирование (создание резервных копий, изменение конфигурации);
- запуск временных сервисов (выполнение скриптов, тестирование);
- `docker exec -it my_container bash`

**Использование `docker attach`:**
- взаимодействие с интерактивными приложениями (REPL, CLI)
- когда нужно видеть stdout/stderr в реальном времени
- для приложений, ожидающих пользовательский ввод
- `docker attach python_app`

## 6. Cleanup Operations
### 1. Verifying Cleanup
```sh
docker system df
```
```
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          6         6         331.7MB   192.2MB (57%)
Containers      7         4         21.52MB   1.1kB (0%)
Local Volumes   2         2         583B      0B (0%)
Build Cache     0         0         0B        0B
```
### 2. Creating Test Objects
```sh
for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
```
```
hello
hello
hello
```
```sh
docker build -t temp-image . && docker rmi temp-image
```
```
[+] Building 0.1s (5/5) FINISHED                                                      
Untagged: temp-image:latest
```
### 3. Removing Stopped Containers
```sh
docker container prune -f
```
```
Deleted Containers:
64cb428410d0445c88610d1e8f9086094502192587c80b9dadfac7dfb6400641
5f955f16193537df91651b64b1973e489e314148eaad497baf7f3a4aee8018b6
d322b910d8842ea2b903521cc061dfc6d8fbaee2672de7b93188cb04fd8831b4
7c0ac3f7774563b8e83af24bdb12213bfc7d123e81882e63b0ca94fe78f2e5fd
ab35eca539d9e9ed4c86a3634cf694f561da7ba1918291a04c1da790cd657b99
cfb2d8de5e062aee16948347f6e368d0327feaf7b7926aef71ea09f9ffee43c1

Total reclaimed space: 1.1kB
```
### 4. Removing Unused Images
```sh
docker image prune -a -f
```
```
Deleted Images:
untagged: ubuntu:latest
untagged: ubuntu@sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
deleted: sha256:f9248aac10f2f82e0970222e36cc7b71215b88e974e001282e5cd89797a82218
deleted: sha256:45a01f98e78ce09e335b30d7a3080eecab7f50dfa0b38ca44a9dee2654ac0530
untagged: my_website:latest
deleted: sha256:2ebc3c6553fe8c747c3e5b18e17a057f202b6b91562b01777a06012693c2e7f6
deleted: sha256:8cdbe4865755dd7975e3be66124365fdad64d2f848a901d75fa7d696c1c9394b
untagged: hello-world:latest
untagged: hello-world@sha256:940c619fbd418f9b2b1b63e25d8861f9cc1b46e3fc8b018ccfe8b78f19b8cc4f
deleted: sha256:74cc54e27dc41bb10dc4b2226072d469509f2f22f1a3ce74f4a59661a1d44602
deleted: sha256:63a41026379f4391a306242eb0b9f26dc3550d863b7fdbb97d899f6eb89efe72

Total reclaimed space: 78.13MB
```
### 5. Verifying Cleanup
```sh
docker system df
```
```
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          3         3         253.6MB   74.81MB (29%)
Containers      4         4         21.52MB   0B (0%)
Local Volumes   2         2         583B      0B (0%)
Build Cache     3         0         0B        0B
```
Удаленные неиспользуемые образы освободили 78.13 MB.

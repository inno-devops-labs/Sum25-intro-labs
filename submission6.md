# Лабораторная работа по контейнерам - Docker

## Задание 0: Экспорт образов

```
user@user-VirtualBox:~/docker-lab$ sudo docker pull ubuntu:latest
latest: Pulling from library/ubuntu
d9d352c11bbd: Pull complete 
Digest: sha256:b59d21599a2b151e23eea5f6602f4af4d7d31c4e236d22bf0b62b86d2e386b8f
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
user@user-VirtualBox:~/docker-lab$ sudo docker save -o ubuntu_image.tar ubuntu:latest
user@user-VirtualBox:~/docker-lab$ ls -lh ubuntu_image.tar
-rw------- 1 root root 77M июл  2 00:02 ubuntu_image.tar
user@user-VirtualBox:~/docker-lab$ echo $(( $(sudo docker image inspect ubuntu:latest --format='{{.Size}}') / 1024 / 1024 ))MB
74MB
```
- Размер .tar-файла превышает размер самого Docker-образа, так как docker save добавляет в архив:
  - Служебные метаданные (манифесты, JSON-описания),
  - Каждый слой в виде отдельной директории,
  - Отсутствие сжатия по умолчанию,
  - Структурные накладные расходы формата TAR (выравнивание, заголовки).
    - Таким образом, .tar чуть больше, чем сумма слоёв, представленных в docker inspect.


## Задание 1: Основные операции с контейнерами

- Список контейнеров:
```
user@user-VirtualBox:~/docker-lab$ sudo docker ps -a
[sudo] password for user: 
CONTAINER ID   IMAGE                      COMMAND                CREATED      STATUS                    PORTS     NAMES
0c6f2eb79419   docker_prac-client         "bash entrypoint.sh"   8 days ago   Up 6 hours                          client
f68f6b973aaf   docker_prac-spring4shell   "catalina.sh run"      8 days ago   Exited (143) 2 days ago             spring
95ed7d319b0c   hello-world                "/hello"               8 days ago   Exited (0) 8 days ago               competent_diffie
```

- Загрузка образа Ubuntu:
```
user@user-VirtualBox:~/docker-lab$ sudo docker pull ubuntu:latest
latest: Pulling from library/ubuntu
Digest: sha256:b59d21599a2b151e23eea5f6602f4af4d7d31c4e236d22bf0b62b86d2e386b8f
Status: Image is up to date for ubuntu:latest
docker.io/library/ubuntu:latest
```

- Запуск интерактивного контейнера:
```
user@user-VirtualBox:~/docker-lab$ sudo docker run -it --name ubuntu_container ubuntu:latest
root@baebb31f60e6:/# exit
exit
```

- Удаление образа:
```
user@user-VirtualBox:~/docker-lab$ sudo docker rmi ubuntu:latest
Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container baebb31f60e6 is using its referenced image bf16bdcff9c9
```
  - Ошибка возникает потому, что образ ubuntu:latest используется работающим или остановленным контейнером (baebb31f60e6). Docker не позволяет удалить образ, если он привязан к контейнеру.



## Задание 2: Кастомизация образа

- Запуск Nginx:
```
user@user-VirtualBox:~/docker-lab$ sudo docker run -d -p 80:80 --name nginx_container nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
3da95a905ed5: Pull complete 
6c8e51cf0087: Pull complete 
9bbbd7ee45b7: Pull complete 
48670a58a68f: Pull complete 
ce7132063a56: Pull complete 
23e05839d684: Pull complete 
ee95256df030: Pull complete 
Digest: sha256:93230cd54060f497430c7a120e2347894846a81b6a5dd2110f7362c5423b4abc
Status: Downloaded newer image for nginx:latest
9124720356b3ccd8714c9dec4387bff8c510b61322ae75479d777478644217b7
user@user-VirtualBox:~/docker-lab$ curl localhost
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

- Настройка веб-сайта
```
user@user-VirtualBox:~/docker-lab$ sudo nano index.html
<html>
<head><title>The best</title></head>
<body><h1>website</h1></body>
</html>
user@user-VirtualBox:~/docker-lab$ sudo docker cp index.html nginx_container:/usr/share/nginx/html/
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
```

- Создание кастомного образа:
```
user@user-VirtualBox:~/docker-lab$ sudo docker commit nginx_container my_website:latest
sha256:942f7353ee37000270a16acb8033f7fff44f187bf054bc44f55c28ca01ff1679
```

- Удаление оригинального контейнера:
```
user@user-VirtualBox:~/docker-lab$ sudo docker rm -f nginx_container
nginx_container
```

- Создание нового контейнера:
```
user@user-VirtualBox:~/docker-lab$ sudo docker run -d -p 80:80 --name my_website_container my_website:latest
0ef239e9833e55484805d6bfcdc6e3db84ba9b4becf8ad87d9443d166b01dabc
```

- Тестирование веб-сервера:
```
user@user-VirtualBox:~/docker-lab$ curl http://127.0.0.1:80
<html>
<head><title>The best</title></head>
<body><h1>website</h1></body>
</html>
```

- Анализ изменений образа:
```
user@user-VirtualBox:~/docker-lab$ sudo docker diff my_website_container
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
C /run
C /run/nginx.pid
```
  - Команда docker diff показывает изменения в файловой системе контейнера по сравнению с образом. Не видно index.html, потому что он был добавлен в кастомный образ my_website:latest до запуска контейнера — и потому не считается изменением.



## Задание 3: Сетевые возможности

- Создание сети:
```
user@user-VirtualBox:~/docker-lab$ sudo docker network create lab_network
b6d4298999b79ed1089e13a280a0e4909b0da2958174b65121986f1afbc7f6e4
```

- Запуск контейнеров:
```
user@user-VirtualBox:~/docker-lab$ sudo docker run -dit --network lab_network --name container1 alpine ash
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
fe07684b16b8: Pull complete 
Digest: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
Status: Downloaded newer image for alpine:latest
c901f5b57edf9cf2f8060cdea88bd61749e338fecf66af39d5f5423cd461b3ea
user@user-VirtualBox:~/docker-lab$ sudo docker run -dit --network lab_network --name container2 alpine ash
49c73f17838f0baf37ad58f66510c590f5559aecf648a5b088af1aec41c00c70
```

- Проверка соединения:
```
user@user-VirtualBox:~/docker-lab$ sudo docker exec container1 ping -c 3 container2
PING container2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.045 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.288 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.133 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.045/0.155/0.288 ms
```

### Внутренний DNS в Docker

- Когда контейнеры запускаются в одной пользовательской сети (`lab_network`), Docker автоматически создает внутренний DNS-сервер. Этот DNS:

    - Назначает имя контейнеру(--name),
    - Обеспечивает разрешение имен контейнеров друг на друга по сети,
    - Работает через встроенный адрес внутри контейнеров.

      - Это позволяет обращаться к другим контейнерам по имени


## Задание 4: Volume Persistence

- Создание тома:
```
user@user-VirtualBox:~/docker-lab$ sudo docker volume create app_data
app_data
```

- Запуск контейнера с томом:
```
user@user-VirtualBox:~/docker-lab$ sudo docker run -d -v app_data:/usr/share/nginx/html --name web nginx
502368f1cf8ac5151f310d2ab3124cde81a5b66a6ac0f9f75f107007982a82f4
```

- Копирование в контейнер index.html:
```
user@user-VirtualBox:~/docker-lab$ sudo docker cp index.html web:/usr/share/nginx/html/
Successfully copied 2.05kB to web:/usr/share/nginx/html/
```

- Проверка постоянства:
  - Остановить и удалить контейнер:
    ```
    user@user-VirtualBox:~/docker-lab$ sudo docker stop web && sudo docker rm web
    web
    web
    ```
  - Создать новый контейнер с тем же томом:
    ```
    user@user-VirtualBox:~/docker-lab$ sudo docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
    bd7f4f08259c59d7fa35f7d7fb4b9769f34e2288e8d868a776383bc1dd17053a
    ```


- Проверка, что содержимое сохранилось:
```
user@user-VirtualBox:~/docker-lab$ sudo curl localhost
<html>
<head><title>The best</title></head>
<body><h1>website</h1></body>
</html>
```

## Задание 5: Инспекция контейнера

- Запуск Redis:
```
user@user-VirtualBox:~/docker-lab$ sudo docker run -d --name redis_container redis
Unable to find image 'redis:latest' locally
latest: Pulling from library/redis
3da95a905ed5: Already exists 
db655ba2dcca: Pull complete 
4ef8fa7693bb: Pull complete 
881b4a6fb2ec: Pull complete 
6d7393f5b310: Pull complete 
4f4fb700ef54: Pull complete 
ab22bb3606ca: Pull complete 
Digest: sha256:b43d2dcbbdb1f9e1582e3a0f37e53bf79038522ccffb56a25858969d7a9b6c11
Status: Downloaded newer image for redis:latest
5e0b6c62ae2d5cb5ce8559f746ed321c37e290672592ef48cf9bbe5d8c62a46a
```

- Просмотр процессов:
```
user@user-VirtualBox:~/docker-lab$ sudo sudo docker top redis_container
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
vboxadd             17384               17362               1                   01:45               ?                   00:00:02            redis-server *:6379
```

- Получение IP:
```
user@user-VirtualBox:~/docker-lab$ sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
172.17.0.4
```

- docker exec чтобы что-то посмотреть, установить, отладить.
- docker attach когда нужно работать напрямую с приложением, запущенным в контейнере.


## Задание 6: Операции по очистке

- Проверить очистку:
```
user@user-VirtualBox:~/docker-lab$ sudo docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          8         8         1.602GB   192.2MB (11%)
Containers      9         6         20.47MB   20.46MB (99%)
Local Volumes   2         2         579B      0B (0%)
Build Cache     32        0         8.71kB    8.71kB
```

- Создание тестовых объектов:
```
user@user-VirtualBox:~/docker-lab$ for i in {1..3}; do sudo docker run --name temp$i alpine echo "hello"; done
hello
hello
hello

user@user-VirtualBox:~/docker-lab$ sudo docker build -t temp-image . && sudo docker rmi temp-image
[+] Building 0.1s (5/5) FINISHED                                                                                                                                                             docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                                   0.0s
 => => transferring dockerfile: 64B                                                                                                                                                                    0.0s
 => WARN: JSONArgsRecommended: JSON arguments recommended for CMD to prevent unintended behavior related to OS signals (line 2)                                                                        0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                                                                                                                       0.0s
 => [internal] load .dockerignore                                                                                                                                                                      0.0s
 => => transferring context: 2B                                                                                                                                                                        0.0s
 => [1/1] FROM docker.io/library/alpine:latest                                                                                                                                                         0.0s
 => exporting to image                                                                                                                                                                                 0.0s
 => => exporting layers                                                                                                                                                                                0.0s
 => => writing image sha256:8a2658296812af8500c810198aa5dc9e9aef1a2395bc40c565a07211da0d7d6e                                                                                                           0.0s
 => => naming to docker.io/library/temp-image                                                                                                                                                          0.0s

 1 warning found (use docker --debug to expand):
 - JSONArgsRecommended: JSON arguments recommended for CMD to prevent unintended behavior related to OS signals (line 2)
Untagged: temp-image:latest
Deleted: sha256:8a2658296812af8500c810198aa5dc9e9aef1a2395bc40c565a07211da0d7d6e
```

- Удалить остановленные контейнеры:
```
user@user-VirtualBox:~/docker-lab$ sudo docker container prune -f
Deleted Containers:
006511d508a9be572ac9f43f710e9af719176a7dffd26dc22b6ea4cd7b0f4a36
7134fd1e0c2c1095f0527a6bcdea28ed80f1e7ed15b346a5c10f2fbc93194ae5
5de46e60d229f7426f9ff51d019dc36d6cec86eaff4f9191a7571923cc4b8cfe
baebb31f60e6a85d5816a7faba3a5eb868491fa178cea63ee410d7afe042d95f
f68f6b973aaf5bcbab160899eb5d2b85994701803967497b248758d9ee0da801
95ed7d319b0c6b77ded98f3f22f000f06bfd1efe0df6cc19b036dae884227257

Total reclaimed space: 20.46MB
```

- Удалить неиспользуемые images:
```
user@user-VirtualBox:~/docker-lab$ sudo docker image prune -a -f
Deleted Images:
untagged: hello-world:latest
untagged: hello-world@sha256:940c619fbd418f9b2b1b63e25d8861f9cc1b46e3fc8b018ccfe8b78f19b8cc4f
deleted: sha256:74cc54e27dc41bb10dc4b2226072d469509f2f22f1a3ce74f4a59661a1d44602
deleted: sha256:63a41026379f4391a306242eb0b9f26dc3550d863b7fdbb97d899f6eb89efe72
untagged: docker_prac-spring4shell:latest
deleted: sha256:76274048bded81f55f27ef87e6fb616afdebbdab9f09f3f57f85fec32686a98e
untagged: ubuntu:latest
untagged: ubuntu@sha256:b59d21599a2b151e23eea5f6602f4af4d7d31c4e236d22bf0b62b86d2e386b8f
deleted: sha256:bf16bdcff9c96b76a6d417bd8f0a3abe0e55c0ed9bdb3549e906834e2592fd5f
deleted: sha256:a8346d259389bc6221b4f3c61bad4e48087c5b82308e8f53ce703cfc8333c7b3

Total reclaimed space: 78.12MB
```

- Проверить очистку:
```
Было

TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          8         8         1.602GB   192.2MB (11%)
Containers      9         6         20.47MB   20.46MB (99%)
Local Volumes   2         2         579B      0B (0%)
Build Cache     32        0         8.71kB    8.71kB

Стало

user@user-VirtualBox:~/docker-lab$ sudo docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          5         5         425.2MB   192.2MB (45%)
Containers      6         6         2.872kB   0B (0%)
Local Volumes   2         2         579B      0B (0%)
Build Cache     35        0         419.2MB   419.2MB
```
- Удалено 3 images, 3 контейнера.

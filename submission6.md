# Containers Lab - Docker

## Task 0: Image Exporting

1. **Export Image**

   ```sh
   docker save -o ubuntu_image.tar ubuntu:latest
   ```
вывод:  
```
root@ubuntu:/home/user# docker images
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       latest    f9248aac10f2   2 weeks ago   78.1MB
root@ubuntu:/home/user# du -h ubuntu_image.tar 
77M	ubuntu_image.tar
```
`docker save` используется для сохранения обраов, сохраненный образ меньше по размеру т.к. это размер файла на диске, а в docker images приблизительный размер в файловой системе docker

## Task 1: Core Container Operations

**Objective**: Master basic container lifecycle management.

1. **List Containers**

   ```sh
   docker ps -a
   ```
вывод:
```
root@ubuntu:/home/user# docker ps -a
CONTAINER ID   IMAGE          COMMAND       CREATED         STATUS                    PORTS     NAMES
0452ebe6df7e   f9248aac10f2   "/bin/bash"   2 seconds ago   Exited (0) 1 second ago             intelligent_mendeleev

```

1. **Pull Ubuntu Image**

   ```sh
   docker pull ubuntu:latest
   ```
вывод:
```
root@ubuntu:/home/user# docker pull ubuntu:latest
latest: Pulling from library/ubuntu
Digest: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
Status: Image is up to date for ubuntu:latest
docker.io/library/ubuntu:latest

```

2. **Run Interactive Container**
  
   ```sh
   docker run -it --name ubuntu_container ubuntu:latest
   ```
вывод:
```
root@ubuntu:/home/user# docker run -it --name ubuntu_container ubuntu:latest
root@76901929a444:/# exit
exit
```

3. **Remove Image**

   ```sh
   docker rmi ubuntu:latest
   ```
```
root@ubuntu:/home/user# docker rmi ubuntu:latest
Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container 0452ebe6df7e is using its referenced image f9248aac10f2
```
Нельзя удалить образ пока он используется хоть одним контейнером

## Task 2: Image Customization
1. **Deploy Nginx**

   ```sh
   docker run -d -p 80:80 --name nginx_container nginx
   ```
вывод:
```
oot@ubuntu:/home/user# docker run -d -p 80:80 --name nginx_container nginx
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
1c8a5b705ab0a15551c4362f3f597ea193e3d38809387c29fa6c64b0b156ee76
root@ubuntu:/home/user# curl localhost
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

2. **Customize Website**
   ```sh
   docker cp index.html nginx_container:/usr/share/nginx/html/
   ```
вывод:
```
root@ubuntu:/home/user# docker cp index.html nginx_container:/usr/share/nginx/html/
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
```

3. **Create Custom Image**

   ```sh
   docker commit nginx_container my_website:latest
   ```
вывод:
```
root@ubuntu:/home/user# docker commit nginx_container my_website:latest
sha256:edcac7d26dcc545e0746397d6c11cc032a2ef1db737fd809ce8b5b49298b8d1f
```

4. **Remove Original Container**:
 
     ```sh
     docker rm -f nginx_container
     ```
вывод:
```
root@ubuntu:/home/user# docker rm -f nginx_container
nginx_container
```

5. **Create New Container**:

     ```sh
     docker run -d -p 80:80 --name my_website_container my_website:latest
     ```
```
root@ubuntu:/home/user# docker run -d -p 80:80 --name my_website_container my_website:latest
0ee7bf5d5fc243afa406153eeb60f68eb2e07bc8bb400789594eca4cf6f42210
```
6. **Test Web Server**:

     ```sh
     curl http://127.0.0.1:80
     ```
вывод:
```
root@ubuntu:/home/user# curl http://127.0.0.1:80
<html>
<head>
<title>The best</title>
</head>
<body>
<h1>website</h1>
</body>
</html>
```
7. **Analyze Image Changes**:

     ```sh
     docker diff my_website_container
     ```
вывод:
```
root@ubuntu:/home/user# docker diff my_website_container
C /run
C /run/nginx.pid
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
```
отображает измененные файлы или директории 

## Task 3: Container Networking

1. **Create Network**:

   ```sh
   docker network create lab_network
   ```
вывод:
```
root@ubuntu:/home/user# docker network create lab_network
5f1de3016f97c1b625b045e629bf58e29a3bed527eacf8226807b10de961d24b
```

2. **Run Connected Containers**:

   ```sh
   docker run -dit --network lab_network --name container1 alpine ash
   docker run -dit --network lab_network --name container2 alpine ash
   ```
вывод:
```
root@ubuntu:/home/user# docker run -dit --network lab_network --name container1 alpine ash
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
fe07684b16b8: Pull complete 
Digest: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
Status: Downloaded newer image for alpine:latest
dd81b0326b769fc4c72437c3a25c4cac77a54d8312dcc69fbc4831894cc79cae
root@ubuntu:/home/user# docker run -dit --network lab_network --name container2 alpine ash
c6cda0b4b3489d6edfa7130582c3841746ffcb199660fee1bfc4c41b4ecb84d0
```
3. **Test Connectivity**:


   ```sh
   docker exec container1 ping -c 3 container2
   ```
вывод:
```
root@ubuntu:/home/user# docker exec container1 ping -c 3 container2
PING container2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.116 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.066 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.063 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.063/0.081/0.116 ms

```
Пинг работает т.к. внутренний dns docker резолвит имена контейнеров находящихся в одной docker сети

## Task 4: Volume Persistence

1. **Create Volume**:
   ```sh
   docker volume create app_data
   ```
вывод:
```
root@ubuntu:/home/user# docker volume create app_data
app_data
```

2. **Run Container with Volume**:

   ```sh
   docker run -d -v app_data:/usr/share/nginx/html --name web nginx
   ```
вывод:
```
root@ubuntu:/home/user# docker run -d -v app_data:/usr/share/nginx/html --name web nginx
9bf04ad9d6ab3d145c85646b5d499614fda7d1cd04e3b8d18570b4a20c092780
```
3. **Modify Content**:

   ```sh
   docker cp index.html web:/usr/share/nginx/html/
   ```
вывод:
```
root@ubuntu:/home/user# docker cp index.html web:/usr/share/nginx/html/
Successfully copied 2.05kB to web:/usr/share/nginx/html/
```
4. **Verify Persistence**:

   ```sh
   docker stop web && docker rm web
   ```
вывод:
```
root@ubuntu:/home/user# docker stop web && docker rm web
web
web
```

   ```sh
   docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
   ```
вывод:
```
root@ubuntu:/home/user# docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
7766d61a3e835ec208cdd658fc38c27128e8ec12984d4747cfa4fc4fde2472e5
```
вывод:
```
root@ubuntu:/home/user# curl localhost
<html>
<head>
<title>new site</title>
</head>
<body>
<h1>new best website</h1>
</body>
</html>
```

## Task 5: Container Inspection

1. **Run Redis Container**:

   ```sh
   docker run -d --name redis_container redis
   ```
вывод:
```
root@ubuntu:/home/user# docker run -d --name redis_container redis
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
3eec5d011b862dd075431023c368590882c84df7b3e536a02b12a0025a0fdc37
```

2. **Inspect Processes**:
   - Find Redis server process:

   ```sh
   docker exec redis_container ps aux
   ```
вывод:
```
root@ubuntu:/home/user# docker exec redis_container ps aux
OCI runtime exec failed: exec failed: unable to start container process: exec: "ps": executable file not found in $PATH: unknown
root@ubuntu:/home/user# docker top redis_container
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
999                 4477                4454                0                   07:40               ?                   00:00:00            redis-server *:6379
```
`ps` отсутствует в контейнере, похтому используется `docker top`

3. **Network Inspection**:

   ```sh
   docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
   ```
вывод:
```
root@ubuntu:/home/user# docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
172.17.0.4
```
4. **exec vs attach**:

`docker exec` позволяет запускать дополнительные процессы внутри запущенного контейнера  
`docker attach` позволяет подключаться к стандартному потоку ввода/вывода уже запущенного процесса в контейнере

## Task 6: Cleanup Operations

1. **Verify Cleanup**:


   ```sh
   docker system df
   ```
вывод:
```
root@ubuntu:/home/user# docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          5         5         331.7MB   192.2MB (57%)
Containers      7         5         2.195kB   5B (0%)
Local Volumes   2         2         592B      0B (0%)
Build Cache     0         0         0B        0B
```
2. **Create Test Objects**:


   ```sh
   for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
   ```
вывод:
```
root@ubuntu:/home/user# for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
hello
hello
hello
```

   ```sh
   docker build -t temp-image . && docker rmi temp-image
   ```
вывод:
```
root@ubuntu:/home/user# docker build -t temp-image . && docker rmi temp-image
[+] Building 0.1s (1/1) FINISHED                                                                                                                                               docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                     0.0s
 => => transferring dockerfile: 2B                                                                                                                                                       0.0s
ERROR: failed to build: failed to solve: failed to read dockerfile: open Dockerfile: no such file or directory
root@ubuntu:/home/user# echo "FROM alpine" > Dockerfile
root@ubuntu:/home/user# docker build -t temp-image . && docker rmi temp-image
[+] Building 0.2s (5/5) FINISHED                                                                                                                                               docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                     0.0s
 => => transferring dockerfile: 49B                                                                                                                                                      0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                                                                                                         0.0s
 => [internal] load .dockerignore                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                          0.0s
 => [1/1] FROM docker.io/library/alpine:latest                                                                                                                                           0.0s
 => exporting to image                                                                                                                                                                   0.0s
 => => exporting layers                                                                                                                                                                  0.0s
 => => writing image sha256:cea2ff433c610f5363017404ce989632e12b953114fefc6f597a58e813c15d61                                                                                             0.0s
 => => naming to docker.io/library/temp-image                                                                                                                                            0.0s
Untagged: temp-image:latest
```
3. **Remove Stopped Containers**:

   ```sh
   docker container prune -f
   ```
вывод:
```
root@ubuntu:/home/user# docker container prune -f
Deleted Containers:
3eec838434c5d1bb6e1c4449a64f5fd17eb48cc349b8d75b1e7a03be52c97def
e7ef925317d1179b2b098e37843684d0ef0f26d1244cb46055550a8e78461283
2f49268f27181e5bd5b650601b7802a418cce5fdbd430576a26adeb76f43bb3c
76901929a4445dc6ce1106f0b849804c83f45190e84cb60d977c71d8a012c9f9
0452ebe6df7e8a2ac98a615b61c6727ac6b1fa099d68a0aecc89eb49f80321af

Total reclaimed space: 5B
```
4. **Remove Unused Images**:

   ```sh
   docker image prune -a -f
   ```
вывод:
```
root@ubuntu:/home/user# docker image prune -a -f
Deleted Images:
untagged: ubuntu:latest
untagged: ubuntu@sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
deleted: sha256:f9248aac10f2f82e0970222e36cc7b71215b88e974e001282e5cd89797a82218
deleted: sha256:45a01f98e78ce09e335b30d7a3080eecab7f50dfa0b38ca44a9dee2654ac0530

Total reclaimed space: 78.12MB
```
5. **Verify Cleanup**:


   ```sh
   docker system df
   ```

вывод:
```
root@ubuntu:/home/user# docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          4         4         253.6MB   192.2MB (75%)
Containers      5         5         2.19kB    0B (0%)
Local Volumes   2         2         592B      0B (0%)
Build Cache     3         0         0B        0B
```


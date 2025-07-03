## LAB 6
Nikita Yaneev n.yaneev@innopolis.unversity


### Task 1

Original image - 77MB

.tar - 78.1MB

When using docker save, each layer is included in full—even if some layers are identical to those in other images. In contrast, Docker’s local storage system deduplicates shared layers and stores them only once

1. 

*Input:*
```bash 
docker ps -a
```

*Output*:
```sh
sumnios@Nikita:~$ docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

2. 
*Input:*
```bash 
docker pull ubuntu:latest
```

*Output*:
```sh
sumnios@Nikita:~$ docker pull ubuntu:latest
latest: Pulling from library/ubuntu
Digest: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
Status: Image is up to date for ubuntu:latest
docker.io/library/ubuntu:latest
```

3.

*Input:*
```bash 
docker run -it --name ubuntu_container ubuntu:latest
```

*Output*:
```sh
sumnios@Nikita:~$ docker run -it --name ubuntu_container ubuntu:latest
root@e9057931a958:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@e9057931a958:/#
```

4.

*Input:*
```bash 
docker rmi ubuntu:latest
```

*Output*:
```sh
sumnios@Nikita:~$ docker rmi ubuntu:latest
Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container e9057931a958 is using its referenced image f9248aac10f2
```

Docker won’t let you remove image because there’s still a container (e9057931a958) that is using that image (f9248aac10f2).

Since the image is in use, Docker blocks its removal to prevent breaking the container

### Task 2

1.

*Input:*
```bash 
docker save -o ubuntu_image.tar ubuntu:latest
```

*Output*:
```sh
sumnios@Nikita:~$ docker save -o ubuntu_image.tar ubuntu:latest
sumnios@Nikita:~$ ls
Dockerfile  SSEC  index.html  nltk_data  packets.pcap  snap  ubuntu_image.tar

```

2.

*Input:*
```bash 
docker cp index.html nginx_container:/usr/share/nginx/html/
```

*Output*:
```sh
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
```

3.

*Input:*
```bash 
docker commit nginx_container my_website:latest
```

*Output*:
```sh
sumnios@Nikita:~$ docker commit nginx_container my_website:latest
sha256:98e09a4cc7fa2ff463378f9f6513a2a959bd7b03ef111a5ef4f58586113be4c8
```

4.

*Input:*
```bash 
docker rm -f nginx_container
```

*Output*:
```sh
sumnios@Nikita:~$ docker rm -f nginx_container
nginx_container
```

5.

*Input:*
```bash 
docker run -d -p 80:80 --name my_website_container my_website:latest
```

*Output*:
```sh
sumnios@Nikita:~$ docker run -d -p 80:80 --name my_website_container my_website:latest
f7229cb5c1e595009382683d313f8bc88eba8ae0571238cc70e89dce6443e340
```

6.
*Input:*
```bash 
curl http://127.0.0.1:80
```

*Output*:
```sh
sumnios@Nikita:~$ curl http://127.0.0.1:80
<html>
<head>
<title>The best</title>
</head>
<body>
<h1>website</h1>
</body>
</html>

```


7. 

*Input:*
```bash 
docker diff my_website_container
```

*Output*:
```sh
sumnios@Nikita:~$ docker diff my_website_container
C /run
C /run/nginx.pid
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
```

The docker diff command shows changes made to the container's filesystem compared to its original image. Each line is prefixed with:

A: Added

D: Deleted

C: Changed

In this case:

All listed files/directories are marked with C, indicating they changed since the container was started

### Task 3


1. 
*Input:*
```bash 
docker network create lab_network
```

*Output*:
```sh
sumnios@Nikita:~$ docker network create lab_network
7516b09f1fb9e8c29c59056dd362564f6c830c51e2511d4dd0dfdf39116b4d02
```

2.
*Input:*
```bash 
docker run -dit --network lab_network --name container1 alpine ash
docker run -dit --network lab_network --name container2 alpine ash
```

*Output*:
```sh
sumnios@Nikita:~$ docker run -dit --network lab_network --name container1 alpine ash
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
fe07684b16b8: Pull complete
Digest: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
Status: Downloaded newer image for alpine:latest
1e4112102d2ef6f2eea2e98715cce19e734a47a8442bfa61657921c6755bb174


sumnios@Nikita:~$ docker run -dit --network lab_network --name container2 alpine ash
d4356cbdd8db8f55eae2e07a4e9fcd7bcc83245a29a598cccd0e1992a256643a
```


3.

*Input:*
```bash 
docker exec container1 ping -c 3 container2
```

*Output*:
```sh
sumnios@Nikita:~$ docker exec container1 ping -c 3 container2
PING container2 (172.19.0.3): 56 data bytes
64 bytes from 172.19.0.3: seq=0 ttl=64 time=0.673 ms
64 bytes from 172.19.0.3: seq=1 ttl=64 time=0.135 ms
64 bytes from 172.19.0.3: seq=2 ttl=64 time=0.121 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.121/0.309/0.673 ms
```


4.
Docker provides internal DNS resolution so containers can communicate using container names or service names instead of IP addresses
### Task 4

1.

*Input:*
```bash 
docker volume create app_data
```

*Output*:
```sh
sumnios@Nikita:~$ docker volume create app_data
app_data
```

2.

*Input:*
```bash 
docker run -d -v app_data:/usr/share/nginx/html --name web nginx
```

*Output*:
```sh
sumnios@Nikita:~$ docker run -d -v app_data:/usr/share/nginx/html --name web nginx
6b0db6651069884fc4bee7e7f2189e692036edd720829901635bba6b087f43b9
```

3.

*Input:*
```bash 
docker cp index.html web:/usr/share/nginx/html/
```

*Output*:
```sh
sumnios@Nikita:~$ docker cp index.html web:/usr/share/nginx/html/
Successfully copied 2.05kB to web:/usr/share/nginx/html/
```

4.
*Input:*
```bash 
docker stop web && docker rm web
```

*Output*:
```sh
sumnios@Nikita:~$ docker stop web && docker rm web
web
web
```

*Input:*
```bash 
docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
```

*Output*:
```sh
sumnios@Nikita:~$ docker run -d -p 80:80 -v app_data:/usr/share/nginx/html --name web_new nginx
b149ee4dac177c85864976f70a4c93df3b1d0e909543874e1f3544c6323715ff
sumnios@Nikita:~$ curl localhost
<html>
<head>
<title>The best</title>
</head>
<body>
<h1>website</h1>
<h2>New website</h2>
</body>
</html>
```

### Task 5

1. 

*Input:*
```bash 
docker run -d --name redis_container redis
```

*Output*:
```sh
sumnios@Nikita:~$ docker run -d --name redis_container redis
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
b69ce01ee46023e637686182fda2512f977edded823a7f296673583e4aa8eafe
```

2.
*Input:*
```bash 
docker exec redis_container ps aux
```

*Output*:
```sh
sumnios@Nikita:~$ docker top redis_container
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
999                 5795                5772                0                   19:40               ?                   00:00:00            redis-server *:6379
```

3.
*Input:*
```bash 
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
```

*Output*:
```sh
sumnios@Nikita:~$ docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
172.17.0.3
```


| Feature               | `docker exec`                                   | `docker attach`                                         |
| --------------------- | ----------------------------------------------- | ------------------------------------------------------- |
| **Purpose**           | Run a new process in a running container        | Attach to the container's main process                  |
| **Use Case**          | Debugging, one-off commands (e.g., bash)        | Viewing live output or interacting with main process    |
| **Interference**      | Runs separately; non-intrusive                  | Shares stdin/stdout with main process                   |
| **Multiple sessions** | Supports multiple simultaneous sessions         | Only one attach session at a time (risk of disruption)  |
| **Disconnection**     | Exit the command without stopping the container | `Ctrl+C` may stop the container unless handled properly |


### Task 6

1.

*Input:*
```bash 
docker system df
```

*Output*:
```sh
sumnios@Nikita:~$ docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          5         4         331.7MB   192.2MB (57%)
Containers      5         4         1.103kB   8B (0%)
Local Volumes   2         2         605B      0B (0%)
Build Cache     4         0         20.2kB    20.2kB
```

2.

*Input:*
```bash 
for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
```

*Output*:
```sh
sumnios@Nikita:~$ for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
hello
hello
hello
```

*Input:*
```bash 
docker build -t temp-image . && docker rmi temp-image
```

*Output*:
```sh
sumnios@Nikita:~$ docker build -t temp-image . && docker rmi temp-image
[+] Building 0.3s (5/5) FINISHED                                                               docker:default
 => [internal] load build definition from Dockerfile                                                     0.0s
 => => transferring dockerfile: 72B                                                                      0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                         0.0s
 => [internal] load .dockerignore                                                                        0.0s
 => => transferring context: 2B                                                                          0.0s
 => [1/1] FROM docker.io/library/alpine:latest                                                           0.0s
 => exporting to image                                                                                   0.1s
 => => exporting layers                                                                                  0.0s
 => => writing image sha256:00f28275e19b78b817486e744168ce87bc4fe7f13000cd715ffda0c786c053ab             0.0s
 => => naming to docker.io/library/temp-image                                                            0.0s
Untagged: temp-image:latest
Deleted: sha256:00f28275e19b78b817486e744168ce87bc4fe7f13000cd715ffda0c786c053ab
```


3.

*Input:*
```bash 
docker build -t temp-image . && docker rmi temp-image
```

*Output*:
```sh
sumnios@Nikita:~$ docker container prune -f
Deleted Containers:
e2faa3695fc89a30939f5db1492f52bdc00e51e2a37ff93956f735e4ac54e325
ec451ae483712f9b8d96d4dc88928c2027baa0e4692e2278be4183aa3ea42dee
0297f1c041c914dbfe226386ff05f772708156e3a88f6a83db9dbad2fb8d7e9c
e9057931a958f90c74d77ec7ebdade3bc89399db54ab51039b00bd259938efe2

Total reclaimed space: 8B
```

4. 

*Input:*
```bash 
docker container prune -f
```

*Output*:
```sh
sumnios@Nikita:~$ docker image prune -a -f
Deleted Images:
untagged: ubuntu:latest
untagged: ubuntu@sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
deleted: sha256:f9248aac10f2f82e0970222e36cc7b71215b88e974e001282e5cd89797a82218
deleted: sha256:45a01f98e78ce09e335b30d7a3080eecab7f50dfa0b38ca44a9dee2654ac0530
untagged: my_website:latest
deleted: sha256:98e09a4cc7fa2ff463378f9f6513a2a959bd7b03ef111a5ef4f58586113be4c8
deleted: sha256:babfbdec8e878160b8af78f4dbb11cd3309c88845185a73bfd5e325b583373d8

Total reclaimed space: 78.12MB
```

5.

*Input:*
```bash 
docker system df
```

*Output*:
```sh
sumnios@Nikita:~$ docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          3         3         253.6MB   74.81MB (29%)
Containers      4         4         1.095kB   0B (0%)
Local Volumes   2         2         605B      0B (0%)
Build Cache     7         0         20.24kB   20.24kB
```
# Lab 6

## Image exporting

### Export Image

```
docker pull ubuntu:latest
```

```
latest: Pulling from library/ubuntu
b08e2ff4391e: Pull complete 
Digest: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```

```
docker save -o ubuntu_image.tar ubuntu:latest
```

```
docker images | grep ubuntu
ubuntu            latest    f9248aac10f2   2 weeks ago   78.1MB
```

```
ls -lh ubuntu_image.tar
-rw------- 1 root root 77M Jul  5 22:22 ubuntu_image.tar
```

In this case, the exported .tar file was slightly smaller than the declared image size.

Possible reasons:

- Docker rounds up values ​​when changing the image shape
- The exported archive contains only the necessary components without service data.

- Some metadata may be more rigid when exporting

Usually, the .tar archive looks more attractive, for example:

- Images in Docker Hub are saved in compressed form.
- `docker save` creates a non-native archive with all layers
- The archive includes additional information about the image representation


## Core Container Operations

```
docker ps -a
```

```
CONTAINER ID   IMAGE                    COMMAND                  CREATED        STATUS                    PORTS                                             NAMES
e6f6e4c88563   rhasspy/rhasspy          "bash /usr/lib/rhass…"   2 months ago   Up 6 weeks                0.0.0.0:12101->12101/tcp, [::]:12101->12101/tcp   rhasspy
ece98e0fc03b   rhasspy/rhasspy:latest   "bash /usr/lib/rhass…"   4 months ago   Exited (1) 4 months ago                                                     laughing_wilson
```

```
docker run -it --name ubuntu_container ubuntu:latest
```

```
docker ps -a
```


```
CONTAINER ID   IMAGE                    COMMAND                  CREATED          STATUS                        PORTS                                             NAMES
8077b9663089   ubuntu:latest            "/bin/bash"              20 seconds ago   Exited (127) 13 seconds ago                                                     ubuntu_container
e6f6e4c88563   rhasspy/rhasspy          "bash /usr/lib/rhass…"   2 months ago     Up 6 weeks                    0.0.0.0:12101->12101/tcp, [::]:12101->12101/tcp   rhasspy
ece98e0fc03b   rhasspy/rhasspy:latest   "bash /usr/lib/rhass…"   4 months ago     Exited (1) 4 months ago                                                         laughing_wilson
```

Ubuntu appeared


```
docker rmi ubuntu:latest
```

```
Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container 8077b9663089 is using its referenced image f9248aac10f2
```

We can't remove repository because container 8077b9663089 is using its image

```
docker rm 8077b9663089
```

```
docker rmi ubuntu:latest
```

```
Untagged: ubuntu:latest
Untagged: ubuntu@sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
Deleted: sha256:f9248aac10f2f82e0970222e36cc7b71215b88e974e001282e5cd89797a82218
Deleted: sha256:45a01f98e78ce09e335b30d7a3080eecab7f50dfa0b38ca44a9dee2654ac0530
```


```
docker ps -a
```

```
CONTAINER ID   IMAGE                    COMMAND                  CREATED        STATUS                    PORTS                                             NAMES
e6f6e4c88563   rhasspy/rhasspy          "bash /usr/lib/rhass…"   2 months ago   Up 6 weeks                0.0.0.0:12101->12101/tcp, [::]:12101->12101/tcp   rhasspy
ece98e0fc03b   rhasspy/rhasspy:latest   "bash /usr/lib/rhass…"   4 months ago   Exited (1) 4 months ago                                                     laughing_wilson
```

Ubuntu disappeared


## Image Customization

```
docker run -d -p 80:80 --name nginx_container nginx
```

```
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
2301322d4e662369d1ce5e4e5fd09a02779b083df0360307ded5b86d63e2dcd7
```

```
curl localhost:80
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

i have created index.html file

```
docker cp index.html nginx_container:/usr/share/nginx/html/
```

```
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
```

```
docker commit nginx_container my_website:latest
```

```
sha256:27bd739206a4b60f4bff18d0d3d0a770f0ec8b0a2ae82c87cf3db6147d925f65
```

```
docker rm -f nginx_container
```

```
docker run -d -p 80:80 --name my_website_container my_website:latest
```

```
curl localhost:80
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

```
docker diff my_website_container 
```

```
C /run
C /run/nginx.pid
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
```

Here we can see that we changed runtime directory -> nginx process id

And also we changed default.conf file in `/etc/nginx/conf.d/default.conf`




## Container Networking

```
docker network create lab_network
```

```
4ed9d2b7ae9c3b4d0fb092ac26ce7000828f17c46a2397feeb7d5a58d3b41b24
```

```
docker run -dit --network lab_network --name container1 alpine ash
```

```
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
fe07684b16b8: Pull complete 
Digest: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
Status: Downloaded newer image for alpine:latest
a49913c5a247e57ca30a287a4d9c15cb0da880433baa7cc4f6b698d68d19da1c
```

```
docker run -dit --network lab_network --name container2 alpine ash
```

```
0b4b5a5690f241d82afe8fc6dc515cfd50baed90ed8e1ae3214c994892856988
```

```
docker exec container1 ping -c 3 container2
```

```
PING container2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.039 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.039 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.039 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.039/0.039/0.039 ms
```

- internal DNS automatically resolves container names to their IPs within the network.

- When creating a network, Docker deploys a built-in DNS server that:

  - Maps the --name of a container to its IP.

  - Only works in custm networks (not the default bridge).

- Containers can address each other by name without needing to know the IP;


## Volume Persistence

```
docker volume create app_data
```

```
app_data
```

```
docker run -d -v app_data:/usr/share/nginx/html --name web nginx
```

```
bf93a4749ac12e99983755edae8febcefa30bc792994a89c652f29184a430416
```

```
echo "<h1>My Persistent Website</h1>" > index.html
```

```
docker cp index.html web:/usr/share/nginx/html/
```

```
Successfully copied 2.05kB to web:/usr/share/nginx/html/
```

```
docker stop web && docker rm web
```

```
docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
```

```
curl localhost
```

```
<h1>My Persistent Website</h1>
```

## Container Inspection

```
docker run -d --name redis_container redis
```

OK

```
docker exec redis_container ps aux
```

```
ps aux | grep redis
```

```
999      2855488  0.1  0.0 153456 17664 ?        Ssl  22:55   0:00 redis-server *:6379
```

```
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
```

```
172.17.0.5
```

docker exec — starts a new process inside a container (e.g. /bin/bash) without affecting the main process. Safe: after exiting, the container continues to run. Ideal for debugging.

docker attach — attaches directly to the main container process (PID 1). Dangerous: Ctrl+C will kill the container. Only suitable for interactive applications (e.g. REPL), not for services like Nginx/Redis.


## Cleanup Operations

```
docker system df
```

```
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          6         5         2.073GB   192.2MB (9%)
Containers      7         6         456.3kB   0B (0%)
Local Volumes   10        3         909.2MB   717.4MB (78%)
Build Cache     0         0         0B        0B
```

```
for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
```

```
hello
hello
hello
```

```
docker build -t temp-image . && docker rmi temp-image
```

```
[+] Building 0.0s (1/1) FINISHED                                                                                                        docker:default
 => [internal] load build definition from Dockerfile                                                                                              0.0s
 => => transferring dockerfile: 2B                                                                                                                0.0s
ERROR: failed to solve: failed to read dockerfile: open Dockerfile: no such file or directory
```

```
echo "FROM alpine" > Dockerfile
```

```
 docker build -t temp-image . && docker rmi temp-image
```

```
[+] Building 0.0s (5/5) FINISHED                                                                                                        docker:default
 => [internal] load build definition from Dockerfile                                                                                              0.0s
 => => transferring dockerfile: 49B                                                                                                               0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                                                                  0.0s
 => [internal] load .dockerignore                                                                                                                 0.0s
 => => transferring context: 2B                                                                                                                   0.0s
 => CACHED [1/1] FROM docker.io/library/alpine:latest                                                                                             0.0s
 => exporting to image                                                                                                                            0.0s
 => => exporting layers                                                                                                                           0.0s
 => => writing image sha256:cea2ff433c610f5363017404ce989632e12b953114fefc6f597a58e813c15d61                                                      0.0s
 => => naming to docker.io/library/temp-image                                                                                                     0.0s
Untagged: temp-image:latest
```

```
docker container prune -f
```

```
Deleted Containers:
db2988c3df659b81ebb70f7ab2f91c47950faed11a3b95e3471d32fdcc495dfb
c54047b624d1f1bd5722de3908a5b8f9522913624e1d56fe98c326dd67f89bd1
e965cc12af3e784c3e99bd5b921ac03d34e8c7ad1b6f27be9111a8a8f518bc1f
ece98e0fc03b6ceae73523a28aa7f8c99e714e42649d3be0f4f683b1bf0fac56

Total reclaimed space: 0B
```

```
docker image prune -a -f
```

```
Deleted Images:
deleted: sha256:27bd739206a4b60f4bff18d0d3d0a770f0ec8b0a2ae82c87cf3db6147d925f65
deleted: sha256:ad5dc293930710e1781ad3db4e8365e0b76799d8085b0c7844dbdc5edf397733

Total reclaimed space: 1.181kB
```


```
docker system df
```

```
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          5         5         2.073GB   192.2MB (9%)
Containers      6         6         456.3kB   0B (0%)
Local Volumes   10        3         909.2MB   717.4MB (78%)
Build Cache     3         0         12B       12B
```

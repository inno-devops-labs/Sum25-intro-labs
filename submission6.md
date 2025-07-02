## Task 0: Image Exporting

- 28,3 MB - Tar size
- 117.29 MB - Docker image size

## Task 1: Core Container Operations

### 1. List Containers
```sh
docker ps -a
```
```sh
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

As we can see, now there is no containers

### 2. Pull Ubuntu Image
```sh
docker pull ubuntu:latest
```
```sh
latest: Pulling from library/ubuntu
b08e2ff4391e: Download complete
Digest: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```
```sh
docker image list
```
```sh
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       latest    440dcf6a5640   12 days ago   117MB
```
### 3. Run Interactive Container
```sh
docker run -it --name ubuntu_container ubuntu:latest
```
```sh
root@180d40652a3b:/# exit
exit
```
### 4. Remove Image
```sh
docker rmi ubuntu:latest
```
```sh
Error response from daemon: conflict: unable to delete ubuntu:latest (must be forced) - container 180d40652a3b is using its referenced image 440dcf6a5640
```
Docker links containers to their source images. If you try to remove the image, it'll check if any container (even stopped ones) are using it. It blocks deletion to avoid losing the container (otherwise there would be no link to the image).

## Task 2: Image Customization

### 1. Deploy Nginx
```sh
docker run -d -p 80:80 --name nginx_container nginx
```
```sh
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
ee95256df030: Download complete
48670a58a68f: Download complete
23e05839d684: Download complete
6c8e51cf0087: Download complete
ce7132063a56: Download complete
3da95a905ed5: Download complete
9bbbd7ee45b7: Download complete
Digest: sha256:93230cd54060f497430c7a120e2347894846a81b6a5dd2110f7362c5423b4abc
Status: Downloaded newer image for nginx:latest
d93403853fe3ccd0730f3a03d7f3027b07a8cd963851d8b0dcad898ebea86a8e
```
```sh
curl localhost
```
```sh
StatusCode        : 200
StatusDescription : OK
Content           : <!DOCTYPE html>
                    <html>
                    <head>
                    <title>Welcome to nginx!</title>
                    <style>
                    html { color-scheme: light dark; }
                    body { width: 35em; margin: 0 auto;
                    font-family: Tahoma, Verdana, Arial, sans-serif; }
                    </style...
RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Accept-Ranges: bytes
                    Content-Length: 615
                    Content-Type: text/html
                    Date: Wed, 02 Jul 2025 17:22:40 GMT
                    ETag: "685adee1-267"
                    Last-Modified: Tue, 24 Jun 2025 ...
Forms             : {}
Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 615], [Content-Type, text/html]
                    ...}
Images            : {}
InputFields       : {}
Links             : {@{innerHTML=nginx.org; innerText=nginx.org; outerHTML=<A href="http://nginx.org/">nginx.org</A>; o
                    uterText=nginx.org; tagName=A; href=http://nginx.org/}, @{innerHTML=nginx.com; innerText=nginx.com;
                     outerHTML=<A href="http://nginx.com/">nginx.com</A>; outerText=nginx.com; tagName=A; href=http://n
                    ginx.com/}}
ParsedHtml        : System.__ComObject
RawContentLength  : 615
```
### 2. Customize Website
```sh
docker cp index.html nginx_container:/usr/share/nginx/html/
```
```sh
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
```
### 3. Create Custom Image
```sh
docker commit nginx_container my_website:latest
```
```sh
sha256:XXXXXX
```
### 4. Remove Original Container
```sh
docker rm -f nginx_container
```
```sh
nginx_container
```
### 5. Create New Container
```sh
docker run -d -p 80:80 --name my_website_container my_website:latest
```
```sh
9db562572f2eb239798cdb32d37ce2fb3a0e456b42f8b6039d3e30678979c6b9
```
### 6. Test Web Server
```sh
curl http://127.0.0.1:80
```
```sh
StatusCode        : 200
StatusDescription : OK
Content           : <html>
                    <head>
                    <title>The best</title>
                    </head>
                    <body>
                    <h1>website</h1>
                    </body>
                    </html>
RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Accept-Ranges: bytes
                    Content-Length: 92
                    Content-Type: text/html
                    Date: Wed, 02 Jul 2025 17:29:44 GMT
                    ETag: "68656b53-5c"
                    Last-Modified: Wed, 02 Jul 2025 17...
Forms             : {}
Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 92], [Content-Type, text/html].
                    ..}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : System.__ComObject
RawContentLength  : 92
```
### 7. Analyze Image Changes
```sh
docker diff my_website_container
```
```sh
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
C /run
C /run/nginx.pid
```

So, C stands for Changed. That means, that our image changes 6 files in comparison to default image.

## Task 3: Container Networking

### 1. Create Network
```sh
docker network create lab_network
```
```sh
59b57969b4c1274217a44fc5f48dac868c4a81c848eaacb5cd9a3677e1a99454
```
### 2. Run Connected Containers
```sh
docker run -dit --network lab_network --name container1 alpine ash
```
```sh
45dd8fb8282de47a54b4bba8e4455d7b42793b3227281b710e6e713c8f65c307
```
```sh
docker run -dit --network lab_network --name container2 alpine ash
```
```sh
af64bb10b0384d9164c658a975c2d33df3017ca8934f31c1a0965598d55ff26a
```
### 3. Test Connectivity
```sh
docker exec container1 ping -c 3 container2
```
```sh
PING container2 (172.19.0.3): 56 data bytes
64 bytes from 172.19.0.3: seq=0 ttl=64 time=0.138 ms
64 bytes from 172.19.0.3: seq=1 ttl=64 time=0.204 ms
64 bytes from 172.19.0.3: seq=2 ttl=64 time=0.203 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.138/0.181/0.204 ms
```
### 4. Documentation
Docker resolves container2 to 172.19.0.3, which is its internal IP address on the Docker network — this resolution happens automatically via Docker's built-in DNS system. It just maps names to IP addresses. 

## Task 4: Volume Persistence

### 1. Create Volume
```sh
docker volume create app_data
```
```sh
app_data
```

### 2. Run Container with Volume
```sh
docker run -d -v app_data:/usr/share/nginx/html --name web nginx
```
```sh
0bf95abb40bbe92734f858eaef377eaa5041dd7ecb80108e4faa3b4b4c7e0e7d
```

### 3. Modify Content
```sh
docker cp index.html web:/usr/share/nginx/html/
```
```sh
Successfully copied 2.05kB to web:/usr/share/nginx/html/
```

### 4. Verify Persistence
```sh
docker stop web
```
```sh
web
```
```sh
docker rm web
```
```sh
web
```
```sh
docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
```
```sh
8a904432612d6a84020d3abbadc85f1681dc48f65a13dd990d1543aa726d3b81
```
```sh
curl localhost
```
```sh
StatusCode        : 200
StatusDescription : OK
Content           : <html>
                    <head>
                    <title>The best</title>
                    </head>
                    <body>
                    <h1>website</h1>
                    </body>
                    </html>
RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Accept-Ranges: bytes
                    Content-Length: 92
                    Content-Type: text/html
                    Date: Wed, 02 Jul 2025 17:57:23 GMT
                    ETag: "68656b53-5c"
                    Last-Modified: Wed, 02 Jul 2025 17...
Forms             : {}
Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 92], [Content-Type, text/html].
                    ..}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : System.__ComObject
RawContentLength  : 92
```

It worked)

## Task 5: Container Inspection

### 1. Run Redis Container
```sh
docker run -d --name redis_container redis
```
```sh
Unable to find image 'redis:latest' locally
latest: Pulling from library/redis
881b4a6fb2ec: Download complete
db655ba2dcca: Download complete
ab22bb3606ca: Download complete
6d7393f5b310: Download complete
4f4fb700ef54: Already exists
4ef8fa7693bb: Download complete
Digest: sha256:b43d2dcbbdb1f9e1582e3a0f37e53bf79038522ccffb56a25858969d7a9b6c11
Status: Downloaded newer image for redis:latest
505ce9ea14b74762f9a7d155547034b40b2a92c3141d50e5c061b6babb05dfab
```
### 2. Inspect Processes
```sh
docker exec -it redis_container sh
# apt update && apt install -y procps
Get:1 http://deb.debian.org/debian bookworm InRelease [151 kB]
Get:2 http://deb.debian.org/debian bookworm-updates InRelease [55.4 kB]
Get:3 http://deb.debian.org/debian-security bookworm-security InRelease [48.0 kB]
Get:4 http://deb.debian.org/debian bookworm/main amd64 Packages [8793 kB]
Get:5 http://deb.debian.org/debian bookworm-updates/main amd64 Packages [756 B]
Get:6 http://deb.debian.org/debian-security bookworm-security/main amd64 Packages [270 kB]
Fetched 9318 kB in 4s (2651 kB/s)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
All packages are up to date.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libgpm2 libncursesw6 libproc2-0 psmisc
Suggested packages:
  gpm
The following NEW packages will be installed:
  libgpm2 libncursesw6 libproc2-0 procps psmisc
0 upgraded, 5 newly installed, 0 to remove and 0 not upgraded.
Need to get 1178 kB of archives.
After this operation, 3778 kB of additional disk space will be used.
Get:1 http://deb.debian.org/debian bookworm/main amd64 libncursesw6 amd64 6.4-4 [134 kB]
Get:2 http://deb.debian.org/debian bookworm/main amd64 libproc2-0 amd64 2:4.0.2-3 [62.8 kB]
Get:3 http://deb.debian.org/debian bookworm/main amd64 procps amd64 2:4.0.2-3 [709 kB]
Get:4 http://deb.debian.org/debian bookworm/main amd64 libgpm2 amd64 1.20.7-10+b1 [14.2 kB]
Get:5 http://deb.debian.org/debian bookworm/main amd64 psmisc amd64 23.6-1 [259 kB]
Fetched 1178 kB in 1s (1418 kB/s)
Selecting previously unselected package libncursesw6:amd64.
(Reading database ... 6100 files and directories currently installed.)
Preparing to unpack .../libncursesw6_6.4-4_amd64.deb ...
Unpacking libncursesw6:amd64 (6.4-4) ...
Selecting previously unselected package libproc2-0:amd64.
Preparing to unpack .../libproc2-0_2%3a4.0.2-3_amd64.deb ...
Unpacking libproc2-0:amd64 (2:4.0.2-3) ...
Unpacking procps (2:4.0.2-3) ...
Selecting previously unselected package libgpm2:amd64.
Preparing to unpack .../libgpm2_1.20.7-10+b1_amd64.deb ...
Unpacking libgpm2:amd64 (1.20.7-10+b1) ...
Selecting previously unselected package psmisc.
Preparing to unpack .../psmisc_23.6-1_amd64.deb ...
Unpacking psmisc (23.6-1) ...
Setting up libgpm2:amd64 (1.20.7-10+b1) ...
Setting up psmisc (23.6-1) ...
Setting up libproc2-0:amd64 (2:4.0.2-3) ...
Setting up libncursesw6:amd64 (6.4-4) ...
Setting up procps (2:4.0.2-3) ...
Processing triggers for libc-bin (2.36-9+deb12u10) ...
```
```sh
# ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
redis        1  0.4  0.1 147348 22044 ?        Ssl  18:08   0:01 redis-server *:6379
root        44  0.0  0.0   2580   940 pts/0    Ss   18:13   0:00 sh
root       233  0.0  0.0   8092  3932 pts/0    R+   18:14   0:00 ps aux
```
### 3. Network Inspection
```sh
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
```
```sh
172.17.0.4
```
### 4. Document Differences
According to [Stack Overflow]():

In the case of attach, we were connecting our terminal to an existing container (read, process).
However, exec is a form of the run command (which itself is just a shortcut for create + start) and starts a new process.

## Task 6: Cleanup Operations

### 1. Verify Cleanup
```sh
docker system df
```
```sh
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          5         5         5.489GB   5.111GB (93%)
Containers      6         5         22.09MB   12.29kB (0%)
Local Volumes   2         2         589B      0B (0%)
Build Cache     21        0         7.974GB   7.974GB
```
### 2. Create Test Objects
```sh
 for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
```
```sh
hello
hello
hello
```
Twice:
```sh
docker build -t temp-image . && docker rmi temp-image
```
```sh
[+] Building 20.2s (6/6) FINISHED                                                                                                                                                                                                                                                docker:default
 => [internal] load build definition from dockerfile                                                                                                                                                                                                                                       0.0s
 => => transferring dockerfile: 84B                                                                                                                                                                                                                                                        0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                                                                                                                                                                                                           0.0s 
 => [internal] load .dockerignore                                                                                                                                                                                                                                                          0.0s 
 => => transferring context: 2B                                                                                                                                                                                                                                                            0.0s 
 => [1/2] FROM docker.io/library/alpine:latest@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715                                                                                                                                                                    19.6s 
 => => resolve docker.io/library/alpine:latest@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715                                                                                                                                                                    19.5s 
 => [2/2] RUN echo "Hello"                                                                                                                                                                                                                                               0.2s
 => exporting to image                                                                                                                                                                                                                                                                     0.2s
 => => exporting layers                                                                                                                                                                                                                                                                    0.1s
 => => exporting manifest sha256:5323adef1de90aa4f66bb002f9b83e9fca21908460849d96641277d14c566497                                                                                                                                                                                          0.0s
 => => exporting config sha256:bce8aace57958a3b9236d30bd1529f5989736796632c8f963e11508db05fba14                                                                                                                                                                                            0.0s 
 => => exporting attestation manifest sha256:2e165ce4374fd85ac3d8eb11c27b3ac49f596c735ab4e3b1fa5bf92b3af903c3                                                                                                                                                                              0.0s 
 => => exporting manifest list sha256:10314ef8a2e623caebf37f7c0d38d414fb1ee380fb27ecbb0c551b4452d2b131                                                                                                                                                                                     0.0s 
 => => naming to docker.io/library/temp-image:latest                                                                                                                                                                                                                                       0.0s 
 => => unpacking to docker.io/library/temp-image:latest                                                                                                                                                                                                                                    0.0s 
Untagged: temp-image:latest
Deleted: sha256:10314ef8a2e623caebf37f7c0d38d414fb1ee380fb27ecbb0c551b4452d2b131
```
```sh
[+] Building 19.2s (6/6) FINISHED                                                                                                                                                                                                                                                docker:default
 => [internal] load build definition from dockerfile                                                                                                                                                                                                                                       0.0s
 => => transferring dockerfile: 84B                                                                                                                                                                                                                                                        0.0s 
 => [internal] load metadata for docker.io/library/alpine:latest                                                                                                                                                                                                                           0.0s 
 => [internal] load .dockerignore                                                                                                                                                                                                                                                          0.0s 
 => => transferring context: 2B                                                                                                                                                                                                                                                            0.0s 
 => [1/2] FROM docker.io/library/alpine:latest@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715                                                                                                                                                                    19.0s 
 => => resolve docker.io/library/alpine:latest@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715                                                                                                                                                                    19.0s 
 => CACHED [2/2] RUN echo "Hello"                                                                                                                                                                                                                                        0.0s
 => exporting to image                                                                                                                                                                                                                                                                     0.1s 
 => => exporting layers                                                                                                                                                                                                                                                                    0.0s 
 => => exporting manifest sha256:5323adef1de90aa4f66bb002f9b83e9fca21908460849d96641277d14c566497                                                                                                                                                                                          0.0s 
 => => exporting config sha256:bce8aace57958a3b9236d30bd1529f5989736796632c8f963e11508db05fba14                                                                                                                                                                                            0.0s 
 => => exporting attestation manifest sha256:d6ec36d1f8764ecb5f9c20b1670d611ffd0d84aeb1163ef085857b8e63c666ea                                                                                                                                                                              0.0s 
 => => exporting manifest list sha256:b3e0bed5e82aa088732a382a1a930ce30ebf82073ca74c95ad28b7633bfccff2                                                                                                                                                                                     0.0s 
 => => naming to docker.io/library/temp-image:latest                                                                                                                                                                                                                                       0.0s 
 => => unpacking to docker.io/library/temp-image:latest                                                                                                                                                                                                                                    0.0s 
Untagged: temp-image:latest
Deleted: sha256:b3e0bed5e82aa088732a382a1a930ce30ebf82073ca74c95ad28b7633bfccff2
```
### 3. Remove Stopped Containers
```sh
docker container prune -f
```
```sh
Deleted Containers:
d954bbfe5e2d4bdd14ef834bd8db3215816c87fb9bfa325d573e87880a7d3c6f
b4a644b9925d4d488dda60ba9d4756041577cda0398ef272fe5c12ded8e07440
c8fde75c90b6749b03cfc77469d6eb64dd3ea9c2fb09ec187ced5cf260a47a19
180d40652a3b57fe72aba2a0d6f3b0f0dffbb5a5cbd85efe03ae28702e5690eb

Total reclaimed space: 24.58kB
```
### 4. Remove Unused Images
```sh
docker image prune -a -f
```
```sh
Deleted Images:
untagged: ubuntu:latest

Total reclaimed space: 0B
```
### 5. Verify Cleanup
```sh
docker system df
```
```sh
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          4         4         5.489GB   5.229GB (95%)
Containers      5         5         22.07MB   0B (0%)
Local Volumes   2         2         589B      0B (0%)
Build Cache     27        0         8.004GB   8.004GB
```
-1 image, -1 container. Reclaimable space increased on about 117MB, however, build cache increased on 30MB

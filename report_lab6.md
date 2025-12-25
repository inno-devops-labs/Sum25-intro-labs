# Containers Lab - Docker

Get hands-on experience with Docker fundamentals through hands-on container management, image operations, networking, and storage tasks.

## Task 1: Basic container operations

The following commands will be executed:

1. **List containers**

```sh
docker ps -a
```

2. **Pull Ubuntu image**

```sh
docker pull ubuntu:latest
```

3. **Run interactive container**

```sh
docker run -it --name ubuntu_container ubuntu:latest
```

4. **Remove image**

```sh
docker rmi ubuntu:latest
```

Result:

```
root@alyona:~# docker ps -a
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
root@alyona:~# docker pull ubuntu:latest
latest: Pulling from library/ubuntu
d9d352c11bbd: Pull complete
Digest: sha256:b59d21599a2b151e23eea5f6602f4af4d7d31c4e236d22bf0b62b86d2e386b8f
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
root@alyona:~# docker run -it --name ubuntu_container ubuntu:latest
root@46a5d064f57f:/# docker rmi ubuntu:latest
bash: docker: command not found
root@46a5d064f57f:/#
```

error occurred because docker is empty and you need to install the necessary ones on an empty docker dependencies

checking package presence

```
root@46a5d064f57f:/# dpkg -l | grep docker
root@46a5d064f57f:/# docker --version
bash: docker: command not found
```

## Task 2: Adjust Image

1. **Image Export**

```sh
docker save -o ubuntu_image.tar ubuntu:latest
```

```
root@alyona:~# docker save -o ubuntu_image.tar ubuntu:latest
root@alyona:~# docker images

REPOSITORY TAG IMAGE ID CREATED SIZE
docker_prac_client latest 2595a436b67a 2 hours ago 172MB
docker_prac_spring4shell latest e6104a59bb25 2 hours ago 1.1GB
python 3.11-slim be3324b8ee1a 3 weeks ago 130MB
ubuntu latest bf16bdcff9c9 3 weeks ago 78.1MB
lunasec/tomcat-9.0.59-jdk11 latest 3a26f2d12af8 3 years ago 680MB
root@alyona:~# ls -lh ubuntu_image.tar

-rw------- 1 root root 77M Jun 25 13:46 ubuntu_image.tar
root@alyona:~#
```

1. Docker image size ubuntu:latest: 78.1 MB (as specified in the output of the docker images command).
2. The size of the ubuntu_image.tar TAR file: 77 MB (as specified in the output of the ls -lh command).


2. **Deploying Nginx**

```sh
docker run -d -p 80:80 --name nginx_container nginx
```

```
root@alyona:~# docker run -d -p 80:80 --name nginx_container nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
dad67da3f26b: Already exists
4b3a9835b30: Full pull
021db26e13de: Full pull
397cc88dcd41: Full Pull
5f4a88bd8474: Full pull
66467f827546: Full pull
f05e87039331: Full pull
Digest: sha256:dc53c8f25a10f9109190ed5b59bda2d707a3bde0e45857ce9e1efaa32ff9cbc1
Status: Downloaded newer image for nginx:latest
0e43b4396045fd00c6f82e6a78c1e488b230dc2f2e1c3f5edb7e2b7ea69208b6
root@alyona:~# curl localhost
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
root@alyona:~#
```

3. **Configure Website**

- Create an HTML file with the specified content:

```html
<html>
<head>
<title>Best</title>
</head>
<body>
<h1>website</h1>
</body>
</html>
```

- Copy the HTML file into the container:

```sh
docker cp index.html nginx_container:/usr/share/nginx/html/
```

```
root@alyona:~# nano index.html
root@alyona:~# cat index.html
<html>
<head>
<title>Best</title>
</head>
<body>
<h1>website</h1>
</body>
</html>
root@alyona:~# docker cp index.html nginx_container:/usr/share/nginx/html/
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
root@alyona:~#
```

4. **Create Custom Image**
   
```sh
docker commit nginx_container my_website:latest
```

```
root@alyona:~# docker commit nginx_container my_website:latest
sha256:be87d9c44cde81f2950c202b11b51be34f7226024fb9752548c9df096ef9fb9b
```

5. **Delete the original container**:

```sh
docker rm -f nginx_container
```

```
root@alyona:~# docker rm -f nginx_container
nginx_container
root@alyona:~#
root@alyona:~# docker ps -a
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
46a5d064f57f ubuntu:latest "/bin/bash" 29 minutes ago Exited (127) 24 minutes ago ubuntu_container
root@alyona:~#
``

6. **Create a new container**:
- Create a new container using the custom image you created (same as the original container).

```sh
docker run -d -p 80:80 --name my_website_container my_website:latest
```

```
root@alyona:~# docker run -d -p 80:80 --name my_website_container my_website:latest
aa208bdc697f887641e2b3f49390d5f3e4a0f38dec97a28f800ec34b5fa96b12
root@alyona:~# docker ps -a
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
aa208bdc697f my_website:latest "/docker-entrypoint.…" 4 seconds ago Up 2 seconds 0.0.0.0:80->80/tcp, :::80->80/tcp my_website_container
46a5d064f57f ubuntu:latest "/bin/bash" 30 minutes ago Exited (127) 24 minutes ago ubuntu_container
root@alyona:~#
```

7. **Test web server**:

```
root@alyona:~# curl http://127.0.0.1:80
<html>
<head>
<title>Best</title>
</head>
<body>
<h1>website</h1>
</body>
</html>
```

8. **Analyze image changes**:

```sh
root@alyona:~# docker diff my_website_container
C /run
C /run/nginx.pid
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf

```

| Change | Path | Description |
|-----------|-----------------------------------|----------------------------------|
| C | /run | /run was changed |
| C | /run/nginx.pid | /run/nginx.pid was changed (contains the PID of the Nginx process) |
| C | /etc | /etc was changed |
| C | /etc/nginx | ​​/etc/nginx was changed |
| C | /etc/nginx/conf.d | /etc/nginx/conf.d was changed |
| C | /etc/nginx/conf.d/default.conf | /etc/nginx/conf.d/default.conf has been modified (contains Nginx configuration) |

## Task 3: Container Networks

1. **Create a network**:

- Create a bridge network named `lab_network`
```sh
root@alyona:~# docker network create lab_network
17b0755d6174f3c0dbc3757bee585705edbda2cf3738383f7cdc7747dc34fb1f
root@alyona:~#
```

2. **Start connected containers**:

- Start two Alpine containers connected to the network:
```sh
root@alyona:~# docker run -dit --network lab_network --name container1 alpine ash
docker run -dit --network lab_network --name container2 alpine ash
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
fe07684b16b8: Pull complete 
Digest: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
Status: Downloaded newer image for alpine:latest
62167c8f2459321139d16f54731d4aa85e067819fa7b51e00615d23c9c84e0e5
c2997c99a95ac931af4dc3f69263f6c1cc5b6018b5b179f1ebe3b697d2f5b652
root@alyona:~# 

```

3. **Check connection**:

- From `container1` ping `container2` by name:
  
```sh
root@alyona:~# docker exec container1 ping -c 3 container2
PING container2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.461 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.065 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.152 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.065/0.226/0.461 ms
root@alyona:~# 
root@alyona:~# 
```

4. **Documentation**:

https://github.com/Kulikova-A18/Sum25-intro-labs/blob/master/submission6.md was written "Internal DNS resolution in Docker"

## Task 4: Volume Saving

1. **Create Volume**:

- Create named volume `app_data`:
  
```sh
root@alyona:~# docker volume create app_data
app_data
```

2. **Run container with volume**:

- Run Nginx with volume mounted:

```sh
root@alyona:~# docker run -d -v app_data:/usr/share/nginx/html --name web nginx
378b0986be987231b9919e4830158157b06488785dbde767c7427d25bb30a37d
root@alyona:~#
``

3. **Modify contents**:

- Create custom `index.html` file
- Copy to volume:

```sh

root@alyona:~# docker cp index.html web:/usr/share/nginx/html/
Successfully copied 2.05kB to web:/usr/share/nginx/html/
root@alyona:~#

```

4. **Check persistence**:

- Stop and remove container:

```sh
root@alyona:~# docker stop web && docker rm web
web
web
root@alyona:~#
```

- Create new container with same volume:

```sh
root@alyona:~# docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
e354d4d146d8153a1eae1db9e3765ec23c341880aa6b3384ee42044a158014cb
root@alyona:~#
```

- Check persistence of contents with `curl localhost`

```
root@alyona:~# curl localhost
<html>
<head>
<title>Лучший</title>
</head>
<body>
<h1>веб-сайт</h1>
</body>
```

## Task 5: Checking the container

1. **Start the Redis container**:

```sh
root@alyona:~# docker run -d --name redis_container redis
Unable to find image 'redis:latest' locally
latest: Pulling from library/redis
dad67da3f26b: Already exists
b90a44fe26dc: Pull complete
11c0ea983116: Pull complete
4bce6440352d: Pull complete
093c29d9fea9: Pull complete
4f4fb700ef54: Pull complete
b222156a9022: Pull complete
Digest: sha256:1b835e5a8d5db58e8b718850bf43a68ef5a576fc68301fd08a789b20b4eecb61
Status: Downloaded newer image for redis:latest
da8fed560307fe0dfd89cf035819c819600e702728f2c7e3469d74cac09a79e3
root@alyona:~#
```

2. **Checking processes**:

- Find the Redis server process:

```sh
root@alyona:~# docker exec redis_container ps aux
OCI runtime exec failed: exec failed: unable to start container process: exec: "ps": executable file not found in $PATH: unknown
root@alyona:~# docker ps -a
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
da8fed560307 redis "docker-entrypoint.s…" 36 seconds ago Up 34 seconds 6379/tcp redis_container
e354d4d146d8 nginx "/docker-entrypoint.…" 2 minutes ago Up 2 minutes 80/tcp web_new
c2997c99a95a alpine "ash" 9 minutes ago Up 9 minutes container2
62167c8f2459 alpine "ash" 9 minutes ago Up 9 minutes container1
aa208bdc697f my_website:latest "/docker-entrypoint.…" 13 minutes ago Up 13 minutes 0.0.0.0:80->80/tcp, :::80->80/tcp my_website_container
46a5d064f57f ubuntu:latest "/bin/bash" 43 minutes ago Exited (127) 38 minutes ago ubuntu_container
root@alyona:~#
```

An error occurred. The Redis container is based on an image that is minimal in size and is designed to run only the Redis server itself. Typically, such images do not include standard Linux utilities such as ps, top, etc. to reduce the image size and reduce the number of potential vulnerabilities.

The error indicates that the ps executable was not found in the $PATH environment variable. This is due to the fact that the Redis image simply does not have this utility.

3. **Network Inspection**:

- Get container IP:

```sh
root@alyona:~# docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
172.17.0.4
```

4. **Doc Differences**:

written in https://github.com/Kulikova-A18/Sum25-intro-labs/blob/master/submission6.md

## Task 6: Cleanup Operations

1. **Create Test Objects**:

- Create 3 Stopped Containers:

```sh
root@alyona:~# for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
hello
hello
hello
```

- Creation of 2 hanging images:

```sh
root@alyona:~# docker build -t temp-image . && docker rmi temp-image
DEPRECATED: The legacy builder is deprecated and will be removed in a future release. 
Install the buildx component to build images with BuildKit: 
https://docs.docker.com/go/buildx/

unable to prepare context: unable to evaluate symlinks in Dockerfile path: lstat /root/Dockerfile: no such file or directory
root@alyona:~#

```

2. **Deleting stopped containers**:

```sh
root@alyona:~# docker container prune -f
Deleted Containers:
43b7c025a7ce5c4429c62c0226ee0eba54d2419cb45162e3e843dd141b69081d
6053d037bc1da32d17aabde504b7e9fbb60bb65aa0d4fc7a68cc6915abb62c 63
15f1f2e145639bde6da9b8d432060a5ee84bd03a37eb922d4915a93f11d6a7bc
46a5d064f57f42bdb8201ff57189fb89ba2575f2e9956c132840ab2c7d1a6f11

Total reclaimed space: 69B
root@alyona:~#
```

3. **Removing unused images**:

```sh
root@alyona:~# docker image prune -a -f
Deleted Images:
untagged: lunasec/tomcat-9.0.59-jdk11:latest
untagged: lunasec/tomcat-9.0.59-jdk11@sha256:383a062a98c70924fb1b1da391a054021b6448f0aa48860ae02f786aa5d4e2ad
untagged: docker_prac_client:latest
deleted: sha256:2595a436b67adaf6c455e798981fd72f4fc2c8db8d355ce974d8bb7b24cf9066
deleted: sha256:82f92730563944f5c9ef6ac39dae3a245169fd67e5a16ded77361de35bf72a5b
deleted: sha256:b0cd911133092651dae46efbfca7cd4b9a5ec1edd8648a43475e5a36a777852c
deleted: sha256:e0dbdafaf857213e603072263bc656db4f43b4478ed48cd4ce20ce98b1980dd5
deleted: sha256:88a44795c922f586f7e0b20a784072d21ecb412572a7905584aba11805e26780
deleted: sha256:6d2d6878f137a098f2341627d4b5fc86edf9e4fbd5ca81e42d59af35a877898c
deleted: sha256:80e7c8d87004d8f5a1ba5d29439b9bdb6b94fe0808a2acb38675047eb2a7b174
deleted: sha256:1d8b7fe14622e7e53af36618db755d5e35b774671bb935f38c9bd2e90051af20
deleted: sha256:51520a499e4bdbc365a036433a9f9ebd6136aa45c45f36240f44ef2ea2ca71e9
deleted: sha256:8b75e84036bd431106da04b814285e493c7f44d6b5096cc3d448f8305f3030be
deleted: sha256:5ffd69f4b66772854b119473a22396a1c77d812fbbb8b51a9593bc30706fcb98
deleted: sha256:aa274a9c82fe8de036a8758e9434939b25cd0662526d214afe428cc60ad6ef15
deleted: sha256:c663b113b3814fa28d7afa6c2230543f51a470ce28e44200e28edf25fabd59b5
untagged: ubuntu:latest
untagged: ubuntu@sha256:b59d21599a2b151e23eea5f6602f4af4d7d31c4e236d22bf0b62b86d2e386b8f
deleted: sha256:bf16bdcff9c96b76a6d417bd8f0a3abe0e55c0ed9bdb3549e906834e2592fd5f
deleted: sha256:a8346d259389bc6221b4f3c61bad4e48087c5b82308e8f53ce703cfc8333c7b3
untagged: docker_prac_spring4shell:latest
deleted: sha256:e6104a59bb2586c25612c8ab41dfb28288e78a4101b27e01b12a97a467203edc
deleted: sha256:c368163795796f13163f52887e78f1244d6e7c5515e694a5275f05bf36685de4
deleted: sha256:c5bf26187456da8dcb173e2ef5a8661e40191c04b525e8cbb748cd8e8aed4b4f
deleted: sha256:69266170ce2c1fa88b95f1671fb346df215b334034758bc81433fcabbb170bb4
deleted: sha256:5306ed426c07bd548f5751da0e25d05b97d131030a522fa328959e3cad540edc
deleted: sha256:29a55823342e2026e8cb2077e175daedb44cd40c293066cedb83b3055b2059ac
deleted: sha256:4abd6c3f13b647f8c40a0fb3c1ef0f9938d300d7dbd1119c21eeb3d5baff850c
deleted: sha256:5d275000b18f48a4af298891a44ced8028549396ca2c0674435d8f39e2b67ba4
deleted: sha256:683a920dbddae37dbfebce48bd03dd58656df8a238272773e3ccd449d2e08299
deleted: sha256:9bc527f7c286195f531362bb092417f20be816caf0b8e938f91625e407fc3908
deleted: sha256:d117185368ffbb908e0b816869491ed0a1176b6cf74df8b2c86172c54741af24
deleted: sha256:f9e74ee7929d7bd3a69177378142ef8defe155b402799f6c370bf4b00be44b0a
deleted: sha256:87fddec9bd9d7367dba73bb3d4f376b1c97ed5f9d0a79104ba88d394a6190123
deleted: sha256:3a26f2d12af8581ad65c72ebefaa5f64b276783dab83ef6ed66f5083a764fcf2
deleted: sha256:204a09c21c2e8a383474e100198e1b9990bc65828ea5f1b2221c27c27ce8d0d0
deleted: sha256:db5be953998ed6fcd138815c5d2e39619c4456590453c35671f3d72b781f547c
deleted: sha256:2fa8d4c45d918d2b6f3b94cd317d554ea269c2fafb9f40453bed99084cdd1c0c
deleted: sha256:40307ac3d35ac17a625a11e6ff5cc53a8fca0910b598ff3e80527cc101eb272c
deleted: sha256:de3a6cc41edfccdc0848584aee6ca24146f7e8e18dc5e63c3d4a119f7010c3b0
deleted: sha256:16c7bcdc64e47e9e36d794e26daebfd66342875c34bc825fe5e0fda04345d277
deleted: sha256:a6c0a8b4c36e38e108633a9dd299d0f36778148c83242f9706ec7e3118d4e19d
deleted: sha256:2adeee00a82e54ebb1236fd3cd6a2de72002ed3211e65057dd1933f425ae13f6
deleted: sha256:e8db4a9e45cf9ae5cc9214264472b2d707915c96f73f59d4faa85baad2f23a0f
deleted: sha256:89fda00479fc0fe3bf2c411d92432001870e9dad42ddd0c53715ab77ac4f2a97
untagged: python:3.11-slim
untagged: python@sha256:9e1912aab0a30bbd9488eb79063f68f42a68ab0946cbe98fecf197fe5b085506
deleted: sha256:be3324b8ee1a17161c5fa4a20f310d4af42cbb4f22a1e7a32a98ee9196a6defd
deleted: sha256:244a0b3c09e3695b892dcd5093545c14bd7c81fdc1d844749bcf897182ccc319
deleted: sha256:3e742ea8298c4f57a3b19d0b9d3f2b32edb4c91480079a6137483fe9c94a3fcc
deleted: sha256:e57d45dd5fa9fd30737dcda5980a7ec2dfc6720e6e17c2645cb0c29b716a0501

Total reclaimed space: 1.274GB
root@alyona:~#
```

4. **Check cleanup**:

- Check disk usage before/after:

```sh
root@alyona:~# docker system df
TYPE TOTAL ACTIVE SIZE RECLAIMABLE
Images 4 4 253.6MB 192.2MB (75%)
Containers 5 5 2.19kB 0B (0%)
Local Volumes 2 2 595B 0B (0%)
Build Cache 0 0 0B 0B
root@alyona:~#

```

| Type | Total | Active | Size | Savings |
|--------------------|-----------|-------------|------------|---------------------|
| Images | 4 | 4 | 253.6MB | 192.2MB (75%) |
| Containers | 5 | 5 | 2.19kB | 0B (0%) |
| Local Volumes | 2 | 2 | 595B | 0B (0%) |
| Build Cache | 0 | 0 | 0B | 0B |

## Information about the author

The report was made by Kulikova Alyona specifically for "Integration and automation of the software development process (advanced course)".

If you have any questions or suggestions for improvement, do not hesitate to contact us!

Link to git: https://github.com/Kulikova-A18

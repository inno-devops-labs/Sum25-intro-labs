# Lab 06

## Task 0

Pulling the image.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker pull ubuntu:latest
latest: Pulling from library/ubuntu
e3bd89a9dac5: Pull complete 
Digest: sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354ff061
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```

Comparing sizes.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker save -o ubuntu_image.tar ubuntu:latest
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker images ubuntu:latest
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       latest    a08e551cb338   2 weeks ago   139MB
(base) ➜  DevOpsFundamentals git:(lab06) ✗ ls -lh ubuntu_image.tar
-rw-------@ 1 makharev  staff    28M Jul 29 14:06 ubuntu_image.tar
```

- The docker save command, by default, creates an uncompressed .tar archive of the image layers and metadata.
- The size reported by docker images is the uncompressed size on disk of the image layers when they are extracted by Docker.

## Task 1

Ubuntu image is already pulled previously.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
- No containers are running.

Running container.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker run -it --name ubuntu_container ubuntu:latest
root@cb1d13df6a6f:/# exit
exit
```

Trying to remove image.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker rmi ubuntu:latest
Error response from daemon: conflict: unable to delete ubuntu:latest (must be forced) - container cb1d13df6a6f is using its referenced image a08e551cb338
```

- The removal failed because the image is still in use by the running container. So, we need to stop the container first. We can do this with the `docker stop` command.

## Task 2

Deploying Nginx container. Nginx is a web server that can be used to serve static content.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker run -d -p 80:80 --name nginx_container nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
10d3f5dcba63: Pull complete 
b3407f3b5b5b: Pull complete 
ecab78f9d45d: Pull complete 
a3bfeb063ded: Pull complete 
5850200e50af: Pull complete 
7996b9ca9891: Pull complete 
6d01b3c42c10: Pull complete 
Digest: sha256:84ec966e61a8c7846f509da7eb081c55c1d56817448728924a87ab32f12a72fb
Status: Downloaded newer image for nginx:latest
44f5999cd32a00049752e9665a728d2ee56898864e931878bfdf8a9d5094d821
```

- This command deploys the nginx container in detached mode, maps port 80 of the container to port 80 of the host, and names the container nginx_container.
- Docker pulled the nginx image from the Docker Hub registry because it was not found locally on the system.

Verifying with `curl localhost`.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ curl localhost
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

- The command returned the nginx welcome page, which indicates that the web server is working correctly.

Creating `index.html` file and copying it to nginx container.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker cp index.html nginx_container:/usr/share/nginx/html/
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
```
- Copied `index.html` to nginx container.

Creating custom image for website.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker commit nginx_container my_website:latest
sha256:ed61c3e42e78297cfe295f5e9c1e0cb653280e4601cf005045783b1c73746827
```

- Created custom image `my_website:latest` from nginx container.

Removing nginx container.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker rm nginx_container
nginx_container
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker ps -a                
CONTAINER ID   IMAGE           COMMAND       CREATED          STATUS                      PORTS     NAMES
cb1d13df6a6f   ubuntu:latest   "/bin/bash"   12 minutes ago   Exited (0) 11 minutes ago             ubuntu_container
```

- Removed nginx container and verified that it has been successfully removed.

Creating container from custom image.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker run -d -p 80:80 --name my_website_container my_website:latest
5bcdc83bedaa7ff9d51e3731ef309e6b824823929bc150126de366879388635b
```

- Created container `my_website_container` from custom image `my_website:latest` and mapped port 80 of the container to port 80 of the host.

Tesing the web server.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ curl http://127.0.0.1:80
<html>
    <head>
        <title>The best</title>
    </head>
    <body>
        <h1>website</h1>
    </body>
</html>
```

- The web server is working correctly because it returned the content of the `index.html` file.

Analyzing image changes.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker diff my_website_container
C /run
C /run/nginx.pid
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
```

- The diff shows "C" lines that mean the files have been changed. It indicates typical operations such as created its PID file and modified default config as part of its initialization process.

## Task 3

Creating a bridge network.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker network create lab_network
1505bd01cf7345f28f458c42dc07078308f9d38ba899836add8480227fc022f0
```

- Created bridge network `lab_network`. This network allows containers to communicate with each other and with the host.

Running connected Alphine containers.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker run -dit --network lab_network --name container1 alpine ash
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
6e174226ea69: Pull complete 
Digest: sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1
Status: Downloaded newer image for alpine:latest
539f15d206256695634c2bdb5cd601d21193afc5639a515d44fab6ec0ad45576
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker run -dit --network lab_network --name container2 alpine ash
dbb519e3b8f0ccc7ff446b8f63bfc585c4c3ec8ca218f3028e3ac640953300b7
```

- These containers are connected to the `lab_network` bridge network.

Tesing connectivity between containers.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker exec container1 ping -c 3 container2
PING container2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.345 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.105 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.343 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.105/0.264/0.345 ms
```

- The containers are connected to the same bridge network, so they can communicate with each other.

Docker's internal DNS allows containers on the same user-defined network to resolve each other's hostnames (which default to the container names) directly. It achieves this by providing an embedded DNS server that routes requests for container names to their corresponding IP addresses within that network.

## Task 4

Starting Nginx container with volume mounted.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker run -d -v app_data:/usr/share/nginx/html --name web nginx
cc7267138c7232361431c97256bc2901f0ffc2f6c5479b3033701f76201ee9c9
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker volume ls
DRIVER    VOLUME NAME
local     app_data
```

- Created volume `app_data` and mounted it to `/usr/share/nginx/html` in the container.

Created customized `index.html`:

```bash
<html>
    <head>
        <title>The best</title>
    </head>
    <body>
        <h1>custom website</h1>
    </body>
</html>
```

Copying `index.html` to the volume.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker cp index.html web:/usr/share/nginx/html/
Successfully copied 2.05kB to web:/usr/share/nginx/html/
```

- Copied `index.html` to the volume `app_data` mounted to `/usr/share/nginx/html` in the container.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker stop web && docker rm web
web
web
```

- Stopped and removed container `web`.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
cbe6f0d82cb1d37c1f5913fde813e0c2fa021ca8673202e7634d944135c4a721
```

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ curl localhost              
<html>
    <head>
        <title>The best</title>
    </head>
    <body>
        <h1>website</h1>
    </body>
</html>
```

- Content persisted.

## Task 5

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker run -d --name redis_container redis
Unable to find image 'redis:latest' locally
latest: Pulling from library/redis
3358465fa9ba: Pull complete 
2493b15fc5cc: Pull complete 
c41e7c7e2963: Pull complete 
ad0336d6fb70: Pull complete 
31d0347aa91b: Pull complete 
4f4fb700ef54: Pull complete 
Digest: sha256:f957ce918b51f3ac10414244bedd0043c47db44a819f98b9902af1bd9d0afcea
Status: Downloaded newer image for redis:latest
34c116cf4dee5c4381fa2a08ef4db07f634e7865211e1edad545e16324760c96
```

- Installed and run Redis container.

I have no install `ps` command on Redis container, so I first installed it.

```bash
docker exec -it redis_container bash
apt-get update
apt-get install -y procps
```

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker exec redis_container ps aux  
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
redis        1  0.8  0.2 159796 22352 ?        Ssl  16:03   0:02 redis-server *:6379
root       255  0.0  0.0   8044  3732 ?        Rs   16:08   0:00 ps aux
```

- Redis server process is running on PID 1.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
172.17.0.4
```

- Redis server is running on IP address `172.17.0.4`.

Both `docker exec` and `docker attach` allows to interact with a running container, but they do so in different ways.

### `docker exec`

Executes a new command/process inside a running container's environment. It's like running a separate program within the container, inheriting its namespaces (network, PID, mount, etc.).

Use Cases:

- Running one-off commands
- Getting a shell
- Executing scripts


Example:

```bash
docker exec -it my_nginx_container bash
# Once inside, you can run:
# ls /etc/nginx/conf.d/
# exit
```

### `docker attach`

Attaches your terminal's standard input (stdin), output (stdout), and error (stderr) to the primary process (PID 1) of a running container. It's like reconnecting to the console output of the main application.

Use Cases:

- Monitoring real-time application output
- Interacting with interactive foreground applications
- Debugging single-process containers

Example:

```bash
# Start an interactive Alpine container in detached mode
docker run -dit --name my_alpine_shell alpine sh
# Attach to its main process (the 'sh' shell)
docker attach my_alpine_shell
# You are now inside the shell. Type something like:
# echo "Hello from container"
```

## Task 6

Inspecting resources usage.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          9         5         4.445GB   4.052GB (91%)
Containers      6         4         22.95MB   22.82MB (99%)
Local Volumes   2         2         709B      0B (0%)
Build Cache     12        0         659.8MB   659.8MB
```

- This shows that we have 9 images, 6 containers, 2 local volumes, and 12 build cache.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
hello
hello
hello
```

- Created 3 stopped containers.

Creating very simple `Dockerfile`.

```bash
echo "FROM alpine:latest" > Dockerfile
```

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker build -t temp-image . && docker rmi temp-image
[+] Building 4.1s (5/5) FINISHED                                                                                                                               docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                           0.0s
 => => transferring dockerfile: 93B                                                                                                                                            0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                                                                                               0.1s
 => [internal] load .dockerignore                                                                                                                                              0.0s
 => => transferring context: 2B                                                                                                                                                0.0s
 => [1/1] FROM docker.io/library/alpine:latest@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1                                                         3.8s
 => => resolve docker.io/library/alpine:latest@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1                                                         3.8s
 => exporting to image                                                                                                                                                         0.0s
 => => exporting layers                                                                                                                                                        0.0s
 => => exporting manifest sha256:f29f2a53dba68952c9b8a8e46b1c45d64d59b6a356bde5313e54908205c16733                                                                              0.0s
 => => exporting config sha256:2350daca4a806bd99c45fb52f839697e5e80e9f4ad492f243f140e9f2378205a                                                                                0.0s
 => => exporting attestation manifest sha256:ffd1299d6674b67694a9077a7e9ae4a57255eef26d70fb2d4a5388a97494b31c                                                                  0.0s
 => => exporting manifest list sha256:86e71ecc2658ec814a03954a3b8ca91f6108b7df07ca5139a66a26b854814975                                                                         0.0s
 => => naming to docker.io/library/temp-image:latest                                                                                                                           0.0s
 => => unpacking to docker.io/library/temp-image:latest                                                                                                                        0.0s
Untagged: temp-image:latest
Deleted: sha256:86e71ecc2658ec814a03954a3b8ca91f6108b7df07ca5139a66a26b854814975
```

- Created 2 dangling images.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker container prune -f
Deleted Containers:
fce23a3fffd2756386a3975a01d2dcd9a1414e95d1e3fc2593453edd56179a08
ff9f3063b4f42c3845fc3968718260cb8edbc4bd6b7c0ac9b1d192a2403c7076
fc05eff4a08d879afd2887267f069cf2cc2f21d6bb4cd696c3ce3c3cdb65d976
34c116cf4dee5c4381fa2a08ef4db07f634e7865211e1edad545e16324760c96
cb1d13df6a6f85874c472b14deca38197d00df11c737c676c6b1187688472792

Total reclaimed space: 22.83MB
```

- Removed only stopped containers.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker image prune -a -f
Deleted Images:
untagged: ubuntu:latest
deleted: sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354ff061
deleted: sha256:561d015542e18ccd6fb31b039a312334184f05f24b147f7562a7af79d16354e9
deleted: sha256:b24db5c17bb8bcfff3c149999ffa403fa580c172b8d2c2950ae8fdccd4a6e4e6
deleted: sha256:e3bd89a9dac501ff564b39359113adad7c3d2813d5e04eab53ee10e20a6793a7
untagged: pgvector/pgvector:0.8.0-pg17
deleted: sha256:5982c00a2cdf786c2daefa45ad90277309c6f8f5784a4332acc34963c2d61ba3
deleted: sha256:db2eb91112c725d9ba840fd46bf71a476dc87b82c66062dca056dcff57bd1315
deleted: sha256:438a79880cd2559658c49ac807386179c036204411ceff761c98b947628aabdb
deleted: sha256:d51c377d94dadb60d549c51ba66d3c4eeaa8bace4935d570ee65d8d1141d38fc
deleted: sha256:774c54d2d309bc0d9f02c69b29d119216a5a164fbf6cec3480052d097e25f9ea
deleted: sha256:405f36104e57cc5d7fd06391de5bb22aeddbffecb409917d7ecc608c2e3f9c80
deleted: sha256:1655e767f751e08409bb39b05f82292ac7689e09a26a6871442725c24b57d8b0
deleted: sha256:cf8078a8a245e2f42169dc661d903d811d08a63cf566346516a68aa7477130ae
deleted: sha256:77b1b7588421aa8a2178678ef8042b65a9bfc5ade9fea7c685f5a674906db062
deleted: sha256:7b8417b4134b63cf9697a07dcf7dc6b1801e18389ca122d20a2f66d86fb9d102
deleted: sha256:a1dedce88ca1d4ac15e6d2943f50b93e8fc6b8d5c8902ac60abbdea76b6392e6
deleted: sha256:551bc275c65f845b384bc7a0fb10652219a511f98d9f01f23485395c2b03f5d1
deleted: sha256:2c6810bb3d75b9d9d71f1ec5bf9e855922d5f98985a51e17034c367b66a45f97
deleted: sha256:f45b4b1e09b9039162df2851f083036de5f1da48d4f099d5433cd01c3b6730d0
deleted: sha256:1cfbe96df98f3912bcfd860546a5a2a9ded49c28273012afb11995c3da867d9a
deleted: sha256:434de25e58a434db3f52013add56aa2e7aa6d3551d308d6885c3eaed4bbafdad
deleted: sha256:8c21e9d8fa8c0a7e419ce04d3585929ccf0db1955c9aa52903c359df462c8d18
deleted: sha256:addec70d43642206a9f5a9940be901a8f6a9c407fa1343c223336f5be1c7297d
deleted: sha256:6f5740fd38047304c65ade82f94510130a5df305ec3fe0148d705896e7f86649
untagged: redis:latest
deleted: sha256:f957ce918b51f3ac10414244bedd0043c47db44a819f98b9902af1bd9d0afcea
deleted: sha256:dc625edc2e00aa604b687b5acfce7bd49dbb0a1cb2a8001c50a8cd4ae92c544e
deleted: sha256:dca75129d19319cc05725f7bab7098ddd65cd6613830eddf2652ef5815612b27
deleted: sha256:ad0336d6fb70097f0a81a6fc5dcb9821b9195ba56c02f04f297b345993b95954
deleted: sha256:2493b15fc5cc9771a2f75fcb7aa4a5d5453af5f7d4d9b380a3b26c85149cef88
deleted: sha256:31d0347aa91bdca1892daf8b8f16da58ef0438297bb9a984e2a85c7506305e85
deleted: sha256:c41e7c7e2963b28ba706c48d17a6c4e0615cf4944d699e5a509aba478a65a92a
deleted: sha256:3358465fa9ba3360e2348b576a91759c6004b0f6e1a6ca5bc3b0486e80d15888
untagged: mcp/puppeteer:latest
deleted: sha256:3c9ed95ae9ab6bf2bdebfed8d1b3da17d1aa7125f3a0240684d25e4b567cab91
deleted: sha256:8c0b97d12bdedb63fcc5a2701166359a8c0c5ee8f1dfdbe629e548fb14649456
deleted: sha256:a79411f253086730398db3f5298c0845b87f717cb97bfd6ab4be96a5f91882ef
deleted: sha256:16c9c4a8e9eef856231273efbb42a473740e8d50d74d35e6aedd04ff69fe161f
deleted: sha256:a4f5d14866ae588c63337c44292afe214aff914d559292c5d723e9a4bcd589f2
deleted: sha256:3dc74108acdc5e130b427d7da7b10d9c4333b64a3d172c569df257601830bbd0
deleted: sha256:10950c267ef75bc6b5a21efb751cd8426f69efa262c9ef260ebbf8e9163095ec
deleted: sha256:c617c02ae6fcb46c2ed260cb0a2fbf807eb597fa949209a3acff003ef8e31a87
deleted: sha256:7c3fc263540b372c72260b67197c0bab0a980b4c9b149259c15be6cdcb80aa40
deleted: sha256:4c5a5d48947e5eb835213ee73f12b72c389755fed5cd3e2ad36a77c10fbe3c2c
deleted: sha256:b039080cfc970b32f8e7ba9f9a93cbf0a58ddcec39f18de2607a8531199d8870
deleted: sha256:4f4fb700ef54461cfa02571ae0db9a0dc1e0cdb5577484a6d75e68dc38e8acc1
deleted: sha256:d08725c3c07e12bd3cb9b939a6ffcb5bdd6e8bc92978a20e39e1e5da7b36cc89
untagged: docker/alpine-tar-zstd:latest
deleted: sha256:b181a712ef50c427b907f77167b22babdd688eac45d033f09bb4fa0dffd73a45
deleted: sha256:c17516d54e4f20b97de4d27173e026efb7ea0309fbc174daf9fb9adf45194a32
deleted: sha256:5a503871855fe8d35d3fa221857d8e16a389fe40c7d33efc3f3737e52a47e0c8
deleted: sha256:a258b2a6b59a7aa244d8ceab095c7f8df726f27075a69fca7ad8490f3f63148a
deleted: sha256:1445ab919df3af9bf1f0967f61cc4e89e99cbe91ad2272d437aeba64714fad92
untagged: digest-frontend:latest
deleted: sha256:6b60da844a462e277d885c59d4a40a4f187862249ab31498a2b40ca3f9f1291a
deleted: sha256:00c8b463a61aa498ecbaf8c8fa72d8757e0582273305776c9c2b01f05322deba
deleted: sha256:ebfc9d592f42adee6beec0abc60a8025f15809d72735e7f4bfb9f80aaeec28d8
deleted: sha256:fda45ec8125d2bc41b86966082c7ff26787c0a08e7d3638810d384b49c0f1b01
deleted: sha256:14815c5bf351f09013c8b0043b0736240fdac69a64ea44ceb15e66a80ffde11b
deleted: sha256:8802fbee2fbb505f38e9abe4747d065f01ecf1ef4d15ce69da9029907faa8dae

Total reclaimed space: 696.7MB
```

- Removed unused images.

```bash
(base) ➜  DevOpsFundamentals git:(lab06) ✗ docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          3         3         1.656GB   1.505GB (90%)
Containers      4         4         135.2kB   0B (0%)
Local Volumes   2         1         709B      88B (12%)
Build Cache     15        0         1.644GB   1.644GB
```

- A significant cleanup of old, unused images and stopped containers took place. This successfully freed up a large amount of disk space.
- New Docker image builds were performed. This resulted in the growth of the build cache.
- One local volume became unused, but was not removed.

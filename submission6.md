# Lab 6: Docker

## Task 0: Image Exporting

Export image:

```
docker save -o ubuntu_image.tar ubuntu:latest
```

Check archive size:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % du -h ubuntu_image.tar
 28M	ubuntu_image.tar
```

Check image size:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker images ubuntu:latest
 REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
 ubuntu       latest    440dcf6a5640   13 days ago   139MB
```

Exported image is smaller, since it is compressed and has no metadata.

## Task 1: Core Container Operations

### List Containers

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker ps -a
CONTAINER ID   IMAGE                              COMMAND                  CREATED      STATUS                        PORTS                                NAMES
bfc81ed57c5e   kibana:9.0.2                       "/bin/tini -- /usr/l…"   3 days ago   Exited (255) 57 seconds ago   127.0.0.1:5601->5601/tcp             procurement-automation-kibana-1
f9f39cf696f4   elastic/elastic-connectors:9.0.2   "/app/bin/elastic-in…"   3 days ago   Exited (255) 57 seconds ago                                        procurement-automation-elastic-connectors-1
14c73dcfbded   mongo:7.0                          "docker-entrypoint.s…"   3 days ago   Exited (255) 57 seconds ago   127.0.0.1:27017->27017/tcp           procurement-automation-mongo-1
dec3e5232569   elasticsearch:9.0.2                "/bin/tini -- /usr/l…"   3 days ago   Exited (255) 57 seconds ago   127.0.0.1:9200->9200/tcp, 9300/tcp   procurement-automation-elastic-1
```

These are the containers from my other project.

### Pull Ubuntu Image

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker pull ubuntu:latest
latest: Pulling from library/ubuntu
3eff7d219313: Pull complete
Digest: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```

Check image size:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker system df -v
Images space usage:

REPOSITORY                   TAG       IMAGE ID       CREATED       SIZE      SHARED SIZE   UNIQUE SIZE   CONTAINERS
ubuntu                       latest    440dcf6a5640   13 days ago   139MB     0B            139.1MB       0
...
```

### Run Interactive Container

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker run -it --name ubuntu_container ubuntu:latest
root@49361867740f:/# exit
exit
```

### Remove Image

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker rmi ubuntu:latest
Error response from daemon: conflict: unable to delete ubuntu:latest (must be forced) - container 49361867740f is using its referenced image 440dcf6a5640
```

Docker cannot remove the image because it is used by the container we created.

## Task 2: Image Customization

### Deploy Nginx

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker run -d -p 80:80 --name nginx_container nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
6ac604e5e41f: Pull complete
7243db3466b3: Pull complete
1184df424fa0: Pull complete
42b122e31aa6: Pull complete
7482a68d7c64: Pull complete
004c60765aad: Pull complete
37259e733066: Pull complete
Digest: sha256:93230cd54060f497430c7a120e2347894846a81b6a5dd2110f7362c5423b4abc
Status: Downloaded newer image for nginx:latest
9aeae090668145be6376369703843ddeeca7b9e970081e637514ec6e1211482b
```

Verify with `curl`:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % curl localhost
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

### Customize Website

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker cp index.html nginx_container:/usr/share/nginx/html/
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
```

### Create Custom Image

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker commit nginx_container my_website:latest
sha256:917e5580ebf74904edfc219e9a8b12cb0060f5282002a9927493a86cc80ba2ab
```

### Remove Original Container

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker rm -f nginx_container
nginx_container
```

Verify that it has been successfully removed:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker ps -a
CONTAINER ID   IMAGE                              COMMAND                  CREATED          STATUS                        PORTS                                NAMES
49361867740f   ubuntu:latest                      "/bin/bash"              19 minutes ago   Exited (0) 19 minutes ago                                          ubuntu_container
bfc81ed57c5e   kibana:9.0.2                       "/bin/tini -- /usr/l…"   3 days ago       Exited (255) 30 minutes ago   127.0.0.1:5601->5601/tcp             procurement-automation-kibana-1
f9f39cf696f4   elastic/elastic-connectors:9.0.2   "/app/bin/elastic-in…"   3 days ago       Exited (255) 30 minutes ago                                        procurement-automation-elastic-connectors-1
14c73dcfbded   mongo:7.0                          "docker-entrypoint.s…"   3 days ago       Exited (255) 30 minutes ago   127.0.0.1:27017->27017/tcp           procurement-automation-mongo-1
dec3e5232569   elasticsearch:9.0.2                "/bin/tini -- /usr/l…"   3 days ago       Exited (255) 30 minutes ago   127.0.0.1:9200->9200/tcp, 9300/tcp   procurement-automation-elastic-1
```

### Create New Container

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker run -d -p 80:80 --name my_website_container my_website:latest
acf2dd4827b96161e50013da7b8735e8c5a606f4691217a7bae308d054e6102a
```

### Test Web server

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % curl http://127.0.0.1:80
<html>
    <head>
        <title>The best</title>
    </head>
    <body>
        <h1>website</h1>
    </body>
</html>
```

### Analyze Image Changes

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker diff my_website_container
C /run
C /run/nginx.pid
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
```

The output shows that there are changes in Nginx runtime and configuration files.

## Task 3: Container Networking

### Create Network

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker network create lab_network
5fbdf4c28a9e8f1cc62aef2c3d132864c2a9b053e8d827644cc98eedfa27f866
```

### Run Connected Containers

Pull alpine image:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker pull alpine
Using default tag: latest
latest: Pulling from library/alpine
d69d4d41cfe2: Pull complete
Digest: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
Status: Downloaded newer image for alpine:latest
docker.io/library/alpine:latest
```

Start containers attached to the network:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker run -dit --network lab_network --name container1 alpine ash
67797b59f040796c965507d1948df8e8189de5e5f7963ce8af9581ecdddedca3
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker run -dit --network lab_network --name container2 alpine ash
fa6ae3afe0c50012657c37a9fbff20b519bc37cee2f652173a5c3b4999fe9f9c
```

### Test Connectivity

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker exec container1 ping -c 3 container2
PING container2 (172.19.0.3): 56 data bytes
64 bytes from 172.19.0.3: seq=0 ttl=64 time=0.127 ms
64 bytes from 172.19.0.3: seq=1 ttl=64 time=0.237 ms
64 bytes from 172.19.0.3: seq=2 ttl=64 time=0.243 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.127/0.202/0.243 ms
```

For internal DNS queries Docker uses built-in DNS server which resolves container names to their IP addresses within the same network. This allows containers to communicate using their names or aliases.

### Task 4: Volume Persistence

### Create Volume

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker volume create app_data
app_data
```

### Run Container with Volume

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker run -d -v app_data:/usr/share/nginx/html --name web nginx
6083e75bdf1c387350b233700c4c42f704aa37674b27807878070d3071b41285
```

### Modify Content

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker cp index.html web:/usr/share/nginx/html/
Successfully copied 2.05kB to web:/usr/share/nginx/html/
```

### Verify Persistence

Stop and remove the container:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker stop web && docker rm web
web
web
```

Create new container with the same volume:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker run -d -p 80:80 -v app_data:/usr/share/nginx/html --name web_new nginx
675c23cb1670d3ef405f3711200a68c5ece2aaea76eef1f6b928e65612b38fbf
```

Verify content persists using `curl`:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % curl localhost
<html>
    <head>
        <title>The worst</title>
    </head>
    <body>
        <h1>website!</h1>
    </body>
</html>
```

## Task 5: Container Inspection

### Run Redis Container

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker run -d --name redis_container redis
Unable to find image 'redis:latest' locally
latest: Pulling from library/redis
6cdbd38be072: Pull complete
929c063e7c67: Pull complete
210bcecec106: Pull complete
1951cc36241a: Pull complete
6487d14aef1c: Pull complete
4f4fb700ef54: Pull complete
Digest: sha256:b43d2dcbbdb1f9e1582e3a0f37e53bf79038522ccffb56a25858969d7a9b6c11
Status: Downloaded newer image for redis:latest
7416472ef5d17d31e453d7c545167a4979a23dfc19a10e9429a0462cd1c80062
```

### Inspect Processes

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker exec redis_container ps aux
OCI runtime exec failed: exec failed: unable to start container process: exec: "ps": executable file not found in $PATH: unknown
```

Install `procps` to be able to run `ps`:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker exec redis_container apt-get update
Get:1 http://deb.debian.org/debian bookworm InRelease [151 kB]
Get:2 http://deb.debian.org/debian bookworm-updates InRelease [55.4 kB]
Get:3 http://deb.debian.org/debian-security bookworm-security InRelease [48.0 kB]
Get:4 http://deb.debian.org/debian bookworm/main arm64 Packages [8693 kB]
Get:5 http://deb.debian.org/debian bookworm-updates/main arm64 Packages [756 B]
Get:6 http://deb.debian.org/debian-security bookworm-security/main arm64 Packages [266 kB]
Fetched 9215 kB in 3s (3665 kB/s)
Reading package lists...

danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker exec redis_container apt-get install -y procps
Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  libgpm2 libncursesw6 libproc2-0 psmisc
Suggested packages:
  gpm
The following NEW packages will be installed:
  libgpm2 libncursesw6 libproc2-0 procps psmisc
0 upgraded, 5 newly installed, 0 to remove and 0 not upgraded.
Need to get 1151 kB of archives.
After this operation, 4863 kB of additional disk space will be used.
Get:1 http://deb.debian.org/debian bookworm/main arm64 libncursesw6 arm64 6.4-4 [122 kB]
Get:2 http://deb.debian.org/debian bookworm/main arm64 libproc2-0 arm64 2:4.0.2-3 [60.1 kB]
Get:3 http://deb.debian.org/debian bookworm/main arm64 procps arm64 2:4.0.2-3 [698 kB]
Get:4 http://deb.debian.org/debian bookworm/main arm64 libgpm2 arm64 1.20.7-10+b1 [14.4 kB]
Get:5 http://deb.debian.org/debian bookworm/main arm64 psmisc arm64 23.6-1 [257 kB]
debconf: delaying package configuration, since apt-utils is not installed
Fetched 1151 kB in 1s (1497 kB/s)
Selecting previously unselected package libncursesw6:arm64.
(Reading database ... 6094 files and directories currently installed.)
Preparing to unpack .../libncursesw6_6.4-4_arm64.deb ...
Unpacking libncursesw6:arm64 (6.4-4) ...
Selecting previously unselected package libproc2-0:arm64.
Preparing to unpack .../libproc2-0_2%3a4.0.2-3_arm64.deb ...
Unpacking libproc2-0:arm64 (2:4.0.2-3) ...
Selecting previously unselected package procps.
Preparing to unpack .../procps_2%3a4.0.2-3_arm64.deb ...
Unpacking procps (2:4.0.2-3) ...
Selecting previously unselected package libgpm2:arm64.
Preparing to unpack .../libgpm2_1.20.7-10+b1_arm64.deb ...
Unpacking libgpm2:arm64 (1.20.7-10+b1) ...
Selecting previously unselected package psmisc.
Preparing to unpack .../psmisc_23.6-1_arm64.deb ...
Unpacking psmisc (23.6-1) ...
Setting up libgpm2:arm64 (1.20.7-10+b1) ...
Setting up psmisc (23.6-1) ...
Setting up libproc2-0:arm64 (2:4.0.2-3) ...
Setting up libncursesw6:arm64 (6.4-4) ...
Setting up procps (2:4.0.2-3) ...
Processing triggers for libc-bin (2.36-9+deb12u10) ...
```

Run `ps` again:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker exec redis_container ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
redis        1  0.7  0.2 159796 22692 ?        Ssl  16:47   0:02 redis-server *:6379
root       256  0.0  0.0   8044  3740 ?        Rs   16:51   0:00 ps aux
```

### Network Inspection

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
172.17.0.3
```

### `docker exec` vs `docker attach`

`docker exec` runs a command inside a container without interrupting its main process. It can be used for debugging, troubleshooting, running some specific tasks inside a container and other things.

`docker attach` attaches your terminal to the container’s main process. Its main purpose is monitoring or interaction with the main process.

## Task 6: Cleanup Operations

### Verify Cleanup

Check disk usage:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          12        8         7.324GB   1.058GB (14%)
Containers      9         4         31.54MB   8.651MB (27%)
Local Volumes   43        4         327.1MB   0B (0%)
Build Cache     0         0         0B        0B
```

### Create Test Objects:

Create 3 stopped containers:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
hello
hello
hello
```

Create dangling images (run twice and change the Dockerfile between runs):

```
docker build -t temp-image . && docker rmi temp-image
```

### Remove Stopped Containers

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker container prune -f
Deleted Containers:
897e05de2777d38cc6273b86625f5796f682002dc1e909e1a05712ccf3b51314
66cf19fe91c0842718ed4eab0fafd8d1da1ea1604c615f80a7b84b4073fed8a1
1627266d0dc5351d64f84df258acb7991bb5a74c302613f50cc7b5e2a76e583e
7416472ef5d17d31e453d7c545167a4979a23dfc19a10e9429a0462cd1c80062
49361867740fd047962fa5c868904d95e60728aa8eee8e7ba734b91243489e91
bfc81ed57c5e14f7f74cc17e49a7d2fd282af678113da3904419fc0461041777
f9f39cf696f48aabb653300c748308d1fa1de941934f28e44eec7725caee3554
14c73dcfbdedec83b08b7db45d97578a2e7627d578565fd9c89010db4e3abc74
dec3e5232569c2a3c716d04e82cbfe6f9e5a3a7d08edc9d352471b8beb65a0e0

Total reclaimed space: 31.46MB
```

### Remove Unused Images

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker image prune -a -f
Deleted Images:
untagged: redis:latest
deleted: sha256:b43d2dcbbdb1f9e1582e3a0f37e53bf79038522ccffb56a25858969d7a9b6c11
deleted: sha256:827c22a04103d6b331b5cf2703cb1097741a34d9220bf0b40a40ac8caaf31cfd
deleted: sha256:64c7b493895df800429b34c0f940a28aefa66aac4e1f70949659c697a22e66a7
deleted: sha256:929c063e7c678d0070c8493f4f1adb7bd4bf19ffacb39bbc25004dc5d6904ae0
deleted: sha256:6487d14aef1cecb8c12701fd57ce78d14504facc295b130fb158398d64982ed3
deleted: sha256:1951cc36241a5a237e70a37ae2c1692daddcf250ad1d5cbcc614e9a84d3ebfef
deleted: sha256:210bcecec106d3a0d1ba33a99dc2117f275b19f1cf8558ca06b8148e218415d4
deleted: sha256:6cdbd38be072595d16d8096e4239add78348987209ec0adf490acc372f7d8b2d
untagged: ubuntu:latest
deleted: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
deleted: sha256:021ffcf72f04042ab2ca66e678bb614f99c8dc9d5d1c97c6dd8302863078adba
deleted: sha256:70ed52c84b4e4cd5f3b15c6e0edc7003fb4cd559df69dfc093fac029c9efd480
deleted: sha256:3eff7d219313fd6db206bd90410da1ca5af1ba3e5b71b552381cea789c4c6713
untagged: sha256:017aa777f8ae718aac9118261493f35d7fa07429f697852439c71115147b01b5
deleted: sha256:017aa777f8ae718aac9118261493f35d7fa07429f697852439c71115147b01b5
deleted: sha256:94405ae98f77574826eea0ac066776640689f2dbc4a5e9713c6c950dae9ff6de
deleted: sha256:885c8b3be960e97365fe090da4ce6dd2136d403cf38674f48efdb15b0e6c78aa
deleted: sha256:6b696f218c62b8b978f8047fc6047701c8c05558e733493d17d20137aad384d9
deleted: sha256:de757af732aa8e4b114f73f457cb8b6e7102a16ade5dcd5a0e2600ba387da990
deleted: sha256:dd466387412dd2d721a74332eabeeefefbfc3ed1d709764051e989afa54f3d45
deleted: sha256:7e61e7a9f6e0f811eb601d9965bff32ed0581143bfc89c418cd8ffbb28fef751
deleted: sha256:4afb0c791c746ba65eac6c728ced808f1b499f087613170796bb90871b8c5aed
deleted: sha256:1a1e557a3ba32342b3db38ac8e151ed3ad874392e5ee6caaf93aee868a2b76e5
deleted: sha256:4e85b2cae4a50aa61a734ff5171828e5078a698e9853498fadda0b9701ac7933
deleted: sha256:548ffe2ff95e549aab09848b3c2c8baef1b6f1fd42d2694ce738b927ea645ef5
deleted: sha256:ec50e3f491989608013d607ffb0978be3cd014667c269132dd5689996190d80d
deleted: sha256:db7f65b2cfd1405ca5ade2cbf3d63127151a5829c5c721d061f5865e10084626
deleted: sha256:08b3632994ee7277050451fc1d2f1765da6362bdb70736c9f783f141abaa7743
deleted: sha256:1bd9dd9d521e238d32dfc6aba7e3df1e517a43b5584863d66b1e077ee8ba82a2
untagged: sha256:9681044f2e264ee9abde6594b7503537cfc98e44dd89d26b9533bfaab9c8c42b
deleted: sha256:9681044f2e264ee9abde6594b7503537cfc98e44dd89d26b9533bfaab9c8c42b
deleted: sha256:96e774e065d0961405f79977dd5cdf0fe03ad68a966369c481055a88204725d1
deleted: sha256:415793278934d13596d7d21e5662ee7c3ba5bee9c69ddca15cd9bc5112525b99
deleted: sha256:f258ee7f14ce0e3998c50b14ce17a0c0115edefcb69d96c3ef016548422246c8
deleted: sha256:56c8ce9e4537efdefcaceed6e6a2fddcc5ea8c493277b647b74d6e7f492e740f
deleted: sha256:1b708351825770e4c1b6aa35b970cd93ac131cd8f2fac7c64c3af43ce4fa04c6
deleted: sha256:a3f6233fdb4e37d4a8216045f36c002fe3e115d06db0f3f6c4932a1ae675de40
deleted: sha256:76335daa08b456eff5abf2766beb72d00a1759ab89ca89bc626d4c57f56a4ff4
deleted: sha256:65663bebaf375a19163b0d311a904ab07a71fd96b17ee3d8fd4ea476f5e2d59d
deleted: sha256:5ca8937e4c83c23b9e8e9c7ed260b112acfe100898399aa0652a3b2fc9314c32
deleted: sha256:0750b5b882da632a23a0777f1c79e4e6bf9500b3df0cbb4883e88864d74aa054
deleted: sha256:b3a365d3c688662f709595153980d5b8812594a5e7b1d20fef0dd7f8eefc65cf
untagged: elastic/elastic-connectors:9.0.2
deleted: sha256:9d00e0deda5a54a0efd13f5d1c310f910f58d34000439de9e4ec0a2c6d10a6f9
deleted: sha256:39499222e4ee081d5d8369d402aaff8009c34638eb8c9ff358bb15b5deb906bf
deleted: sha256:35d64ae420dbd180559bafd75f89f13ad74630cba934a8ba5e6835e378ad5d59
deleted: sha256:909fafa3f667acca306f251d633faddd6a9776dd3cf12291bb239745d12fb26b
deleted: sha256:de967a4395586d65bcc7b0246fee8ba855460b48f7fc2014936648998759dca6
deleted: sha256:4ca545ee6d5db5c1170386eeb39b2ffe3bd46e5d4a73a9acbebc805f19607eb3
deleted: sha256:7d8ea11f0081a2cc2012f6cb77929b5cb8cdc2df6d4f4a2b9b291f27a5fa86e1
deleted: sha256:6650ded963edbeecae34aa839b98e70f33efc5fb168e7062aa9070dd85dec9a3
untagged: my_website:latest
deleted: sha256:917e5580ebf74904edfc219e9a8b12cb0060f5282002a9927493a86cc80ba2ab
deleted: sha256:f7427ab76d773d100cb68eba3b5d92c36d3897e51e5f3a2e728e548eb350cac4
untagged: sha256:a63b08c39aa7a67b9e1200d4994097fbea8546af5a38ef919afe771742349cf0
deleted: sha256:a63b08c39aa7a67b9e1200d4994097fbea8546af5a38ef919afe771742349cf0
deleted: sha256:7af7d3506a8a624b68f651648c5510ebaf0ed129b33a0e4f724c662cd1b89696
deleted: sha256:8d081a19b80fc2b864fb865833b1a360787eb268102ff9c7418933a8dec4df16
untagged: elasticsearch:9.0.2
deleted: sha256:bfa9d2126a5c3381ac272ee67264083ca04318def1d7b4ea9194ad0b0a8959bf
deleted: sha256:eb0f18a29d158a7e20cb23a9334f432d259556a765850b3093790693bfacfa10
deleted: sha256:fcadb6fc0bfc4cecacb6c51e67ed5e0b49d24c83b089db02d50bebfb39a0e90d
deleted: sha256:55461445230f402a74e4424d8b22b60a43c66f7dd2da16f9d282df92834c32a7
deleted: sha256:e04db52cda08459751af50b8d9747851a602a8b9a63bd9cef4ecddc7aed506f8
deleted: sha256:a8212e916e75c1cc40a1da75639d5e8c3b90b634724d204ca176486f7dfa2748
deleted: sha256:d5ac7db66450218ff56934f58e5ae46bbbddd4cc844ba040dd19fb4629284cc8
deleted: sha256:bffd79f82b3ea5ceeb3e95d9e38b1c5e7fc326c728b62780c736a5a7aa9fe706
deleted: sha256:987c68a9d57713c874beef210be0aaeb6019b676adcd48791c43227d2f9f833f
deleted: sha256:4bfc8fe24b1258468a4173e8fc0edcc63b4629575a39b7e4963fd35f1d722375
deleted: sha256:561c231ad2193037e519aa6006c98dff469de13d3e66b50894c518cbfce79cdb
untagged: kibana:9.0.2
deleted: sha256:3b85ce5b71155983e32aeb7958572a93e8a58139ec0b722267f8020e9a598293
deleted: sha256:841ef84a014690ba295ea15fcde52201ba221744f4fce98a72290e0e4ebac67e
deleted: sha256:88135df31e567756b3ceb1bcb01c909a9920b9dee8dbb2b196d4151844e7d322
deleted: sha256:ba92c2079b2b21a2f178ace5ca98b5ef2d5cd02901c30e48729b7afe34ecd27e
deleted: sha256:3ff6d8a12862c4f2c3be59e6fe3c174f1102ae9321884fcf10eae8c4aff0dd22
deleted: sha256:fd2ddd52bc1fd463a8ac709f2abcb31aa22e69042732725c943615b0632ea875
deleted: sha256:a75c4b16951b7af9cbefa7b073a535acc32d62b2c9916de0a3d02a87906a2fb0
deleted: sha256:bd5f4699e620708c472666af9fb977fd799b59885a4f0b6d3eebaae225471c4a
deleted: sha256:f596f95919a08a8acceeeeab7b10879f04f583952a48a261fc7eaed3f0123e2e
deleted: sha256:4f4fb700ef54461cfa02571ae0db9a0dc1e0cdb5577484a6d75e68dc38e8acc1
deleted: sha256:f84888a193e57651c470407df142a4599a29d62f889542662f1583b291320aba
deleted: sha256:0205426ba9dc6acc17b666b4483f38b0383e3cb696de9529435db8c3f2b8f9fa
deleted: sha256:dffc8a9394db94888819efdf51824b66e8b3ad9e1a967edb7999b16b0795b200
deleted: sha256:d6af3f8a8f420720cad8c60166fd89ecfcbaef12afadec0515bd59ef89c81ea3
deleted: sha256:7da364773d147df1b2eab242e11b727ec0ea9b4a4a73c4ef5665af086c121dc4
deleted: sha256:14172a2d00e0dc69c211b85844dc9bb3a2eacbff7a21bdd83a0e8b8c75f7f2ac
deleted: sha256:36b98317dc09b7b78764a0420fdec2d14d576c7f1be1d4472359a32534689aa7
untagged: mongo:7.0
deleted: sha256:b59cefef4ac85d75492e4891d790aafeed4a46625f3795600a8d06586632068e
deleted: sha256:cff70de6da51c944cc3c90c97af54470d2d77cca484b2b792729e252af0df8b7
deleted: sha256:32007f09d4c258abd1c043d40c47f3773bbad5bb6b48143601c20265e4d90cab
deleted: sha256:0e25612b6db22df273732c47faba1dd81735a0dd9f6ea27b5222f281d67409f5
deleted: sha256:5eb248b6ddf1eadf7eaca9b867b48d2fb358bd5fc7dfc92e87380a22b8b17059
deleted: sha256:2cc77ea490de9f702ea64bc43eb81ee198becae77e86919b49e883735ad25f0b
deleted: sha256:3158b1c1e6c9cc737ff7f08bbdcbc3347ae2cee597bf6dfa7cf477f9222afa4a
deleted: sha256:713746464844a161951ac8fb95333403ed5084a9f98a472f288b7f9319ff2753
deleted: sha256:4e05c0f84fef18b087bc441264e6c079bc15949819f18fe0c869220cf3e30521
deleted: sha256:68565d0bd70359891fa6293eaf79d38c2f1ccce8c80ab68bc160505ceb88e7f5
deleted: sha256:648424fae6c67a473a7c5eab41f9487b605c42d4759a4fb8b8962653ee51bbc0

Total reclaimed space: 2.603GB
```

### Verify Cleanup

Check disk usage after cleanup:

```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          0         0         9.216MB   9.216MB (100%)
Containers      0         0         0B        0B
Local Volumes   43        0         327.1MB   327.1MB (100%)
Build Cache     5         0         4.173MB   4.173MB
```

Deleted all images and containers. The build cache increased.

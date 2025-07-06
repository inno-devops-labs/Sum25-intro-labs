### Lab 6 Docker

## Task: 0 
###Export image
┌──(root㉿kali)-[/opt]
└─# docker save -o ubuntu_image.tar ubuntu:latest

### List container                                                                                                                                
┌──(root㉿kali)-[/opt]
└─# docker ps -a                                 
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

### Check archive                                                                                                                                   
┌──(root㉿kali)-[/opt]
└─# du -h ubuntu_image.tar
77M     ubuntu_image.tar

### Image size
┌──(root㉿kali)-[/opt]
└─# docker images ubuntu:latest   
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       latest    f9248aac10f2   2 weeks ago   78.1MB

## Task 1: Core Container 
### List containers
└─# docker ps -a                                        
CONTAINER ID   IMAGE           COMMAND       CREATED          STATUS                     PORTS     NAMES
f5d3e2bf5eb9   ubuntu:latest   "/bin/bash"   20 seconds ago   Exited (0) 2 seconds ago             ubuntu_container

### Pull Ubuntu Image
└─# docker pull ubuntu:latest
latest: Pulling from library/ubuntu
Digest: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
Status: Image is up to date for ubuntu:latest
docker.io/library/ubuntu:latest

### Run interactive Container
└─# docker run -it --name ubuntu_container ubuntu:latest
root@f5d3e2bf5eb9:/# 
root@f5d3e2bf5eb9:/# ps -al
F S   UID     PID    PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
4 R     0       9       1  0  80   0 -  1980 -      pts/0    00:00:00 ps
root@f5d3e2bf5eb9:/# whoami 
root
root@f5d3e2bf5eb9:/# exit
exit

### Remove image 
└─# docker rmi ubuntu:latest                            
Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container f5d3e2bf5eb9 is using its referenced image f9248aac10f2

--We connot remove the imge because it is used (docker rm or docker rmi -f)

## Task 2: Image Customization
### Deploy Nginx
└─# docker run -d -p 80:80 --name nginx_container nginx
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
c231c59315360b38d4a43fa9e630065ea80eda043b653314e0071febca4dd1f9

-- curl check
└─# curl localhost
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

### Customize Website
Create index.html

└─# docker cp index.html nginx_container:/usr/share/nginx/html/
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/

└─# curl localhost                                             
<html>
<head>
<title>The best check</title>
</head>
<body>
<h1>website</h1>
</body>
</html>

### Create Custom Image
└─# docker commit nginx_container my_website:latest
sha256:76c540e9960d66d24f09f02a50970fcfec16c5a8283c9e345f20d63caa112d8e

└─# docker ps -a                                   
CONTAINER ID   IMAGE           COMMAND                  CREATED          STATUS                      PORTS                               NAMES
c231c5931536   nginx           "/docker-entrypoint.…"   4 minutes ago    Up 4 minutes                0.0.0.0:80->80/tcp, :::80->80/tcp   nginx_container

### Remove Original Container 
└─# docker rm -f nginx_container
nginx_container

└─# docker ps -a                
CONTAINER ID   IMAGE           COMMAND       CREATED          STATUS                      PORTS     NAMES
f5d3e2bf5eb9   ubuntu:latest   "/bin/bash"   13 minutes ago   Exited (0) 13 minutes ago             ubuntu_container

### Create New Container
└─# docker run -d -p 80:80 --name my_website_container my_website:latest
6b80525b851e3a87880c319c2a51e350fea15a13e1370563e30ffe8aa0ef9f41

### Test Web Server
└─# curl http://127.0.0.1:80
<html>
<head>
<title>The best check</title>
</head>
<body>
<h1>website</h1>
</body>
</html>

### Analyze Image Change
└─# docker diff my_website_container
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
C /run
C /run/nginx.pid

-- The docker diff command shows the changes in the container's filesystem compared to the base image. The output indicates:
C means "Changed" - the file was modified
/usr/share/nginx/html directory was modified (because we added a new file)
/usr/share/nginx/html/index.html was changed (our custom HTML file replaced the default one)

## Task 3: Container network
### Create Network
└─# docker network create lab_network
0865ef4e2edf94457b59e28ff58c7172590aab835d0ce93fc13f6940fe09e2e1

### Run Connected Containers
└─# docker run -dit --network lab_network --name container1 alpine ash
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
fe07684b16b8: Pull complete 
Digest: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
Status: Downloaded newer image for alpine:latest
b21a9d7b23c58b138426ca5a3e28df8b3bb66ee4dd1e1404836e82922f228a94

└─# docker run -dit --network lab_network --name container2 alpine ash
303c4c1155f815019126a5738e20c02f8d1f8164357aa8c8ab4fe76389b6ff53

### Test Connectivity
└─# docker exec container1 ping -c 3 container2
PING container2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.199 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.215 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.307 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.199/0.240/0.307 ms
#Docker DNS Resolution Explanation
Docker's internal DNS resolution works through:

Built-in DNS server: Docker runs an embedded DNS server on each container
Container name resolution: Containers can resolve each other by name within the same network
Network isolation: DNS resolution only works for containers in the same Docker network
IP address assignment: Docker assigns IP addresses automatically and maintains name-to-IP mapping

### Task 4: Volume Persistance
## Create Volume
└─# docker volume create app_data
app_data

## Run Container with Volume 
└─# docker run -d -v app_data:/usr/share/nginx/html --name web nginx
d99c4ed1f33fdcfc911932c1a052d7ecbabfdb7d54821b9bab02435661f0877c

## Modify Content
└─# docker cp index.html web:/usr/share/nginx/html/
Successfully copied 2.05kB to web:/usr/share/nginx/html/

## Verify Persistence
└─# docker stop web && docker rm web
web
web

└─# docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
3343e13b9bf68175fb70d969e3b5e1629793d9f2b1e8941710daf5cf20c4f096

└─# curl localhost          
<html>
<head>
<title>The best check</title>
</head>
<body>
<h1>website</h1>
</body>
</html>

### Task 5: Container Inspection
## Run Redis Container 
└─# docker run -d --name redis_container redis
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
db89d3bd82d03c8b89d70b7c1aa11deb752d3accfdaa91c9143abe658e34be02

## Inspect Processes
└─# docker exec redis_container ps aux
OCI runtime exec failed: exec failed: unable to start container process: exec: "ps": executable file not found in $PATH: unknown

--need install procps
└─# docker exec redis_container apt-get update 
Get:1 http://deb.debian.org/debian bookworm InRelease [151 kB]
Get:2 http://deb.debian.org/debian bookworm-updates InRelease [55.4 kB]
Get:3 http://deb.debian.org/debian-security bookworm-security InRelease [48.0 kB]
Get:4 http://deb.debian.org/debian bookworm/main amd64 Packages [8793 kB]
Get:5 http://deb.debian.org/debian bookworm-updates/main amd64 Packages [756 B]
Get:6 http://deb.debian.org/debian-security bookworm-security/main amd64 Packages [271 kB]
Fetched 9319 kB in 9s (1033 kB/s)
Reading package lists...

└─# docker exec redis_container apt-get install -y procps
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
Need to get 1178 kB of archives.
---------
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


└─# docker exec redis_container ps aux                   
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
redis          1  0.6  0.1 147312 23008 ?        Ssl  13:34   0:00 redis-server *:6379
root         230 16.6  0.0   8092  4260 ?        Rs   13:37   0:00 ps aux

## Network Inspection
└─# docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
172.17.0.4

### Docker exec vs Docker attach
docker exec: Debugging, running diagnostic commands, accessing container shell without affecting main process
docker attach: Interactive applications, viewing real-time logs, direct interaction with main application

## Task 6: Cleanup Operation
### Initial Disk Usage
└─# docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          5         5         331.7MB   192.2MB (57%)
Containers      6         5         21.52MB   20B (0%)
Local Volumes   2         2         589B      0B (0%)
Build Cache     0         0         0B        0B

### Create Test Objects
└─# for i in {1..5}; do docker run --name temp$i alpine echo "hello"; done
hello
hello
hello
hello
hello

### Remove Stopped Containers
Deleted Containers:
416e4c5c8dbd21ade2e10d8ad169aabf07992317a10fe5f00952bb6ddfadf26c
2c1dc6c5c2d6e4f26cc8c8a7f004325beda62e9926ef86730268e10e812b363b
24c56c45cc596c4ab631f9fbe146135e0b1865000cbda8c252824b54d2562a06
fc92ef5cac716d1798af823ecdc4a413a4acdaa54fcdcce01e78b0a70a8207f6
cd398c6d777796f3c75333e621c7941a70691524c58837b8ee9545530dcf4738
f5d3e2bf5eb98226a12987f82385d258758f44ddc9e7896291799526b857a960

Total reclaimed space: 20B

### Remove Unused Images
└─# docker image prune -a -f
Deleted Images:
untagged: ubuntu:latest
untagged: ubuntu@sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
deleted: sha256:f9248aac10f2f82e0970222e36cc7b71215b88e974e001282e5cd89797a82218
deleted: sha256:45a01f98e78ce09e335b30d7a3080eecab7f50dfa0b38ca44a9dee2654ac0530

Total reclaimed space: 78.12MB

### Final Disk Usage

└─# docker system df                                                      
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          4         4         253.6MB   192.2MB (75%)
Containers      5         5         21.52MB   0B (0%)
Local Volumes   2         2         589B      0B (0%)
Build Cache     0         0         0B        0B

Key Learnings

Container Lifecycle: Understanding the relationship between images, containers, and their dependencies
Image Layers: How Docker builds and manages image layers for efficiency
Networking: Docker's built-in DNS and network isolation capabilities
Data Persistence: Volume management for data that survives container restarts
Resource Management: Importance of regular cleanup to manage disk space
Inspection Tools: Various methods to examine container internals and troubleshoot issues

### prepare and use some script
└─# ./clean-docker.sh 
🧹 Docker Lab 6 - Cleanup
=========================
Stopping all running containers...
db89d3bd82d0
3343e13b9bf6
303c4c1155f8
b21a9d7b23c5
6b80525b851e
Removing lab containers...
my_website_container
container1
container2
web_new
redis_container
Removing temporary containers...
Removing custom network...
lab_network
Removing volumes...
app_data
Removing custom images...
Untagged: my_website:latest
Deleted: sha256:76c540e9960d66d24f09f02a50970fcfec16c5a8283c9e345f20d63caa112d8e
Deleted: sha256:41ba647b24285243e9f5cb238e1841ee54fefc59a1f7b7075120ce9cb128a1fa
Removing exported tar file...
Final cleanup - removing unused resources...
Deleted Volumes:
a08ccf6927a803d5bc0e984ce384c3f8b103c58ea3c0cf0ec2d5735b7ec0a1ae

Deleted Images:
untagged: redis:latest
untagged: redis@sha256:b43d2dcbbdb1f9e1582e3a0f37e53bf79038522ccffb56a25858969d7a9b6c11
deleted: sha256:ed3a2af6d0d46ba343b13c99d5f410d5b5db5470712ec6f404fb3442665f7490
deleted: sha256:790365dd7a7df02c7a8cbafe96e39a67aafd2a30e80224428a228276c47e82c3
deleted: sha256:a9d60cdf032c33bafe2f02ab87f992873bf03e5651b401bfcce96f9aa79f1371
deleted: sha256:9f6332e5846c42c9fcbaf21d2c34f97d620e7aea7038c7316aa2c45407abd9ad
deleted: sha256:d0733542a16bbf95d4443e2c6c82b6711a5600e60f5947720a4042a6628158db
deleted: sha256:3c7b0ebe1a438257dfe1b426dcd8a58ef1875d8363840530b44f0281188809d0
deleted: sha256:3490e7b67ce4f4b7ebe6ee4830fdcfc999f66d2c64453fe331296d0c3dde2fa1
untagged: nginx:latest
untagged: nginx@sha256:93230cd54060f497430c7a120e2347894846a81b6a5dd2110f7362c5423b4abc
deleted: sha256:9592f5595f2b12c2ede5d2ce9ec936b33fc328225a00b3901b96019e3dd83528
deleted: sha256:8f3a28fb15e024be11bb5558f29adeaa18f2087363187d7dbb3ea58140f9887c
deleted: sha256:350738d51ca51436ab482da48a1ff31e39e0b76e06b301205e458e500dc14fd0
deleted: sha256:d914f296dd7dad8fee558cc14bf984bb569a301f95c757e77b1e59d0d3a4e640
deleted: sha256:2e79d5623eaa2cfc931d9903695f10d0b9def9208f5558a0d5a76af319fe2e02
deleted: sha256:cbc33e4b574314612fab56ecbe98b5b00d5f9a60865ad833dccacbf0110bb9f3
deleted: sha256:74127feb282ee904f7c10e10c2d86f6b27db8421c361813546a8da7f351ef64a
deleted: sha256:1bb35e8b4de116e84b2ccf614cce4e309b6043bf2cd35543d8394edeaeb587e3
untagged: alpine:latest
untagged: alpine@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
deleted: sha256:cea2ff433c610f5363017404ce989632e12b953114fefc6f597a58e813c15d61
deleted: sha256:fd2758d7a50e2b78d275ee7d1c218489f2439084449d895fa17eede6c61ab2c4

Total reclaimed space: 253.6MB
✅ Cleanup completed!
Lab environment has been reset.


# Credentials

The work is done by M24-RO student  
Anton Kirilin  
a.kirilin@innopolis.university  

# Task 0

Here I am using WSL again. I ran into a problem that basically there are no docker images  

```sh
:~/Sum25-intro-labs$ sudo docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
```  
So let's pull the latest ubuntu to create the image and save it  

```sh
:~/Sum25-intro-labs$ sudo docker pull ubuntu:latest
latest: Pulling from library/ubuntu
b08e2ff4391e: Pull complete 
Digest: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```  

Now I have the image to store  

```sh
:~/Sum25-intro-labs$ sudo docker images
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       latest    f9248aac10f2   2 weeks ago   78.1MB
```  

the compressed image is 1 mb less  

```sh
:~/Sum25-intro-labs$ du -sh ubuntu_image.tar 
77M     ubuntu_image.tar
```  

# Task 1

Right now I have 0 docker containers  

```sh
:~/Sum25-intro-labs$ sudo docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```  

I already pulled the latest image, so skip that step  

```sh
:~/Sum25-intro-labs$ sudo docker run -it --name ubuntu_container ubuntu:latest
root@ffe41fbf65ad:/# exit
exit
```  

Let's remove the image  

```sh
:~/Sum25-intro-labs$ sudo docker rmi ubuntu:latest
Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container ffe41fbf65ad is using its referenced image f9248aac10f2
```  

We have created a container that uses the image that is why we cannot remove it.  

# Task 2

Let's start  

```sh
:~/Sum25-intro-labs$ sudo docker run -d -p 80:80 --name nginx_container nginx
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
bb9acf380dee72599d1a5218c37fee7371f08b5df82a7f435011f847162eacce
```  

```sh
:~/Sum25-intro-labs$ curl localhost
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

Now we create a file and copy it into the container  

```sh
:~/Sum25-intro-labs$ sudo docker cp index.html nginx_container:/usr/share/nginx/html/
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
```   

```sh
:~/Sum25-intro-labs$ sudo docker commit nginx_container my_website:latest
sha256:b71c8bf7a1ef5971556441f2f733d770fd41a3f9c1855ca9329eb46c5b0a9450
```  

now I remove the container  

```sh
:~/Sum25-intro-labs$ sudo docker rm -f nginx_container
nginx_container
```  

```sh
:~/Sum25-intro-labs$ sudo docker ps -a
CONTAINER ID   IMAGE           COMMAND       CREATED          STATUS                      PORTS     NAMES
ffe41fbf65ad   ubuntu:latest   "/bin/bash"   14 minutes ago   Exited (0) 14 minutes ago             ubuntu_container
```  

Now I create the container from the saved image

```sh
:~/Sum25-intro-labs$ sudo docker run -d -p 80:80 --name my_website_container my_website:latest
1e947c2e191d7c902bab8d0a295b34104f0794ca24d286a14da28e9207860511
```  

Everything is fine on the localhost  

```sh
:~/Sum25-intro-labs$ curl http://127.0.0.1:80
<html>
<head>
<title>The best</title>
</head>
<body>
<h1>website</h1>
</body>
```  

```sh
:~/Sum25-intro-labs$ sudo docker diff my_website_container
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
C /run
C /run/nginx.pid
```  

Changes are in the config files and run files

# Task 3

```sh
:~/Sum25-intro-labs$ sudo docker network create lab_network
1de36e0cd70100bb213748fa303962cd2e6ba62686e81662c37d977ecd33a9c7
```  

I have no alpine images (you could tell from the previous step), so I pull it  

```sh
:~/Sum25-intro-labs$ sudo docker pull alpine
Using default tag: latest
latest: Pulling from library/alpine
fe07684b16b8: Pull complete 
Digest: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
Status: Downloaded newer image for alpine:latest
docker.io/library/alpine:latest
```  

Now I start the 2 docker containers

```sh
sudo    docker run -dit --network lab_network --name container1 alpine ash
34bc9b21a5daf546ee7ac28119d6209b734f74e26d1ad66ba0d0522cc57b2a3e
```  

```sh
:~/Sum25-intro-labs$ sudo docker run -dit --network lab_network --name container2 alpine ash
53e5772c947266d61d5a6f9817701fc19533e5a7b9f15f69a102df19bf62ae54
```  

Now let's ping one from another

```sh
:~/Sum25-intro-labs$ sudo docker exec container1 ping -c 3 container2
PING container2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.106 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.282 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.156 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.106/0.181/0.282 ms
```  

Docker containers on the same bridge network can ping each other due to how Docker handles networking. When containers are created with a bridge network, Docker automatically creates a virtual Ethernet bridge (a software bridge) on the host machine and connects each container's network interface to this bridge using virtual Ethernet pairs (veth pairs). This setup allows containers on the same bridge network to communicate with each other using their IP addresses or hostnames.  

# Task 4

Creating the volume

```sh
:~/Sum25-intro-labs$ sudo docker volume create app_data
app_data
```  

starting nginx with mounted volume

```sh
:~/Sum25-intro-labs$ sudo docker run -d -v app_data:/usr/share/nginx/html --name web nginx
1ec6dff86975f6968333774ef7eb71fd673ef7a7dba47e7170f64e6ce027c3a5
```  

I already have the html file from the previos tasks, let's just add task 4 somewhere in it  

```sh
:~/Sum25-intro-labs$ sudo docker cp index.html web:/usr/share/nginx/html/
Successfully copied 2.05kB to web:/usr/share/nginx/html/
```  
remove the web container  

```sh
:~/Sum25-intro-labs$ sudo docker stop web && sudo docker rm web
web
web
```  

Here is the thing, I was unable to access the localhost because the ports for the container were unaccessable. So I had to specify the port manually. 

```sh
:~/Sum25-intro-labs$ sudo docker run -d -p 80:80 -v app_data:/usr/share/nginx/html --name web_new nginx
d620c8e5bf560fb064cca0a99399b0fbcb88bec52bc0acd40c1f27c710b4647e
```  

```sh
:~/Sum25-intro-labs$ curl localhost
<html>
<head>
<title>The best</title>
</head>
<body>
<h1>website (TASK 4)</h1>
</body>
```  

# Task 5

First we run the container  

```sh
~/Sum25-intro-labs$ sudo docker run -d --name redis_container redis
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
9c5ba3f57523f389d38f302a9b39f33b3449ac204530ad68b74624662ac96536
```  

redis util has no ps comman so we have to install it

```sh
:~/Sum25-intro-labs$ sudo docker exec redis_container ps aux
OCI runtime exec failed: exec failed: unable to start container process: exec: "ps": executable file not found in $PATH: unknown
```  

after the installation we have  

```sh
:~/Sum25-intro-labs$ sudo docker exec redis_container ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
redis          1  0.4  0.2 147312 17920 ?        Ssl  09:42   0:02 redis-server *:6379
root         248 42.8  0.0   8092  4096 ?        Rs   09:51   0:00 ps aux
```  

Now inspect  

```sh
:~/Sum25-intro-labs$ sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
172.17.0.3
```  

As the names suggest the exec command executes the script inside the dicker container. Its purpose is to work with the new things, like sending the message and waiting for the reply. Whereas attach is attached to a already runnig process inside the container. Therefore you are able use it online to see the changes and work from the inside.

# Task 6

Check the sizes  

```sh
:~/Sum25-intro-labs$ sudo docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          5         4         331.7MB   192.2MB (57%)
Containers      5         4         21.52MB   5B (0%)
Local Volumes   2         2         591B      0B (0%)
Build Cache     0         0         0B        0B
```  

create the containers  

```sh
:~/Sum25-intro-labs$ for i in {1..3}; do sudo docker run --name temp$i alpine echo "hello"; done
hello
hello
hello
```  

create 2 dangling images  

```sh
:~/Sum25-intro-labs$ sudo docker build -t temp-image . && sudo docker rmi temp-image
[+] Building 0.1s (5/5) FINISHED                                                                                                                              docker:default
 => [internal] load build definition from Dockerfile                                                                                                                    0.0s
 => => transferring dockerfile: 84B                                                                                                                                     0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                                                                                        0.0s
 => [internal] load .dockerignore                                                                                                                                       0.0s
 => => transferring context: 2B                                                                                                                                         0.0s
 => CACHED [1/1] FROM docker.io/library/alpine:latest                                                                                                                   0.0s
 => exporting to image                                                                                                                                                  0.0s
 => => exporting layers                                                                                                                                                 0.0s
 => => writing image sha256:cd95a7a63d4cb4a1233f86b9e88373a178361ad1fabfe804d5df4bd346c7ff7b                                                                            0.0s
 => => naming to docker.io/library/temp-image                                                                                                                           0.0s
Untagged: temp-image:latest
Deleted: sha256:cd95a7a63d4cb4a1233f86b9e88373a178361ad1fabfe804d5df4bd346c7ff7b
```  

let's clear  

```sh
:~/Sum25-intro-labs$ sudo docker container prune -f
Deleted Containers:
4ee9dfbb1329edd7a24348196ccbfe229385428a7c8aee8a0f18b72ca18d6f99
62220f1dd86db89b18f964eca885aea948386c2bad18ca1cadae169b5565521e
2dca9b6c06c439df67d1f60dbd26f523ae7c3f768e63d222fd03552aeddf9672
ffe41fbf65ada8e1965ddfccebad75ef92d9129e7b897d7ff27cc17e83b906e1

Total reclaimed space: 5B
```  

remove unused images  

```sh
:~/Sum25-intro-labs$ sudo docker image prune -a -f
Deleted Images:
untagged: ubuntu:latest
untagged: ubuntu@sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
deleted: sha256:f9248aac10f2f82e0970222e36cc7b71215b88e974e001282e5cd89797a82218
deleted: sha256:45a01f98e78ce09e335b30d7a3080eecab7f50dfa0b38ca44a9dee2654ac0530
untagged: my_website:latest
deleted: sha256:b71c8bf7a1ef5971556441f2f733d770fd41a3f9c1855ca9329eb46c5b0a9450
deleted: sha256:2af5b1bfa30324e4c96a26d2e05c4edd87771fffc18fdd86b1db779e9c5c1bc7

Total reclaimed space: 78.12MB
```  

verify (shouldn't we heck it first after we have created useless containers? idk)  

```sh
:~/Sum25-intro-labs$ sudo docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          3         3         253.6MB   74.81MB (29%)
Containers      4         4         21.52MB   0B (0%)
Local Volumes   2         2         591B      0B (0%)
Build Cache     3         0         0B        0B
```  
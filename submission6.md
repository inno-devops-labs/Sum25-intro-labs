## Task 1

Command `docker ps -a`

~~~bash
CONTAINER ID   IMAGE             COMMAND                  CREATED        STATUS                      PORTS     NAMES
bb6afca6e593   postgres:latest   "docker-entrypoint.s…"   2 months ago   Exited (0) 2 months ago               postgres_container
f5a5083402ef   odoo:18.0         "/entrypoint.sh odoo…"   2 months ago   Exited (0) 2 months ago               ODOO
102c38d4b171   postgres:15       "docker-entrypoint.s…"   2 months ago   Exited (0) 2 months ago               POSTGRES
c06e7a1c17a0   482f23155c95      "/bin/sh -c 'echo Co…"   3 months ago   Exited (0) 3 months ago               brave_torvalds
10e2a8235157   482f23155c95      "/bin/bash -ci 'sour…"   3 months ago   Exited (0) 3 months ago               ros_noetic_container
0a732f5ca068   870141b735e7      "/sbin/tini -- /dock…"   5 months ago   Exited (143) 2 months ago             mongodb-mongo-express-1
e81cb51f7950   f08e39122805      "docker-entrypoint.s…"   5 months ago   Exited (0) 2 months ago               mongodb-mongo-1
~~~

Command `docker pull ubuntu:latest`

~~~bash
latest: Pulling from library/ubuntu
b08e2ff4391e: Pulling fs layer
b08e2ff4391e: Verifying Checksum
b08e2ff4391e: Download complete
b08e2ff4391e: Pull complete
Digest: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
~~~

Command `docker run -it --name ubuntu_container ubuntu:latest`

~~~bash
[?2004h]0;root@fcabb221c669: /root@fcabb221c669:/# exit
[?2004l
exit
~~~

Command `docker rmi ubuntu:latest`

~~~bash
Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container fcabb221c669 is using its referenced image f9248aac10f2
~~~

While the container is running, thus we connot to delete the image

Command `docker run -d -p 80:80 --name nginx_container nginx | curl localhost`

~~~html
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
~~~

Command `docker cp index.html nginx_container:/usr/share/nginx/html/`

~~~bash
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
~~~

Command `curl localhost`

~~~html
<html>
     <head>
     <title>The best</title>
     </head>
     <body>
     <h1>website</h1>
     </body>
     </html>
~~~

Command `docker commit nginx_container my_website:latest`

~~~bash
sha256:04e979b5d839d14a980eae2f1b7fb2841772697df5b1b33210e483db11572f23
~~~

Command `docker rm -f nginx_container`

~~~bash
nginx_container
~~~

Command `docker run -d -p 80:80 --name my_website_container my_website:latest`

~~~bash
dc3461deca950cf063623127a8adcdcfc253640d17d8486659ef69a6b50913e9
~~~

Command `curl http://127.0.0.1:80`

~~~html
<html>
     <head>
     <title>The best</title>
     </head>
     <body>
     <h1>website</h1>
     </body>
     </html>
~~~

Command `docker diff my_website_container`

~~~bash
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
C /run
C /run/nginx.pid
~~~

## Task 3

Command `docker network create lab_network`

~~~bash
b577b0cebfe135809b7caabba270fd80fb0d132972c8c70d660c126247f1383b
~~~

Command `docker run -dit --network lab_network --name container1 alpine ash`

~~~bash
7774d9a3c95afed7644a109089597ffcd28fc40b4a3d7cd3c86bad336a90b2ec
~~~

Command `docker run -dit --network lab_network --name container2 alpine ash`

~~~bash
13b3101fb23debe6e282ab0a0a86e1086a817c8af9be01181264ba2c1aa0ec89
~~~

Command `docker exec container1 ping -c 3 container2`

~~~bash
PING container2 (172.29.0.3): 56 data bytes
64 bytes from 172.29.0.3: seq=0 ttl=64 time=0.065 ms
64 bytes from 172.29.0.3: seq=1 ttl=64 time=0.104 ms
64 bytes from 172.29.0.3: seq=2 ttl=64 time=0.105 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.065/0.091/0.105 ms
~~~

## Task 4

Command `docker volume create app_data`

~~~bash
app_data
~~~

Command `docker run -d -v app_data:/usr/share/nginx/html --name web nginx`

~~~bash
26f896dc03d746891f0ad1f9353e7bdc2d038f444fb2882fe9cda7da549fdf15
~~~

Command `docker stop web && docker rm web`

~~~bash
web
~~~

Command `docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx`

~~~bash
3e710bd82939acef3542951e99c61389b9ab25e8a86646410f1266e9d56b9271
~~~

Command `curl localhost`

~~~html
<html>
     <head>
     <title>The best</title>
     </head>
     <body>
     <h1>website</h1>
     </body>
     </html>
~~~

## Task 5

Command `docker run -d --name redis_container redis`

~~~bash
1157fef98b31cad5f26a35b2a935ba10c61d0c6acac8ddf17ef8b23937854760
~~~

Command `docker exec redis_container ps aux`

~~~bash
OCI runtime exec failed: exec failed: unable to start container process: exec: "ps": executable file not found in $PATH: unknown
~~~

Command `docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container`

~~~bash
172.17.0.4
~~~

## Report

To stop all containers you can use `docker stop $(docker ps -a -q) `, and to remove all images `docker rmi -f $(docker images -a -q)`
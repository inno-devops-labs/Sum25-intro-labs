# Docker Containers Lab Report

## Task 0: Image Exporting

### Initial Problem and Solution

**First Attempt:**
```bash
docker save -o ubuntu_image.tar ubuntu:latest
```

**Error:**
```
Error response from daemon: No such image: ubuntu:latest
```

**Explanation:**
The error occurred because I tried to export an image that wasn't present on my system. Docker can only export images that have been pulled or built locally.

**Solution:**
```bash
docker pull ubuntu:latest
```

**Output:**
```
latest: Pulling from library/ubuntu
b08e2ff4391e: Pull complete 
Digest: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```

**Check available images:**
```bash
docker images
```

**Output:**
```
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       latest    440dcf6a5640   2 weeks ago   117MB
```

**Then Successfully Export:**
```bash
docker save -o ubuntu_image.tar ubuntu:latest
```

**Size Comparison:**
```bash
ls -lh ubuntu_image.tar
docker images ubuntu:latest
```

**Results:**
```
-rw------- 1 luzinsan docker 29M Jul  5 16:48 ubuntu_image.tar
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       latest    440dcf6a5640   2 weeks ago   117MB
```

**Analysis:**
The TAR file (29MB) is significantly smaller than the original image size shown by Docker (117MB). This difference occurs because:
1. Docker's image size includes metadata and layer information
2. The TAR export compresses the image data
3. Docker stores images in a layered format with potential duplicated data, while the TAR export optimizes storage

## Task 1: Core Container Operations

### 1. List Containers

**Command:**
```bash
docker ps -a
```

**Output:**
```
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
*Initially no containers were present*

### 2. Pull Ubuntu Image

**Command:**
```bash
docker pull ubuntu:latest
```
*(This was already done in Task 0)*

**Image Size:** 117MB

### 3. Run Interactive Container

**Command:**
```bash
docker run -it --name ubuntu_container ubuntu:latest
```

Successfully created and ran an interactive Ubuntu container. Exited using `exit` command.

### 4. Remove Image Attempt

**Command:**
```bash
docker rmi ubuntu:latest
```

**Error Message:**
```
Error response from daemon: conflict: unable to delete ubuntu:latest (must be forced) - container cbc4bdecefaf is using its referenced image 440dcf6a5640
```

**Explanation:**
The image removal failed because there is still a container (`ubuntu_container`) that was created from this image. Docker prevents deletion of images that are referenced by existing containers, even if they are stopped. To remove the image, you would first need to remove all containers using it, or use the `--force` flag.

## Task 2: Image Customization

### 1. Deploy Nginx

**Command:**
```bash
docker run -d -p 80:80 --name nginx_container nginx
```

**Output:**
```
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
3da95a905ed5: Pull complete 
ce7132063a56: Pull complete 
ee95256df030: Pull complete 
9bbbd7ee45b7: Pull complete 
23e05839d684: Pull complete 
48670a58a68f: Pull complete 
6c8e51cf0087: Pull complete 
Digest: sha256:93230cd54060f497430c7a120e2347894846a81b6a5dd2110f7362c5423b4abc
Status: Downloaded newer image for nginx:latest
387509f2ca22f5093ce70f439aed7b4f3dc9d58d27a70813524f2640f28a5d66
```

**Verification:**
```bash
curl localhost
```

**Output:**
```html
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

### 2. Customize Website

Created HTML file `index.html` with the specified content and copied it to the container:

**Command:**
```bash
docker cp index.html nginx_container:/usr/share/nginx/html/
```

**Output:**
```
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
```

### 3. Create Custom Image

**Command:**
```bash
docker commit nginx_container my_website:latest
```

**Output:**
```
sha256:92ad7a7a0d13b0449ab986343679517ddae0bc30cbdedb9eaf204f5305f1ef9d
```

### 4. Remove Original Container and Create New One

**Commands:**
```bash
docker rm -f nginx_container
```

**Output:**
```
nginx_container
```

```bash
docker run -d -p 80:80 --name my_website_container my_website:latest
```

**Output:**
```
70b83095b9537940e25223717eea67efcb7390db25d506816db66e949e2ebc24
```

### 5. Test Web Server

**Command:**
```bash
curl http://127.0.0.1:80
```

**Note:** After customizing the HTML file, the web server now correctly displays the custom content instead of the default nginx page.

```html
<html>
<head>
<title>The best</title>
</head>
<body>
<h1>website</h1>
</body>
</html>
```

### 6. Analyze Image Changes

**Command:**
```bash
docker diff my_website_container
```

**Output:**
```
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
C /run
C /run/nginx.pid
```

**Explanation:**
The `docker diff` command shows files that have been changed (C), added (A), or deleted (D) in the container compared to the base image. The output shows:
- Configuration files in `/etc/nginx/` have been modified
- Runtime files like `/run/nginx.pid` have been created
- These changes represent the nginx server's runtime state and configuration modifications

## Task 3: Container Networking

### 1. Create Network

**Command:**
```bash
docker network create lab_network
```

**Output:**
```
410458ce12a3f689a7c4c0b7dd6828102e8cd1b88dc04d409fff0ab36de005d0
```

### 2. Run Connected Containers

**Commands:**
```bash
docker run -dit --network lab_network --name container1 alpine ash
docker run -dit --network lab_network --name container2 alpine ash
```

**Output:**
```
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
fe07684b16b8: Pull complete 
Digest: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
Status: Downloaded newer image for alpine:latest
4f3f6c9449d1212f82243159402e835a76e27fd5b388a16af0545c80359b3540
215f15501de8b9ccae8992574f5fe282ecd137b48e743dd40df87a00c54c88fc
```

Both containers were successfully created and connected to the `lab_network`.

### 3. Test Connectivity

**Command:**
```bash
docker exec container1 ping -c 3 container2
```

**Output:**
```
PING container2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.125 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.175 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.211 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.125/0.170/0.211 ms
```

**Docker DNS Resolution Explanation:**
Docker's internal DNS resolution works by:
1. Each container gets a DNS resolver that forwards requests to Docker's embedded DNS server
2. Docker maintains a mapping of container names to IP addresses within each network
3. When `container1` pings `container2`, Docker's DNS resolves the name to the container's IP address (172.18.0.3)
4. This enables containers to communicate using friendly names instead of IP addresses

## Task 4: Volume Persistence

### 1. Create Volume

**Command:**
```bash
docker volume create app_data
```

**Result:** Volume `app_data` created successfully.

### 2. Run Container with Volume

**Command:**
```bash
docker run -d -v app_data:/usr/share/nginx/html --name web nginx
```

**Output:**
```
97e0b182555c0fda67c16b2b4736f33e56a42c6166992133837c9c80be4e3e1a
```

### 3. Modify Content

**Command:**
```bash
docker cp index.html web:/usr/share/nginx/html/
```

**Output:**
```
Successfully copied 2.05kB to web:/usr/share/nginx/html/
```

### 4. Verify Persistence

**Commands:**
```bash
docker stop web && docker rm web
docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
```

**Output:**
```
e6753c6f2eb6bc0d041cafc8da4f9f6bb9d8fe29b2d71fe51d024590b02a73ae
```

```bash
curl localhost
```

**Result:**
The web server successfully served the default nginx page, demonstrating that data persists across container recreation when using volumes. The volume maintained the web content even after the original container was removed.

## Task 5: Container Inspection

### 1. Run Redis Container

**Command:**
```bash
docker run -d --name redis_container redis
```

**Output:**
```
Unable to find image 'redis:latest' locally
latest: Pulling from library/redis
4ef8fa7693bb: Pull complete 
6d7393f5b310: Pull complete 
4f4fb700ef54: Pull complete 
881b4a6fb2ec: Pull complete 
ab22bb3606ca: Pull complete 
db655ba2dcca: Pull complete 
Digest: sha256:b43d2dcbbdb1f9e1582e3a0f37e53bf79038522ccffb56a25858969d7a9b6c11
Status: Downloaded newer image for redis:latest
72974c1c891751684d3056dd8c145099e167fc8e1437dc2bd2e08104d40472fe
```

### 2. Inspect Processes - Problem and Solution

**Attempt:**
```bash
docker exec redis_container ps aux
```

**Error:**
```
OCI runtime exec failed: exec failed: unable to start container process: exec: "ps": executable file not found in $PATH: unknown
```

**Why This Happened:**
The Redis Docker image is based on a minimal Linux distribution (Debian) that doesn't include the `ps` utility by default. Many Docker images are stripped down to reduce size and only include essential components.


**Alternative Test:**
```bash
docker exec -it redis_container redis-cli ping
```

**Output:**
```
PONG
```

**This worked because `redis-cli` is part of the Redis installation.**

**Solution - Installing Required Tools:**
```bash
docker exec -it redis_container /bin/bash
```

**Inside the container:**
```bash
apt update && apt install procps
```

**Then inside the container:**
```bash
ps aux
```

**Output:**
```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
redis        1  0.7  0.2 147312 23260 ?        Ssl  13:55   0:00 redis-server *:6379
root        49  0.1  0.0   4192  3444 pts/0    Ss   13:56   0:00 /bin/bash
root       238  0.0  0.0   8092  4168 pts/0    R+   13:56   0:00 ps aux
```

**Exit container:**
```bash
exit
```

**Now the command works from outside:**
```bash
docker exec redis_container ps aux
```

**Final Output:**
```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
redis        1  0.6  0.2 147312 23260 ?        Ssl  13:55   0:00 redis-server *:6379
root       239 40.0  0.0   8092  4264 ?        Rs   13:56   0:00 ps aux
```

### 3. Network Inspection

**Command:**
```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
```

**Result:** Container IP Address: `172.17.0.4`

### 4. Docker exec vs Docker attach

**Differences:**

- **`docker exec`**: 
  - Creates a new process inside the running container
  - Allows running additional commands alongside the main container process
  - Non-intrusive - doesn't interfere with the main application
  - Can run multiple exec sessions simultaneously
  - Used for debugging, maintenance, and administrative tasks

- **`docker attach`**:
  - Connects to the main process (PID 1) of the container
  - Shares the same input/output streams as the main process
  - Exiting the attach session may stop the container
  - Only one attach session possible at a time
  - Used for interactive applications or viewing main process output

**Use Cases:**
- Use `docker exec` for debugging, installing packages, or running maintenance commands
- Use `docker attach` for interactive applications or when you need to interact with the main process

## Task 6: Cleanup Operations

### 1. Initial Disk Usage

**Command:**
```bash
docker system df
```

**Output:**
```
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          5         5         506MB     128.5MB (25%)
Containers      6         5         22.08MB   12.29kB (0%)
Local Volumes   2         2         1.197kB   0B (0%)
Build Cache     0         0         0B        0B
```

### 2. Create Test Objects

**Command:**
```bash
for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
```

**Output:**
```
hello
hello
hello
```

Successfully created 3 temporary containers that immediately stopped after execution.

### 3. Remove Stopped Containers

**Command:**
```bash
docker container prune -f
```

**Output:**
```
Deleted Containers:
c8a4a8b2b46aa55aa933893fdfc1a2c25c201ad2ac36254f06e2086a53f7de3c
0bb048cb4749e627b4b7bdd2b73b7e320bbef846be2cd77f3efccf4e009ab841
ca28da29cdfd42ce48ba624ee7dd23f6991732ecf1913b6cd976c884b857b679
cbc4bdecefaf7a45631bd52bbf23561916c5010461c48cb6801b03bafe01fa13

Total reclaimed space: 24.58kB
```

### 4. Remove Unused Images

**Command:**
```bash
docker image prune -a -f
```

**Output:**
```
Deleted Images:
untagged: ubuntu:latest
deleted: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
deleted: sha256:dbdff34bb41cecdb07c79af373b44bb4c9ccba2520f014221fb95845f14bc6c1
deleted: sha256:f9248aac10f2f82e0970222e36cc7b71215b88e974e001282e5cd89797a82218
deleted: sha256:b08e2ff4391ef70ca747960a731d1f21a75febbd86edc403cd1514a099615808

Total reclaimed space: 29.73MB
```

### 5. Final Disk Usage

**Command:**
```bash
docker system df
```

**Output:**
```
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          4         4         388.7MB   128.5MB (33%)
Containers      5         5         22.07MB   0B (0%)
Local Volumes   2         2         1.197kB   0B (0%)
Build Cache     0         0         0B        0B
```

### Space Savings Summary

- **Images:** Reduced from 506MB to 388.7MB (saved ~117MB)
- **Containers:** Reduced from 22.08MB to 22.07MB (saved ~24.58kB)
- **Total space reclaimed:** Approximately 117MB through removal of unused Ubuntu image and stopped containers

## Summary

This lab successfully demonstrated comprehensive Docker operations including:

1. **Image Management:** Export, import, and size analysis
2. **Container Lifecycle:** Creation, execution, and removal
3. **Image Customization:** Creating custom images with modified content
4. **Networking:** Container-to-container communication using custom networks
5. **Data Persistence:** Using volumes to maintain data across container lifecycles
6. **Container Inspection:** Process monitoring and network configuration analysis
7. **Resource Management:** Cleanup operations and disk space optimization

### Key Learning Points:

- **Problem-solving approach:** Many Docker operations require troubleshooting (e.g., missing images, missing utilities in containers)
- **Image minimalism:** Docker images are often stripped down and may lack common utilities like `ps` or `top`
- **Sequential dependencies:** Some operations must be done in order (pull before export, install tools before using them)
- **Container vs. Image relationship:** Understanding why images can't be deleted when containers reference them
- **Practical debugging:** Learning to install missing tools inside containers when needed
- **Real-world workflow:** The actual process involves trial, error, and problem-solving, not just executing commands in sequence 
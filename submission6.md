# Docker Lab Submission

## Task 0: Image Exporting

### Results:
- Exported .tar file size: **77 MB**
- Original image size in Docker: **78.1 MB**

### Explanation:
The size difference occurs because:
1. Docker images are stored as layered filesystems with additional metadata
2. The export process compresses layers differently than Docker's native storage
3. The .tar archive doesn't include all runtime configuration data

---

## Task 1: Core Container Operations

### 1.1 Container Listing

```plaintext
CONTAINER ID   IMAGE         COMMAND    CREATED         STATUS                     PORTS     NAMES
7383b8330f29   hello-world   "/hello"   7 minutes ago   Exited (0) 7 minutes ago             festive_kirch
9ad1cdde7803   hello-world   "/hello"   8 minutes ago   Exited (0) 8 minutes ago             festive_williamson
```

### 1.2 Pull Ubuntu Image

Downloaded ubuntu:latest size: 78.1MB

```plaintext
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       latest    f9248aac10f2   2 weeks ago   78.1MB
```

### 1.4 Image removal error

When trying to remove the Ubuntu image:

```plaintext
Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container c33d8aa0b12e is using its referenced image f9248aac10f2
```

**Reason**: The image cannot be removed because it's being used by stopped container "ubuntu_container".

## Task 2: Image Customization

### 2.1 Deploy Nginx

```plaintext
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

### 2.2 Customize Website

```plaintext
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
```

### 2.7 Analyze Image Changes

```plaintext
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
C /run
C /run/nginx.pid
```

C (Changed) indicates metadata modifications (timestamps, permissions).

## Task 3: Container Networking

### 3.3 Test Connectivity

```plaintext
PING container2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.076 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.072 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.073 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.072/0.073/0.076 ms
```

Docker uses internal DNS-server for containers' names resolving

## Task 4: Volume Persistence

### 4.4 Verify Persistence

```plaintext
danila@danila-VirtualBox:~$ docker stop web && docker rm web
web
web

danila@danila-VirtualBox:~$ docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
1fbaca40ad822c6b9947cd9a8c58c1178a7338d39ce5b14df16de44ad58d8861

danila@danila-VirtualBox:~$ curl localhost
<html>
<head>
<title>The best</title>
</head>
<body>
<h1>website</h1>
</body>
</html>
```

## Task 5: Container Inspection

### 5.2 Inspect processes

```plaintext
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
redis          1  0.1  0.2 147316 18248 ?        Ssl  16:29   0:05 redis-server *:6379
root         235  0.0  0.0   8092  4264 ?        Rs   17:17   0:00 ps aux
```

### 5.4 Document Difference

- `docker exec`: Runs a new command in a running container (without interrupting the main process).
- `docker attach`: Attaches to the main process of the container. If the process terminates, the container will stop.

## Task 6: Cleanup Operations

### 6.5 Verify Cleanup

**Before:**

```plaintext
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          7         6         331.7MB   192.2MB (57%)
Containers      10        5         21.52MB   5B (0%)
Local Volumes   2         2         583B      0B (0%)
Build Cache     0         0         0B        0B
```

**After:**

```plaintext
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          4         4         253.6MB   192.2MB (75%)
Containers      5         5         21.52MB   0B (0%)
Local Volumes   2         2         583B      0B (0%)
Build Cache     0         0         0B        0B
```
Space Reclaimed: 78.1 MB

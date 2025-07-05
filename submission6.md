# Containers Lab - Docker

Gain practical experience with Docker fundamentals through hands-on container management, image operations, networking, and storage tasks.

## Task 0: Image Exporting

**Objective**: Exporting images.

1. **Export Image**

   ```sh
   docker save -o ubuntu_image.tar ubuntu:latest
   ```

    After pulling the latest ubuntu image, and exporting it, comparison is as follows:

    ```sh
    justsomedude@DESKTOP-VD06QG9:~$ sudo docker save -oubuntu_image.tar ubuntu:latest
    justsomedude@DESKTOP-VD06QG9:~$ sudo docker images ubuntu
    REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
    ubuntu       latest    f9248aac10f2   2 weeks ago   78.1MB
    justsomedude@DESKTOP-VD06QG9:~$ ls -lh ubuntu_image.tar
    -rw------- 1 root root 77M Jul  6 00:43 ubuntu_image.tar
    ```
    - `docker images` Size (78.1MB):
        Represents the uncompressed size of all image layers combined. When Docker stores an image locally, it decompresses layers for runtime efficiency.
        This is the space consumed on disk for the image.

    - `docker save` Tarball Size (77M):
        Contains the compressed layers as they exist in the Docker registry (plus metadata). When one exports an image, Docker uses the original compressed blobs from its cache.
        This is the transfer-friendly version of the image.
## Task 1: Core Container Operations

**Objective**: Master basic container lifecycle management.

1. **List Containers**

   ```sh
   docker ps -a
   ```

    ```sh
    CONTAINER ID   IMAGE         COMMAND    CREATED          STATUS                      PORTS     NAMES
    20ccce2671f9   hello-world   "/hello"   19 minutes ago   Exited (0) 19 minutes ago             distracted_lumiere
    ```
    Here I have a test image that I used to test my installation.

2. **Pull Ubuntu Image**

   ```sh
   docker pull ubuntu:latest
   ```
    I have already pulled `ubuntu:latest` for task 0
    ```
    latest: Pulling from library/ubuntu
    Digest: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
    Status: Image is up to date for ubuntu:latest
    docker.io/library/ubuntu:latest
    ```
    I can see image size this way:
    ```
    justsomedude@DESKTOP-VD06QG9:~$ sudo docker images
    REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
    ubuntu        latest    f9248aac10f2   2 weeks ago    78.1MB
    hello-world   latest    74cc54e27dc4   5 months ago   10.1kB
    ```

3. **Run Interactive Container**
  
   ```sh
   docker run -it --name ubuntu_container ubuntu:latest
   ```
   Result of running:
    ```sh
    root@2609724bfcb7:/# echo "Test"
    Test
    root@2609724bfcb7:/# exit
    exit
    justsomedude@DESKTOP-VD06QG9:~$
    ```

4. **Remove Image**

   ```sh
   docker rmi ubuntu:latest
   ```
   ```
    Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container 2609724bfcb7 is using its referenced image f9248aac10f2
   ```
    The error occurs because a Docker container (`2609724bfcb7`) is still using the `ubuntu:latest` image. 

    To fix that, we need to remove the container first.
    ```sh
    justsomedude@DESKTOP-VD06QG9:~$ sudo docker rm -f 2609724bfcb7
    2609724bfcb7
    justsomedude@DESKTOP-VD06QG9:~$ sudo docker rmi ubuntu:latest
    Untagged: ubuntu:latest
    Untagged: ubuntu@sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
    Deleted: sha256:f9248aac10f2f82e0970222e36cc7b71215b88e974e001282e5cd89797a82218
    Deleted: sha256:45a01f98e78ce09e335b30d7a3080eecab7f50dfa0b38ca44a9dee2654ac0530
    ```

## Task 2: Image Customization

**Objective**: Create and deploy custom images.

1. **Deploy Nginx**

   ```sh
   docker run -d -p 80:80 --name nginx_container nginx
   ```
   ```
    justsomedude@DESKTOP-VD06QG9:~$ sudo    docker run -d -p 80:80 --name nginx_container nginx
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
    8a5a9ec481ad7801e004b0faca0de5554679fa4e40b2bb75d35b61f21edc0069
   ```

   Verify with `curl localhost`.
   ```sh
    justsomedude@DESKTOP-VD06QG9:~$ curl localhost
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
    justsomedude@DESKTOP-VD06QG9:~$
   ```

2. **Customize Website**

    ```
    justsomedude@DESKTOP-VD06QG9:~$ touch index.html
    justsomedude@DESKTOP-VD06QG9:~$ # Edited the file using vscode
    justsomedude@DESKTOP-VD06QG9:~$ sudo docker cp index.html nginx_container:/usr/share/nginx/html/
    Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
    justsomedude@DESKTOP-VD06QG9:~$ curl localhost
    <html>
    <head>
    <title>The best</title>
    </head>
    <body>
    <h1>website</h1>
    </body>
    </html>
    justsomedude@DESKTOP-VD06QG9:~$
    ```

3. **Create Custom Image**

   ```sh
   docker commit nginx_container my_website:latest
   ```

    ```
    sha256:0200ebd04f74cad5feaa66b43208dc8808a3009ba93604321c92b59a5ccd3179
    ```

4. **Remove Original Container**:
- Remove the original container (`nginx_container`) and verify that it has been successfully removed.

    ```sh
    justsomedude@DESKTOP-VD06QG9:~$ sudo docker rm -f nginx_container
    nginx_container
    ```

    Verifying that container is removed:

    ```sh
    justsomedude@DESKTOP-VD06QG9:~$ sudo docker container ls
    CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
    ```

5. **Create New Container**:
- Create a new container using the custom image you've created (the same way as the original container).

    ```sh
    docker run -d -p 80:80 --name my_website_container my_website:latest
    ```
    ```sh
    e164ca5615b9bc6bc9841e3d2e14ddfcf3818a507613a9e20b5a980d77f200e5
    justsomedude@DESKTOP-VD06QG9:~$ sudo docker container ls
    CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS                                 NAMES
    e164ca5615b9   my_website:latest   "/docker-entrypoint.…"   15 seconds ago   Up 14 seconds   0.0.0.0:80->80/tcp, [::]:80->80/tcp   my_website_container
    justsomedude@DESKTOP-VD06QG9:~$
    ```

6. **Test Web Server**:
   - Use the `curl` command to access the web server at `127.0.0.1:80`.

    ```sh
    curl http://127.0.0.1:80
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

7. **Analyze Image Changes**:
   - Use the `docker diff` command to analyze the changes made to the new image.

    ```sh
    docker diff my_website_container
    ```
    ```
    C /etc                            # Contents in /etc directory changed
    C /etc/nginx                      # Nginx configuration directory modified
    C /etc/nginx/conf.d               # Configuration subdirectory altered
    C /etc/nginx/conf.d/default.conf  # Nginx's main config file modified
    C /run                            # Runtime directory changed
    C /run/nginx.pid                  # Nginx process ID file changed
    ```


## Task 3: Container Networking

**Objective**: Explore Docker networking fundamentals.

1. **Create Network**:
- Create a bridge network named `lab_network`

   ```sh
   docker network create lab_network
   ```
   ```
   8e2eb11f6c9c44b52aeee680bcee92702a85df2ec8fc69fd4a1ee6bc8fb46df0
   ```

2. **Run Connected Containers**:
- Start two Alpine containers attached to the network:

    ```sh
    justsomedude@DESKTOP-VD06QG9:~$ sudo    docker run -dit --network lab_network --name container1 alpine ash
    Unable to find image 'alpine:latest' locally
    latest: Pulling from library/alpine
    fe07684b16b8: Pull complete
    Digest: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
    Status: Downloaded newer image for alpine:latest
    29f7cfd2544bc8eafd3bb239bb06ca9ddfc1a4537cb086f91b361e406ee1cf23
    justsomedude@DESKTOP-VD06QG9:~$ sudo    docker run -dit --network lab_network --name container2 alpine ash
    687e8ea778171c2f9702f04e6c7ef4a0de623ee514e29b2988758099af643216
    ```

3. **Test Connectivity**:
   - From `container1`, ping `container2` by name:

   ```sh
   docker exec container1 ping -c 3 container2
   ```
   ```
    PING container2 (172.18.0.3): 56 data bytes
    64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.266 ms
    64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.101 ms
    64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.084 ms

    --- container2 ping statistics ---
    3 packets transmitted, 3 packets received, 0% packet loss
    round-trip min/avg/max = 0.084/0.150/0.266 ms
   ```
   Docker's embedded DNS server (running at 127.0.0.1 in each container) automatically resolves container names to their private IPs within the same Docker network. When container1 pings container2, it queries this DNS, which returns container2's IP (e.g., 172.18.0.3), enabling direct communication over Docker's virtual bridge network - all without manual IP configuration or hostfile edits.

## Task 4: Volume Persistence

**Objective**: Understand data persistence in containers.

1. **Create Volume**:
   - Create a named volume `app_data`:

   ```sh
   docker volume create app_data
   ```
   ```
   app_data
   ```

2. **Run Container with Volume**:
   - Start Nginx with volume mounted:

   ```sh
   docker run -d -v app_data:/usr/share/nginx/html --name web nginx
   ```
   ```
   19f3c136663023ce2e5b6fb40e7f3d5aea7f5595471f36e3ebf12f5ddd4653f6
   ```
    ```
    justsomedude@DESKTOP-VD06QG9:~$ sudo docker container ls
    CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS                                 NAMES
    19f3c1366630   nginx               "/docker-entrypoint.…"   27 seconds ago   Up 26 seconds   80/tcp                                web
    687e8ea77817   alpine              "ash"                    5 minutes ago    Up 5 minutes                                          container2
    29f7cfd2544b   alpine              "ash"                    5 minutes ago    Up 5 minutes                                          container1
    e164ca5615b9   my_website:latest   "/docker-entrypoint.…"   10 minutes ago   Up 10 minutes   0.0.0.0:80->80/tcp, [::]:80->80/tcp   my_website_container
    ```

3. **Modify Content**:
   - Create custom `index.html` file
   - Copy to volume:

    ```
    justsomedude@DESKTOP-VD06QG9:~$ # Editing index.html I have via VSCode
    justsomedude@DESKTOP-VD06QG9:~$ cat index.html
    <html>
    <head>
    <title>The best</title>
    </head>
    <body>
    <h1>CUSTOM website</h1>
    </body>
    </html>
    ```

   ```sh
   docker cp index.html web:/usr/share/nginx/html/
   ```
   ```
   Successfully copied 2.05kB to web:/usr/share/nginx/html/
   ```

4. **Verify Persistence**:
   - Stop and remove container:

   ```sh
   justsomedude@DESKTOP-VD06QG9:~$ sudo docker stop web && sudo docker rm web
   web
   web
   ```

   - Create new container with same volume:

   ```sh
   # Modified original command - TA forgot to toss ports
   justsomedude@DESKTOP-VD06QG9:~$ sudo docker run -d -v app_data:/usr/share/nginx/html -p 80:80 --name web_new nginx
   3cdbdbb57884be2e503c62404e80b68b03446ed0f4ebe83cd4fb900e549ba006
   ```
   ```
   260f081b72f3909e4570f0e7fa38dc930b41ff744b9605e85b3f97b320356ab9
   ```

   - Verify content persists using `curl localhost`

   ```
   curl localhost
   <html>
   <head>
   <title>The best</title>
   </head>
   <body>
   <h1>CUSTOM website</h1>
   </body>
   </html>
   ```

## Task 5: Container Inspection

**Objective**: Examine container internals.

1. **Run Redis Container**:

   ```sh
   docker run -d --name redis_container redis
   ```
    ```
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
    d85b507ea1cbbfeb4fcf327919e7db31ac256d7382a8f033b21545d42c571377
    ```

2. **Inspect Processes**:
- Find Redis server process:

    Note: This image does not have `ps` by default. Needed to install first:

    ```
    sudo docker exec redis_container apt install -y procps
    ```

   ```sh
   docker exec redis_container ps aux
   ```

   ```
   USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
   redis          1  0.3  0.2 147312 17536 ?        Ssl  22:29   0:01 redis-server *:6379
   root         409 33.3  0.0   8092  4224 ?        Rs   22:34   0:00 ps aux
   ```

3. **Network Inspection**:
   - Get container IP address:

   ```sh
   docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
   ```

   ```
   172.17.0.3
   ```

4. **Document Differences**:
   - Compare `docker exec` vs `docker attach` in `submission6.md`
   - Explain use cases for each

   `docker exec` starts a new process (like `/bin/bash`) in a running container, ideal for debugging or running commands without affecting the main process. Use it for troubleshooting, log checks, or service restarts. `docker attach` connects directly to the container's main process (PID 1), sharing its input/output streams. Use it only for interactive CLI apps (like Python REPL) where you need direct control, but avoid it for production services since accidental exits (e.g., `Ctrl-C`) can terminate the entire container. Prefer `docker exec` for safety in most scenarios.

## Task 6: Cleanup Operations

**Objective**: Practice resource management.

1. **Verify Cleanup**:
- Check disk usage:

   ```sh
   docker system df
   ```

   ```
   justsomedude@DESKTOP-VD06QG9:~$ sudo docker system df
   TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
   Images          5         4         253.6MB   192.2MB (75%)
   Containers      5         4         21.52MB   0B (0%)
   Local Volumes   2         2         596B      0B (0%)
   Build Cache     0         0         0B        0B
   ```

2. **Create Test Objects**:
- Create 3 stopped containers:

   ```sh
   for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
   ```

    ```
    hello
    hello
    hello
    ```

   - Create 2 dangling images:

    Note: First needed to make the minimal dockerfile in `my-app` directory
    ```
    # Use official lightweight base image
    FROM alpine:latest

    # Set a default command to execute when container starts
    CMD ["echo", "Hello, World!"]
    ```

   ```sh
   docker build -t temp-image . && docker rmi temp-image
   ```

    ```
    justsomedude@DESKTOP-VD06QG9:~/my-app$ sudo docker build -t temp-image .
    [+] Building 0.1s (5/5) FINISHED                                                                                                                   docker:default
    => [internal] load build definition from Dockerfile                                                                                                         0.0s
    => => transferring dockerfile: 187B                                                                                                                         0.0s
    => [internal] load metadata for docker.io/library/alpine:latest                                                                                             0.0s
    => [internal] load .dockerignore                                                                                                                            0.0s
    => => transferring context: 2B                                                                                                                              0.0s
    => [1/1] FROM docker.io/library/alpine:latest                                                                                                               0.0s
    => exporting to image                                                                                                                                       0.0s
    => => exporting layers                                                                                                                                      0.0s
    => => writing image sha256:215b2b179cb8be67db8d43f4983fa0b3469b0dd20a08ff222cecab9bdc390c9e                                                                 0.0s
    => => naming to docker.io/library/temp-image                                                                                                                0.0s
    justsomedude@DESKTOP-VD06QG9:~/my-app$ sudo docker rmi temp-image
    Untagged: temp-image:latest
    Deleted: sha256:215b2b179cb8be67db8d43f4983fa0b3469b0dd20a08ff222cecab9bdc390c9e
    ```


3. **Remove Stopped Containers**:

   ```sh
   docker container prune -f
   ```
    ```
    Deleted Containers:
    a80d35aab700c2c29dca7c8efb207c0ad6e4301f7a847a8ee89aa569186cce57
    83befc30f592102b700b41cc4c20f3528c6334161a780b3c64864744c0b5df3d
    709078676f90719942a84f65bbee663d075ea4ab4ea4bb73f67c79219654ba14
    20ccce2671f9ea8193a7680d292b4779242eaadafd0c96bac8abe1c97c2e9c13

    Total reclaimed space: 0B
    ```

4. **Remove Unused Images**:

   ```sh
   docker image prune -a -f
   ```
    ```
    Deleted Images:
    untagged: hello-world:latest
    untagged: hello-world@sha256:940c619fbd418f9b2b1b63e25d8861f9cc1b46e3fc8b018ccfe8b78f19b8cc4f
    deleted: sha256:74cc54e27dc41bb10dc4b2226072d469509f2f22f1a3ce74f4a59661a1d44602
    deleted: sha256:63a41026379f4391a306242eb0b9f26dc3550d863b7fdbb97d899f6eb89efe72
    untagged: my_website:latest
    deleted: sha256:0200ebd04f74cad5feaa66b43208dc8808a3009ba93604321c92b59a5ccd3179
    deleted: sha256:3d40d42f9366b9c28e7c860fdceed8606439fd054ae62a493cbdc6bdd3bb0113

    Total reclaimed space: 11.26kB
    ```

5. **Verify Cleanup**:
   - Check disk usage after cleanup:

   ```sh
   docker system df
   ```

    ```
    TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
    Images          3         3         253.6MB   74.81MB (29%)
    Containers      4         4         21.52MB   0B (0%)
    Local Volumes   2         2         596B      0B (0%)
    Build Cache     4         0         0B        0B
    ```
    Compared to:
    ```
    justsomedude@DESKTOP-VD06QG9:~$ sudo docker system df
    TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
    Images          5         4         253.6MB   192.2MB (75%)
    Containers      5         4         21.52MB   0B (0%)
    Local Volumes   2         2         596B      0B (0%)
    Build Cache     0         0         0B        0B
    ```

# Containers Lab - Docker

Gain practical experience with Docker fundamentals through hands-on container management, image operations, networking, and storage tasks.

## Task 0: Image Exporting

**Objective**: Exporting images.

1. **Export Image**

   ```sh
   docker save -o ubuntu_image.tar ubuntu:latest
   ```

    - Saved `.tar` size: 80.6 MB;
    - Original pulled image size: 78.1 MB;

    **Explanation:** The `.tar` file is slightly larger because it contains all image layers, metadata, and history in raw form, without compression. Docker internally may reuse compressed layers or deduplicate them across images.

## Task 1: Core Container Operations

**Objective**: Master basic container lifecycle management.

1. **List Containers**

   ```sh
   docker ps -a
   ```

   **Output:**
    ```
    CONTAINER ID   IMAGE     COMMAND                  CREATED       STATUS                     PORTS     NAMES
    466cd991daf4   drake     "/bin/sh -c 'echo Co…"   6 weeks ago   Exited (0) 5 weeks ago               elastic_franklin
    2e6ffa89f785   drake     "/bin/bash"              6 weeks ago   Exited (137) 6 weeks ago             objective_raman
    6cd6ec5c8100   drake     "/bin/bash"              6 weeks ago   Exited (137) 6 weeks ago             stoic_torvalds
    ```

2. **Pull Ubuntu Image**

   ```sh
   docker pull ubuntu:latest
   ```

   Original pulled image size: 78.1 MB;

3. **Run Interactive Container**
  
   ```sh
   docker run -it --name ubuntu_container ubuntu:latest
   ```

   Exit container with `exit`.

4. **Remove Image**

   ```sh
   docker rmi ubuntu:latest
   ```

   **Error message:**
   ```
   Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container ef003a867d45 is using its referenced image f9248aac10f2
   ```  

   **Explanation:** Cannot remove image while a container is using it.


## Task 2: Image Customization

**Objective**: Create and deploy custom images.

1. **Deploy Nginx**

   ```sh
   docker run -d -p 80:80 --name nginx_container nginx
   ```

   Verified with `curl localhost`.

2. **Customize Website**

   - HTML file `index.html`:

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

   - Copied to the container:

        ```sh
        docker cp index.html nginx_container:/usr/share/nginx/html/
        ```

3. **Create Custom Image**

    ```sh
    docker commit nginx_container my_website:latest
    ```

4. **Remove Original Container**:

     ```sh
     docker rm -f nginx_container
     ```

5. **Create New Container**:

     ```sh
     docker run -d -p 80:80 --name my_website_container my_website:latest
     ```

6. **Test Web Server**:

    ```sh
    curl http://127.0.0.1:80
    ```

    **Output:**
    ```
    <html>
    <head>
    <title>The best</title>
    </head>
    <body>
    <h1>website</h1>
    </body>
    ```

7. **Analyze Image Changes**:

    ```sh
    docker diff my_website_container
    ```

    **Output:**
    ```
    C /run
    C /run/nginx.pid
    C /etc
    C /etc/nginx
    C /etc/nginx/conf.d
    C /etc/nginx/conf.d/default.conf
    ```

    **Explanation:** Shows what files were added/modified in the container.


## Task 3: Container Networking

**Objective**: Explore Docker networking fundamentals.

1. **Create Network**:

   ```sh
   docker network create lab_network
   ```

2. **Run Connected Containers**:

   ```sh
   docker run -dit --network lab_network --name container1 alpine ash
   docker run -dit --network lab_network --name container2 alpine ash
   ```

3. **Test Connectivity**:

   ```sh
   docker exec container1 ping -c 3 container2
   ```

   **Output:**
    ```
    PING container2 (172.18.0.3): 56 data bytes
    64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.105 ms
    64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.078 ms
    64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.135 ms

    --- container2 ping statistics ---
    3 packets transmitted, 3 packets received, 0% packet loss
    round-trip min/avg/max = 0.078/0.106/0.135 ms
    ```

    **Docker DNS Explanation:**

    - Docker provides an internal DNS service.
    - Container names are automatically resolved within a user-defined bridge network.


## Task 4: Volume Persistence

**Objective**: Understand data persistence in containers.

1. **Create Volume**:

   ```sh
   docker volume create app_data
   ```

2. **Run Container with Volume**:

   ```sh
   docker run -d -v app_data:/usr/share/nginx/html --name web nginx
   ```

3. **Modify Content**:
   - Created custom `index.html` file
        ```
        <html>
        <head>
        <title>The best</title>
        </head>
        <body>
        <h1>website</h1>
        </body>
        ```

   - Copied to volume:

        ```sh
        docker cp index.html web:/usr/share/nginx/html/
        ```

4. **Verify Persistence**:
   - Stopped and removed container:

        ```sh
        docker stop web && docker rm web
        ```

   - Created new container with same volume:

        ```sh
        docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
        ```

   - Verified using `curl localhost`

    **Output:**

    ```
    <html>
    <head>
    <title>The best</title>
    </head>
    <body>
    <h1>website</h1>
    </body>
    ```

## Task 5: Container Inspection

**Objective**: Examine container internals.

1. **Run Redis Container**:

   ```sh
   docker run -d --name redis_container redis
   ```

2. **Inspect Processes**:
   - Find Redis server process:

        ```sh
        docker top redis_container
        ```

        **Output:**

        ```
        UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
        999                 21825               21802               0                   21:29               ?                   00:00:01            redis-server *:6379
        ```

3. **Network Inspection**:
   - Get container IP address:

        ```sh
        docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
        ```

        **Output:**

        ```
        172.17.0.4
        ```

### docker exec vs docker attach:

- `docker exec`: run a new process inside a running container (non-blocking)
- `docker attach`: attach to the main process of a container (blocking, shared I/O)

**Use cases:**

- Use `exec` to run isolated commands.
- Use `attach` for full interaction or debugging.

## Task 6: Cleanup Operations

**Objective**: Practice resource management.

1. **Verify Cleanup**:

   ```sh
   docker system df
   ```

   **Before Cleanup:**

    ```
    TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
    Images          6         6         2.996GB   192.2MB (6%)
    Containers      9         5         393.1MB   393.1MB (99%)
    Local Volumes   3         3         269.2MB   0B (0%)
    Build Cache     38        0         10.53MB   10.53MB
    ```

2. **Create Test Objects**:
   - Created 3 stopped containers:

        ```sh
        for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
        ```

   - Created 2 dangling images:

        ```sh
        docker build -t temp-image . && docker rmi temp-image
        ```

3. **Remove Stopped Containers**:

   ```sh
   docker container prune -f
   ```

4. **Remove Unused Images**:

   ```sh
   docker image prune -a -f
   ```

5. **Verify Cleanup**:

   ```sh
   docker system df
   ```

   **After Cleanup:**

    ```
    Deleted Images:
    untagged: drake:latest
    deleted: sha256:503ce1abc59ffa190f130bed07b0d6dbba0d4551d8eeb423165b6692eafb22e4
    untagged: ubuntu:latest
    untagged: ubuntu@sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
    deleted: sha256:f9248aac10f2f82e0970222e36cc7b71215b88e974e001282e5cd89797a82218
    deleted: sha256:45a01f98e78ce09e335b30d7a3080eecab7f50dfa0b38ca44a9dee2654ac0530

    Total reclaimed space: 78.12MB
    ```
# Task 0

Size of the original image is 75MB, while the size of the .tar file is 77MB. This is because:

- Docker save packs every layer in full—even if some layers are duplicates of those in other images—whereas Docker’s local storage deduplicates shared layers and counts them only once.
- The TAR format adds about 512 bytes of header data for each file it contains.

![](./images_lab6/image.png)

# Task 1

1. List containers

![](./images_lab6/image-1.png)

This command shows that there are no running docker images

2. Pull Ubuntu Image

![](./images_lab6/image-2.png)

This step was already performed in order to complete Task 0.

The size of the image is 78.1 MB

![](./images_lab6/image-3.png)

3. Run Interactive Container

![](./images_lab6/image-4.png)

Container is running

4. Remove Image

![](./images_lab6/image-5.png)

The removal fails because Docker won’t delete an image that’s still in use by a container. Container must be first stopped and removed before the image can be removed. (or it can also be forced)

# Task 2

1. Deploy Nginx

![](./images_lab6/image-6.png)
![](./images_lab6/image-7.png)

2. Customize Website

![](./images_lab6/image-8.png)

3. Create Custom Image

![](./images_lab6/image-9.png)

4. Remove Original Container

![](./images_lab6/image-10.png)
![](./images_lab6/image-11.png)

Container successfully removed

5. Create New Container:

![](./images_lab6/image-12.png)

New container successfully created

6. Test Web Server

![](./images_lab6/image-13.png)

7. Analyze Image Changes

![](./images_lab6/image-14.png)

The `docker diff my_website_container` command is showing exactly what’s changed in the container’s filesystem compared to the original image. Each line starts with a code:

A — Added
C — Changed
D — Deleted

Which means that the output is showing that I've made changes in the directories listed.

# Task 3

![](./images_lab6/image-15.png)

Embedded DNS server
- When a user-defined bridge network is created (here: lab_network), the Docker daemon injects an embedded DNS resolver into every container on that network.
- Inside each container, /etc/resolv.conf points to 127.0.0.11 (the embedded DNS).

Name registration
- As soon as a container is started with --name, Docker registers that name (and any aliases) in the network’s DNS namespace, mapping it to the container’s IP on that network.

Query flow
- When container1 does ping container2, it queries the embedded DNS at 127.0.0.11.
- The embedded DNS returns the IP address of container2 on lab_network (e.g. 172.18.0.3).

Fallback to upstream
- If the embedded DNS has no record, it forwards the query to the Docker daemon’s configured upstream DNS servers (inherited from the host or set in daemon.json).

Network scoping
- Each user-defined network has its own DNS namespace. Two containers with the same name on different networks won’t conflict, because their names are only visible within their own network.

# Task 4

1. Create Volume, Run Container with Volume, Modify Content

![](./images_lab6/image-16.png)

2. Verify Persistence

![](./images_lab6/image-17.png)

# Task 5

![](./images_lab6/image-18.png)
![](./images_lab6/image-19.png)

| Aspect              | `docker exec`                                            | `docker attach`                                              |
|---------------------|----------------------------------------------------------|--------------------------------------------------------------|
| What it does        | Starts a _new_ process inside a running container.       | Attaches your terminal to the _main_ process’s stdio streams.|
| Invocation          | `docker exec [options] <container> <command> [args...]`  | `docker attach [options] <container>`                        |
| Isolation           | You get a fresh shell or run a specific command in its own PID context. | You share the PID and stdio of the primary process (PID 1).    |
| Use cases           | - Inspect logs or configuration<br> - Run diagnostic tools (`ps`, `top`, `bash`, etc.)<br> - Perform one-off administrative tasks | - Interact directly with the main service’s console (e.g. a REPL)<br> - Stream realtime output to your terminal (like `docker logs -f` but with stdin) |
| Risk / caveats      | Non-intrusive to the main process; easy to start and exit. | If you detach improperly, you may stop or hang the main process.<br> Requires knowing the detach key sequence (`Ctrl+P, Ctrl+Q`). |
| Exit behavior       | Exiting your `exec` session does **not** stop the container. | Exiting (without detaching) can send EOF to the main process and shut down the container. |


# Task 6

![](./images_lab6/image-20.png)
![](./images_lab6/image-21.png)

78.12MB of space was freed by clearing out unused images.
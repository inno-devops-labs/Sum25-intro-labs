# Containers Lab - Docker

Gain practical experience with Docker fundamentals through hands-on container management, image operations, networking, and storage tasks.

[Docker Documentation](https://docs.docker.com/)

```txt
dev@b2b-ip-host:~$ docker --help
Usage:  docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

Common Commands:
  run         Create and run a new container from an image
  exec        Execute a command in a running container
  ps          List containers
  build       Build an image from a Dockerfile
  bake        Build from a file
  pull        Download an image from a registry
  push        Upload an image to a registry
  images      List images
  login       Authenticate to a registry
  logout      Log out from a registry
  search      Search Docker Hub for images
  version     Show the Docker version information
  info        Display system-wide information

Management Commands:
  builder     Manage builds
  buildx*     Docker Buildx
  compose*    Docker Compose
  container   Manage containers
  context     Manage contexts
  image       Manage images
  manifest    Manage Docker image manifests and manifest lists
  network     Manage networks
  plugin      Manage plugins
  system      Manage Docker
  trust       Manage trust on Docker images
  volume      Manage volumes

Swarm Commands:
  swarm       Manage Swarm

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  import      Import the contents from a tarball to create a filesystem image
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  wait        Block until one or more containers stop, then print their exit codes

Global Options:
      --config string      Location of client config files (default "/home/dev/.docker")
  -c, --context string     Name of the context to use to connect to the daemon (overrides DOCKER_HOST env var and
                           default context set with "docker context use")
  -D, --debug              Enable debug mode
  -H, --host list          Daemon socket to connect to
  -l, --log-level string   Set the logging level ("debug", "info", "warn", "error", "fatal") (default "info")
      --tls                Use TLS; implied by --tlsverify
      --tlscacert string   Trust certs signed only by this CA (default "/home/dev/.docker/ca.pem")
      --tlscert string     Path to TLS certificate file (default "/home/dev/.docker/cert.pem")
      --tlskey string      Path to TLS key file (default "/home/dev/.docker/key.pem")
      --tlsverify          Use TLS and verify the remote
  -v, --version            Print version information and quit

Run 'docker COMMAND --help' for more information on a command.
```

## Task 0: Image Exporting

**Objective**: Exporting images.

We can search the specified images using:

```bash
    docker search <image_name>
```

Before exporting we need to pull the image from Docker registry.

```bash
    docker pull ubuntu:latest
```

Exporting:

```bash
   docker save -o ubuntu_image.tar ubuntu:latest
```

![image_exporting](../images/image_exporting.png)

## Task 1: Core Container Operations

**Objective**: Master basic container lifecycle management.

1. **List Containers**

    ![docker_ps_a](../images/docker_ps_a.png)

2. **Pull Ubuntu Image**

    > The result in Task 0

3. **Run Interactive Container**

    ```bash
        docker run -it --name ubuntu_container ubuntu:latest
    ```

    ![interactive_container](../images/interactive_container.png)

4. **Remove Image**

    ```bash
        docker rmi ubuntu:latest
    ```

    ![rmi_error](../images/rmi_error.png)

    > I can’t remove the image ubuntu:latest because a containers (93c3ef433423) and (93c3ef433423) are still using it, even if that container is stopped. I must remove or delete the container first.

    ![succ_rmi](../images/succ_rmi.png)

## Task 2: Image Customization

**Objective**: Create and deploy custom images.

1. **Deploy Nginx**

    ```bash
        docker run -d -p 80:80 --name nginx_container nginx
    ```

    ![deploy_nginx](../images/deploy_nginx.png)

2. **Customize Website**

    - Copy the HTML file to the container:

    ```bash
        docker cp index.html nginx_container:/usr/share/nginx/html/
        docker cp dex.png nginx_container:/usr/share/nginx/html/
    ```

    ![cat_website](../images/cat_website.png)

    - I used `cp` and `exec` to manipulate with container contents.

    ![exec](../images/exec.png)

3. **Create Custom Image**

    ![docker_commit](../images/docker_commit.png)

    ```sh
        docker commit nginx_container my_website:latest
    ```

    ![commit_my_website](../images/commit_my_website.png)

4. **Remove Original Container**

    ```sh
        docker rm -f nginx_container
    ```

    ![rm_nginx_container](../images/rm_nginx_container.png)

5. **Create New Container**:
    - Create a new container using the custom image you've created (the same way as the original container).

    ```sh
        docker run -d -p 80:80 --name my_website_container my_website:latest
    ```

6. **Test Web Server**:
    - Use the `curl` command to access the web server at `127.0.0.1:80`.

    ```sh
        curl http://127.0.0.1:80
    ```

    ![test_web_server](../images/test_web_server.png)

7. **Analyze Image Changes**:
    - Use the `docker diff` command to analyze the changes made to the new image.

    ```sh
        docker diff my_website_container
    ```

    ![docker_diff](../images/docker_diff.png)

    - Explain the output of the `docker diff` command in the `submission6.md` file.

    The `docker diff` command shows file system changes between the original image and the running container. In my case, it shows that **Nginx** created some runtime files, but **HTML** customization is already committed into the image, so it doesn't show up here.

## Task 3: Container Networking

1. **Create Network**:
    - Create a bridge network named `lab_network`

    ```sh
        docker network create lab_network
    ```

    ![network_ls](../images/network_ls.png)

2. **Run Connected Containers**:
    - Start two Alpine containers attached to the network:

    ```sh
        docker run -dit --network lab_network --name container1 alpine ash
        docker run -dit --network lab_network --name container2 alpine ash
    ```

    ![alpine_containers_creation](../images/alpine_containers_creation.png)

3. **Test Connectivity**:
    - From `container1`, ping `container2` by name:

    ```sh
        docker exec container1 ping -c 3 container2
    ```

    ![ping](../images/ping.png)

    Docker has a built-in internal DNS server that runs on each Docker network. It allows containers to resolve:

    - Other container names
    - Service names (in Docker Compose or Swarm)
    - External DNS through /etc/resolv.conf fallback

    To check docker network configuration:

    ```txt
        dev@b2b-ip-host:~$ docker network inspect lab_network
        [
            {
                "Name": "lab_network",
                "Id": "4670b73afdb2e5f2f5326c867bd82427909f0b261d91e1db4732c41fd0ae2162",
                "Created": "2025-07-17T14:52:26.026296035Z",
                "Scope": "local",
                "Driver": "bridge",
                "EnableIPv4": true,
                "EnableIPv6": false,
                "IPAM": {
                    "Driver": "default",
                    "Options": {},
                    "Config": [
                        {
                            "Subnet": "172.18.0.0/16",
                            "Gateway": "172.18.0.1"
                        }
                    ]
                },
                "Internal": false,
                "Attachable": false,
                "Ingress": false,
                "ConfigFrom": {
                    "Network": ""
                },
                "ConfigOnly": false,
                "Containers": {
                    "64fd567fca5e46970c511296cdaab01f8cba572044ce448e59737decf4e8b10b": {
                        "Name": "container1",
                        "EndpointID": "4100d28c2e101a223d969b7c5ecc2813940b71a329b532303c3174af7ed2859b",
                        "MacAddress": "16:ea:e6:29:bc:b5",
                        "IPv4Address": "172.18.0.2/16",
                        "IPv6Address": ""
                    },
                    "abbb8e69a096c23d0334df6f534ce9b120e5b8014f83cf76ffdfa20624117d2a": {
                        "Name": "container2",
                        "EndpointID": "5e625183019e4090e6f026dfd25b7963a534926ef654a9db9424f86b4e377616",
                        "MacAddress": "1a:d7:2c:dd:2f:27",
                        "IPv4Address": "172.18.0.3/16",
                        "IPv6Address": ""
                    }
                },
                "Options": {},
                "Labels": {}
            }
        ]
    ```

## Task 4: Volume Persistence

**Objective**: Understand data persistence in containers.

1. **Create Volume**:
    - Create a named [volume](https://docs.docker.com/engine/storage/volumes/) `app_data`:

    ```sh
        docker volume create app_data
    ```

    ![volume_creation](../images/volume_creation.png)

2. **Run Container with Volume**:
    - Start Nginx with volume mounted:

    ```sh
        docker run -d -p 80:80 -v app_data:/usr/share/nginx/html --name web nginx
    ```

    ![container_with_volume](../images/container_with_volume.png)

3. **Modify Content**:
    - Create custom `index.html` file
    - Copy to volume:

    ```sh
        docker cp index.html web:/usr/share/nginx/html/
    ```

    ![copy_content_to_volume](../images/copy_content_to_volume.png)

4. **Verify Persistence**:
    - Stop and remove container:

    ```sh
        docker stop web && docker rm web
    ```

    ![stop&remove_web](../images/stop&remove_web.png)

    - Create new container with same volume:

    ```sh
        docker run -d -p 80:80 -v app_data:/usr/share/nginx/html --name web_new nginx
    ```

    - Verify content persists using `curl localhost`

    ![chech_volume_content_after_container_recreation](../images/chech_volume_content_after_container_recreation.png)

## Task 5: Container Inspection

**Objective**: Examine container internals.

1. **Run Redis Container**:

    [Redis container information](https://hub.docker.com/_/redis)

    ```sh
        docker run -d --name redis_container redis
    ```

    ![run_redis](../images/run_redis.png)

2. **Inspect Processes**:
    - Find Redis server process:

    ```sh
        docker exec redis_container ps aux
    ```

    ![redis_server_process](../images/redis_server_process.png)

3. **Network Inspection**:
    - Get container IP address:

    ```sh
        docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
    ```

    ![redis_ip](../images/redis_ip.png)

4. **Document Differences**:
    - Compare `docker exec` vs `docker attach` in `submission6.md`
    - Explain use cases for each

    From command's `help`:
    - `exec` - Execute a command in a running container
    - `attach` - Attach local standard input, output, and error streams to a running container

    | Feature                      | `docker exec`                                      | `docker attach`                                       |
    | ---------------------------- | -------------------------------------------------- | ----------------------------------------------------- |
    | 🎯 **Purpose**               | Run a **new command** inside a running container   | Attach to the **existing running main process**       |
    | 🔁 **Processes**             | Starts a **separate process** inside container     | Attaches to **PID 1** (the main process, e.g. Redis)  |
    | 🧠 **Use case**              | Debugging, admin tasks, running interactive shells | View live logs/output of container's main process     |
    | 🚪 **Detachment**            | You exit **only your command**                     | Exiting can stop the container if not careful         |
    | 🔒 **Safety**                | ✅ Safe, sandboxed                                  | ❌ Risky: e.g. `Ctrl+C` can kill container's main proc |
    | 🖥️ **TTY support**          | Supports `-it` for interactive terminal            | Inherits the I/O of the running container process     |
    | 🗃️ **Multiple connections** | Each exec is **independent**                       | You can attach only to the container's output/input   |

## Task 6: Cleanup Operations

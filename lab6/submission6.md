# Containers Lab - Docker

## Image Exporting

![exporting a docker image](src/export-image.png)

We can notice that the `.tar` is a little smaller than the image, which is expected, `save` produce a tarred repository, and we are using `-o` to save it to a file.

## Core Container Operations

* **List Containers:**

    ![List containers](src/docker-ps.png)

* **Pull Ubuntu Image:**

    ![Pull ubuntu image](src/docker-pull.png)

* **Run Interactive Container:**

    ![Run interactive container](src/run-interactive.png)

* **Remove Image:**

    ![Remove image](src/rmi.png)

    We notice that we got an error, since we ran a container using this image we can't delete the image unless we delete all running containers based on that image. As we can see after removing the container we manged to delete the image.

## Image Customization

* **Deploy nginx:**

    ![Deploy nginx](src/nginx.png)

* **Customize Website:**

  * After creating a HTML file we copy it to the nginx container:

    ![Copy HTML to container](src/copy-html.png)

* **Create Custom Image:**

    ![Create custom image](src/custom-image.png)

* **Remove Original Container:**

    ![Remove original image](src/remove-container.png)

* **Create New Container:**

    ![Create a new container](src/create-new-container.png)

* **Test Web Server:**

    ![Test web server](src/new-web-server.png)

* **Analyze Image Changes:**

    ![Analyze image changes](src/docker-diff.png)

    This shows that files that have been modified since the container started running.\
    According to the [documentation](https://docs.docker.com/reference/cli/docker/container/diff/), `C` means *"A file or directory was changed"*.

## Container Networking

* **Create Network:**

    ![Create a docker network](src/create-docker-network.png)

* **Run Connected Containers:**

    ![Run connected containers](src/run-connected-containers.png)

* **Test Connectivity:**

    ![Test connectivity](src/test-connection.png)

When we create a bridge network like `lab_network`, docker automatically sets up an internal DNS server for that network.

* Each container connected to the same network gets a hostname and an IP address.
* Docker’s internal DNS keeps track of these names and IPs.
* So when we ping `container2` from `container1`, docker’s embedded DNS resolves `container2` to its correct IP address inside `lab_network`.

## Volume Persistence

* **Create Volume:**

    ![Create a volume](src/create-volume.png)

* **Run Container with Volume:**

    ![Run container with volume](src/run-container-with-volume.png)

* **Modify Content:**

    ```html
    <html>
    <head>
    <title>Docker Volumes</title>
    </head>
    <body>
    <h1>This is an HTML file to test Docker Volumes</h1>
    </body>
    </html>
    ```

    ![copy to volume](src/copy-to-volume.png)

* **Verify Persistence:**

    ![Verify persistence](src/verify-persistence.png)

## Container Inspection

* **Run Redis Container:**

    ![Rund redis container](src/run-redis.png)

* **Inspect Processes:**

    ![Inspect processes](src/docker-top.png)

    Since the redis container is simple, it doesn't have the packages needed to run `ps`.\
    In cases like this we can use the [`top`](https://docs.docker.com/reference/cli/docker/container/top/) command from docker to display the running processes of the container.

* **Network Inspection:**

    ![Network inspection](src/docker-inspect.png)

* `docker exec` vs `docker attach`

  * **[`docker exec`](https://docs.docker.com/reference/cli/docker/container/exec/):** Runs a new command in a running container. It's useful for debugging, and gaining access to the containers system, to debug/modify.
  * **[`docker attach`](https://docs.docker.com/reference/cli/docker/container/attach/):** Connects to the container’s **main process**. You see its existing output. Using `Ctrl + C` stops the container.
  It can be useful when we want to check the output of the main process in the container.

## Cleanup Operations

* **Verify Cleanup:**

    ![docker df](src/docker-df.png)

* **Create Test Objects:**

    ![Creating test objects](src/test-objects.png)

    The images where based on a simple Dockerfile:

    ```dockerfile
    FROM alpine
    CMD ["echo", "Hello!"]
    ```

* **Remove Stopped Containers:**

    ![remove stopped containers](src/remove-stopped-containers.png)

* **Remove Unused Images:**

    ![Remove unused containers](src/remove-unused-images.png)

* **Verify Cleanup:**

    ![Storage after cleanup](src/docker-df-2.png)

    We notice that we saved some space by deleting the unused images.
    *(I removed all the unused containers before starting this part)*

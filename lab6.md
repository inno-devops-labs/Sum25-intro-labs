# Containers Lab - Docker

Gain practical experience with Docker fundamentals through hands-on container management, image operations, networking, and storage tasks.

## Task 1: Core Container Operations

**Objective**: Master basic container lifecycle management.

1. **List Containers**

   ```sh
   docker ps -a
   ```

   Record output in a Markdown file named `submission6.md` in the lab folder.

2. **Pull Ubuntu Image**

   ```sh
   docker pull ubuntu:latest
   ```

   Document image size in the `submission6.md` file.

3. **Run Interactive Container**
  
   ```sh
   docker run -it --name ubuntu_container ubuntu:latest
   ```

   Exit container with `exit`.

4. **Remove Image**

   ```sh
   docker rmi ubuntu:latest
   ```

   Note error message and explain why removal fails in the `submission6.md` file.

## Task 2: Image Customization

**Objective**: Create and deploy custom images.

1. **Export Image**

   ```sh
   docker save -o ubuntu_image.tar ubuntu:latest
   ```

   Compare tar size with original image. Explain any differences, if present, in the same `submission6.md` file.

2. **Deploy Nginx**

   ```sh
   docker run -d -p 80:80 --name nginx_container nginx
   ```

   Verify with `curl localhost`.

3. **Customize Website**

   - Create an HTML file with the specified content:

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

   - Copy the HTML file to the container:

   ```sh
   docker cp index.html nginx_container:/usr/share/nginx/html/
   ```

4. **Create Custom Image**

   ```sh
   docker commit nginx_container my_website:latest
   ```

5. **Remove Original Container**:
   - Remove the original container (`nginx_container`) and verify that it has been successfully removed.

     ```sh
     docker rm -f nginx_container
     ```

6. **Create New Container**:
   - Create a new container using the custom image you've created (the same way as the original container).

     ```sh
     docker run -d -p 80:80 --name my_website_container my_website:latest
     ```

7. **Test Web Server**:
   - Use the `curl` command to access the web server at `127.0.0.1:80`.

     ```sh
     curl http://127.0.0.1:80
     ```

8. **Analyze Image Changes**:
   - Use the `docker diff` command to analyze the changes made to the new image.

     ```sh
     docker diff my_website_container
     ```

   - Explain the output of the `docker diff` command in the `submission6.md` file.

## Task 3: Container Networking

**Objective**: Explore Docker networking fundamentals.

1. **Create Network**:
   - Create a bridge network named `lab_network`

   ```sh
   docker network create lab_network
   ```

2. **Run Connected Containers**:
   - Start two Alpine containers attached to the network:

   ```sh
   docker run -dit --network lab_network --name container1 alpine ash
   docker run -dit --network lab_network --name container2 alpine ash
   ```

3. **Test Connectivity**:
   - From `container1`, ping `container2` by name:

   ```sh
   docker exec container1 ping -c 3 container2
   ```

4. **Documentation**:
   - Record ping output in `submission6.md`
   - Explain how Docker's internal DNS resolution works

## Task 4: Volume Persistence

**Objective**: Understand data persistence in containers.

1. **Create Volume**:
   - Create a named volume `app_data`:

   ```sh
   docker volume create app_data
   ```

2. **Run Container with Volume**:
   - Start Nginx with volume mounted:

   ```sh
   docker run -d -v app_data:/usr/share/nginx/html --name web nginx
   ```

3. **Modify Content**:
   - Create custom `index.html` file
   - Copy to volume:

   ```sh
   docker cp index.html web:/usr/share/nginx/html/
   ```

4. **Verify Persistence**:
   - Stop and remove container:

   ```sh
   docker stop web && docker rm web
   ```

   - Create new container with same volume:

   ```sh
   docker run -d -v app_data:/usr/share/nginx/html --name web_new nginx
   ```

   - Verify content persists using `curl localhost`

## Task 5: Container Inspection

**Objective**: Examine container internals.

1. **Run Redis Container**:

   ```sh
   docker run -d --name redis_container redis
   ```

2. **Inspect Processes**:
   - Find Redis server process:

   ```sh
   docker exec redis_container ps aux
   ```

3. **Network Inspection**:
   - Get container IP address:

   ```sh
   docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
   ```

4. **Document Differences**:
   - Compare `docker exec` vs `docker attach` in `submission6.md`
   - Explain use cases for each

## Task 6: Cleanup Operations

**Objective**: Practice resource management.

1. **Create Test Objects**:
   - Create 3 stopped containers:

   ```sh
   for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
   ```

   - Create 2 dangling images:

   ```sh
   docker build -t temp-image . && docker rmi temp-image
   ```

2. **Remove Stopped Containers**:

   ```sh
   docker container prune -f
   ```

3. **Remove Unused Images**:

   ```sh
   docker image prune -a -f
   ```

4. **Verify Cleanup**:
   - Check disk usage before/after:

   ```sh
   docker system df
   ```

   - Document space savings in `submission6.md`

### Guidelines

- Use proper Markdown formatting and structure for the documentation files.
- Organize the files within the lab folder using appropriate naming conventions.
- Create a Pull Request to the main branch of the repository with your completed lab assignment.

> Note: Focus on understanding Docker's architecture rather than just executing commands.

Internal DNS resolution in Docker

| # | Name | Description |
|----|-----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1 | Docker DNS Server | Docker runs a built-in DNS server on each host that responds to DNS requests from containers. This server handles container and network name resolution requests. |
| 2 | Network namespaces | Each container in Docker runs in its own network namespace, which allows it to have its own network interfaces and routes. Containers can be on the same network or on different networks. |
| 3 | Container name resolution | When a container tries to contact another container by name (for example, web), the Docker DNS server looks up that name among running containers on the same network. If a container with that name exists, it returns the corresponding IP address. |
| 4 | Services and aliases | If you use Docker Compose or create services in Docker Swarm, you can define aliases for services that will also be reachable via DNS. |
| 5 | Network isolation | Containers on different networks cannot resolve each other's names. |
| 6 | Caching | The Docker DNS server can cache name resolution results, which improves performance for repeated requests. |
| 7 | Configuring DNS | You can configure DNS servers for containers using the --dns options when starting a container or via settings in Docker Compose. |

table comparing docker exec and docker attach commands

| Aspect | docker exec | docker attach |
|------------------------|--------------------------------------------------------|---------------------------------------------------------|
| Description | Allows you to run a new command in a running container. | Attaches the current terminal to the standard streams (stdin, stdout, stderr) of an already running container. |
| Create a new process | + | - |
| Isolation from other processes | Each call to docker exec creates a new process, isolated from others. | Attach to the same process, which can lead to conflicts if multiple connections. |
| Interactive mode | Can be used with the -it flag for interactive access. | Can also be used for interactive access, but only to the main process of the container. |
| Usage | Used to execute commands, install packages, run scripts, etc. | Used to monitor output or interact with the main process of the container (for example, for debugging). |
| Closing the connection | Closing the session has no effect on the running container. | Closing the connection may cause the process in the container to terminate (if it is the main process). |
| Support multiple connections | Supports multiple connections via different exec calls. | Does not support multiple connections; only one connection to a single process. |
| Example usage | docker exec -it my_container bash (run bash in the container) | docker attach my_container (attach to the main process of the container) |

Use cases

- docker exec:

1. Install software or libraries inside a container.
2. Run scripts or commands to manage applications.
3. Run additional tools for diagnostics or debugging.

- docker attach:

1. Monitor the output of the main process (e.g. application logs).
2. Interact with the application running in the container (e.g. enter commands interactively).
3. Debug applications when you need to see what is happening in real time.

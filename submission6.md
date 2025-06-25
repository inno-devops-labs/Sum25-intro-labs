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

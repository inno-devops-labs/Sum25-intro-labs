# Solution to Lab 6

by Dmitry Beresnev <d.beresnev@innopolis.university>

The tasks are done under **Linux Fedora 42**

## Task 0: Image Exporting

Before, I needed to pull the image:

```bash
docker pull ubuntu:latest
```

**Command:**

```bash
docker save -o ubuntu_image.tar ubuntu:latest
ls -lh ubuntu_image.tar
```

**Output:**

```bash
-rw-------. 1 dsomni dsomni 77M Jul  2 18:26 ubuntu_image.tar
```

**Command:**

```bash
docker images ubuntu:latest
```

**Output:**

```bash
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       latest    f9248aac10f2   12 days ago   78.1MB
```

**Comparison:**

- The exporter archive (77 MB) is slightly lighter than the image inside docker (78.1 MB). The sizes are almost the same because the docker saves the uncompressed version of exactly the same image

## Task 1: Core Container Operations

**Command:**

```bash
docker ps -a
```

**Output:**

```bash
CONTAINER ID   IMAGE                             COMMAND                  CREATED       STATUS                     PORTS     NAMES
adc7611b013e   accept_kafka-sink                 "uv run main.py"         5 weeks ago   Exited (143) 5 weeks ago             accept_kafka-sink-1
b5614c90b561   accept_kafka-frontend             "docker-entrypoint.s…"   5 weeks ago   Exited (0) 5 weeks ago               accept_kafka-frontend-1
36da849f7abf   accept_kafka-checker              "uv run main.py"         5 weeks ago   Exited (143) 5 weeks ago             accept_kafka-checker-2
1bbcc50075f4   accept_kafka-checker              "uv run main.py"         5 weeks ago   Exited (143) 5 weeks ago             accept_kafka-checker-1
f1b6130637f6   accept_kafka-checker              "uv run main.py"         5 weeks ago   Exited (143) 5 weeks ago             accept_kafka-checker-3
1139211b3cbc   accept_kafka-backend              "fastapi run /app/ma…"   5 weeks ago   Exited (0) 5 weeks ago               accept_kafka-backend-1
51661b21b721   confluentinc/cp-kafka:7.5.0       "/etc/confluent/dock…"   5 weeks ago   Exited (143) 5 weeks ago             accept_kafka-kafka-1
17e4933daf1e   confluentinc/cp-zookeeper:7.5.0   "/etc/confluent/dock…"   5 weeks ago   Exited (143) 5 weeks ago             accept_kafka-zookeeper-1
```

The listed containers were used for side pet project

**Command:**

```bash
docker pull ubuntu:latest
docker images ubuntu:latest
```

**Output:**

```bash
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       latest    f9248aac10f2   12 days ago   78.1MB
```

**Command:**

```bash
docker rmi ubuntu:latest
```

**Output:**

```bash
Error response from daemon: conflict: unable to remove repository reference "ubuntu:latest" (must force) - container 6aa08d636b1e is using its referenced image f9248aac10f2
```

Removal fails because the image is still using by the container `ubuntu_container` created by previous command. To successfully remove the image, the dependent container must be firstly removed.

**Command:**

```bash
docker ps -a
```

**Output:**

```diff
  CONTAINER ID   IMAGE                             COMMAND                  CREATED              STATUS                          PORTS     NAMES
+ 6aa08d636b1e   ubuntu:latest                     "/bin/bash"              About a minute ago   Exited (0) About a minute ago             ubuntu_container
...
```

## Task 2: Image Customization

**Command:**

```bash
docker run -d -p 80:80 --name nginx_container nginx
curl localhost
```

**Output:**

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Welcome to nginx!</title>
    <style>
      html {
        color-scheme: light dark;
      }
      body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
      }
    </style>
  </head>
  <body>
    <h1>Welcome to nginx!</h1>
    <p>
      If you see this page, the nginx web server is successfully installed and
      working. Further configuration is required.
    </p>

    <p>
      For online documentation and support please refer to
      <a href="http://nginx.org/">nginx.org</a>.<br />
      Commercial support is available at
      <a href="http://nginx.com/">nginx.com</a>.
    </p>

    <p><em>Thank you for using nginx.</em></p>
  </body>
</html>
```

**Command:**

```bash
docker cp index.html nginx_container:/usr/share/nginx/html/
```

**Output:**

```bash
Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/
```

**Command:**

```bash
docker ps --filter "name=nginx_container"
```

**Output:**

```bash
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

**Command:**

```bash
docker run -d -p 80:80 --name my_website_container my_website:latest
curl http://127.0.0.1:80
```

**Output:**

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

**Command:**

```bash
docker diff my_website_container
```

**Output:**

```bash
C /run
C /run/nginx.pid
C /etc
C /etc/nginx
C /etc/nginx/conf.d
C /etc/nginx/conf.d/default.conf
```

`C` means that the corresponding files were changed. Actually, output captures the initialization process of the nginx container: it first modifies its own configuration and then starts the server process, which modifies a PID file

## Task 3: Container Networking

**Command:**

```bash
docker network create lab_network
docker run -dit --network lab_network --name container1 alpine ash
docker run -dit --network lab_network --name container2 alpine ash
docker exec container1 ping -c 3 container2
```

**Output:**

```bash
PING container2 (172.20.0.3): 56 data bytes
64 bytes from 172.20.0.3: seq=0 ttl=64 time=0.137 ms
64 bytes from 172.20.0.3: seq=1 ttl=64 time=0.159 ms
64 bytes from 172.20.0.3: seq=2 ttl=64 time=0.215 ms

--- container2 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.137/0.170/0.215 ms
```

The output shows that container1 successfully resolved the name container2 to its IP address and received replies.

Docker has built-in DNS service which works as follows:

1. When a container is launched and attached to a custom network, the Docker daemon automatically registers the container's name and its assigned IP address with this internal DNS server
2. When another container on the same network makes a network request using a container name, the container's internal DNS resolver (which is configured by Docker to point to the embedded DNS server) sends a query to right container
3. The Docker DNS server receives the query, finds the entry for container, and returns its corresponding IP address

## Task 4: Volume Persistence

**Command:**

```bash
docker volume create app_data
docker run -d -v app_data:/usr/share/nginx/html --name web nginx
docker cp index.html web:/usr/share/nginx/html/
docker stop web && docker rm web
docker run -d -v -p 80:80 app_data:/usr/share/nginx/html --name web_new nginx
```

**Output:**

```bash
<html>
  <head>
    <title>The best</title>
  </head>
  <body>
    <h1>website</h1>
  </body>
  Modified version
</html>
```

Note that the container, which was previously working with port 80, should be stopped

## Task 5: Container Inspection

**Command:**

```bash
docker run -d --name redis_container redis
docker top redis_container
```

**Output:**

```bash
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
geoclue             40657               40635               0                   19:27               ?                   00:00:00            redis-server *:6379
```

**Command:**

```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
```

**Output:**

```bash
172.17.0.3
```

| `docker exec`                                                                    | `docker attach`                                                     |
| -------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Runs new, separate command inside a running container                            | To connect the terminal to the main running process of a container  |
| Creates a new process inside the container                                       | Does not create a new process; it "latches onto" the existing PID 1 |
| The `exec` session ends when its command finishes, leaving the container running | The attach session is tied to the container's main process          |
| Exiting the command only terminates the `exec` process                           | Sending a `Ctrl-C` signal stops the container                       |

## Task 6: Cleanup Operations

**Command:**

```bash
docker system df
```

**Output:**

```bash
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          19        11        10.58GB   6.098GB (57%)
Containers      14        4         53.22MB   53.22MB (99%)
Local Volumes   10        7         134.3MB   0B (0%)
Build Cache     604       0         20.16GB   20.16GB
```

**Command:**

```bash
for i in {1..3}; do docker run --name temp$i alpine echo "hello"; done
docker build -t temp-image . && docker rmi temp-image
docker container prune -f
```

**Output:**

```bash
Deleted Containers:
aa33dd2b3e5539de836b4cd2d3eaec99d060fd891091c3427f4ef859a0398a8e
48336796cdfd93cb52c89f7a54f53b1550323c06558cb04ba77e421dee2e9b29
7099a2269013d0794c8dd65be83051aa456fe232543d2a3dec5ac58fad3a7512
3e421e6716775a16c82ed6b80e472390c66218d49b1a84b9ff87cef3ff87aadd
6aa08d636b1eae6bf860272a63f50b680165aae8fd7d8322656d70061602f274
adc7611b013eaf6ad2bcc711ff4385ec1a33a5f5916cb4cfccaeccc0a6027dcc
b5614c90b561a180de7b4c5f12ea035f9b009caed87a3ad00ac6f07d4ee9b81b
36da849f7abf350c3527fdad9ab8f34beaa38ecf076f7c2045ba7f7668a473a4
1bbcc50075f444903dd3ad72e9e666a576d79dd826b189ce841dbcf406095332
f1b6130637f68403f43ab89e91ff28b7571d7a1dc98d69cc4765cdb7d6dd93dc
1139211b3cbc1b0961fa651eddea38972280df541dd49bd6ae9eb6c35ac92fac
51661b21b721d8ca9568e18d9d9d156719c2b3c62bb314cc45cfb5023bb2b08f
17e4933daf1ef42640102a08f64606f063d1a98debcf623c5a3c244c25fe9d89

Total reclaimed space: 53.22MB
```

**Command:**

```bash
docker image prune -a -f
```

**Output:**

```bash
Deleted Images:
untagged: ubuntu:latest
untagged: ubuntu@sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
deleted: sha256:f9248aac10f2f82e0970222e36cc7b71215b88e974e001282e5cd89797a82218
deleted: sha256:45a01f98e78ce09e335b30d7a3080eecab7f50dfa0b38ca44a9dee2654ac0530
untagged: code-runner/python:latest
deleted: sha256:d619abb9b393d8455828f038afbad2ea5e0dc14dcee30c6afe994f4e6d97bef0
untagged: accept_kafka-checker:latest
deleted: sha256:74ca975d83ad20062cd26a328066b4e762672b4c055cf0216ee21a78660e0c09
untagged: apache/kafka:3.9.0
untagged: apache/kafka@sha256:fbc7d7c428e3755cf36518d4976596002477e4c052d1f80b5b9eafd06d0fff2f
deleted: sha256:2956061ba5d3388af8eb3148200f385ccba13ef75bc0eb6dcca5827ebd2d36d4
deleted: sha256:d73eb99b37ffc102db973952a1e0a10d7daff9df6f292716180504bdbd332759
deleted: sha256:eed1ad75f84c8efcfa6df42538b9a6826c8002f9a4572b6fc71788010b8e09d9
deleted: sha256:1293f8485d45de32170982b31eef0d1c24647ca06b76db2ff31469746100aa91
deleted: sha256:0dfdabe873bbe0da3a461077c103a0f4f41b5673aa992257b95580fb3ef97e80
deleted: sha256:11aae36d29ec4fdb9b081f61a33e4d7e471463fb2986dfaae4e1622be584821e
deleted: sha256:7cfd6ee5587774153dfb181e514bc0a3c2bf8f693698d1378113162b42093739
deleted: sha256:109ebe44bf22489eab8227c28e3b19e401ec5171e9c0a3474b9abcd9f8398eb2
deleted: sha256:7e58840259fc687b82e4e8840f81f4127ddfc94dc8f7e565cc5361cc91bb290e
deleted: sha256:aa5e2ae6c6b5662a3eef5bfe0e55f9f6fc611155efd9f1a1183b4834078d74ed
deleted: sha256:63ca1fbb43ae5034640e5e6cb3e083e05c290072c5366fcaa9d62435a4cced85
untagged: accept_kafka-sink:latest
deleted: sha256:7793a53c8a27e5702ae07768fe71cfd487065dd20563eefab54f8aa34372e115
untagged: confluentinc/cp-kafka:7.5.0
untagged: confluentinc/cp-kafka@sha256:fbbb6fa11b258a88b83f54d4f0bddfcffbf2279f99d66a843486e3da7bdfbf41
deleted: sha256:af34583c49f0fe6458d0679679ad968d7b245eee4d557d6066fb05275e802846
deleted: sha256:d9a38e63d5a385f6494dd94c9c8c33d0a782f8d63372ea838ecf08f5c9d5181a
deleted: sha256:4d60f0f7cc282ad29ae8eac4226248e912c8373a91e5181e9706fa7a15d92bcf
untagged: code-runner/pascal:latest
deleted: sha256:71f0d23b9e9a0b0e47c8bca705513629345f2afe9eb0caa70926ffec279c687b
untagged: accept_kafka-frontend:latest
deleted: sha256:653cd3ea6d2cbc853008dc132ebc686fd38ee070ecc49e7819bfbd851195ec62
untagged: accept_kafka-backend:latest
deleted: sha256:ae844794a246adaa4e351ec94f0e02ea89b4480b2f91eda17c7d710101d60bbf
untagged: confluentinc/cp-zookeeper:7.5.0
untagged: confluentinc/cp-zookeeper@sha256:02f6c042bb9a7844382fc4cedc513a44585d8a5acae873fb9e510e3ca9dcabc6
deleted: sha256:04bd40128a4eff8a0cf26f35611e42dd7cbee6f43967c6b430a840e7c62ace23
deleted: sha256:3c09ad1c3e509e7165f438d54784675d1bc571335d870623d598d642204f74f0
deleted: sha256:f61e2d2854ebbce5b526f5126c713c4498e3700bcf0e6694c625f9bbf4de604b
deleted: sha256:6cd74851e0b7687df3ca939d5ba24857f7ba735a5e44e57657265b1c9dc8d575
deleted: sha256:3c6e30a485c272e80c8e174f7f9c8e9f20d9f13fb8a772e3e111db3e11e5e2ba
deleted: sha256:5551c0d479aa324bb4e637966df7a1f87128e96a917e8231c9c191042c0f1fc7
deleted: sha256:161963da8ff1afc0acceb781a84861d5219356115f4f7fca092a326685c020f9
deleted: sha256:771a59f992a69e4307866ea4e5826cc45cd8d015c52bd209df37bc28cc6c17f6
deleted: sha256:bb7b4f00c271e2853fac279bc136acd01b4ce92028c6b1909434b83fc1f517ef
deleted: sha256:e741b76565c3f61a65b82b6cbb59cdea04ea37132217bd281d30599e8cf003f9
deleted: sha256:84c4ba00cf5055b54a75e57dfa51d6871a7ba4643a4accec59aa43f3915a5fab
deleted: sha256:ad5362eb8973710afa7450bf83d239791333ed21195b84118618dedc15e41c96
untagged: code-runner/c:latest
deleted: sha256:417d07eb832746d39b33832d5fc4dee383ae1f80b6996e2822bb97dee394cb99
untagged: code-runner/legacy:latest
deleted: sha256:682c94014c458746071567860416330aaf57018b67ece12c9df80a8fd9c5f2d0
untagged: code-runner/unpopular:latest
deleted: sha256:85c4b460bcebaecbd51b1b63e74a5689a15028cb8bf39dd7323bf2356868efb6
untagged: my_website:latest
deleted: sha256:e791daaa50aee75513f70bfb5475ddacb4964ab3b17dd4a71b97eea75839c3ce
deleted: sha256:9a2e2837427995f120e4d162071e96b2b9d7456110827279324dc37e41b88a91
untagged: code-runner/go:latest
deleted: sha256:ad06acf429e062fdb066a1a35051ca0a8470d0e5f889f68732ee31c6fbf93ba6
untagged: code-runner/java:latest
deleted: sha256:83cb1a59c1bd8bbc3eb5daa392d72c7654f6fea29eae078b69bfb0148349ff56

Total reclaimed space: 1.459GB
```

**Command:**

```bash
docker builder prune -f -a
```

**Output:**

```bash
...
Total:  28.71GB
```

**Command:**

```bash
docker system df
```

**Output:**

```bash
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          3         3         253.6MB   74.81MB (29%)
Containers      4         4         1.095kB   0B (0%)
Local Volumes   10        2         134.3MB   134.3MB (99%)
Build Cache     0         0         0B        0B
```

# Лабоартаорная работа №6 Docker

## Задание 0

- Запустили движок докера и во встроенном терминале командой 
    
    docker pull ubuntu:latest

    загрузили образ убунты. Далее сохранили его в архив 

    docker save -o ubuntu_image.tar ubuntu:latest

- Сравнили размеры файлов командами 

    />>docker images              
    
    REPOSITORY     TAG       IMAGE ID       CREATED        SIZE
    
    ubuntu         latest    440dcf6a5640   2 weeks ago    117MB

    />>(Get-Item ubuntu_image.tar).Length / 1MB
    
    28,3583984375

Размеры изображений не совпадают потому что файл сжат в архив и в нем нет метаданных, которые нужны для работы Docker

## Задание 1
Согласно плану командой 

    docker ps -a 

Проверяем какие конейнеры есть, никаких 

    CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

Здесь надо было опять подтянуть убунту, это уже сделано, размеры срвнены, поэтому запускаем образ 

    docker run -it --name ubuntu_container ubuntu:latest

И забавы ради поделаем в нем что-нибудь 

    root@1ab7f529f636:/# w
    16:03:28 up 37 min,  0 user,  load average: 0.00, 0.00, 0.01
    USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU  WHAT
    root@1ab7f529f636:/# uname -a
    Linux 1ab7f529f636 5.15.167.4-microsoft-standard-WSL2 #1 SMP Tue Nov 5 00:21:55 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

Выйдем из контейнера через 

    exit 

И удалим образ (а вот и не удалим) потому что докер не даст удалить образ если есть хотя бы один контейнер, даже остановленный, который использует этот образ. Сначала надо удалить контейнеры, а потм уже образ, или удалить принудительно, тогда все контейнеры тоже удалятся.


## Здание 2 Кастомный Nginx

Запустим nginx в фотовом режиме 

    >>docker run -d -p 80:80 --name nginx_container nginx
    Unable to find image 'nginx:latest' locally
    latest: Pulling from library/nginx
    6c8e51cf0087: Pull complete
    ee95256df030: Pull complete
    48670a58a68f: Pull complete
    ce7132063a56: Pull complete
    9bbbd7ee45b7: Pull complete
    23e05839d684: Pull complete
    3da95a905ed5: Pull complete
    Digest: sha256:93230cd54060f497430c7a120e2347894846a81b6a5dd2110f7362c5423b4abc
    Status: Downloaded newer image for nginx:latest
    616f3d4dc1f6f1dec775b6c4ed1cb04bdd3b29c704c5e55aa4d160688e1e89c2

Докер не нашел такого образа локально но подятнул его из облака. Теперь проверим что сервер работает 

    >>curl http://localhost


    StatusCode        : 200
    StatusDescription : OK
    Content           : <!DOCTYPE html>
                        <html>
                        <head>
                        <title>Welcome to nginx!</title>
                        <style>
                        html { color-scheme: light dark; }
                        body { width: 35em; margin: 0 auto;
                        font-family: Tahoma, Verdana, Arial, sans-serif; }
                        </style...
    RawContent        : HTTP/1.1 200 OK
                        Connection: keep-alive
                        Accept-Ranges: bytes
                        Content-Length: 615
                        Content-Type: text/html
                        Date: Sat, 05 Jul 2025 16:16:32 GMT
                        ETag: "685adee1-267"
                        Last-Modified: Tue, 24 Jun 2025 ...
    Forms             : {}
    Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 615], [Content-Type, text/html]...}
    Images            : {}
    InputFields       : {}
    Links             : {@{innerHTML=nginx.org; innerText=nginx.org; outerHTML=<A href="http://nginx.org/">nginx.org</A>; outerText=nginx.org; tagName=A; hre
                        f=http://nginx.org/}, @{innerHTML=nginx.com; innerText=nginx.com; outerHTML=<A href="http://nginx.com/">nginx.com</A>; outerText=ngin 
                        x.com; tagName=A; href=http://nginx.com/}}
    ParsedHtml        : mshtml.HTMLDocumentClass
    RawContentLength  : 615

Статус 200 - все хорошо. 

Добавим в корень терминала в котором работаем файл index.html из задания. И заменим им стандартную страницу nginx 

    >>docker cp index.html nginx_container:/usr/share/nginx/html/

    Successfully copied 2.05kB to nginx_container:/usr/share/nginx/html/

Теперь пинганем сервер снова и увидим что html код старницы именно тот что мы написали. 

    curl http://localhost


    StatusCode        : 200
    StatusDescription : OK
    Content           : <html>
                        <head>
                        <title>The best</title>
                        </head>
                        <body>
                        <h1>website</h1>
                        </body>
                        </html>
    RawContent        : HTTP/1.1 200 OK
                        Connection: keep-alive
                        Accept-Ranges: bytes
                        Content-Length: 92
                        Content-Type: text/html
                        Date: Sat, 05 Jul 2025 16:22:42 GMT
                        ETag: "68695126-5c"
                        Last-Modified: Sat, 05 Jul 2025 16...
    Forms             : {}
    Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 92], [Content-Type, text/html]...}
    Images            : {}
    InputFields       : {}
    Links             : {}
    ParsedHtml        : mshtml.HTMLDocumentClass
    RawContentLength  : 92

Содержимое наше, статус код 200 - все хорошо. 

Закоммитим изменения в новый образ 

    >>docker commit nginx_container my_website:latest

    sha256:9a14e011ff048...

Посмотрим что образ и вправду есть 

    >>docker images
    REPOSITORY     TAG       IMAGE ID       CREATED          SIZE
    my_website     latest    9a14e011ff04   42 seconds ago   279MB
    nginx          latest    93230cd54060   10 days ago      279MB
    ubuntu         latest    440dcf6a5640   2 weeks ago      117MB
    sentimentapp   latest    2d730adf04d4   2 months ago     15.2GB

Здесь видны наши образы и один что остался с лабораторной работы по ML-Ops

Остановим и удалим старый контейнер

    >>docker stop nginx_container
    >>docker rm nginx_container

Проверим что его нет 

    docker ps -a 
    CONTAINER ID   IMAGE           COMMAND       CREATED          STATUS                        PORTS     NAMES
    1ab7f529f636   ubuntu:latest   "/bin/bash"   27 minutes ago   Exited (130) 26 minutes ago             ubuntu_container

Остался только первый убунту контейнер, удалим его тоже 

    >>docker rm ubuntu_container

Создадим новый контейнер, из измененного образа 

    >>docker run -d -p 80:80 --name my_website_container my_website:latest

Проверим что содержимое контейнера, тот самый index.html на сервере крутится правильно 

     curl http://localhost


    StatusCode        : 200
    StatusDescription : OK
    Content           : <html>
                        <head>
                        <title>The best</title>
                        </head>
                        <body>
                        <h1>website</h1>
                        </body>
                        </html>
    RawContent        : HTTP/1.1 200 OK
                        Connection: keep-alive
                        Accept-Ranges: bytes
                        Content-Length: 92
                        Content-Type: text/html
                        Date: Sat, 05 Jul 2025 16:35:57 GMT
                        ETag: "68695126-5c"
                        Last-Modified: Sat, 05 Jul 2025 16...
    Forms             : {}
    Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 92], [Content-Type, text/html]...}
    Images            : {}
    InputFields       : {}
    Links             : {}
    ParsedHtml        : mshtml.HTMLDocumentClass
    RawContentLength  : 92

Код 200, содержимое нужное - все хорошо 

Проанализируем что отличается в контейнере 

    >>docker diff my_website_container

    C /etc
    C /etc/nginx
    C /etc/nginx/conf.d
    C /etc/nginx/conf.d/default.conf
    C /run
    C /run/nginx.pid

Странно что не отличается файл index.html возможно его изменение было закомичено раньше и не затрекалось здесь. В остальном изменились конфигурационные файлы Nginx, что логично. 

## Задание 3. Сети

Создадим bridge-сеть 

    >>docker network create lab_network
    46ef4be3bac9b5c707a3cc984f8e4ab2b757c4890047f0bef8259ed8b4d8e05d

Проверим что сеть есть 

    >>docker network ls 
    NETWORK ID     NAME          DRIVER    SCOPE
    262af2c3aa1d   bridge        bridge    local
    e4c855000888   host          host      local
    46ef4be3bac9   lab_network   bridge    local
    f835beee8e81   none          null      local

Создаем два котейнера на этой сети с самым легким образом линукса - alpine 

    >>docker run -dit --network lab_network --name container1 alpine ash
    Unable to find image 'alpine:latest' locally
    latest: Pulling from library/alpine
    fe07684b16b8: Pull complete
    Digest: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
    Status: Downloaded newer image for alpine:latest
    ba5e3d3ed7ec863f06dda1f600fb3eb9df8d46d34eb0cace614b61e90d5669a0
    
    >>docker run -dit --network lab_network --name container2 alpine ash
    5cde25365380408c7ff356d972d0dc2ec788b2bc40287b83cf972e061bb29362

Контейнеры есть 

    >>docker ps
    CONTAINER ID   IMAGE               COMMAND                  CREATED              STATUS              PORTS                NAMES
    5cde25365380   alpine              "ash"                    About a minute ago   Up 59 seconds                            container2
    ba5e3d3ed7ec   alpine              "ash"                    About a minute ago   Up About a minute                        container1
    f1b20f7a0008   my_website:latest   "/docker-entrypoint.…"   14 minutes ago       Up 14 minutes       0.0.0.0:80->80/tcp   my_website_container

Пингуем контейнер 2 из контейнера 1 

    >>docker exec container1 ping -c 3 container2
    PING container2 (172.18.0.3): 56 data bytes
    64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.574 ms
    64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.173 ms
    64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.201 ms

    --- container2 ping statistics ---
    3 packets transmitted, 3 packets received, 0% packet loss
    round-trip min/avg/max = 0.173/0.316/0.574 ms

Все работает. Docker встроил DNS-сервер, который преобразует имена контейнеров (например, container2) в их IP-адреса внутри сети. При этом они не видят контейнеры в других сетях. Например мы можем узнать их адреса 

    >> docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container1
    172.18.0.2

    >> docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container2
    172.18.0.3

Или проверить маршрутизацию 

    >>docker exec container1 ip route
    default via 172.18.0.1 dev eth0 
    172.18.0.0/16 dev eth0 scope link  src 172.18.0.2

## Задание №4. Работа с томами

Тома Docker — это механизм для сохранения данных независимо от контейнеров.

Создаем том 

    >> docker volume create app_data

Проверем что он создался

    >> docker volume ls
    app_data
    DRIVER    VOLUME NAME

Поднимаем контейнер с томом

    docker run -d -v app_data:/usr/share/nginx/html --name web nginx

    -v app_data:/usr/share/nginx/html — подключает том app_data в указанную папку контейнера.

    --name web — имя контейнера

Копируем туда написанный html файл 

    >>docker cp index.html web:/usr/share/nginx/html/
    Successfully copied 2.05kB to web:/usr/share/nginx/html/

Проверяем что файл существует 

    >>curl http://localhost


    StatusCode        : 200
    StatusDescription : OK
    Content           : <html>
                        <head>
                        <title>The best website</title>
                        </head>
                        <body>
                        <h1>Data persists!</h1>
                        </body>
                        </html>
    RawContent        : HTTP/1.1 200 OK
                        Connection: keep-alive
                        Accept-Ranges: bytes
                        Content-Length: 107
                        Content-Type: text/html
                        Date: Sat, 05 Jul 2025 17:34:46 GMT
                        ETag: "68696079-6b"
                        Last-Modified: Sat, 05 Jul 2025 1...
    Forms             : {}
    Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 107], [Content-Type, text/html]...}
    Images            : {}
    InputFields       : {}
    Links             : {}
    ParsedHtml        : mshtml.HTMLDocumentClass
    RawContentLength  : 107

Останавливаем и удаляем старый контейнер 

    >>docker stop web 
    >>docker rm web 

После этого создаем новый контейнер 

    >>docker run -d -p 80:80 -v ${PWD}:/usr/share/nginx/html --name my_nginx_2 nginx

И проверим что используется оставшаяся в томе страница 

    >>curl http://localhost


    StatusCode        : 200
    StatusDescription : OK
    Content           : <html>
                        <head>
                        <title>The best website</title>
                        </head>
                        <body>
                        <h1>Data persists!</h1>
                        </body>
                        </html>
    RawContent        : HTTP/1.1 200 OK
                        Connection: keep-alive
                        Accept-Ranges: bytes
                        Content-Length: 107
                        Content-Type: text/html
                        Date: Sat, 05 Jul 2025 17:40:22 GMT
                        ETag: "68696079-6b"
                        Last-Modified: Sat, 05 Jul 2025 1...
    Forms             : {}
    Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 107], [Content-Type, text/html]...}
    Images            : {}
    InputFields       : {}
    Links             : {}
    ParsedHtml        : mshtml.HTMLDocumentClass
    RawContentLength  : 107

Код 200, данные наши - все хорошо. Том работает и не зависит от контейнеров, можем хранить данные. 

## Задание 5. Анализ контейнеров

Изучим как работает контейнер 

    >>docker run -d --name redis_container redis

    Unable to find image 'redis:latest' locally
    latest: Pulling from library/redis
    881b4a6fb2ec: Pull complete
    ab22bb3606ca: Pull complete
    4ef8fa7693bb: Pull complete
    6d7393f5b310: Pull complete
    db655ba2dcca: Pull complete
    4f4fb700ef54: Pull complete
    Digest: sha256:b43d2dcbbdb1f9e1582e3a0f37e53bf79038522ccffb56a25858969d7a9b6c11
    Status: Downloaded newer image for redis:latest
    d1374cf588bd9a2504a52832b5d1114b3ee80dbfa040c3656c5b54e3fa84e78e

    >>docker ps
    CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS      NAMES
    d1374cf588bd   redis     "docker-entrypoint.s…"   38 seconds ago   Up 37 seconds   6379/tcp   redis_container

Посмотрим какие процессы есть в контенйере 

    >>docker exec redis_container ps aux
    OCI runtime exec failed: exec failed: unable to start container process: exec: "ps": executable file not found in $PATH: unknown

Как узнал, в мнималистичных образах нет устилиты PS. Можно узнать пизды процессов с помощью 

    >>docker inspect --format '{{.State.Pid}}' redis_container
    1768

А адрес с помощью 

    >>docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis_container
    172.17.0.2

- exec: Запускает новый процесс (без влияния на контейнер).
- attach: Подключается к основному процессу (может остановить контейнер).

## Задание №6

    >>docker system df
    TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
    Images          6         0         18.12GB   18.12GB (100%)
    Containers      0         0         0B        0B
    Local Volumes   2         0         692B      692B (100%)
    Build Cache     11        0         28.67kB   28.67kB

Создаем три контейнера

    >>for ($i=1; $i -le 3; $i++) { docker run --name temp$i alpine echo "hello" }

и два висячих образа

    >>docker build -t temp-image . && docker rmi temp-image

Удаляем неиспользованные образы

    >>docker container prune -f
    Deleted Containers:
    36a9b97c23b99e4c5a271a9cc6f3f8e139a2551f814b06fa333013eb4f1eb18a
    3f6611516264d3ce4886377fb775686bcb2548e82aaa55aabc2e069baf848579
    0d6d1a5fcc245de3cd5e3a048ff689fda4333ebc0054157252178bd84899adc0

Полностью очищаем систему

    >>docker image prune -a -f
    Deleted Images:
    untagged: ubuntu:latest
    deleted: sha256:440dcf6a5640b2ae5c77724e68787a906afb8ddee98bf86db94eea8528c2c076
    deleted: sha256:dbdff34bb41cecdb07c79af373b44bb4c9ccba2520f014221fb95845f14bc6c1
    deleted: sha256:f9248aac10f2f82e0970222e36cc7b71215b88e974e001282e5cd89797a82218
    deleted: sha256:b08e2ff4391ef70ca747960a731d1f21a75febbd86edc403cd1514a099615808
    untagged: alpine:latest
    deleted: sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
    deleted: sha256:08001109a7d679fe33b04fa51d681bd40b975d8f5cea8c3ef6c0eccb6a7338ce
    deleted: sha256:cea2ff433c610f5363017404ce989632e12b953114fefc6f597a58e813c15d61...

Теперь освобождено больше места 

    >>docker system df
    TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
    Images          0         0         8.956GB   8.956GB (100%)
    Containers      0         0         0B        0B
    Local Volumes   2         0         692B      692B (100%)
    Build Cache     12        0         15.25GB   15.25GB
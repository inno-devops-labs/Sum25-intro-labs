## Task 1

Verify `docker run -d --name juice-shop -p 3000:3000 bkimminich/juice-shop`

~~~bash
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS          PORTS                                       NAMES
a05d64ddcda0   bkimminich/juice-shop   "/nodejs/bin/node /j…"   19 seconds ago   Up 19 seconds   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   juice-shop
~~~

Verify `http://localhost:3000`

![alt text](image.png)

**Scan with OWASP ZAP**:

~~~bash
docker run --rm -u zap -v $(pwd):/zap/wrk:rw \
-t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py \
-t http://172.17.0.1:3000 \
-g gen.conf \
-r zap-report.html
~~~

![alt text](image-1.png)

## Task 2

**Scan using Trivy in Docker**:

~~~bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
aquasec/trivy:latest image \
--severity HIGH,CRITICAL \
bkimminich/juice-shop
~~~

![alt text](image-2.png)
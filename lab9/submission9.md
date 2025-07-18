## Task 1 Results
### Install Juice shop

### 1. Start the vulnerable target application (Juice Shop):

docker run -d --name juice-shop -p 3000:3000 bkimminich/juice-shop

** Verify it's running: http://localhost:3000 in browser **

-- Screen Juice shop - juice.png


### 2. Scan with OWASP ZAP
** Determining the IP address of the docker0 interface: **
└─# ip -f inet -o addr show docker0 | awk '{print $4}' | cut -d '/' -f 1
172.17.0.1

**Starting the scan**
docker run --rm -u zap -v $(pwd):/zap/wrk:rw \
 -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py \
 -t http://172.17.0.1:3000 \
 -g gen.conf \
 -r zap-report.html

### 3. Analyze results**:
Open **zap-report.html** in a browser:

Screen -- zap-report.png

**Juice Shop vulnerabilities found (Medium): 2**
Content Security Policy (CSP) Header Not Set
Cross-Domain Misconfiguration


### 4. Clean up:

docker stop juice-shop && docker rm juice-shop

## Task 2: Container Vulnerability Scanning with Trivy

### 1. Scan using Trivy in Docker:
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
aquasec/trivy:latest image \
--severity HIGH,CRITICAL \
bkimminich/juice-shop

### 2.Analyze results:

**trivy output -- trivy-output.txt**
    - The total number of CRITICAL vulnerabilities: 6
    - 2 vulnerable package names: 
        - glibc — vulnerabiliti CVE-2023-4813 (HIGH)
        - AsymmetricPrivateKey (private-key) (HIGH)

### 3. Clean up:
docker rmi bkimminich/juice-shop


## Task 1 Results
- Juice Shop vulnerabilities found (Medium): 2
- Most interesting vulnerability found: **Content Security Policy (CSP) Header Not Set**
- Security headers present: No
## Task 2 Results
- Critical vulnerabilities in Juice Shop image: 10
- Vulnerable packages: 
   1. glibc
   2. openssl
- Dominant vulnerability type: OS-level CVEs (e.g., Buffer Overflow, RCE)


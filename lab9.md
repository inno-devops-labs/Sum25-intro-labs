# Lab9: Introduction to DevSecOps Tools

In this lab, you'll explore fundamental DevSecOps practices by performing security scans on containers and web applications using industry-standard tools. You'll learn how to identify vulnerabilities in a safe, controlled environment using intentionally vulnerable targets.

## Task 1: Web Application Scanning with OWASP ZAP

**Objective**: Perform automated security scanning of a vulnerable web application using OWASP ZAP in Docker to identify common web vulnerabilities. Web application scanning helps discover security flaws like XSS, SQL injection, and misconfigurations before attackers exploit them. ZAP is an industry-standard tool maintained by OWASP.

1. **Start the vulnerable target application** (Juice Shop):

   ```bash
      docker run -d --name juice-shop -p 3000:3000 bkimminich/juice-shop
   ```

   Verify it's running: `http://localhost:3000` in your browser

2. **Scan with OWASP ZAP**:

   ```bash
      docker run --rm -u zap -v $(pwd):/zap/wrk:rw \
      -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py \
      -t http://host.docker.internal:3000 \
      -g gen.conf \
      -r zap-report.html
   ```

   > *Note*:
   > - Mac/Windows: Use `host.docker.internal` as above
   > - Linux: Replace with your machine's LAN IP. You can use following command `ip -f inet -o addr show docker0 | awk '{print $4}' | cut -d '/' -f 1`

3. **Analyze results**:
    - Find the HTML report in your current directory: `zap-report.html`
    - Open it in a browser and identify:
    - 2 Medium risk vulnerabilities
    - Security headers status

4. **Clean up**:

   ```bash
      docker stop juice-shop && docker rm juice-shop
   ```

---

## Task 2: Container Vulnerability Scanning with Trivy

**Objective**: Identify vulnerabilities in container images using Trivy executed via Docker, focusing on intentionally vulnerable images for education. Container scanning detects OS/library vulnerabilities in images before deployment. Trivy is the industry's most comprehensive open-source scanner.

1. **Pull a vulnerable educational image**:

   ```bash
      docker pull vulnweb/acunetix:latest
   ```

2. **Scan using Trivy in Docker**:

   ```bash
      docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
      aquasec/trivy:latest image \
      --severity HIGH,CRITICAL \
      bkimminich/juice-shop
   ```

3. **Analyze results**:
    - Identify:
    - The total number of CRITICAL vulnerabilities
    - 2 vulnerable package names
    - The most common vulnerability type

4. **Clean up**:

   ```bash
      docker rmi bkimminich/juice-shop
   ```

---

## Submission Guidelines

1. Create `submission9.md` with:

   ```markdown
   ## Task 1 Results
   - Juice Shop vulnerabilities found (Medium): [Number]
   - Most interesting vulnerability found: [Name]
   - Security headers present: [Yes/No]

   ## Task 2 Results
   - Critical vulnerabilities in Juice Shop image: [Number]
   - Vulnerable packages: 
      1. [Package 1]
      2. [Package 2]
   - Dominant vulnerability type: [e.g., SQLi, XSS]
   ```

2. Include screenshot evidence:
    - ZAP HTML report overview
    - Trivy terminal output showing critical findings

3. Submit via pull request to course repository.

> **Safety Note**: All scans target intentionally vulnerable containers/web apps running locally. Never run automated scanners against production systems without explicit permission.

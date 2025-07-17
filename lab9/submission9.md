# Introduction to DevSecOps Tools

![juice-shop](src/main-page.png)

## Task 1 Results

![zap-scan](src/scan-result.png)

- **Juice Shop vulnerabilities found (Medium):** 2
- **Most interesting vulnerability found:** Content Security Policy (CSP) Header Not Set
- **Security headers present:** No

## Task 2 Results

![trivy scan](src/trivy-scan1.png)

![trivy vulnerabilities](src/triviy-scan2.png)

- **Critical vulnerabilities in Juice Shop image:** 8
- **Vulnerable packages:**
   1. jsonwebtoken
   2. lodash
- **Dominant vulnerability type:** Insecure Dependencies / Prototype Pollution

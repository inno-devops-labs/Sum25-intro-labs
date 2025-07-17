# Lab 9: Introduction to DevSecOps Tools

## Task 1: Web Application Scanning with OWASP ZAP
Results
- **Juice Shop vulnerabilities found (Medium):** 2  
- **Most interesting vulnerability found:** Content Security Policy (CSP) Header Not Set  
- **Security headers present:** No
<img width="1456" height="608" alt="image" src="https://github.com/user-attachments/assets/84c17b43-01dc-40ee-85f8-edfe8f74eb99" />
<img width="1754" height="907" alt="image" src="https://github.com/user-attachments/assets/fed49779-0119-460d-bb80-e95f2b8cbaf8" />
  <img width="1275" height="693" alt="image" src="https://github.com/user-attachments/assets/51d20c13-1ec2-4096-b997-62f335575cb8" />


## Task 2: Container Vulnerability Scanning with Trivy
Results
- **Critical vulnerabilities in Juice Shop image**: 8
- **Vulnerable packages**: 
   1. CVE-2023-46233 
   2. CVE-2015-9235
   3. CVE-2015-9235
   4. CVE-2019-10744
   5. GHSA-5mrr-rgp6-x4gr
   6. CVE-2023-32314
   7. CVE-2023-37466
   8. CVE-2023-37903
- **Dominant vulnerability type:** Cryptographic weaknesses / authentication bypass  
<img width="1710" height="890" alt="image" src="https://github.com/user-attachments/assets/bf684c98-cabb-4f97-8f52-9a08bc0705a6" />

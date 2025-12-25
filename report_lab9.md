# Introduction to DevSecOps Tools

In this lab, you'll explore fundamental DevSecOps practices by performing security scans on containers and web applications using industry-standard tools. You'll learn how to identify vulnerabilities in a safe, controlled environment using intentionally vulnerable targets.

## Task 1: Web Application Scanning with OWASP ZAP

**Objective**: Perform automated security scanning of a vulnerable web application using OWASP ZAP in Docker to identify common web vulnerabilities. Web application scanning helps discover security flaws like XSS, SQL injection, and misconfigurations before attackers exploit them. ZAP is an industry-standard tool maintained by OWASP.

1. **Start the vulnerable target application** (Juice Shop):

   ```bash
      docker run -d --name juice-shop -p 3000:3000 bkimminich/juice-shop
   ```

   Verify it's running: `http://localhost:3000` in your browser

<img width="1404" height="1076" alt="image" src="https://github.com/user-attachments/assets/f173bfdf-ed6e-4785-a0c0-35a8f92ebc58" />


2. **Scan with OWASP ZAP**:

   ```bash
      docker run --rm -u zap -v $(pwd):/zap/wrk:rw \
      -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py \
      -t http://host.docker.internal:3000 \
      -g gen.conf \
      -r zap-report.html
   ```

<img width="1160" height="469" alt="image" src="https://github.com/user-attachments/assets/3465bd8e-4f63-44b1-8541-ff6cdb58d1c0" />

   > *Note*:
   > - Mac/Windows: Use `host.docker.internal` as above
   > - Linux: Replace with your machine's LAN IP. You can use following command `ip -f inet -o addr show docker0 | awk '{print $4}' | cut -d '/' -f 1`

<img width="917" height="201" alt="image" src="https://github.com/user-attachments/assets/38834f4a-459a-442d-84b6-b4840014a1fa" />

3. **Analyze results**:
    - Find the HTML report in your current directory: `zap-report.html`
    - Open it in a browser and identify:
    - 2 Medium risk vulnerabilities
    - Security headers status

<img width="760" height="98" alt="image" src="https://github.com/user-attachments/assets/d76daa56-4f0c-4062-861d-d38e1408b502" />

<img width="1561" height="956" alt="image" src="https://github.com/user-attachments/assets/74c650ff-db4b-4556-a01e-32d51e4134e8" />

4. **Clean up**:

   ```bash
      docker stop juice-shop && docker rm juice-shop
   ```

---

## Task 2: Container Vulnerability Scanning with Trivy

**Objective**: Identify vulnerabilities in container images using Trivy executed via Docker, focusing on intentionally vulnerable images for education. Container scanning detects OS/library vulnerabilities in images before deployment. Trivy is the industry's most comprehensive open-source scanner.

1. **Scan using Trivy in Docker**:

   ```bash
      docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
      aquasec/trivy:latest image \
      --severity HIGH,CRITICAL \
      bkimminich/juice-shop
   ```

<img width="1397" height="1062" alt="image" src="https://github.com/user-attachments/assets/89f7e908-5384-4c2d-8da0-6bbbd1824492" />

```
bkimminich/juice-shop (debian 12.11)
====================================
Total: 1 (HIGH: 1, CRITICAL: 0)

┌─────────┬───────────────┬──────────┬──────────┬───────────────────┬───────────────┬───────────────────────────────────────────────────────────┐
│ Library │ Vulnerability │ Severity │  Status  │ Installed Version │ Fixed Version │                           Title                           │
├─────────┼───────────────┼──────────┼──────────┼───────────────────┼───────────────┼───────────────────────────────────────────────────────────┤
│ libc6   │ CVE-2025-4802 │ HIGH     │ affected │ 2.36-9+deb12u10   │               │ glibc: static setuid binary dlopen may incorrectly search │
│         │               │          │          │                   │               │ LD_LIBRARY_PATH                                           │
│         │               │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2025-4802                 │
└─────────┴───────────────┴──────────┴──────────┴───────────────────┴───────────────┴───────────────────────────────────────────────────────────┘

Node.js (node-pkg)
==================
Total: 25 (HIGH: 17, CRITICAL: 8)

┌─────────────────────────────────────┬─────────────────────┬──────────┬──────────┬───────────────────┬──────────────────────────────┬──────────────────────────────────────────────────────────────┐
│               Library               │    Vulnerability    │ Severity │  Status  │ Installed Version │        Fixed Version         │                            Title                             │
├─────────────────────────────────────┼─────────────────────┼──────────┼──────────┼───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ base64url (package.json)            │ NSWG-ECO-428        │ HIGH     │ fixed    │ 0.0.6             │ >=3.0.0                      │ Out-of-bounds Read                                           │
│                                     │                     │          │          │                   │                              │ https://hackerone.com/reports/321687                         │
├─────────────────────────────────────┼─────────────────────┤          │          ├───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ braces (package.json)               │ CVE-2024-4068       │          │          │ 2.3.2             │ 3.0.3                        │ braces: fails to limit the number of characters it can       │
│                                     │                     │          │          │                   │                              │ handle                                                       │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2024-4068                    │
├─────────────────────────────────────┼─────────────────────┼──────────┤          ├───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ crypto-js (package.json)            │ CVE-2023-46233      │ CRITICAL │          │ 3.3.0             │ 4.2.0                        │ crypto-js: PBKDF2 1,000 times weaker than specified in 1993  │
│                                     │                     │          │          │                   │                              │ and 1.3M times...                                            │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2023-46233                   │
├─────────────────────────────────────┼─────────────────────┼──────────┤          ├───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ express-jwt (package.json)          │ CVE-2020-15084      │ HIGH     │          │ 0.1.3             │ 6.0.0                        │ Authorization bypass in express-jwt                          │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2020-15084                   │
├─────────────────────────────────────┼─────────────────────┤          │          ├───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ http-cache-semantics (package.json) │ CVE-2022-25881      │          │          │ 3.8.1             │ 4.1.1                        │ http-cache-semantics: Regular Expression Denial of Service   │
│                                     │                     │          │          │                   │                              │ (ReDoS) vulnerability                                        │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2022-25881                   │
├─────────────────────────────────────┼─────────────────────┤          ├──────────┼───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ ip (package.json)                   │ CVE-2024-29415      │          │ affected │ 2.0.1             │                              │ node-ip: Incomplete fix for CVE-2023-42282                   │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2024-29415                   │
├─────────────────────────────────────┼─────────────────────┼──────────┼──────────┼───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ jsonwebtoken (package.json)         │ CVE-2015-9235       │ CRITICAL │ fixed    │ 0.1.0             │ 4.2.2                        │ nodejs-jsonwebtoken: verification step bypass with an        │
│                                     │                     │          │          │                   │                              │ altered token                                                │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2015-9235                    │
│                                     ├─────────────────────┼──────────┤          │                   ├──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│                                     │ CVE-2022-23539      │ HIGH     │          │                   │ 9.0.0                        │ jsonwebtoken: Unrestricted key type could lead to legacy     │
│                                     │                     │          │          │                   │                              │ keys usagen                                                  │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2022-23539                   │
│                                     ├─────────────────────┤          │          │                   ├──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│                                     │ NSWG-ECO-17         │          │          │                   │ >=4.2.2                      │ Verification Bypass                                          │
│                                     ├─────────────────────┼──────────┤          ├───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│                                     │ CVE-2015-9235       │ CRITICAL │          │ 0.4.0             │ 4.2.2                        │ nodejs-jsonwebtoken: verification step bypass with an        │
│                                     │                     │          │          │                   │                              │ altered token                                                │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2015-9235                    │
│                                     ├─────────────────────┼──────────┤          │                   ├──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│                                     │ CVE-2022-23539      │ HIGH     │          │                   │ 9.0.0                        │ jsonwebtoken: Unrestricted key type could lead to legacy     │
│                                     │                     │          │          │                   │                              │ keys usagen                                                  │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2022-23539                   │
│                                     ├─────────────────────┤          │          │                   ├──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│                                     │ NSWG-ECO-17         │          │          │                   │ >=4.2.2                      │ Verification Bypass                                          │
├─────────────────────────────────────┼─────────────────────┤          │          ├───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ jws (package.json)                  │ CVE-2016-1000223    │          │          │ 0.2.6             │ >=3.0.0                      │ Forgeable Public/Private Tokens                              │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2016-1000223                 │
├─────────────────────────────────────┼─────────────────────┼──────────┤          ├───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ lodash (package.json)               │ CVE-2019-10744      │ CRITICAL │          │ 2.4.2             │ 4.17.12                      │ nodejs-lodash: prototype pollution in defaultsDeep function  │
│                                     │                     │          │          │                   │                              │ leading to modifying properties                              │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2019-10744                   │
│                                     ├─────────────────────┼──────────┤          │                   ├──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│                                     │ CVE-2018-16487      │ HIGH     │          │                   │ >=4.17.11                    │ lodash: Prototype pollution in utilities function            │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2018-16487                   │
│                                     ├─────────────────────┤          │          │                   ├──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│                                     │ CVE-2021-23337      │          │          │                   │ 4.17.21                      │ nodejs-lodash: command injection via template                │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2021-23337                   │
├─────────────────────────────────────┼─────────────────────┤          ├──────────┼───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ lodash.set (package.json)           │ CVE-2020-8203       │          │ affected │ 4.3.2             │                              │ nodejs-lodash: prototype pollution in zipObjectDeep function │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2020-8203                    │
├─────────────────────────────────────┼─────────────────────┼──────────┤          ├───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ marsdb (package.json)               │ GHSA-5mrr-rgp6-x4gr │ CRITICAL │          │ 0.6.11            │                              │ Command Injection in marsdb                                  │
│                                     │                     │          │          │                   │                              │ https://github.com/advisories/GHSA-5mrr-rgp6-x4gr            │
├─────────────────────────────────────┼─────────────────────┼──────────┼──────────┼───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ moment (package.json)               │ CVE-2017-18214      │ HIGH     │ fixed    │ 2.0.0             │ 2.19.3                       │ nodejs-moment: Regular expression denial of service          │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2017-18214                   │
│                                     ├─────────────────────┤          │          │                   ├──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│                                     │ CVE-2022-24785      │          │          │                   │ 2.29.2                       │ Moment.js: Path traversal in moment.locale                   │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2022-24785                   │
├─────────────────────────────────────┼─────────────────────┤          │          ├───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ sanitize-html (package.json)        │ CVE-2022-25887      │          │          │ 1.4.2             │ 2.7.1                        │ sanitize-html: insecure global regular expression            │
│                                     │                     │          │          │                   │                              │ replacement logic may lead to ReDoS                          │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2022-25887                   │
├─────────────────────────────────────┼─────────────────────┼──────────┤          ├───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ vm2 (package.json)                  │ CVE-2023-32314      │ CRITICAL │          │ 3.9.17            │ 3.9.18                       │ vm2: Sandbox Escape                                          │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2023-32314                   │
│                                     ├─────────────────────┤          ├──────────┤                   ├──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│                                     │ CVE-2023-37466      │          │ affected │                   │                              │ vm2: Promise handler sanitization can be bypassed allowing   │
│                                     │                     │          │          │                   │                              │ attackers to escape the...                                   │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2023-37466                   │
│                                     ├─────────────────────┤          │          │                   ├──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│                                     │ CVE-2023-37903      │          │          │                   │                              │ vm2: custom inspect function allows attackers to escape the  │
│                                     │                     │          │          │                   │                              │ sandbox and run...                                           │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2023-37903                   │
├─────────────────────────────────────┼─────────────────────┼──────────┼──────────┼───────────────────┼──────────────────────────────┼──────────────────────────────────────────────────────────────┤
│ ws (package.json)                   │ CVE-2024-37890      │ HIGH     │ fixed    │ 7.4.6             │ 5.2.4, 6.2.3, 7.5.10, 8.17.1 │ nodejs-ws: denial of service when handling a request with    │
│                                     │                     │          │          │                   │                              │ many HTTP headers...                                         │
│                                     │                     │          │          │                   │                              │ https://avd.aquasec.com/nvd/cve-2024-37890                   │
└─────────────────────────────────────┴─────────────────────┴──────────┴──────────┴───────────────────┴──────────────────────────────┴──────────────────────────────────────────────────────────────┘

/juice-shop/build/lib/insecurity.js (secrets)
=============================================
Total: 1 (HIGH: 1, CRITICAL: 0)

HIGH: AsymmetricPrivateKey (private-key)
════════════════════════════════════════
Asymmetric Private Key
────────────────────────────────────────
 /juice-shop/build/lib/insecurity.js:47 (added by 'COPY --chown=65532:0 /juice-shop . # bui')
────────────────────────────────────────
  45   const z85 = __importStar(require("z85"));
  46   exports.publicKey = node_fs_1.default ? node_fs_1.default.readFileSync('encryptionkeys/jwt.pub', 'ut
  47 [ ----BEGIN RSA PRIVATE KEY-----****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************-----END RSA PRIVATE
  48   const hash = (data) => node_crypto_1.default.createHash('md5').update(data).digest('hex');
────────────────────────────────────────



/juice-shop/lib/insecurity.ts (secrets)
=======================================
Total: 1 (HIGH: 1, CRITICAL: 0)

HIGH: AsymmetricPrivateKey (private-key)
════════════════════════════════════════
Asymmetric Private Key
────────────────────────────────────────
 /juice-shop/lib/insecurity.ts:23 (added by 'COPY --chown=65532:0 /juice-shop . # bui')
────────────────────────────────────────
  21   
  22   export const publicKey = fs ? fs.readFileSync('encryptionkeys/jwt.pub', 'utf8') : 'placeholder-publi
  23 [ ----BEGIN RSA PRIVATE KEY-----****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************-----END RSA PRIVATE
  24   
────────────────────────────────────────

```

2. **Analyze results**:
    - Identify:
    - The total number of CRITICAL vulnerabilities
    - 2 vulnerable package names
    - The most common vulnerability type

3. **Clean up**:

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

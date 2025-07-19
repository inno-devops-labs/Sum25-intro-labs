# Lab 9 

## Task 1 Results
- Juice Shop vulnerabilities found (Medium): 2
- Most interesting vulnerability found: Low уровень "Dangerous JS Functions", указывает на функцию с именем `bypassSecurityTrustHtml`
- Security headers present: Нет, как раз одна из двух Medium проблем о том, что headers не установлены

![alt text](<screenshots/Снимок экрана от 2025-07-19 19-30-54.png>) \
![alt text](<screenshots/Снимок экрана от 2025-07-19 19-31-14.png>)


## Task 2 Results
- Critical vulnerabilities in Juice Shop image: 0 Critical и 1 High. Также Critical есть в Node.js, но в Juice shop не нашел
- Vulnerable packages: 
   1. libc6 (High)
- Dominant vulnerability type: CVE

![alt text](<screenshots/image copy.png>)
# Lab 2 
# Task 1: Understanding Version Control Systems

## Commit Object  
**Command**  
```  
git cat-file -p 8ec252c8d1d33ba58ecfeb1cbed307c15bafc43e  
```  
**Output**  
```  
tree d1c28b8c52dae6527b82f13ffaba103fd52b6e85
parent a43f35b33123d573b146cd008965f7e8ffcd5e1b
author anntorkot <sadrievaav@gmail.com> 1749550117 +0300
committer anntorkot <sadrievaav@gmail.com> 1749550429 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgo6P5k7R8Av3WNRrqnyc3qoFoG0
 w/3sllaA1jW7WWHOUAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQCHoFBFu4tjc7obGWwGOclHwu7wMKPeIBzkhFQ6XdP5PuhdR8o7UFqD8Oj4t+NyxOI
 DQ0AMySsnlUnvvnml7ng4=
 -----END SSH SIGNATURE-----

Test SSH signature  
```  
**Explanation**  
Commit-объект хранит ссылку на tree-объект, метаданные (автор, дата) и сообщение коммита.

---

## Tree Object  
**Command**  
```  
git cat-file -p d1c28b8c52dae6527b82f13ffaba103fd52b6e85  
```  
**Output**  
```  
100644 blob ede183da8ef201e5f5737eea502edc77fd8a9bdc	README.md
100644 blob ac9e7a231061add35465853a044b0f7ba1f32166	check.txt
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e	lab1.md
100644 blob 2f55474cb16ac9d18a31bdfaa6b15e9ed5d29343	submission1.md  
```  
**Explanation**  
Tree-объект содержит список файлов в каталоге и их blob-хеши.

---

## Blob Object  
**Command**  
```  
git cat-file -p ede183da8ef201e5f5737eea502edc77fd8a9bdc 
```  
**Output**  
DevOps Introduction Course: Learn the Fundamentals of DevOps
# DevOps Introduction Course: Learn the Fundamentals of DevOps

Welcome to the DevOps Introduction Course, where you will gain a solid foundation in DevOps principles and practical skills. This course is designed to provide you with a comprehensive understanding of DevOps and its key components. Through hands-on labs and lectures, you will learn about various topics such as version control, software distribution, CI/CD, containers, and cloud computing.

## Course Overview

In this course, we will cover the following topics:

1. Introduction to DevOps: Understand the core principles and concepts of DevOps.
2. Tooling: Explore the essential tools used in the DevOps ecosystem.
3. Version Control: Learn about version control systems and their importance in collaborative software development.
4. Software Distribution: Gain insights into software distribution strategies and best practices.
5. GitOps & SRE: Discover the principles of GitOps and Site Reliability Engineering (SRE).
6. Operating Systems & Networking: Get familiar with operating systems and networking fundamentals in a DevOps context.
7. Virtualization: Understand the concepts and benefits of virtualization in modern IT infrastructures.
8. Containers: Dive into containerization technologies like Docker and container orchestration with Kubernetes.
9. CI/CD: Explore continuous integration and continuous deployment practices.
10. Cloud Computing: Learn about cloud platforms and their integration with DevOps workflows.

## Lab Instructions and Grading

To ensure hands-on learning, this course includes practical labs. Each lab has specific tasks that need to be completed for grading purposes. The labs contribute 80% to your final grade, while a final exam accounts for the remaining 20%.

Here are some guidelines and rules for lab submissions:

- You need to submit each lab and achieve a minimum score of 6/10 to pass the course.
- Attending all lectures, practices, and submitting all lab assignments exempts you from the final exam and earns you extra points.
- To create a lab submission, create a new branch in your forked repository specifically for that lab.
- Complete the lab tasks in your branch and submit a pull request (PR) to the main branch of the course repository.
- Only the last commit of your PR before the deadline will be checked and graded.
- The deadline for lab submissions will be discussed and communicated.

## Grading and Grades Distribution

- **Labs**: 80% of the final grade  
- **Final Exam**: 20% of the final grade  

Grade ranges:  
- 90–100 — A  
- 75–89 — B  
- 60–74 — C  
- 0–59  — D  

Each lab is marked out of 10 points. Completing the main tasks correctly will earn you the maximum of 10 points. However, if you're short on time or unable to complete all tasks, you can still achieve a minimum of 6 points by completing a subset of tasks.

Submission Policy
It's essential to submit your lab results on time to maximize your grading. Late submissions will receive a maximum score of 6 points for the corresponding lab. Remember, submitting all labs is a requirement to pass the course successfully.

We look forward to embarking on this DevOps learning journey together and helping you build valuable skills for your career. 
**Explanation**  
Blob-объект хранит «сырые» данные файла без каких-либо метаданных.

# Task 2: Practice with Git Reset Command
### **git log --oneline после трёх коммитов** 
```
24ea64c Third commit
440ce5b Second commit
3db9af2 First commit
```

### **git reflog** 

**Command:**  
```
git reflog
```
**Output:**
```
440ce5b (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD@{2}
3db9af2 HEAD@{1}: checkout: moving from git-reset-practice to git-reset-practice
3db9af2 HEAD@{2}: reset: moving to HEAD~1
440ce5b (HEAD -> git-reset-practice) HEAD@{3}: reset: moving to HEAD~1
24ea64c HEAD@{4}: commit: Third commit
```

 

# Lab 2 
## Task 1: Understanding Version Control Systems

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
The commit object stores a reference to the tree object, metadata (author, date), and a commit message.

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
The Tree object contains a list of files in the directory and their blob hashes.

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
A blob object stores the raw data of a file without any metadata.

## Task 2: Practice with Git Reset Command
### **git log --oneline** 
```
a711acb Third commit
56e2277 Second commit
0d9a0dc First commit
```
###  git reset --soft HEAD~1
**git status**:
```
On branch lab2-reset-practice
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   file.txt
```
**git log --oneline** :
```
56e2277 Second commit
0d9a0dc First commit
```
### git reset --hard HEAD~1
**Command:**  
```
git reset --hard HEAD~1
```

**git status**:
```
On branch lab2-reset-practice
nothing to commit, working tree clean
```

**git log --oneline** :
```
0d9a0dc First commit
```

### **git reflog** 

**Command:**  
```
git reflog
```
**Output:**
```
0d9a0dc HEAD@{0}: reset: moving to HEAD~1
56e2277 HEAD@{1}: reset: moving to HEAD~1
a711acb HEAD@{2}: commit: Third commit
56e2277 HEAD@{3}: commit: Second commit
0d9a0dc HEAD@{4}: commit: First commit
```
### git reset --hard HEAD@{2}
**Command:**  
```
git reset --hard 'HEAD@{2}'
```
**git status**:
```
On branch lab2-reset-practice
nothing to commit, working tree clean
```
**git log --oneline** :
```
a711acb Third commit
56e2277 Second commit
0d9a0dc First commit
```
## Task 3: Visualizing Git Commit History

### 1. Create Several Commits
**Commands:**  
```
echo "Commit A" > history.txt
git add history.txt
git commit -m "Commit A"

echo "Commit B" >> history.txt
git add history.txt
git commit -m "Commit B"

echo "Commit C" >> history.txt
git add history.txt
git commit -m "Commit C"
```
**Commit messages:** 
Commit C
Commit B
Commit A

### 2. View Simple Commit Graph
**Command:**
```
git log --oneline --graph --all
```
**Graph snippet:**
```
* c2c9bea Commit C
* 1f6a3bd Commit B
* 71fe7da Commit A
* a711acb Third commit
* 56e2277 Second commit
* 0d9a0dc First commit
```

### 3. Optional Branching
**Command:**
```
git checkout -b side-branch
echo "Branch commit" >> history.txt
git add history.txt
git commit -m "Side branch commit"
git checkout master
```

### 4. View Commit Graph with Branch
**Command:**
```
git log --oneline --graph --all | head -n7
```
**Graph snippet:**
```
* fd2476c Side branch commit
* c2c9bea Commit C
* 1f6a3bd Commit B
* 71fe7da Commit A
* a711acb Third commit
* 56e2277 Second commit
* 0d9a0dc First commit
```

### 5. Reflection
Visualizing history with the --graph flag allows you to quickly see which commits were made on the main branch and which were made on branches, making it easier to analyze branches and merges when collaborating.

## Task 4: Tagging a Commit
### 1. Create and Push v1.0.0

**Tag name:** `v1.0.0`  
**Commit hash:** `c2c9bea270e6b382108e5fe6f4fac34e0735a9fd`  

**Commands:**  
```
git checkout lab2-reset-practice
git rev-parse HEAD               # outputs c2c9bea270e6b382108e5fe6f4fac34e0735a9fd
git tag v1.0.0
git push origin v1.0.0
```

### 2. Create a New Commit and Tag v1.1.0
**Commands:**  
```
echo "Practice v1.1.0 update" >> history.txt
git add history.txt
git commit -m "Practice update for v1.1.0"
git rev-parse HEAD               # outputs 8d9344be41572bf644f89e6cea80a6336ddc8b20
git tag v1.1.0
git push origin v1.1.0
```
Tag name: v1.1.0
Commit hash: 8d9344be41572bf644f89e6cea80a6336ddc8b20

### 3. Why Tagging Matters
Tagging specific commits creates immutable "milestones" in your project’s history.

- It makes it easy to reference and check out exact release points.

- CI/CD systems can trigger pipelines based on tags.

- Release notes map directly to tagged versions.

  

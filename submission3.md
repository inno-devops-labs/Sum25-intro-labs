# Task 1: Git Object Investigation

tree ea4441646ee9472a98a9173d936cfdcf47cb2440
parent fbd31df851e9b5bcee2678814e230ea92636e05d
author ALEKSANDR <miklin92@bk.ru> 1749036535 +0300
committer ALEKSANDR <miklin92@bk.ru> 1749036535 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgRJG5BWERiqQlxt9HK5niV8BaEt
 3JQVA1bzR/9fnBxMAAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQOLwHjPIf+uWE8eOUPHgODsaoZjAG9dXOvE4z0ev7px4akjdhE+grijZvZhR545euL
 PhJs+McOp7uwnkiJyKYAE=
 -----END SSH SIGNATURE-----

Update file1

100644 blob 5e20fea11bcb6e951534cb22e3afb1ad714227b4    file1.txt
100644 blob 2248c7e5e941afc9968905a23199552b30933474    file2.txt

Hello, i am new here
New line

# Task 2: Git Reset Practice

# Actions Performed

# Branch created: "git-reset-practice"

git checkout -b git-reset-practice

# Created 3 commits

echo "Start" > reset-demo.txt
git add reset-demo.txt
git commit -m "Reset commit 1"

echo "Step 2" >> reset-demo.txt
git add reset-demo.txt
git commit -m "Reset commit 2"

echo "Step 3" >> reset-demo.txt
git add reset-demo.txt
git commit -m "Reset commit 3"

# Soft and hard reset performed and a new commit created:


123@123-▒▒ MINGW64 ~/git-lab2 (git-reset-practice)
$ git reset --soft HEAD~1

123@123-▒▒ MINGW64 ~/git-lab2 (git-reset-practice)
$ git status
On branch git-reset-practice
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   reset-demo.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        submission3.md

# A new commit was created after the soft reset:

123@123-▒▒ MINGW64 ~/git-lab2 (git-reset-practice)
$ git commit -m "New commit instead of reset commit 3"
[git-reset-practice efd894c] New commit instead of reset commit 3
 1 file changed, 1 insertion(+)

123@123-▒▒ MINGW64 ~/git-lab2 (git-reset-practice)
$ git reset --hard HEAD~1
HEAD is now at eb3ebb6 Reset commit 2

123@123-▒▒ MINGW64 ~/git-lab2 (git-reset-practice)
$ git status
On branch git-reset-practice
Untracked files:
(use "git add <file>..." to include in what will be committed)
submission3.md


# Checking commit history after hard reset:

$ git log --oneline
eb3ebb6 (HEAD -> git-reset-practice) Reset commit 2
37e6fac Reset commit 1
5ef83ab (main) Update file1
fbd31df Second commit
6546207 First commit


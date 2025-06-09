# Lab 2: Version Control

## Task 1: Understanding Version Control Systems

### Commands

List current log history:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git log
commit 4db366c7dfcd6bb9da9f854d8039926593a19632 (HEAD -> lab-02)
Author: Danil Andreev <61481131+FleshRazer@users.noreply.github.com>
Date:   Sun Jun 8 12:09:54 2025 +0300

    lab2 add submission file

commit 3dd1718fc2372ae838773f8f780807faa26995bd (upstream/master, master)
Author: Dmitriy Creed <creed@soramitsu.co.jp>
Date:   Thu Jun 5 17:49:49 2025 +0300

    lab2 Git
    
    Signed-off-by: Dmitriy Creed <creed@soramitsu.co.jp>

commit 0fea98cc519f60820f4c54f514b1596d5bf145b5 (origin/master, origin/HEAD)
Author: Dmitriy Creed <creed@soramitsu.co.jp>
Date:   Sun Jun 1 22:25:33 2025 +0300

    lab2 Git
    
    Signed-off-by: Dmitriy Creed <creed@soramitsu.co.jp>

commit a107866e91af12c22ef78d4c7ad53ae39135ef43
Author: Dmitriy Creed <creed@soramitsu.co.jp>
Date:   Thu May 29 20:48:58 2025 +0300

    lab1 Intro
    
    Signed-off-by: Dmitriy Creed <creed@soramitsu.co.jp>
```

List blobs and subtrees referenced by "lab2 Git" commit:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git ls-tree 3dd1718fc2372ae838773f8f780807faa26995bd
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
```

List blobs and subtrees referenced by the new commit:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git ls-tree 4db366c7dfcd6bb9da9f854d8039926593a19632
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
040000 tree f5089a2c79687a63ea864917977a7fea68a3b45b    dir
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
```

Inspect the commit:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git cat-file -p 4db366c7dfcd6bb9da9f854d8039926593a19632
tree e09b5bba51358046a5036d09c1081005a8387e5b
parent 3dd1718fc2372ae838773f8f780807faa26995bd
author Danil Andreev <61481131+FleshRazer@users.noreply.github.com> 1749373794 +0300
committer Danil Andreev <61481131+FleshRazer@users.noreply.github.com> 1749373794 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgaAkeOWP5wbPkJLnJ2qNAusFKrN
 TJNpJfEiPYDUFjfAEAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQMohKxzXmOdMxZrF0ufIWrkJBatf/VKdpPeg98etAiuzzyMNZjM8w/+cZ685GgJe3x
 ykbhitElwBlD4rynenvw4=
 -----END SSH SIGNATURE-----

lab2 add submission file
```

Inspect the subtree:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git cat-file -p f5089a2c79687a63ea864917977a7fea68a3b45b
100644 blob c15ebc8e860f9cd75ae747b41c250179d3045fe9    submission2.md
```

Inspect the blob:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git cat-file -p c15ebc8e860f9cd75ae747b41c250179d3045fe9
# Lab 2: Version Control
```

### Summary

- **Blobs** store file contents, one blob for each file. Each version of a file is also stored as a separate blob.

- **Trees** represent directory content and structure by referencing blobs and other trees.

- **Commits** represent a repository snapshot at a specific point of time. They reference a single tree object that represents the whole repository, parent commit, and other metadata.

## Task 2: Practice with Git Reset Command

### Commands

Switch to new branch:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git switch -c git-reset-practice
Switched to a new branch 'git-reset-practice'
```

Create mock commits:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % echo "First commit" > file.txt
git add file.txt
git commit -m "First commit"
[git-reset-practice 74e34d1] First commit
 1 file changed, 1 insertion(+)
 create mode 100644 file.txt

danilandreev@Danils-MacBook-Air ms24-sum25-devops % echo "Second commit" >> file.txt
git add file.txt
git commit -m "Second commit"
[git-reset-practice 5df285d] Second commit
 1 file changed, 1 insertion(+)

danilandreev@Danils-MacBook-Air ms24-sum25-devops % echo "Third commit" >> file.txt
git add file.txt
git commit -m "Third commit"
[git-reset-practice e36a07d] Third commit
 1 file changed, 1 insertion(+)
```

Perform soft reset to previous commit, then check commit history and working directory:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git reset --soft HEAD~1

danilandreev@Danils-MacBook-Air ms24-sum25-devops % git log --oneline -n 2 
5df285d (HEAD -> git-reset-practice) Second commit
74e34d1 First commit

danilandreev@Danils-MacBook-Air ms24-sum25-devops % git status             
On branch git-reset-practice
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   file.txt
```

Perform hard reset to the previous commit, then check commit history and working directory:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git reset --hard HEAD~1
HEAD is now at 74e34d1 First commit

danilandreev@Danils-MacBook-Air ms24-sum25-devops % git log --oneline -n 1 
74e34d1 (HEAD -> git-reset-practice) First commit

danilandreev@Danils-MacBook-Air ms24-sum25-devops % git status             
On branch git-reset-practice
nothing to commit, working tree clean
```

Check reflog and undo resets:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git reflog
74e34d1 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
5df285d HEAD@{1}: reset: moving to HEAD~1
e36a07d HEAD@{2}: commit: Third commit
5df285d HEAD@{3}: commit: Second commit
74e34d1 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
f1f79b6 (lab-02) HEAD@{5}: checkout: moving from lab-02 to git-reset-practice
f1f79b6 (lab-02) HEAD@{6}: commit: lab2 add task1
4db366c HEAD@{7}: reset: moving to HEAD~
625f79d HEAD@{8}: commit: lab2 update submission
4db366c HEAD@{9}: commit: lab2 add submission file
3dd1718 (upstream/master, master) HEAD@{10}: rebase (finish): returning to refs/heads/lab-02
3dd1718 (upstream/master, master) HEAD@{11}: rebase (start): checkout master
0fea98c (origin/master, origin/HEAD) HEAD@{12}: checkout: moving from master to lab-02
3dd1718 (upstream/master, master) HEAD@{13}: pull upstream master: Fast-forward
0fea98c (origin/master, origin/HEAD) HEAD@{14}: checkout: moving from lab-02 to master
0fea98c (origin/master, origin/HEAD) HEAD@{15}: reset: moving to HEAD
0fea98c (origin/master, origin/HEAD) HEAD@{16}: reset: moving to HEAD~
f62eac4 HEAD@{17}: commit: lab2 add submission file
0fea98c (origin/master, origin/HEAD) HEAD@{18}: reset: moving to head~
8138b40 HEAD@{19}: commit: lab2 add submission file
0fea98c (origin/master, origin/HEAD) HEAD@{20}: checkout: moving from master to lab-02
0fea98c (origin/master, origin/HEAD) HEAD@{21}: checkout: moving from lab-01 to master
5a19fb3 (origin/lab-01, lab-01) HEAD@{22}: commit: lab1 add task2
81dde98 HEAD@{23}: commit: lab1 add task1
0fea98c (origin/master, origin/HEAD) HEAD@{24}: reset: moving to HEAD~
f7a4a02 HEAD@{25}: commit: add task 1 solution
0fea98c (origin/master, origin/HEAD) HEAD@{26}: checkout: moving from master to lab-01
0fea98c (origin/master, origin/HEAD) HEAD@{27}: clone: from https://github.com/FleshRazer/ms24-sum25-devops.git

danilandreev@Danils-MacBook-Air ms24-sum25-devops % git reset --hard e36a07d
HEAD is now at e36a07d Third commit

danilandreev@Danils-MacBook-Air ms24-sum25-devops % git log --oneline -n 3        
e36a07d (HEAD -> git-reset-practice) Third commit
5df285d Second commit
74e34d1 First commit
```

### Summary

1. We did soft reset to the previous commit on the branch. This updated HEAD pointer, but kept working directory and staging area as is.
2. We did hard reset to the previous commit on the branch. This updated HEAD pointer, discarded staging area and updated working directory to match the previous commit.
3. We checked the reflog to find the hash of the third commit, and restored everything by resetting head to that commit.

## Task 3: Visualizing Git Commit History

Commit graph:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git log --oneline --graph --all
* 3971236 (side-branch) Side branch commit
* 0f8efb3 (lab-02) Commit C
* 05bec13 Commit B
* a4b96e0 Commit A
* f542a10 lab2 add task2
| * e36a07d (git-reset-practice) Third commit
| * 5df285d Second commit
| * 74e34d1 First commit
|/  
* f1f79b6 lab2 add task1
* 4db366c lab2 add submission file
* 3dd1718 (HEAD -> master, upstream/master) lab2 Git
| * 5a19fb3 (origin/lab-01, lab-01) lab1 add task2
| * 81dde98 lab1 add task1
|/  
* 0fea98c (origin/master, origin/HEAD) lab2 Git
* a107866 lab1 Intro
```

List of commit messages:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git log --oneline --all
3971236 (side-branch) Side branch commit
0f8efb3 (lab-02) Commit C
05bec13 Commit B
a4b96e0 Commit A
f542a10 lab2 add task2
e36a07d (git-reset-practice) Third commit
5df285d Second commit
74e34d1 First commit
f1f79b6 lab2 add task1
4db366c lab2 add submission file
3dd1718 (HEAD -> master, upstream/master) lab2 Git
5a19fb3 (origin/lab-01, lab-01) lab1 add task2
81dde98 lab1 add task1
0fea98c (origin/master, origin/HEAD) lab2 Git
a107866 lab1 Intro
```

Graph visualization helps to see how branches diverge, track contributions, and resolve conflicts.

## Task 4: Tagging a Commit

### Commands

Create and push new tag:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git tag v1.0.0

danilandreev@Danils-MacBook-Air ms24-sum25-devops % git push origin v1.0.0 
Enumerating objects: 22, done.
Counting objects: 100% (22/22), done.
Delta compression using up to 8 threads
Compressing objects: 100% (14/14), done.
Writing objects: 100% (21/21), 4.55 KiB | 4.55 MiB/s, done.
Total 21 (delta 9), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (9/9), done.
To https://github.com/FleshRazer/ms24-sum25-devops.git
 * [new tag]         v1.0.0 -> v1.0.0
```

Check tagged commit hash:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git log -n 1  
commit 0f8efb36a3db35b48990692fd2e365f1293193d1 (HEAD -> lab-02, tag: v1.0.0)
Author: Danil Andreev <61481131+FleshRazer@users.noreply.github.com>
Date:   Sun Jun 8 14:05:22 2025 +0300

    Commit C
```

### Summary

Tagging helps mark important versions so teams can track releases, automate testing/deployment, and keep release notes organized.

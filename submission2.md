# Task 1

## Check commit
```
git cat-file -p 9d216e299b01e25adc1669cd9e1c8563d3b8801c
```
```
tree 93a2d7356180d3dd53fabb3c60cf894dbaae460c
parent 28cd2df748932c4ab2f9ee52d8787aa7f968e3bf
author Vsevolod Kliushev <kadaverciant@gmail.com> 1749489321 +0300
committer Vsevolod Kliushev <kadaverciant@gmail.com> 1749489321 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgURJ+VbGs/oJSSm9eKgXW/VDcac
 aStTUpaliHM8hT/EsAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQCHfZjsbJChTYpoH5J9u0afDasEGcgN52OpBBX33/Z0zXZVPYDEHnrdjxuOvLWcfpU
 /eSkoQt+ckq8CYZkQtYAo=
 -----END SSH SIGNATURE-----

Third commit
```
**Explanation**: Stores hashes of tree, parent commit and commit information itself (commit message and info about author)

## Check tree
```
git cat-file -p 93a2d7356180d3dd53fabb3c60cf894dbaae460c
```
```
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 5b3c010a011b95052efe998176ef18ca8efd4adf    file.txt
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
```
**Explanation**: Represents the directory with all blobs (files), their hashes and permissions

## Check blob
```
git cat-file -p 5b3c010a011b95052efe998176ef18ca8efd4adf
```
```
First commit
Second commit
Third commit
```
**Explanation**: Stores content of the file

# Task 2

## Soft
```
git reset --soft HEAD~1
```
![alt text](image-2.png)
**Explanation**: Removes last commit but keep its changes staged

## Hard
```
git reset --hard HEAD~1
```
```
HEAD is now at 9da3525 First commit
```
![alt text](image-3.png)
**Explanation**: Removes all staged changes and all changes produced by last commit. Also outputs on which commit HEAD is looking

## Ref Log
```
git reflog
```
```
9da3525 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
28cd2df HEAD@{1}: reset: moving to HEAD~1
9d216e2 HEAD@{2}: commit: Third commit
28cd2df HEAD@{3}: reset: moving to HEAD~
710e88e HEAD@{4}: reset: moving to HEAD
710e88e HEAD@{5}: commit: Second commit
28cd2df HEAD@{6}: commit: Second commit
9da3525 (HEAD -> git-reset-practice) HEAD@{7}: commit: First commit
3dd1718 (origin/master, origin/HEAD, master) HEAD@{8}: checkout: moving from master to git-reset-practice
3dd1718 (origin/master, origin/HEAD, master) HEAD@{9}: pull: Fast-forward
0fea98c HEAD@{10}: checkout: moving from 3dd1718fc2372ae838773f8f780807faa26995bd to master
3dd1718 (origin/master, origin/HEAD, master) HEAD@{11}: checkout: moving from git-reset-practice to origin/master
0fea98c HEAD@{12}: checkout: moving from 0fea98cc519f60820f4c54f514b1596d5bf145b5 to git-reset-practice
0fea98c HEAD@{13}: checkout: moving from labs/Lab-01 to origin/master
0031c6b (origin/labs/Lab-01, labs/Lab-01) HEAD@{14}: commit: Add submission1.md
0fea98c HEAD@{15}: checkout: moving from master to labs/Lab-01
0fea98c HEAD@{16}: clone: from https://github.com/Kadaverciant/Sum25-intro-labs.git
```

## Reset --hard to <reflog_hash>
```
git reset --hard 9d216e2
```
```
HEAD is now at 9d216e2 Third commit
```
![alt text](image-4.png)
**Explanation**: Completely restores resetted commit. Also outputs on which commit HEAD is looking

## Git Log
```
git log
```
```
commit 9d216e299b01e25adc1669cd9e1c8563d3b8801c (HEAD -> git-reset-practice)
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:15:21 2025 +0300

    Third commit

commit 28cd2df748932c4ab2f9ee52d8787aa7f968e3bf
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:09:04 2025 +0300

    Second commit

commit 9da35251f3e07a94bbf43640f79a687ec9e1e905
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:08:46 2025 +0300

    First commit
:...skipping...
commit 9d216e299b01e25adc1669cd9e1c8563d3b8801c (HEAD -> git-reset-practice)
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:15:21 2025 +0300

    Third commit

commit 28cd2df748932c4ab2f9ee52d8787aa7f968e3bf
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:09:04 2025 +0300

    Second commit

commit 9da35251f3e07a94bbf43640f79a687ec9e1e905
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:08:46 2025 +0300

    First commit

:...skipping...
commit 9d216e299b01e25adc1669cd9e1c8563d3b8801c (HEAD -> git-reset-practice)
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:15:21 2025 +0300

    Third commit

commit 28cd2df748932c4ab2f9ee52d8787aa7f968e3bf
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:09:04 2025 +0300

    Second commit

commit 9da35251f3e07a94bbf43640f79a687ec9e1e905
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:08:46 2025 +0300

    First commit

commit 3dd1718fc2372ae838773f8f780807faa26995bd (origin/master, origin/HEAD, master)
:...skipping...
commit 9d216e299b01e25adc1669cd9e1c8563d3b8801c (HEAD -> git-reset-practice)
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:15:21 2025 +0300

    Third commit

commit 28cd2df748932c4ab2f9ee52d8787aa7f968e3bf
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:09:04 2025 +0300

    Second commit

commit 9da35251f3e07a94bbf43640f79a687ec9e1e905
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:08:46 2025 +0300

    First commit

commit 3dd1718fc2372ae838773f8f780807faa26995bd (origin/master, origin/HEAD, master)
Author: Dmitriy Creed <creed@soramitsu.co.jp>
:...skipping...
commit 9d216e299b01e25adc1669cd9e1c8563d3b8801c (HEAD -> git-reset-practice)
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:15:21 2025 +0300

    Third commit

commit 28cd2df748932c4ab2f9ee52d8787aa7f968e3bf
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:09:04 2025 +0300

    Second commit

commit 9da35251f3e07a94bbf43640f79a687ec9e1e905
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:08:46 2025 +0300

    First commit

commit 3dd1718fc2372ae838773f8f780807faa26995bd (origin/master, origin/HEAD, master)
Author: Dmitriy Creed <creed@soramitsu.co.jp>
Date:   Thu Jun 5 17:49:49 2025 +0300
:...skipping...
commit 9d216e299b01e25adc1669cd9e1c8563d3b8801c (HEAD -> git-reset-practice)
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:15:21 2025 +0300

    Third commit

commit 28cd2df748932c4ab2f9ee52d8787aa7f968e3bf
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:09:04 2025 +0300

    Second commit

commit 9da35251f3e07a94bbf43640f79a687ec9e1e905
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:08:46 2025 +0300

    First commit

commit 3dd1718fc2372ae838773f8f780807faa26995bd (origin/master, origin/HEAD, master)
Author: Dmitriy Creed <creed@soramitsu.co.jp>
Date:   Thu Jun 5 17:49:49 2025 +0300

:
commit 9d216e299b01e25adc1669cd9e1c8563d3b8801c (HEAD -> git-reset-practice)
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:15:21 2025 +0300

    Third commit

commit 28cd2df748932c4ab2f9ee52d8787aa7f968e3bf
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:09:04 2025 +0300

    Second commit

commit 9da35251f3e07a94bbf43640f79a687ec9e1e905
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:08:46 2025 +0300

    First commit

commit 3dd1718fc2372ae838773f8f780807faa26995bd (origin/master, origin/HEAD, master)
Author: Dmitriy Creed <creed@soramitsu.co.jp>
Date:   Thu Jun 5 17:49:49 2025 +0300
:
commit 9d216e299b01e25adc1669cd9e1c8563d3b8801c (HEAD -> git-reset-practice)
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:15:21 2025 +0300

    Third commit

commit 28cd2df748932c4ab2f9ee52d8787aa7f968e3bf
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:09:04 2025 +0300

    Second commit

commit 9da35251f3e07a94bbf43640f79a687ec9e1e905
Author: Vsevolod Kliushev <kadaverciant@gmail.com>
Date:   Mon Jun 9 20:08:46 2025 +0300

    First commit

commit 3dd1718fc2372ae838773f8f780807faa26995bd (origin/master, origin/HEAD, master)
Author: Dmitriy Creed <creed@soramitsu.co.jp>
```
**Explanation**: This command shows all actions that was performed

# Task 3

## Commit graph
```
git log --oneline --graph --all
```
```
* 84a1989 (HEAD -> git-reset-practice) Commit C
* a05c53f Commit B
* f2d2909 Commit A
* 9d216e2 Third commit
* 28cd2df Second commit
* 9da3525 First commit
* 3dd1718 (origin/master, origin/HEAD, master) lab2 Git
| * 0031c6b (origin/labs/Lab-01, labs/Lab-01) Add submission1.md
|/  
| * f441cdc (origin/Lab-01) Fix submission1.md
| * 65c277a Fix submission1.md
| * 06088fc Fix submission1.md
| * af8ba9a Add submission1.md
|/  
* 0fea98c lab2 Git
* a107866 lab1 Intro
```
## Optional Branchin
```
git log --oneline --graph --all
```
```
* 1a8a67d (side-branch) Side branch commit
* 84a1989 (git-reset-practice) Commit C
* a05c53f Commit B
* f2d2909 Commit A
* 9d216e2 Third commit
* 28cd2df Second commit
* 9da3525 First commit
* 3dd1718 (HEAD -> master, origin/master, origin/HEAD) lab2 Git
| * 0031c6b (origin/labs/Lab-01, labs/Lab-01) Add submission1.md
|/  
| * f441cdc (origin/Lab-01) Fix submission1.md
| * 65c277a Fix submission1.md
| * 06088fc Fix submission1.md
| * af8ba9a Add submission1.md
|/  
* 0fea98c lab2 Git
* a107866 lab1 Intro
```

## Explanation

As we can see, such graph helps to see, what work which person did. It helps to understand overall state of your repository.

# Task 4
## The tag name(s) created.
```
v1.0.0
```
## The command(s) used.
```
git tag v1.0.0
git push origin v1.0.0
```
## The associated commit hash(es).
```
84a198935cd7bb15a2f29993dd31da6d7cf48109
```
## Value of tagging in software development
**Explanation**: Actually using tags is very usefull in software development. On my work this tags helps to define and use different versopna of company platform libriries. Since migration from one to another might influence significant project modifications, tags allows soft transition without breaking current working versions. Tags also helps to understand the importance of new version minor/major.

# Task 5: GitHub Social Interactions
Starring repos is very important. Usually, the more stars, the more reliable and usefull open source repositoty is, especially in open source projects.

Also following people helps to be in context of what person is currently doing and not to miss any important changes. Maybe you'll also be able to contribute in his project.

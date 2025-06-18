# Task 1: Understanding Version Control Systems

- git cat-file -p <blob_hash>
Prints the contents of a file (blob object). Shows the actual file data stored at that hash.
```bash
# git ls-tree HEAD README.md  # Directly get blob hash of README.md
git cat-file -p af7fda8ea32b60578a1103ce061a50d7f6f09a35

# DevOps Introduction Course: Learn the Fundamentals of DevOps

Welcome to the DevOps Introduction Course, where you will gain a solid foundation in DevOps principles and practical skills. This course is designed to provide you with a comprehensive understanding of DevOps and its key components. Through hands-on labs and lectures, you will learn about various topics such as version control, software distribution, CI/CD, containers, and cloud computing.
...
```

- git cat-file -p <tree_hash>
Prints the directory structure (tree object). Lists files/subdirectories with their permissions, types, and hashes.
```bash
# git ls-tree HEAD:./  # Inspect './' directory
# No directories in this repo
# 100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
# 100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
# 100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
# 100644 blob ee82f41affad8007c973c86a36a1a765332c68a8    lab3.md
```

- git cat-file -p <commit_hash>
Prints commit metadata. Shows author, date, commit message, and parent commit hash(es), plus the root tree hash for the snapshot.
```bash
# git rev-parse HEAD   # Directly get HEAD's commit hash
git cat-file -p e97e227389e1e76ebc881aa1aff3560469d356e3

tree a633650a1bf66fe809ea6ac45d594268d2ac5462
parent 3dd1718fc2372ae838773f8f780807faa26995bd
author Dmitriy Creed <creed@soramitsu.co.jp> 1749905857 +0300
committer Dmitriy Creed <creed@soramitsu.co.jp> 1749905857 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgpI1gCp6xYZHxTcaJQoIBFt1czX
 sk7920Nox85cTfRuIAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQJ5Gd7hahTItOhXPbD+rraGi0xcIscjfdfBKdpRqdT15ygmzcNC0AhWcCW2QLljejT
 RtrE+6CcUdpY5kpZQRDwE=
 -----END SSH SIGNATURE-----

Publish lab3 CI

Signed-off-by: Dmitriy Creed <creed@soramitsu.co.jp>
```

# Task 2: Practice with Git Reset Command

1. Created a series of three commits on a new branch. Obtained the file `file.txt`:
```text
First commit
Second commit
Third commit

```


2. `git reset --soft HEAD~1`
Moves the branch pointer back to the previous commit (Second commit), but keeps both the staging area and working directory unchanged. The changes from the Third commit appear as staged but uncommitted changes.
```sh
git reflog
132cf5f (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
b0ba3ec HEAD@{1}: commit: Third commit
132cf5f (HEAD -> git-reset-practice) HEAD@{2}: commit: Second commit
97bf35e HEAD@{3}: commit: First commit
da07dab (lab02) HEAD@{4}: checkout: moving from lab02 to git-reset-practice
...
```
```sh
git log
commit 132cf5f542db42e238063fd7386f1dc2258b7273 (HEAD -> git-reset-practice)
Author: Vladimir Makharev <v.makharev@yandex.ru>
Date:   Tue Jun 17 21:26:19 2025 +0300

    Second commit

commit 97bf35e12f7a71503642855076396bd441b47aba
Author: Vladimir Makharev <v.makharev@yandex.ru>
Date:   Tue Jun 17 21:26:12 2025 +0300

    First commit

commit da07dab406b114011568bb781b3e0270934d3f7c (lab02)
Author: Vladimir Makharev <v.makharev@yandex.ru>
Date:   Tue Jun 17 21:23:18 2025 +0300

    task 01 commit
...
```
3. `git reset --hard HARD~1`
Resets the branch pointer to the First commit and forcibly updates both the staging area and working directory to match this commit. All changes from the Second and Third commits are discarded.
```sh
git reflog
97bf35e HEAD@{3}: reset: moving to HEAD~1
132cf5f HEAD@{4}: reset: moving to HEAD~1
b0ba3ec (HEAD -> git-reset-practice) HEAD@{5}: commit: Third commit
132cf5f HEAD@{6}: commit: Second commit
97bf35e HEAD@{7}: commit: First commit
da07dab (lab02) HEAD@{8}: checkout: moving from lab02 to git-reset-practice
```
```sh
git log
commit 97bf35e12f7a71503642855076396bd441b47aba
Author: Vladimir Makharev <v.makharev@yandex.ru>
Date:   Tue Jun 17 21:26:12 2025 +0300

    First commit

commit da07dab406b114011568bb781b3e0270934d3f7c (lab02)
Author: Vladimir Makharev <v.makharev@yandex.ru>
Date:   Tue Jun 17 21:23:18 2025 +0300

    task 01 commit
```
4. Returning back to "Third commit"
Moves the branch pointer directly to the Third commit (by its hash) and updates the staging area and working directory to exactly match this commit state. Restores all changes from the Third commit.
```sh
git reset --hard b0ba3ec
HEAD is now at b0ba3ec Third commit
```

# Task 3: Visualizing Git Commit History

1. Created a series of three commits on a new branch. Obtained the file `history.txt`:
```text
Commit A
Commit B
Commit C

```
2. Visualising commit history graph:
```sh
git log --oneline --graph --all
* a5dd262 (HEAD -> lab02) Commit C
* f697901 Commit B
* f5da185 Commit A
* 3a32799 task 02 commit
| * b0ba3ec (git-reset-practice) Third commit
| * 132cf5f Second commit
| * 97bf35e First commit
|/  
* da07dab task 01 commit
| * f28f91c (origin/lab01, lab01) feat: signed commit with merging strategies comparison
| * d47189e feat: first signed commit
|/  
* e97e227 (origin/master, origin/HEAD, master) Publish lab3 CI
* 3dd1718 lab2 Git
* 0fea98c lab2 Git
* a107866 lab1 Intro
```

This graph shows the commit history, including commit hashes, messages, and their order. It also visualizes branches with their names and lines indicating their origin. Pointers like HEAD (local) and origin/master, origin/HEAD, master (remote) mark the current positions.

# Task 4: Tagging a Commit

1. On the current branch (lab02) I tagged latest commit (of previous task) with `v1.0.0` using command:
```sh
git tag v1.0.0
```
2. Pushed the changes with new tag using command:
```sh
git push origin v1.0.0
...
 * [new tag]         v1.0.0 -> v1.0.0
 ```
Tagging commits help to trigger actions in CI/CD pipeline by special keywords in the tag.
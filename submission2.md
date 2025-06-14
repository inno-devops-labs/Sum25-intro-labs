# Task 1: Understanding Version Control Systems

0) I created a new branch for this task
```bash
$ git checkout -b lab2
```
1) I created and commited a file.txt
```bash
$ touch file.txt
$ echo "Some info for commit" > file.txt
$ git add file.txt
$ git commit -m "Some commit"
[lab2 0d9bfa4] Some commit
 1 file changed, 1 insertion(+)
 create mode 100644 file.txt
```
2) Git log say:
```bash
$ git log
commit 0d9bfa46baca9dd6ecdc6bf1dbddefca3e392a0f (HEAD -> lab2)
Author: Dm1stry <BattleshipWriter@yandex.ru>
Date:   Fri Jun 13 16:10:10 2025 +0300

    Some commit
```
3) Used git cat-file on different git objects:

```bash
$ git cat-file -p 0d9bfa46b
tree 2f413c9e02d4806d4b15e48f73d90354a8b30795
parent 533b4c235eba3cb3bc56e2d3b797f3fa3dc4bd77
author Dm1stry <BattleshipWriter@yandex.ru> 1749820210 +0300
committer Dm1stry <BattleshipWriter@yandex.ru> 1749820210 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
<secret gpg signaure info>
 -----END SSH SIGNATURE-----

Some commit
```

Here I've got metadata info of commit including info about tree and parent. Now we can explore the tree

```bash
$ git cat-file -p 2f413c9e02d48
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob e6f8a56f72fe99db5abdb2da60a4519a25d90e32    file.txt
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
100644 blob 8a60305746f9e54e2a6267cc3a73eb9d7124ad57    submission1.md
```

Here I've got hashes of previous committed files in tree and type of it's git objects

```bash
$ git cat-file -p e6f8a56f7
Some info for commit
```

And after inspecting of blob we can get change that blob carries

# Task 2: Practice with Git Reset Command

1) First of all I've created a branch and switched to it:
```bash
$ git checkout -b git-reset-practice
Switched to a new branch 'git-reset-practice'
```

2) Then i created three commits (I'm a little lazy, so i made it by script):
```sh
#!/bin/bash
echo "First commit" > file.txt
git add file.txt
git commit -m "First commit"

echo "Second commit" >> file.txt
git add file.txt
git commit -m "Second commit"

echo "Third commit" >> file.txt
git add file.txt
git commit -m "Third commit"
```
So it looked like:
```bash
$ ./script.sh 
warning: in the working copy of 'file.txt', LF will be replaced by CRLF the next time Git touches it
[git-reset-practice ac44572] First commit
 1 file changed, 1 insertion(+), 1 deletion(-)
warning: in the working copy of 'file.txt', LF will be replaced by CRLF the next time Git touches it
[git-reset-practice 0c58fc2] Second commit
 1 file changed, 1 insertion(+)
warning: in the working copy of 'file.txt', LF will be replaced by CRLF the next time Git touches it
[git-reset-practice f645d31] Third commit
 1 file changed, 1 insertion(+)
 ```

3) Then I've explored `git reset --soft`:
```bash
$ git reset --soft HEAD~1

$ git status
On branch git-reset-practice
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   file.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   submission2.md

$ git log
commit 0c58fc2bf2c5a13a2a50aacccd1dfbdcd294d3f1 (HEAD -> git-reset-practice)
Author: Dm1stry <BattleshipWriter@yandex.ru>
Date:   Fri Jun 13 16:40:24 2025 +0300

    Second commit

commit ac44572d77b10f0d3f140e5866e5a280cf76ffaa
Author: Dm1stry <BattleshipWriter@yandex.ru>
Date:   Fri Jun 13 16:40:23 2025 +0300

    First commit

$ git reflog
0c58fc2 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
f645d31 HEAD@{1}: commit: Third commit
0c58fc2 (HEAD -> git-reset-practice) HEAD@{2}: commit: Second commit
ac44572 HEAD@{3}: commit: First commit
314f020 (origin/master, origin/HEAD, master) HEAD@{4}: checkout: moving from master to git-reset-practice
```

So after `git reset --soft` changes remin staged and just HEAD moved back/

Then I've tried `git reset --hard`:
```bash
$ git status
On branch git-reset-practice
nothing to commit, working tree clean

$ git log
commit ac44572d77b10f0d3f140e5866e5a280cf76ffaa (HEAD -> git-reset-practice)
Author: Dm1stry <BattleshipWriter@yandex.ru>
Date:   Fri Jun 13 16:40:23 2025 +0300

    First commit

$ git reflog
ac44572 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
0c58fc2 HEAD@{1}: reset: moving to HEAD~1
f645d31 HEAD@{2}: commit: Third commit
0c58fc2 HEAD@{3}: commit: Second commit
ac44572 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
314f020 (origin/master, origin/HEAD, master) HEAD@{5}: checkout: moving from master to git-reset-practice
```

So after `git reset --hard` changes are completely erased from files too

4) Then i've recovered commits using reflog:
```bash
$ git reflog
ac44572 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
0c58fc2 HEAD@{1}: reset: moving to HEAD~1
f645d31 HEAD@{2}: commit: Third commit
0c58fc2 HEAD@{3}: commit: Second commit
ac44572 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
314f020 (origin/master, origin/HEAD, master) HEAD@{5}: checkout: moving from master to git-reset-practice

$ git reset --hard f645d31
HEAD is now at f645d31 Third commit
```

And all changes are back, so even after `git reset --hard` it's possible to get your changes back

# Task 3: Visualizing Git Commit History
0) I've created a new branch and moved to it
```bash
$ git checkout -b lab2-task3
Switched to a new branch 'lab2-task3'
```

1) I've created commits:
```sh
#!/bin/bash

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

```bash
$ ./script.sh 
warning: in the working copy of 'history.txt', LF will be replaced by CRLF the next time Git touches it
[lab2-task3 9a10c85] Commit A
 1 file changed, 1 insertion(+)
 create mode 100644 history.txt
warning: in the working copy of 'history.txt', LF will be replaced by CRLF the next time Git touches it
[lab2-task3 5ce3886] Commit B
 1 file changed, 1 insertion(+)
warning: in the working copy of 'history.txt', LF will be replaced by CRLF the next time Git touches it
[lab2-task3 9363617] Commit C
 1 file changed, 1 insertion(+)
```

2) Then i've explored the Commit Graph:
> Yeah, i've needed to fix some stuff between the steps

```bash
$ git log --oneline --graph --all
* 9ad261a (HEAD -> lab2-task3) small fix
* 9363617 Commit C
* 5ce3886 Commit B
* 9a10c85 Commit A
*   e9c331f (origin/master, origin/HEAD, master) Lab2 Task 2 Git reset practice complete (#3)
|\
| * 2a03b7d (origin/git-reset-practice, git-reset-practice) file.txt deleted and submission2.md updated
| * f645d31 Third commit
| * 0c58fc2 Second commit
| * ac44572 First commit
|/
*   314f020 Lab2 Task 1 complete (#2)
|\
| * b4a3fca (origin/lab2, lab2) Task 1 in Lab2 complete
| * 0d9bfa4 Some commit
|/
*   533b4c2 Lab 1[homework] Merge strategies summary added and commit are signed (#1)
|\
| * 586a4fd (origin/homework, homework) Submission 1 file created and summary written
|/
* 3dd1718 lab2 Git
* 0fea98c lab2 Git
* a107866 lab1 Intro
```

3) Then following the task I created a new branch to see what changes would appear in the commit graph

```bash
$ git checkout -b side-branch
Switched to a new branch 'side-branch'

$ echo "Branch commit" >> history.txt

$ git add history.txt

$ git commit -m "Side branch commit"
[side-branch 37b9cc2] Side branch commit
 1 file changed, 1 insertion(+)

$ git checkout lab2-task3
M       submission2.md
Switched to branch 'lab2-task3'
```

4) And then I again displayed commit history:
```bash
$ git log --oneline --graph --all
* 37b9cc2 (side-branch) Side branch commit
* 9ad261a (HEAD -> lab2-task3) small fix
* 9363617 Commit C
* 5ce3886 Commit B
* 9a10c85 Commit A
*   e9c331f (origin/master, origin/HEAD, master) Lab2 Task 2 Git reset practice complete (#3)
|\
| * 2a03b7d (origin/git-reset-practice, git-reset-practice) file.txt deleted and submission2.md updated
| * f645d31 Third commit
| * 0c58fc2 Second commit
| * ac44572 First commit
|/
*   314f020 Lab2 Task 1 complete (#2)
|\
| * b4a3fca (origin/lab2, lab2) Task 1 in Lab2 complete
| * 0d9bfa4 Some commit
|/
*   533b4c2 Lab 1[homework] Merge strategies summary added and commit are signed (#1)
|\
| * 586a4fd (origin/homework, homework) Submission 1 file created and summary written
|/
* 3dd1718 lab2 Git
* 0fea98c lab2 Git
* a107866 lab1 Intro
```

Visualization of branching and histrory helps to understand work in better way and reduce errors.
# Solution to Lab 2

by Dmitry Beresnev <d.beresnev@innopolis.university>

## Task 1

To display the blob hashes I use

```bash
git ls-tree HEAD
```

which results in

```text
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob df2328140b07882ea4ac53192aee403f5b2d31ab    commit_generator.sh
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
100644 blob 4bb4900818c1275f06b8996529dbcb3c0e9199bc    random.txt
```

To find a branch hash I use

```bash
git rev-parse lab2
```

which results in

```text
eb1f95a74781f346e337a0f40cec80693bfafca6
```

Finally, to find a tree hash I use

```bash
git cat-file -p eb1f95a74781f346e337a0f40cec80693bfafca6
```

which results in

```text
tree bc61f7ddff9797e4ca5083bad80745c1778d7695
parent ea14b4250de45d7e5320338e2bef7877c769d23b
author dsomni <pro100pro10010@gmail.com> 1749488583 +0300
committer dsomni <pro100pro10010@gmail.com> 1749488583 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgR1OEyAFzkl5AtbHQKhVOpPssNT
 J+nFypOoR5ynhpXnIAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQHqova+IYunGHZ7R6+feZUYsapw65SX/qmW7S50xMrt1ijwHsAo2lg4Ssp4bEZuzc+
 AP/6zQyfnNVmGDWo9qrQk=
 -----END SSH SIGNATURE-----

Add [commit generator] global
```

### Exploring blob

```bash
git cat-file -p 4bb4900818c1275f06b8996529dbcb3c0e9199bc
```

results in

```text
tdbdg
nGAyV
```

Therefore, a **blob** represents the raw content of a file

### Exploring tree

```bash
git cat-file -p 4bb4900818c1275f06b8996529dbcb3c0e9199bc
```

results in

```text
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob df2328140b07882ea4ac53192aee403f5b2d31ab    commit_generator.sh
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
100644 blob 4bb4900818c1275f06b8996529dbcb3c0e9199bc    random.txt
```

Therefore, a **tree** represents the root directory with the following information about files/directories (blobs):

- permission
- blob hash
- filename

### Exploring commit

```bash
git cat-file -p ea14b4250de45d7e5320338e2bef7877c769d23b
```

results in

```text
tree 55aa1c359596027b7f9b641b34febe666585afce
parent 45371d783799ba13a5572238c5f83f60c12efc32
author dsomni <pro100pro10010@gmail.com> 1749488548 +0300
committer dsomni <pro100pro10010@gmail.com> 1749488548 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgR1OEyAFzkl5AtbHQKhVOpPssNT
 J+nFypOoR5ynhpXnIAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQJyWg2prTwtd/i0XbhdySQaIPWgJ70L5dIeJYdjlmwHXCQsKmL2EzUmZKSpQjS0bzy
 BTZHvderuKRqkSjpVxMwM=
 -----END SSH SIGNATURE-----

Add [nGAyV] random.txt
```

Therefore, a **commit** contains the metadata about the snapshot:

- tree hash of the commit
- parent (previous) commit hash (if any)
- who made the commit and when (with ssh signature)
- commit message

## Task 2

### Soft reset

```bash
git reset --soft HEAD~1
```

This command reverts the last commit and unstage changes made in it.
So now there are only "First commit" and "Second commit" in tree, and staged `file.txt`.

### Hard reset

```bash
git reset --hard HEAD~1
```

This command reverts the last commit and clear all staged changes. So now there are only "First commit" in tree, and nothing is staged.

### Recovering

```bash
git reflog
```

returns

```text
ca6d247 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
b9c340a HEAD@{1}: reset: moving to HEAD~1
befd019 HEAD@{2}: commit: Third commit
b9c340a HEAD@{3}: commit: Second commit
ca6d247 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
1aab261 (origin/lab2, origin/git-reset-practice, lab2) HEAD@{5}: reset: moving to HEAD~1
b4df42d HEAD@{6}: reset: moving to HEAD~1
c98e2bb HEAD@{7}: reset: moving to HEAD~1
c478519 HEAD@{8}: reset: moving to HEAD
c478519 HEAD@{9}: reset: moving to HEAD
c478519 HEAD@{10}: reset: moving to HEAD
c478519 HEAD@{11}: reset: moving to HEAD
c478519 HEAD@{12}: reset: moving to HEAD
c478519 HEAD@{13}: commit: Third commit
c98e2bb HEAD@{14}: commit: Second commit
b4df42d HEAD@{15}: commit: First commit
1aab261 (origin/lab2, origin/git-reset-practice, lab2) HEAD@{16}: checkout: moving from lab2 to git-reset-practice
1aab261 (origin/lab2, origin/git-reset-practice, lab2) HEAD@{17}: checkout: moving from git-reset-practice to lab2
1aab261 (origin/lab2, origin/git-reset-practice, lab2) HEAD@{18}: checkout: moving from lab2 to git-reset-practice
1aab261 (origin/lab2, origin/git-reset-practice, lab2) HEAD@{19}: checkout: moving from git-reset-practice to lab2
1aab261 (origin/lab2, origin/git-reset-practice, lab2) HEAD@{20}: checkout: moving from lab2 to git-reset-practice
1aab261 (origin/lab2, origin/git-reset-practice, lab2) HEAD@{21}: checkout: moving from git-reset-practice to lab2
b312eb3 HEAD@{22}: reset: moving to HEAD
b312eb3 HEAD@{23}: reset: moving to HEAD
b312eb3 HEAD@{24}: commit: Third commit
2ed777c HEAD@{25}: commit: Second commit
75d7a59 HEAD@{26}: commit: First commit
1aab261 (origin/lab2, origin/git-reset-practice, lab2) HEAD@{27}: checkout: moving from lab2 to git-reset-practice
```

which is history of changes in tree.

```bash
git reset --hard b312eb3
```

Recovers state after the "Third commit". Now all the commits are in tree and nothing is staged.

### Log

```bash
git log
```

returns

```text
commit b312eb393ea5cc732822484826eeaf539d649770 (HEAD -> git-reset-practice)
Author: dsomni <pro100pro10010@gmail.com>
Date:   Mon Jun 9 20:28:59 2025 +0300

    Third commit

commit 2ed777c45b087e0c96bbde9501fc843494a65411
Author: dsomni <pro100pro10010@gmail.com>
Date:   Mon Jun 9 20:28:59 2025 +0300

    Second commit

commit 75d7a59268634eb08112ca81d04a9bbdabb3a58f
Author: dsomni <pro100pro10010@gmail.com>
Date:   Mon Jun 9 20:28:59 2025 +0300

    First commit

commit 1aab26173ef43ca2c247a7fa57e764819337eb86 (origin/lab2, origin/git-reset-practice, lab2)
Author: dsomni <pro100pro10010@gmail.com>
Date:   Mon Jun 9 20:27:52 2025 +0300

    Add [task1] submission2.md

commit eb1f95a74781f346e337a0f40cec80693bfafca6
Author: dsomni <pro100pro10010@gmail.com>
Date:   Mon Jun 9 20:03:03 2025 +0300

    Add [commit generator] global

commit ea14b4250de45d7e5320338e2bef7877c769d23b
Author: dsomni <pro100pro10010@gmail.com>
Date:   Mon Jun 9 20:02:28 2025 +0300

    Add [nGAyV] random.txt

commit 45371d783799ba13a5572238c5f83f60c12efc32
Author: dsomni <pro100pro10010@gmail.com>
Date:   Mon Jun 9 20:02:28 2025 +0300

    Add [tdbdg] random.txt

commit 3dd1718fc2372ae838773f8f780807faa26995bd (origin/master, origin/HEAD, master)
Author: Dmitriy Creed <creed@soramitsu.co.jp>
Date:   Thu Jun 5 17:49:49 2025 +0300

    lab2 Git

    Signed-off-by: Dmitriy Creed <creed@soramitsu.co.jp>

commit 0fea98cc519f60820f4c54f514b1596d5bf145b5
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

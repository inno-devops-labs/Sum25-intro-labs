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
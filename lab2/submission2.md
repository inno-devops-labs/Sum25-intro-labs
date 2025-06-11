# Version Control

## Task 1: Understanding Version Control Systems

### Blob (Binary Large Object)

Blob is a raw file content (not the file name, not the path, just the content)

I added a title to the `submission2.md` file and commited that change.

```txt
❯ git ls-tree HEAD
100644 blob cf82bccef811740ae45601c1b4a0fe247b35dfce    submission2.md

❯ git cat-file -p cf82bccef811740ae45601c1b4a0fe247b35dfce
# Version Control
```

### Tree

- A directory listing: file names, file modes, and pointers to blobs and subtrees
- Acts like a UNIX directory, mapping names to blobs (files) or other trees (subdirectories)

```txt
❯ git ls-tree HEAD
100644 blob c53739c1581e02d94316e080fb2d7d5e5879ebad    .markdownlint.yaml
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
040000 tree c9d77be51decd725bec1566cd455a233276c1d5f    lab1
100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
040000 tree 506d1ac1b38743a91e588974f0b0878925b1460e    lab2

❯ git cat-file -p 506d1ac1b38743a91e588974f0b0878925b1460e
100644 blob 2e2ab7970f076892d95205a157f8d5dad0200b57    submission2.md
```

The blob hash changed cause I commited a blob part of `submission2.md`.

````txt
❯ git cat-file -p 2e2ab7970f076892d95205a157f8d5dad0200b57
# Version Control

## Task 1: Understanding Version Control Systems

### Blob (Binary Large Object)

Blob is a raw file content (not the file name, not the path, just the content)

I added a title to the `submission2.md` file and commited that change.

```
❯ git ls-tree HEAD
100644 blob cf82bccef811740ae45601c1b4a0fe247b35dfce    submission2.md

❯ git cat-file -p cf82bccef811740ae45601c1b4a0fe247b35dfce
# Version Control
```
````

### Commit

- A snapshot of the tree
- The parent commit(s)
- Author/committer info and commit message

My last commit was `add: tree part`

```txt
❯ git log --oneline
57fb092 (HEAD -> lab2) add: tree part
01c20d8 add: blob part
1b1f11b add: submission2.md title
```

The contents of `57fb092` commit

```txt
tree 8dbe3e3202f9739ee0e0e9afbbd76f96fd7045cf
parent 01c20d8696d3702618fa540ab16b412e02cf9329
author Samat Gatin <gatin-05@bk.ru> 1749667735 +0300
committer Samat Gatin <gatin-05@bk.ru> 1749667735 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 ...<some signature>...
 -----END SSH SIGNATURE-----

add: tree part
```

## Task 2: Practice with Git Reset Command

### 1. Undo last commit but keep changes (Uncommit)

```bash
git reset --soft HEAD~1
```

- Keeps both staged and working directory changes
- Removes commit but lets you re-edit message or modify content

### 2. Undo last commit and unstage files

```bash
git reset --mixed HEAD~1
```

- Keeps working directory changes
- Unstages all files

### 3. Undo last commit and delete changes

```bash
git reset --hard HEAD~1
```

- Discards changes in the commit and in your working directory
- Use with caution — it's destructive

### 4. Use git reflog to recover commits after a reset

```bash
git reflog
git reset --hard <reflog_hash>
```

### Practice of reset process

```txt
❯ git reset --soft HEAD~1
> 

❯ git reflog
256241d (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
f889ca5 HEAD@{1}: commit: add: Third commit
256241d (HEAD -> git-reset-practice) HEAD@{2}: commit: add: Second commit
db7921d (origin/git-reset-practice) HEAD@{3}: reset: moving to HEAD~1
4c3a659 HEAD@{4}: commit: Second commit
db7921d (origin/git-reset-practice) HEAD@{5}: commit: add: First commit
c1cdcfc (origin/lab2, lab2) HEAD@{6}: checkout: moving from lab2 to git-reset-practice
c1cdcfc (origin/lab2, lab2) HEAD@{7}: reset: moving to HEAD
c1cdcfc (origin/lab2, lab2) HEAD@{8}: reset: moving to HEAD
c1cdcfc (origin/lab2, lab2) HEAD@{9}: commit: add: commit part
57fb092 HEAD@{10}: commit: add: tree part
01c20d8 HEAD@{11}: reset: moving to HEAD~1
6b556c7 HEAD@{12}: commit: add: add tree part

❯ git reset --hard f889ca5
HEAD is now at f889ca5 add: Third commit
```

- I reset `Third commit` and went back to it
- In `git reflog` u can see that I changed commit massage of `Second commit` before

# Lab Submission: Version Control

## Task 1: Understanding Git Objects

### 

```fish
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> echo "This is the content of my first file." > sample_file.txt

ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git add sample_file.txt

ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git commit -m "Add sample_file.txt"

[lab1-complete db850ca] Add sample_file.txt
 1 file changed, 1 insertion(+)
 create mode 100644 sample_file.txt
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git log -1

commit db850ca5a9000a8abc0ec2e6079c2daf37b292c0 (HEAD -> lab1-complete)
Author: hvostcheduser <yogik_iz_gretsii@mail.ru>
Date:   Thu Jun 12 22:02:22 2025 +0300

    Add sample_file.txt
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git cat-file -p db850ca
tree f487458f8b211e2eb232c6dff9e9d1fdb8343979
parent 5f4a7d66c6c4bd166a915ae9576f83af0abab17e
author hvostcheduser <yogik_iz_gretsii@mail.ru> 1749754942 +0300
committer hvostcheduser <yogik_iz_gretsii@mail.ru> 1749754942 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAAZcAAAAHc3NoLXJzYQAAAAMBAAEAAAGBALEPoQliCMbdiPoBbo+OI+
 GwDfI+LPPKs8ETxT2kle7Az2pGH9wRC4Kfxw0+NbP8rI2kJa1PsY8T0+QKEr1JWM2x88hQ
 y/g/PuM/fHnFF2DGn88YQEC2AN2Hg+4m9eMhgY6AwNeDUgZQq0k3I6zmzd7Uha5TfTqhJz
 n5f5TpPHR7tKLmWoM5a3GLiVk5DW/EXXpxB/bd4B+m4L3s+MXyxobFOeORcjFgdmwjwOsF
 b4Bx5hrZEoP7vXSkYHWWXwELaprok58bl+VfSV3CDrQGHZnTbdI49PJD04+w3ZXbbbShcy
 H0J1zBm2qhBTV8d6GKYMGlPwufGIZMVVCvq+3Nc0/IwWHNVFbEsTXPTB7tFmdL5jEfXzw+
 erHnosgixoyyZ5yDo/aHjTR25r1cd2qnslVdIGPXeCGCZV7mlEHWrOwIKCbsj2ASUAYAWA
 OMgiHLr9ZjNBmY44qZp0QOf8P2ZWPUTehuhdLCTYwsG/1ICz4gk0MZ2CxycJcDkyptvd1o
 KwAAAANnaXQAAAAAAAAABnNoYTUxMgAAAZQAAAAMcnNhLXNoYTItNTEyAAABgGE6gaHfz+
 J7QD4Q4HiDSyWPtSCl/uezIjwhjVYBLEKqyiOMhU43whjOjXI+7YLTHQiVh7K/eRdlSKNz
 SdhmpYiExxtHfWv36Do/3kj1b1v9UCaP0tpetRCOCP57x4+IuFLIr/hXTjkpYl/kHJp3zV
 88bj9J/P486mXijSzbyTkDgbIbBPSHPHABrHJgbqenJhD664BPht3Mt4GUx/HLfU/l06Aw
 nQDx4CFxCfHe80NV9rlYwldpJRePiAMkqnsw2kkirx2VHXJ4BMFKT9HZtYX6PujxlbcYjf
 3wwffxfJlgvnswhezYmb3PXY7kanPGN/yzeb5WTVvq5ADT80A5Q4oiSZTM0swK7E/hGz5Z
 yDXnOr96jNs5bkUMsx9Ecn+hWS/rzuWubTfOfj+dPnW4prOKaE4VymPPlgGid+x6qci9qa
 NlSr+YAImqJXiL8slc0qOaKk7bsXKkgto4FsCyBKw14qFgfzP3LcYKjmwiiiTcwix4ESwy
 1ILtlxMv9FIqdw==
 -----END SSH SIGNATURE-----

Add sample_file.txt
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git cat-file -p f487458f8b211e2eb232c6dff9e9d1fdb8343979

100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35	README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e	lab1.md
100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb	lab2.md
100644 blob aababaf2aa910e866351989eb7b4981213c91814	sample_file.txt
100644 blob 1e42f316d822175c17245a9490123d1e9cab6add	submission1.md
@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git cat-file -p aababaf2aa910e866351989eb7b4981213c91814
This is the content of my first file.
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> touch submission2.md


```


## Task 2: Git Reset Practice ### Initial State The `git-reset-practice` branch was created with three commits.

```fish
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git checkout -b git-reset-practice
Переключились на новую ветку «git-reset-practice»
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> echo "First commit" > file.txt
  git add file.txt
  git commit -m "First commit"

  echo "Second commit" >> file.txt
  git add file.txt
  git commit -m "Second commit"

  echo "Third commit" >> file.txt
  git add file.txt
  git commit -m "Third commit"
[git-reset-practice 005e28b] First commit
 1 file changed, 1 insertion(+)
 create mode 100644 file.txt
[git-reset-practice 987a9f6] Second commit
 1 file changed, 1 insertion(+)
[git-reset-practice 45c43b2] Third commit
 1 file changed, 1 insertion(+)
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git log --oneline
45c43b2 (HEAD -> git-reset-practice) Third commit
987a9f6 Second commit
005e28b First commit
db850ca (lab1-complete) Add sample_file.txt
5f4a7d6 (origin/lab1-complete) Task 2: Add summary of merge strategies
c3e8e15 Task 1: Add summary of signed commits benefits
0fea98c (origin/master, origin/HEAD, master) lab2 Git
a107866 lab1 Intro
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git reset --soft HEAD~1
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git log --oneline
  git status
987a9f6 (HEAD -> git-reset-practice) Second commit
005e28b First commit
db850ca (lab1-complete) Add sample_file.txt
5f4a7d6 (origin/lab1-complete) Task 2: Add summary of merge strategies
c3e8e15 Task 1: Add summary of signed commits benefits
0fea98c (origin/master, origin/HEAD, master) lab2 Git
a107866 lab1 Intro
Текущая ветка: git-reset-practice
Изменения, которые будут включены в коммит:
  (используйте «git restore --staged <файл>...», чтобы убрать из индекса)
	изменено:      file.txt

Неотслеживаемые файлы:
  (используйте «git add <файл>...», чтобы добавить в то, что будет включено в коммит)
	submission2.md

ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git commit -m "Third commit (re-committed)"
[git-reset-practice 2123526] Third commit (re-committed)
 1 file changed, 1 insertion(+)
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git reset --hard HEAD~1
Указатель HEAD сейчас на коммите 987a9f6 Second commit
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git log --oneline
  git status
987a9f6 (HEAD -> git-reset-practice) Second commit
005e28b First commit
db850ca (lab1-complete) Add sample_file.txt
5f4a7d6 (origin/lab1-complete) Task 2: Add summary of merge strategies
c3e8e15 Task 1: Add summary of signed commits benefits
0fea98c (origin/master, origin/HEAD, master) lab2 Git
a107866 lab1 Intro
Текущая ветка: git-reset-practice
Неотслеживаемые файлы:
  (используйте «git add <файл>...», чтобы добавить в то, что будет включено в коммит)
	submission2.md

индекс пуст, но есть неотслеживаемые файлы
(используйте «git add», чтобы проиндексировать их)
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git reflog
987a9f6 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
2123526 HEAD@{1}: commit: Third commit (re-committed)
987a9f6 (HEAD -> git-reset-practice) HEAD@{2}: reset: moving to HEAD~1
45c43b2 HEAD@{3}: commit: Third commit
987a9f6 (HEAD -> git-reset-practice) HEAD@{4}: commit: Second commit
005e28b HEAD@{5}: commit: First commit
db850ca (lab1-complete) HEAD@{6}: checkout: moving from lab1-complete to git-reset-practice
db850ca (lab1-complete) HEAD@{7}: commit: Add sample_file.txt
5f4a7d6 (origin/lab1-complete) HEAD@{8}: commit: Task 2: Add summary of merge strategies
c3e8e15 HEAD@{9}: commit: Task 1: Add summary of signed commits benefits
0fea98c (origin/master, origin/HEAD, master) HEAD@{10}: reset: moving to HEAD~1
a3cdf61 HEAD@{11}: commit: Task 1: Add summary of signed commits benefits (with correct allowed_signers)
0fea98c (origin/master, origin/HEAD, master) HEAD@{12}: reset: moving to HEAD~1
87c323f HEAD@{13}: commit: benefits of signed commits section in my submission
0fea98c (origin/master, origin/HEAD, master) HEAD@{14}: reset: moving to HEAD~1
335a90f HEAD@{15}: commit: benefits of signed commits section in my submission
0fea98c (origin/master, origin/HEAD, master) HEAD@{16}: checkout: moving from master to lab1-complete
0fea98c (origin/master, origin/HEAD, master) HEAD@{17}: clone: from github.com:HvostchedUser/Sum25-intro-labs.git
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git reset --hard HEAD@{1}
Указатель HEAD сейчас на коммите 2123526 Third commit (re-committed)
ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> 

```

## Task 3: Visualizing Git History

### Commit Graph


```fish

ivan@hp-spectre-x360 /home/ivan/Projects/Sum25-intro-labs  
> git log --oneline --graph --all
* eca38fc (HEAD -> master) Commit C
* 8c50b92 Commit B
* f5865f4 Commit A
| * 2123526 (git-reset-practice) Third commit (re-committed)
| * 987a9f6 Second commit
| * 005e28b First commit
| * db850ca (lab1-complete) Add sample_file.txt
| * 5f4a7d6 (origin/lab1-complete) Task 2: Add summary of merge strategies
| * c3e8e15 Task 1: Add summary of signed commits benefits
|/  
* 0fea98c (origin/master, origin/HEAD) lab2 Git
* a107866 lab1 Intro


```

## Task 4: Tagging a Commit

*   **Tag Name:** `v1.0.0`
*   **Command Used:** `git tag v1.0.0` and `git push origin v1.0.0`
*   **Associated Commit Hash:** `eca38fc62a3c4553480913a88f5830b8ebe6eae1`

**Value of Tagging:** Tagging is valuable for creating stable release points in a project's history. It allows developers to check out a specific version and triggers automated build and deployment pipelines.

## Bonus Task: GitHub Social Interactions

Social features like starring and following build community and make it easier to discover projects and good developers. Following team members helps keep track of their contributions and activity across different repositories.

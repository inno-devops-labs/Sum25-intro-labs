## LAB 2
Nikita Yaneev n.yaneev@innopolis.unversity

New commit

### TASK 1

git cat-file -p <blob_hash> 

*This command shows the contents of the file.* 

``` 
git cat-file -p 6a0cf3824c3ebaa6ab9478ab7e65f9637e7fddd3
```
```
## LAB 2
Nikita Yaneev n.yaneev@innopolis.unversity

New commit
```

git cat-file -p <tree_hash>

*This command shows the structure of the files in the branch.*

```
git cat-file -p 678feae4e1a3ac5f29e79d96f33138eb48d56fdc
```

```
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 3dce38ab2076903506fd82f0668aa89cef32275b    image.png
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
100644 blob 6db11f151d8dce37cdc908e92d0af9610319b198    submission1.md
100644 blob 6a0cf3824c3ebaa6ab9478ab7e65f9637e7fddd3    submission2.md

```

git cat-file -p <commit_hash>

*This command shows us the general structure of the branch, its metadata , author, and last commit.*


```
git cat-file -p 3594ebf40ffc1b251a8259bfdfc536eda6459551
```

```

tree 678feae4e1a3ac5f29e79d96f33138eb48d56fdc
parent ab0afaa4fb04d0a9be328f964f78911c4cc22b58
author adbedlam <nyaneev@yandex.ru> 1749488972 +0300
committer adbedlam <nyaneev@yandex.ru> 1749488972 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgYGh7eh3bGznPAgFVCM0GiniQpZ
 v5OI0/PWM8sTc+AysAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQF1+I2pkcC76T0m3B4m3AYJPBZQJFo+9nEEWsk7oAgIZM+vhpocG5sd8hh+r0+EdBJ
 vredPc3eTKIDnjCAz1eAw=
 -----END SSH SIGNATURE-----

add commit

```

### TASK 2

1. `git checkout -b git-reset-practice`

2. 
```
echo "First commit" > file.txt
git add file.txt
git commit -m "First commit"
```
Content of filt.txt:

```
First commit

```

```
echo "Second commit" >> file.txt
git add file.txt
git commit -m "Second commit"
```

Content after the second commit
```
First commit
Second commit
```


```
echo "Third commit" >> file.txt
git add file.txt
git commit -m "Third commit"

```

Content after the third commit

```
First commit
Second commit
Third commit
```

3. After `git reset --soft HEAD~1`
We stage the last commit, just canceled last command `git commit`

4. If we use `git reset --hard HEAD~1` it's delete last commit and all stages files

5. `git reflog`

```
08c6ef3 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
912d668 HEAD@{1}: reset: moving to HEAD~1
1c4857e HEAD@{2}: commit: Third commit
912d668 HEAD@{3}: commit: Second commit
08c6ef3 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
```

6. `git log`

```
commit 08c6ef311ec78eaaf1c7f87028c1869d2a335615 (HEAD -> git-reset-practice)
Author: adbedlam <nyaneev@yandex.ru>
Date:   Mon Jun 9 20:41:16 2025 +0300

    First commit

commit 3be9ee457a039d5b19638eb2e07c3a597b264810
Author: adbedlam <nyaneev@yandex.ru>
Date:   Mon Jun 9 20:40:52 2025 +0300

    rem

commit cc98465c65e6db52348917688a8b3575db98b8e0 (origin/git-reset-practice)
Author: adbedlam <nyaneev@yandex.ru>
Date:   Mon Jun 9 20:32:52 2025 +0300

    Second commit

commit c2961c57b01af51538bb5aa560f3ab40a1b4bdaa
Author: adbedlam <nyaneev@yandex.ru>
Date:   Mon Jun 9 20:32:31 2025 +0300
:
commit 08c6ef311ec78eaaf1c7f87028c1869d2a335615 (HEAD -> git-reset-practice)
Author: adbedlam <nyaneev@yandex.ru>
Date:   Mon Jun 9 20:41:16 2025 +0300

    First commit

commit 3be9ee457a039d5b19638eb2e07c3a597b264810
Author: adbedlam <nyaneev@yandex.ru>
Date:   Mon Jun 9 20:40:52 2025 +0300

    rem

commit cc98465c65e6db52348917688a8b3575db98b8e0 (origin/git-reset-practice)
Author: adbedlam <nyaneev@yandex.ru>
Date:   Mon Jun 9 20:32:52 2025 +0300

    Second commit

commit c2961c57b01af51538bb5aa560f3ab40a1b4bdaa
Author: adbedlam <nyaneev@yandex.ru>
Date:   Mon Jun 9 20:32:31 2025 +0300
```

### TASK 3

1. 
```
echo "Commit A" > history.txt
git add history.txt

```

```
echo "Commit B" >> history.txt
git add history.txt
git commit -m "Commit B"
```

```
echo "Commit C" >> history.txt
git add history.txt
git commit -m "Commit C"
```

2. `git log --oneline --graph --all`

```
* 668f421 (HEAD -> git-reset-practice) Commit C
* a0bb5fc Commit B
* e7e8865 Commit A
* 50053f2 (origin/git-reset-practice) Add task2
* 08c6ef3 First commit
* 3be9ee4 rem
* cc98465 Second commit
* c2961c5 First commit
* f841697 small fixes
* c02f6fd add task1
* fab1b52 First commit
* 3594ebf add commit
* ab0afaa new commit
* 6366a50 (origin/lab2) add submission.md
*   7b48717 (origin/master, origin/HEAD, master) Merge branch 'master' of https://github.com/adbedlam/Sum25-intro-labs
|\
| *   7fae309 Merge branch 'inno-devops-labs:master' into master
| |\
| | * 0fea98c lab2 Git
* | | d2f04b4 Add task 2
|/ /
:

```

```
* ac318bd (HEAD -> side-branch) Side branch commit
* 668f421 (git-reset-practice) Commit C
* a0bb5fc Commit B
* e7e8865 Commit A
* 50053f2 (origin/git-reset-practice) Add task2
* 08c6ef3 First commit
* 3be9ee4 rem
* cc98465 Second commit
* c2961c5 First commit
* f841697 small fixes
* c02f6fd add task1
* fab1b52 First commit
* 3594ebf add commit
* ab0afaa new commit
* 6366a50 (origin/lab2) add submission.md
*   7b48717 (origin/master, origin/HEAD, master) Merge branch 'master' of https://github.com/adbedlam/Sum25-intro-labs
|\
| *   7fae309 Merge branch 'inno-devops-labs:master' into master
| |\
| | * 0fea98c lab2 Git
* | | d2f04b4 Add task 2
|/ /
* / 41a2e59 Signed commit
|/
* a107866 lab1 Intro

```

With this view, you can intuitively understand the structure of each branch and its committees.


### TASK 4

1. `git tag v1.0.0`

2. `git push origin v1.0.0`
```
Enumerating objects: 10, done.
Counting objects: 100% (10/10), done.
Delta compression using up to 8 threads
Compressing objects: 100% (7/7), done.
Writing objects: 100% (9/9), 1.13 KiB | 1.13 MiB/s, done.
Total 9 (delta 5), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (5/5), completed with 1 local object.
To https://github.com/adbedlam/Sum25-intro-labs.git
 * [new tag]         v1.0.0 -> v1.0.0
```

3. `git tag v1.1.0` with new commit

4. ` git push origin v1.1.0`
```
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 1.10 KiB | 1.10 MiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/adbedlam/Sum25-intro-labs.git
 * [new tag]         v1.1.0 -> v1.1.0
 ```


*Commit hashes:*
- 2640273959e2b8198f9cbbec3cf5b608f3531774

- 668f4210c73ba06c21b8eaf9f8337e837a299541


 Tagging in software development provides clear milestones for versioning, triggers automated CI/CD pipelines, and simplifies release notes by marking specific points in the codebase (e.g., commits, builds, or releases).


 ### TASK 5: GitHub Social Interactions

 Social features on GitHub like discussions, reactions collaboration by making communication transparent and engaging, which helps open-source communities and teams coordinate, share feedback, and build momentum around projects. They also encourage contributions by making interactions more accessible and inclusive.




# Task 1: Understanding Version Control Systems

## Commit Object
```
git cat-file -p 93a9225

tree a17a081db94b628e3702dcdfc8d3e79cca8bd05f
parent e89e1d7e50a9ed71dfb6fd83a800fedb0ed5a827
author someilay <ismilioshyn@gmail.com> 1749758072 +0300
committer someilay <ismilioshyn@gmail.com> 1749758072 +0300

task 1 commit
```
**Explanation:**
The commit object contains metadata about the commit, such as the author, date, commit message, and references to the tree and parent commits.

## Tree Object
```
git cat-file -p a17a081db94b628e3702dcdfc8d3e79cca8bd05f

100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 93f5b7abf48c9066c6caef5bb22525be5de59b12    image-1.png
100644 blob 7130d3356196e7283fb5efdbe2feeb336c16c9d8    image.png
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
100644 blob 0ab3d9306b82333d3d9e67089ac12eaf26198b20    submission1.md
100644 blob 30d74d258442c7c65512eafab474568dd706c430    submission2.md
```
**Explanation:**
The tree object represents a directory listing (snapshot) of the project at a certain point in time. It contains references to blobs (files) and possibly other trees (subdirectories).

## Blob Object
```
git cat-file -p 30d74d258442c7c65512eafab474568dd706c430

test
```
**Explanation:**
The blob object stores the actual contents of a file. It does not contain any metadata about the file name or location—just the file data itself.

# Task 2: Practice with Git Reset Command

## 1. Created a new branch
```
git checkout -b git-reset-practice
Switched to a new branch 'git-reset-practice'
```

## 2. Created a series of commits
```
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

## 3. git log before reset
```
git log --oneline | head -n 3
e2a135e Third commit
d5f6f8d Second commit
ea2e0d2 First commit
```

## 4. Soft reset
```
git reset --soft HEAD~1
git log --oneline | head -n 3
d5f6f8d Second commit
ea2e0d2 First commit
88b1b18 task 1

git status
On branch git-reset-practice
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   file.txt
```
**Explanation:**
`git reset --soft HEAD~1` moves the HEAD pointer back by one commit, but keeps the changes from the removed commit staged (in the index).

## 5. Hard reset
```
git reset --hard HEAD~1
git log --oneline | head -n 3
ea2e0d2 First commit
88b1b18 task 1
93a9225 task 1 commit
```
**Explanation:**
`git reset --hard HEAD~1` moves the HEAD pointer back by one commit and discards all changes in the working directory and index.

## 6. Reflog and recovery
```
git reflog
ea2e0d2 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
d5f6f8d HEAD@{1}: reset: moving to HEAD~1
e2a135e HEAD@{2}: commit: Third commit
d5f6f8d HEAD@{3}: commit: Second commit
ea2e0d2 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
...

git reset --hard e2a135e
HEAD is now at e2a135e Third commit

git log --oneline | head -n 3
e2a135e Third commit
d5f6f8d Second commit
ea2e0d2 First commit
```
**Explanation:**
`git reflog` shows a log of where HEAD and branch references have been. You can use it to recover lost commits. Here, we used `git reset --hard e2a135e` to recover the 'Third commit'.

# Task 3: Visualizing Git Commit History

## Created several commits
```
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

## Commit graph
```
git log --oneline --all --decorate --graph | head -n 10
* fa74a14 (side-branch) Side branch commit
* 4012e01 (HEAD -> master) Commit C
* c5235c2 Commit B
* 86630c4 Commit A
* 2b78673 (origin/master, origin/HEAD) task2
| * 4cb37e9 (origin/git-reset-practice, git-reset-practice) task2
| * e2a135e Third commit
| * d5f6f8d Second commit
| * ea2e0d2 First commit
|/  
```

## Commit messages
```
Side branch commit
Commit C
Commit B
Commit A
task2
Third commit
Second commit
First commit
task 1
task 1 commit
lab 1
lab 1
lab2 Git
lab2 Git
lab1 Intro
```

## Reflection
This visualization helps understand how different branches diverge and merge, making it easier to track collaboration and parallel development in a project. It provides a clear overview of the project's history and structure.

# Task 4

I used commands
```
git tag v1.0.0
git push origin v1.0.0
```

Tagging is valuable in software development because it marks specific points in the project history, such as releases, making it easier to manage versioning, automate CI/CD pipelines, and generate release notes.
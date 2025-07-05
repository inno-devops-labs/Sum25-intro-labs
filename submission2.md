# Understanding Version Control Systems
## Commit object
```bash
git cat-file -p df9cd60cd79cb2b770520c14148a474f113b95da
```
df9cd60cd79cb2b770520c14148a474f113b95da - hash of last commit found by git rev-parse HEAD

### Output:

tree be7836e06c8e5d120a7150ae99aeff7e9d80ae0b

parent 6d5f17e13fffcbe24b9c8b6d80022f11d37caafd

author beleet <mcpokon@gmail.com> 1749758976 +0200

committer beleet <mcpokon@gmail.com> 1749758976 +0200

gpgsig -----BEGIN SSH SIGNATURE-----

\<signature\>

 -----END SSH SIGNATURE-----

Add file2.txt

### Explanation:

The commit object stores a reference to the tree (snapshot), the author and committer, and the message.


## Tree object

```
git cat-file -p be7836e06c8e5d120a7150ae99aeff7e9d80ae0b
```

### Output 

100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md

100644 blob 8b137891791fe96927ad78e64b0aad7bded08bdc    file1.txt

100644 blob 8b137891791fe96927ad78e64b0aad7bded08bdc    file2.txt

100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md

100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md

100644 blob 007e00fafdabb9ae79bec4289ee6af18f4a713a3    submission1.md

### Explanation:

The tree object represents a directory. It lists the files and their associated blob hashes.


## Blob object

```
git cat-file -p af7fda8ea32b60578a1103ce061a50d7f6f09a35
```

Outputs nothing because file is empty

### Explanation:
The blob stores the actual contents of a file, in this case, file1.txt.


# Practice with Git Reset Command

## Step 1: Create Branch
```bash
git checkout -b git-reset-practice
```

## Step 2: Create Commits

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

## git log after third commit:

```
f8bbf7b (HEAD -> git-reset-practice) Third commit
5940203 Second commit
1b4e969 First commit
7c2f05b (origin/master, origin/HEAD, master) submission2
df9cd60 Add file2.txt
6d5f17e Add file1.txt
eb11205 Add merge strategies comparison
880b7e5 Fix email and commit signature
8eca018 submission1.md added
3dd1718 lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro
```

## Step 3: git reset --soft HEAD~1

```
git reset --soft HEAD~1
```

### Explanation:

- HEAD moved back one commit.
- File changes from third commit still in staging.
- git status showed file is staged.


## Step 4: git reset --hard HEAD~1

```
git reset --hard HEAD~1
```

### Explanation:

- HEAD moved back again.
- File content from third commit lost.
- file.txt now has only two lines.

```
git log --oneline
```

```
1b4e969 (HEAD -> git-reset-practice) First commit
7c2f05b (origin/master, origin/HEAD, master) submission2
df9cd60 Add file2.txt
6d5f17e Add file1.txt
eb11205 Add merge strategies comparison
880b7e5 Fix email and commit signature
8eca018 submission1.md added
3dd1718 lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro
```

## Step 5: git reflog

```
git reflog
```

```
1b4e969 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
5940203 HEAD@{1}: reset: moving to HEAD~1
f8bbf7b HEAD@{2}: commit: Third commit
5940203 HEAD@{3}: commit: Second commit
1b4e969 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
7c2f05b (origin/master, origin/HEAD, master) HEAD@{5}: checkout: moving from master to git-reset-practice
7c2f05b (origin/master, origin/HEAD, master) HEAD@{6}: commit: submission2
df9cd60 HEAD@{7}: commit: Add file2.txt
6d5f17e HEAD@{8}: commit: Add file1.txt
eb11205 HEAD@{9}: commit: Add merge strategies comparison
880b7e5 HEAD@{10}: commit: Fix email and commit signature
8eca018 HEAD@{11}: commit: submission1.md added
3dd1718 HEAD@{12}: clone: from https://github.com/beleet/Sum25-intro-labs.git
```

## Step 6: Recover using git reset --hard

```
git reset --hard f8bbf7b
```

```
git log --oneline
```

```
f8bbf7b (HEAD -> git-reset-practice) Third commit
5940203 Second commit
1b4e969 First commit
7c2f05b (origin/master, origin/HEAD, master) submission2
df9cd60 Add file2.txt
6d5f17e Add file1.txt
eb11205 Add merge strategies comparison
880b7e5 Fix email and commit signature
8eca018 submission1.md added
3dd1718 lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro
```

```
cat file.txt
```

```
First commit
Second commit
Third commit
```

### Explanation:
- Third commit restored successfully.
- File content back to 3 lines.


# Visualizing Git Commit History

## Commit Messages
- Commit A
- Commit B
- Commit C

## Git Commit Graph Output

```bash
git log --oneline --graph --all
```


```
* c32beb5 (HEAD -> git-reset-practice) Commit C
* 794a27a Commit B
* 192b900 Commit A
* f8bbf7b Third commit
* 5940203 Second commit
* 1b4e969 First commit
* 7c2f05b (origin/master, origin/HEAD, master) submission2
* df9cd60 Add file2.txt
* 6d5f17e Add file1.txt
* eb11205 Add merge strategies comparison
* 880b7e5 Fix email and commit signature
* 8eca018 submission1.md added
* 3dd1718 lab2 Git
* 0fea98c lab2 Git
* a107866 lab1 Intro
```

## Reflection

Visualizing the commit graph helps clearly see how branches diverge and where new work happens. It’s especially helpful in collaborative environments to understand where teammates are working and how to merge work later.

# Task 4: Tagging a Commit

## Tags Created

- **v1.0.0**
  - **Command:** `git tag v1.0.0`
  - **Pushed with:** `git push origin v1.0.0`
  - **Commit Hash:** `a2ba9c6ac456baa1c5d6c516e721e8b29ba2e842`

- **v1.1.0**
  - **Command:** `git tag v1.1.0`
  - **Pushed with:** `git push origin v1.1.0`
  - **Commit Hash:** `e4f521085091fa5495802d8203ea2d36dfe2b64f`

## Value of Tagging in Development

Tagging helps developers mark specific points in history as important (e.g., releases like v1.0.0). Tags are critical for versioning, automating CI/CD pipelines, and generating release notes.

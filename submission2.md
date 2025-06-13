## Task 1: Git Internal Objects

### Commit Object:
```
tree 22ec74f1bb640b6e116768c8349261cb9495af6e
parent c4971855277a50024cddd6f771ffaf4c168552cb
parent c4971855277a50024cddd6f771ffaf4c168552cb
author Danila Moskvitin <ddmoskvitin@gmail.com> 1749826423 +0300
committer Danila Moskvitin <ddmoskvitin@gmail.com> 1749826423 +0300
author Danila Moskvitin <ddmoskvitin@gmail.com> 1749826423 +0300
committer Danila Moskvitin <ddmoskvitin@gmail.com> 1749826423 +0300
```
**Explanation**: Contain commit's metadata - author, data, message and tree object's link.

### Tree Object:
```
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 82053586253caa46096e86b64aef8b0a088007ab    git_internals.txt
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
100644 blob 434d6826ab8f026c30aaef39cbb14f1849fcbd6d    submission1.md
```

### Blob Object:
```
��Hello Git Internals
```
**Explanation**: Contains the actual file request in compressed form.

## Task 2: Git Reset Practice

### Шаги:
1. Create 3 commits:
   - First commit
   - Second commit
   - Third commit

2. `git reset --soft HEAD~1`:
   - **Result**: The last commit was cancelled, changes in staged
   ```bash
   On branch git-reset-practice
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   reset.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        submission2.md
   ```

3. `git reset --hard HEAD~1`:
   - **Result**: Another one commit was cancelled, all changes were deleted
   ```bash
   On branch git-reset-practice
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        submission2.md

nothing added to commit but untracked files present (use "git add" to track)
   ```

4. Restoring by reflog:
   ```bash
   12bb098 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
3426bee HEAD@{1}: reset: moving to HEAD~1
4b00492 HEAD@{2}: commit: Third commit
3426bee HEAD@{3}: commit: Second commit
12bb098 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
8f6eeef (lab2-vcs) HEAD@{5}: checkout: moving from lab2-vcs to git-reset-practice
8f6eeef (lab2-vcs) HEAD@{6}: commit: Understanding Git objects
c497185 (origin/master, origin/HEAD, master) HEAD@{7}: checkout: moving from master to lab2-vcs
c497185 (origin/master, origin/HEAD, master) HEAD@{8}: commit: Added merge strategies comparison
12bb098 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
3426bee HEAD@{1}: reset: moving to HEAD~1
4b00492 HEAD@{2}: commit: Third commit
3426bee HEAD@{3}: commit: Second commit
12bb098 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
8f6eeef (lab2-vcs) HEAD@{5}: checkout: moving from lab2-vcs to git-reset-practice
8f6eeef (lab2-vcs) HEAD@{6}: commit: Understanding Git objects
c497185 (origin/master, origin/HEAD, master) HEAD@{7}: checkout: moving from master to lab2-vcs
c497185 (origin/master, origin/HEAD, master) HEAD@{8}: commit: Added merge strategies comparison
5d7353c HEAD@{9}: commit: Add signed commit for Lab 1
3dd1718 (upstream/master) HEAD@{10}: clone: from https://github.com/DanilaMos/Sum25-intro-labs.git
   ```
   - Restored commit: 4b00492
   - After restoring:
   ```bash
   HEAD is now at 4b00492 Third commit
   ```

## Task 3: Commit History Visualization

### Commits' graph:
```bash
* 870e798 (side-branch) Side branch commit
* 71dfe11 (git-reset-practice) Commit B
* 1822f13 Commit A
* 4b00492 Third commit
* 3426bee Second commit
* 12bb098 First commit
* 8f6eeef (HEAD -> lab2-vcs) Understanding Git objects
* c497185 (origin/master, origin/HEAD, master) Added merge strategies comparison
* 5d7353c Add signed commit for Lab 1
* 3dd1718 (upstream/master) lab2 Git
* 0fea98c lab2 Git
* a107866 lab1 Intro
```

### Commits list:
1. Commit A
2. Commit B
3. Side branch commit


## Task 4: Git Tagging

### Created tag:
1. v1.0.0

### Commands:
```bash
git tag v1.0.0
git push origin v1.0.0
```

### Commit's hash:
8f6eeefa745f4c95213b59363d0994fee8ba00d8
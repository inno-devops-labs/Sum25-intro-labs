## Lab 2 Submission

## Task 1: Understanding Git Object Storage

### Commands used:
```bash
git log --oneline -3
9a9756a (HEAD -> master) another file
f4e6ebd Add test file for git
9b11533 (origin/master, origin/HEAD) Add Task 2: Merge strategies


git cat-file -p 9a97556a
tree c02847d4645c271ffd28d6c5449a26fa6ca6fae7
parent f4e6ebdeb010b1ff061ddb126ee658a9e6887198
author root <mc.mocbka@gmail.com> 1749793152 +0500
committer root <mc.mocbka@gmail.com> 1749793152 +0500
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgX14E43m7ymg9uSkBrTweJq7c+7
 BolF/r42l5z34K+7AAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQFz9C/8NmsgItW6J9fh9/aiiSLrecq4f4yWqx/hIKwgqvI7XK6veM52ZYMb+98kiEL
 bS7r9wzbFgqBmiMeBnsww=
 -----END SSH SIGNATURE-----


git cat-file -p c02847d4645c271ffd28d6c5449a26fa6ca6fae7
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob c3c53659f79e42f533efe7aa2bca0ae992435126    another-file.txt
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
100644 blob 50354a0a5ca2c82175ad57dca910f8d72081bf08    submission1.md
100644 blob 14c8ce326612c32c6f4af5c03931308ffb682fd3    test-file.txt


git cat-file -p c3c53659f79e42f533efe7aa2bca0ae992435126
One more file


## Task 2: Git Reset Command Practice

### Steps performed:

1. **Created commits:**
   - First commit: "First commit"
   - Second commit: "Second commit"  
   - Third commit: "Third commit"

2. **Used `git reset --soft HEAD~1`:**
   - **Result:** 
The latest commit ("Third commit") was removed from the commit history, but its changes remain in the staging area (index).
   - **Files status:**
On branch master
Your branch is ahead of 'origin/master' by 4 commits.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   file.txt

3. **Used `git reset --hard HEAD~2`:**
   - **Result:** 
The last two commits ("Second commit" and "First commit") were removed from the commit history, and all associated changes were discarded from both the staging area and the working directory.
   - **Files content:**
git status             
On branch master
Your branch is ahead of 'origin/master' by 3 comm

4. **Used `git reflog` to recover:**
e3e6974 (HEAD -> master) HEAD@{0}: reset: moving to HEAD~2
0cce87e HEAD@{1}: commit: Third commit
29c3467 HEAD@{2}: reset: moving to HEAD~1
7fb237a HEAD@{3}: commit: Third commit
29c3467 HEAD@{4}: commit: Second commit
e3e6974 (HEAD -> master) HEAD@{5}: commit: First commit
9a9756a HEAD@{6}: commit: another file
f4e6ebd HEAD@{7}: commit: Add test file for git
9b11533 (origin/master, origin/HEAD) HEAD@{8}: commit: Add Task 2: Merge strategies
d673f88 HEAD@{9}: commit: Add Task 1: SSH commit signature verification
0fea98c HEAD@{10}: clone: from https://github.com/m0CbKa/Sum25-intro-labs.git

- **Recovery command:** `git reset --hard 7fb237a`
HEAD is now at 7fb237a Third commit

### Explanation:
- `--soft`: Only moves HEAD, keeps changes in staging area
- `--hard`: Moves HEAD and resets working directory, **DANGEROUS** - loses changes
- `reflog`: Shows history of HEAD movements, allows recovery of "lost" commits


## Task 3: Visualizing Git Commit History

### Commands used:
```bash
git log --oneline --graph --all
* 7bd738f (HEAD -> master) Commit C
* 95cf5f5 Commit B
* dbb3a7a Commit A
* 7fb237a Third commit
* 29c3467 Second commit
* e3e6974 First commit
* 9a9756a another file
* f4e6ebd Add test file for git
* 9b11533 (origin/master, origin/HEAD) Add Task 2: Merge strategies
* d673f88 Add Task 1: SSH commit signature verification
* 0fea98c lab2 Git
* a107866 lab1 Intro


git log --graph --pretty=format:'%h -%d %s (%cr) <%an>' --abbrev-commit --all
* 7bd738f - (HEAD -> master) Commit C (2 minutes ago) <root>
* 95cf5f5 - Commit B (2 minutes ago) <root>
* dbb3a7a - Commit A (3 minutes ago) <root>
* 7fb237a - Third commit (30 minutes ago) <root>
* 29c3467 - Second commit (31 minutes ago) <root>
* e3e6974 - First commit (32 minutes ago) <root>
* 9a9756a - another file (48 minutes ago) <root>
* f4e6ebd - Add test file for git (49 minutes ago) <root>
* 9b11533 - (origin/master, origin/HEAD) Add Task 2: Merge strategies (10 days ago) <root>
* d673f88 - Add Task 1: SSH commit signature verification (10 days ago) <root>
* 0fea98c - lab2 Git (11 days ago) <Dmitriy Creed>
* a107866 - lab1 Intro (2 weeks ago) <Dmitriy Creed>


## Task 4: Tagging Commits

### Tags created:
- **v1.1.0** - Commit hash: 75b9f615bb1601290a64b17e229dbab86820fc5e

### Commands used:
```bash
git tag
git push origin v1.1.0

### Value of GitHub social features:
GitHub's social features help build professional networks and enable developers to discover interesting projects, collaborate more effectively, and stay updated on work from colleagues and the broader open source community.


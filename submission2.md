## Task 1: Understanding Version Control Systems


### Get hash commit
```sh
PS D:\VScode> git log
commit 3883d4c3f482a6793bb8d80305d16d663222917d (HEAD -> master, origin/master, origin/HEAD)
Merge: de0e73d 0fea98c
Author: Valerii QA <60028759+Valeriitsoy@users.noreply.github.com>
Date:   Tue Jun 3 02:45:02 2025 +0300

    Merge branch 'inno-devops-labs:master' into master
```

### Get hash tree
```sh
PS D:\VScode> git cat-file -p 3883d4c3f482a6793bb8d80305d16d663222917d
tree 4a6923bf81efde9cc0a11a4129cf47a64a1f298a
```

### Get hash blob
```sh
PS D:\VScode> git cat-file -p 4a6923bf81efde9cc0a11a4129cf47a64a1f298a
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
100644 blob abf2a48d82ce2c35574e70e2ed40fda2440fa7ab    submission1.md
```

### Get blob
```sh
PS D:\VScode> git cat-file -p abf2a48d82ce2c35574e70e2ed40fda2440fa7ab

**Commit signing provides essential security benefits:**
- Author verification - confirms commits are genuinely from the claimed author.
- Data integrity - ensures commit content hasn't been tampered with.
- Protection against impersonation - prevents malicious commits under someone else's identity.
- Security compliance - meets enterprise security requirements.
- Team trust - builds confidence in code authenticity.

____________________________________________________________________________________
**Strategy Comparison:**

*Standard Merge**
Creates a merge commit combining two branches. Preserves complete history and clearly shows integration points, but can create complex commit graphs.

*Squash and Merge*
Combines all feature branch commits into a single commit. Results in clean linear history but loses detailed development context, making debugging harder.

*Rebase and Merge*
Replays feature commits on top of the target branch. Creates clean history while preserving individual commits, but rewrites history and can complicate collaboration.

*Why the standard merge strategy is often preferred in collaborative environments:*
Standard merge is preferred in collaborative environments because it maintains full context without rewriting history.
This approach supports better debugging, easier rollbacks, and clearer integration tracking. Most CI/CD tools are optimized for merge commits,
and the complete history helps with code reviews and project understanding.
```
_________________________________________________________________________________________________________________________________________________________________________________________

### Explanation:
- Blob: Stores the actual file content.
- Tree: Represents a directory and contains references to blobs and other trees (files and folders).
- Commit: Points to a tree, stores metadata (author, message), and links to parent commits.




## Task 2: Practice with Git Reset Command

```sh
PS D:\VScode> git checkout -b git-reset-practice
Switched to a new branch 'git-reset-practice'
PS D:\VScode> echo "First commit" > file.txt
PS D:\VScode> git add file.txt
PS D:\VScode> git commit -m "First commit"
[git-reset-practice 2cdd095] First commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file.txt
PS D:\VScode> echo "Second commit" >> file.txt
PS D:\VScode> git add file.txt
PS D:\VScode> git commit -m "Second commit"
[git-reset-practice aa22af1] Second commit
 1 file changed, 0 insertions(+), 0 deletions(-)
PS D:\VScode> echo "Third commit" >> file.txt
PS D:\VScode> git add file.txt
PS D:\VScode> git commit -m "Third commit"
[git-reset-practice ff3b723] Third commit
 1 file changed, 0 insertions(+), 0 deletions(-)
PS D:\VScode> git reset --soft HEAD~1
PS D:\VScode> git reset --hard HEAD~1

HEAD is now at 2cdd095 First commit
PS D:\VScode> git reflog

2cdd095 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
aa22af1 HEAD@{1}: reset: moving to HEAD~1
ff3b723 HEAD@{2}: commit: Third commit
aa22af1 HEAD@{3}: commit: Second commit
2cdd095 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
3883d4c (origin/master, origin/HEAD, master) HEAD@{5}: checkout: moving from master to git-reset-practice


PS D:\VScode> git reset --hard ff3b723
HEAD is now at ff3b723 Third commit
```

---------------------------------------------------------------------------------------------------------------------

- reflog is a powerful tool that helps recover lost commits after resets.
- Practicing with reset gives better control over commit history and local state.


## Task 3: Visualizing Git Commit History



### Commit Graph

```sh
PS D:\VScode> git log --oneline --graph --all
* 8c02c1f (HEAD -> git-reset-practice) Commit C
* a50eaf0 Commit B
* 954ce3f Commit A
* e68be0b Third commit
* feef172 Second commit
* ef2401b First commit
*   d7e4f5f (origin/master, origin/HEAD, master) Merge branch 'inno-devops-labs:master' into master
|\
| * 3dd1718 lab2 Git
* | 3883d4c Merge branch 'inno-devops-labs:master' into master
|\|
| * 0fea98c lab2 Git
* | de0e73d Merge Strategies in Git
* | 4e72eab Why Sign Commits?
|/
* a107866 lab1 Intro
```


### Optional Branching

```sh
PS D:\VScode> git log --oneline --graph --all
* ba8355e (side-branch) Side branch commit
* 8c02c1f (git-reset-practice) Commit C
* a50eaf0 Commit B
* 954ce3f Commit A
* e68be0b Third commit
* feef172 Second commit
* ef2401b First commit
*   d7e4f5f (HEAD -> master, origin/master, origin/HEAD) Merge branch 'inno-devops-labs:master' into master
|\
| * 3dd1718 lab2 Git
* | 3883d4c Merge branch 'inno-devops-labs:master' into master
|\|
| * 0fea98c lab2 Git
* | de0e73d Merge Strategies in Git
* | 4e72eab Why Sign Commits?
|/
* a107866 lab1 Intro
```

- The commit graph helps me clearly see when branches diverge and merge, making it easier to understand how different team members contribute in parallel.


## Task 4: Tagging a Commit

```sh
PS D:\VScode> git tag v1.1.0
PS D:\VScode> git push origin v1.1.0
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To https://github.com/Valeriitsoy/Sum25-intro-labs.git
 * [new tag]         v1.1.0 -> v1.1.0
PS D:\VScode> git log
commit d7e4f5fd5cef6b4b6d177253e37c8b42f3f44e41 (HEAD -> master, tag: v1.1.0, tag: v1.0.0, origin/master, origin/HEAD)
Merge: 3883d4c 3dd1718
Author: Valerii QA <60028759+Valeriitsoy@users.noreply.github.com>
Date:   Tue Jun 10 11:50:49 2025 +0300

    Merge branch 'inno-devops-labs:master' into master
```


- Tagging allows developers to mark important points in the project, like stable releases, which is essential for versioning and CI/CD pipelines.
- Git tags make it easier to track versions and automate deployments based on specific release points.



## Bonus Task: GitHub Social Interactions

- GitHub’s social features, like following and starring, help developers stay connected, discover useful projects, and build a professional network in the open source community.
- Social features on GitHub promote knowledge sharing and visibility, which is valuable in both open-source and collaborative team environments.


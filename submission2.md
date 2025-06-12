# Lab 2 Submission: Version Control

This document contains the complete submission for Lab 2 focusing on version control systems and Git.

---

## Task 1: Understanding Version Control Systems

### Git Object Inspection

I explored the Git repository structure using `git cat-file` to inspect various Git objects:

#### 1. Commit Object Inspection
```bash
$ git cat-file -p dba9c4e
tree 036f135e17df16fae53da3a320a93c6260db2f97  
parent 613e64ecc101cb07d564d67275fb114c4b290a5e
author Mousatat <m.mousatat@gmail.com> 1749147397 +0300
committer Mousatat <m.mousatat@gmail.com> 1749147397 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgzZcKEb/+UYN7DLSmd43gVJZN6d
 oAgcCxJIqKf+XMypgAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQJnIMfuskqhe8m3ZIKyl4dOPAtee8iOwWCVjZ3M1r5hsmCbxzNSghzYTGhcnA4FXFG
 ZV+uETedIltIlBeJQL4wg=
 -----END SSH SIGNATURE-----

Test signed commit

$ git cat-file -t dba9c4e
commit
```

**Explanation**: The commit object contains metadata about the commit including:
- Tree hash pointing to the project snapshot
- Parent commit hash (for version history)
- Author and committer information with timestamps
- GPG signature for verification
- Commit message

#### 2. Tree Object Inspection
```bash
$ git cat-file -p 036f135e17df16fae53da3a320a93c6260db2f97
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md  
040000 tree 6ce59e139fa7afb62ce7873c389dd1e296410ab0    lab1_solution
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md

$ git cat-file -t 036f135e17df16fae53da3a320a93c6260db2f97
tree
```

**Explanation**: The tree object represents a directory snapshot containing:
- File permissions (100644 for regular files, 040000 for directories)
- Object type (blob for files, tree for subdirectories)
- Hash of the content
- Filename

#### 3. Blob Object Inspection
```bash
$ git cat-file -t af7fda8ea32b60578a1103ce061a50d7f6f09a35
blob
```

**Explanation**: The blob object stores the actual file content. It contains the raw data of files without any metadata like filename or permissions. The blob hash is calculated from the file content, making it content-addressable.

### Summary
Git uses three main object types:
- **Commit**: Contains metadata and points to a tree
- **Tree**: Represents directory structure and points to blobs/trees
- **Blob**: Contains actual file content

This design allows Git to efficiently store snapshots, track changes, and ensure data integrity through cryptographic hashing.

---

## Task 2: Practice with Git Reset Command

### Creating git-reset-practice Branch

```bash
$ git checkout -b git-reset-practice
```

### Creating Test Commits

```bash
$ echo "First commit" > file.txt
$ git add file.txt
$ git commit -m "First commit"

$ echo "Second commit" >> file.txt
$ git add file.txt
$ git commit -m "Second commit"

$ echo "Third commit" >> file.txt
$ git add file.txt
$ git commit -m "Third commit"
```

### Git Reset Experiments

#### Git Reset --soft
```bash
$ git reset --soft HEAD~1
```

**Effect**: Moved HEAD to the previous commit but kept changes in the staging area. The working directory remained unchanged.

#### Git Reset --hard
```bash
$ git reset --hard HEAD~1
```

**Effect**: Moved HEAD to the previous commit and discarded all changes in both staging area and working directory.

### Using Git Reflog for Recovery

```bash
$ git reflog
```

**Output**: Shows history of HEAD movements including the reset operations, allowing recovery of "lost" commits.

```bash
$ git reset --hard <reflog_hash>
```

**Effect**: Recovered the previously reset commits using the reflog hash.

### Key Differences
- `--soft`: Only moves HEAD, preserves staging area and working directory
- `--mixed` (default): Moves HEAD and resets staging area, preserves working directory  
- `--hard`: Moves HEAD and resets both staging area and working directory

---

## Task 3: Visualizing Git Commit History

### Creating History Commits

```bash
$ echo "Commit A" > history.txt
$ git add history.txt
$ git commit -m "Commit A"

$ echo "Commit B" >> history.txt
$ git add history.txt
$ git commit -m "Commit B"

$ echo "Commit C" >> history.txt
$ git add history.txt
$ git commit -m "Commit C"
```

### Commit Graph Visualization

```bash
$ git log --oneline --graph --all
```

### Optional Branching

```bash
$ git checkout -b side-branch
$ echo "Branch commit" >> history.txt
$ git add history.txt
$ git commit -m "Side branch commit"
$ git checkout main
$ git log --oneline --graph --all
```

### Reflection
The commit graph visualization helps understand:
- **Collaboration**: Shows how different contributors' work merges together
- **Branching**: Displays parallel development streams and their integration points
- **History**: Provides clear timeline of project evolution and decision points

This visualization is essential for understanding complex development workflows and debugging issues in collaborative projects.

---

## Task 4: Tagging a Commit

### Creating and Pushing Tags

```bash
$ git tag v1.0.0
$ git push origin v1.0.0
```

### Tag Information
- **Tag Name**: v1.0.0
- **Command Used**: `git tag v1.0.0` followed by `git push origin v1.0.0`
- **Associated Commit Hash**: ab9496420ad99284363698e9fed2d53e850d27d4

### Value of Tagging
Tagging is valuable in software development for:
- **Versioning**: Marking specific releases and milestones
- **CI/CD Integration**: Triggering automated deployments and builds
- **Release Management**: Creating clear reference points for release notes and rollbacks
- **Historical Reference**: Providing stable references to specific project states

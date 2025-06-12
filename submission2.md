# Task 1: Git Object Descriptions

### Blob object

#### Sample commands and outputs:
```
$ git cat-file -p fcacba3c7b4e20bc91b4590f8a8cc19978fc908d
@main def m(args: String*) =
    args.foreach(arg => println(arg))
```

```
$ git cat-file -t fcacba3c7b4e20bc91b4590f8a8cc19978fc908d
blob
```
#### Short object description:
We can see that the blob object represents solely the content of a specific file contained at some point inside our repository. Git stores all the versions of our files, old and new, so even if the file is deleted locally, we can still retrieve any version of it from ```.git/objects``` directory.

### Tree object

#### Sample commands and outputs:
```
$ git cat-file -p b51937945eb0d7cc15828e9ae0eafc11805c9eaf
100644 blob 7e81440422e458f48b869097a9c0a99e457a62d6    echoargs.scala
100644 blob 3dc07ee8e835b729ab9b1d34d9d1ee9852cdd578    forargs.scala
100644 blob 19e3320376afbb2c622f224ad5289429bf0faa82    hello.scala
100644 blob a1a0ecac4fce05a36d76d8e2510fce822af53142    helloarg.scala
100644 blob a270ec1f6897f1f5e1c71cf1f10b9be6f201511b    pa.scala
100644 blob be34a5542083952f12d54f86037d23336e4e972c    printargs.scala
```

```
$ git cat-file -t b51937945eb0d7cc15828e9ae0eafc11805c9eaf
tree
```

#### Short object description:

The tree objects' functions are similar to directories in UNIX filesystems. They contain one or more entries, each one covering the SHA-1 hash of a blob file or a subtree, with their associated modes, types and filenames.

A tree is normally created by Git when it takes account of the state of the staging area and writes series of tree objects from it. The user can create their own tree objects by building their own staging area and then executing the command ```git write-tree```. If they wish, they can build a tree with different versions of files saved in the Git database by adding them through the ```git update-index --add --cacheinfo {address}``` command.

### Commit object

#### Sample commands and outputs:

```
$ git cat-file -p 3e9c2b4ea798889dae6e831428a554f587479673
tree b51937945eb0d7cc15828e9ae0eafc11805c9eaf
author Daru <daru191407@gmail.com> 1749685264 +0300
committer Daru <daru191407@gmail.com> 1749685264 +0300

for loop in Scala
```

```
$git cat-file -t 3e9c2b4ea798889dae6e831428a554f587479673
commit
```

#### Short object description:

The commit object contains the following information:
1. SHA-1 hash for the top-level tree for the snapshot of the project at the time of the commit.
2. Author/commiter information, utilizing user's ```user.name``` and ```user.email``` information, as well as the timestamp of the time of commit.
3. A blank line.
4. The commit message.

# Task 2: Git Reset

### Soft reset

When we run the command ```git reset --soft HEAD~1```, the branch head (the reference to the current commit) is reset to the parent commit of current HEAD (**Second commit**). However, neither the staged area (index file), nor the working tree are changed. This leaves all our changed files as changes to be committed.

### Hard reset

When we run the command ```git reset --hard HEAD~1``` afterwards, not only is the HEAD moved back to **First commit**, but the entire index file and working tree are reset: any changes to the tracked files in the working tree since the current HEAD are discarded, and untracked files are simply deleted. So, ultimately, we're left with file.txt with a single line: "First commit".

### Git reflog

In our case Git reflog command shows the full history of HEAD changes from the first commit in the repository to the current state. If other parameters are passed, some of the history can be pruned from the output based on the time of the change recorded. The information used by the reflog command is recorded in the reference logs, ("reflogs"). Here's the full output of the ```git reflog``` command we received:

```
$ git reflog
dae6f16 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
a1355b4 HEAD@{1}: reset: moving to HEAD~1
f161276 HEAD@{2}: commit: Third commit
a1355b4 HEAD@{3}: commit: Second commit
dae6f16 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
e47495a (origin/lab2, lab2) HEAD@{5}: checkout: moving from git-reset-practice to git-reset-practice
e47495a (origin/lab2, lab2) HEAD@{6}: checkout: moving from lab2 to git-reset-practice
e47495a (origin/lab2, lab2) HEAD@{7}: commit: Task 1 complete
e1ba46e HEAD@{8}: commit: for loop in Scala
daf1f91 HEAD@{9}: commit: even shorter arg printer
9cd3f5d HEAD@{10}: commit: Even shorter arg printer
780fd79 HEAD@{11}: commit: Prettier version of scala while printer
1fa3b54 HEAD@{12}: commit: Tested Scala while loop
bcaea0b HEAD@{13}: commit: Added scala script accepting args
3a15a3e HEAD@{14}: merge origin/master: Merge made by the 'ort' strategy.
34fcd5c HEAD@{15}: checkout: moving from master to lab2
5ee1861 (origin/master, origin/HEAD, master) HEAD@{16}: commit: Added gitignore for artifacts from Scala compilation
3dd1718 (upstream/master) HEAD@{17}: checkout: moving from 3dd1718fc2372ae838773f8f780807faa26995bd to master
3dd1718 (upstream/master) HEAD@{18}: checkout: moving from lab2 to 3dd1718fc2372ae838773f8f780807faa26995bd
34fcd5c HEAD@{19}: commit: commit 1 - scala hello, world
3dd1718 (upstream/master) HEAD@{20}: checkout: moving from master to lab2
3dd1718 (upstream/master) HEAD@{21}: rebase (finish): returning to refs/heads/master
3dd1718 (upstream/master) HEAD@{22}: rebase (start): checkout upstream/master
a107866 HEAD@{23}: checkout: moving from lab1 to master
fcb4f7c (origin/lab1, lab1) HEAD@{24}: commit: Added git merge strategies comparison
42a1d18 HEAD@{25}: commit: Will it sign or will it not?
a107866 HEAD@{26}: checkout: moving from master to lab1
a107866 HEAD@{27}: clone: from https://github.com/Daru1914/Sum25-intro-labs
(END)
```

This information is very useful, as it contains the hash of the commit we can use to reset our repository back to the **Third commit**. Even though the changes from file.txt were removed, the relevant blob and commit objects are still stored by Git unless explicitly garbage collected, and they can be used to restore the branch to its original state.

### Second hard reset

```
$ git reset --hard f161276
HEAD is now at f161276 Third commit
```

As we can see, we have managed to restore the history of the repository back to the **Third commit**. As we used another hard reset, the index file was cleared and the working tree reassembled as it was before the sequence of resets had begun. However, any uncommited changes made to the files between the two hard resets are now also lost.

# Task 3: Git Commit History

### Commit graph

#### 1. lab2 branch

```
$ git log --oneline --graph --all
* d9b8d6a (HEAD -> lab2) Commit C
* 6d7677f Commit B
* f136997 Commit A
*   536eef1 (origin/lab2) Task 2 completed
|\
| * cd3c25d (git-reset-practice) Documentation for task 2
| * f161276 Third commit
| * a1355b4 Second commit
| * dae6f16 First commit
|/
* e47495a Task 1 complete
* e1ba46e for loop in Scala
* daf1f91 even shorter arg printer
* 9cd3f5d Even shorter arg printer
* 780fd79 Prettier version of scala while printer
* 1fa3b54 Tested Scala while loop
* bcaea0b Added scala script accepting args
*   3a15a3e Add gitignore to lab2, as it needs it
|\
| * 5ee1861 (origin/master, origin/HEAD, master) Added gitignore for artifacts from Scala compilation
* | 34fcd5c commit 1 - scala hello, world
|/
* 3dd1718 (upstream/master) lab2 Git
* 0fea98c lab2 Git
| * fcb4f7c (origin/lab1, lab1) Added git merge strategies comparison
| * 42a1d18 Will it sign or will it not?
|/
* a107866 lab1 Intro
(END)
```

#### 2. After the side-branch

```
$ git log --oneline --graph --all
*   cead78c (refs/stash) WIP on side-branch: 82e7591 Side branch commit
|\
| * 8471aac index on side-branch: 82e7591 Side branch commit
|/
* 82e7591 (side-branch) Side branch commit
* d9b8d6a (lab2) Commit C
* 6d7677f Commit B
* f136997 Commit A
*   536eef1 (origin/lab2) Task 2 completed
|\
| * cd3c25d (git-reset-practice) Documentation for task 2
| * f161276 Third commit
| * a1355b4 Second commit
| * dae6f16 First commit
|/
* e47495a Task 1 complete
* e1ba46e for loop in Scala
* daf1f91 even shorter arg printer
* 9cd3f5d Even shorter arg printer
* 780fd79 Prettier version of scala while printer
* 1fa3b54 Tested Scala while loop
* bcaea0b Added scala script accepting args
*   3a15a3e Add gitignore to lab2, as it needs it
|\
| * 5ee1861 (HEAD -> master, origin/master, origin/HEAD) Added gitignore for artifacts from Scala compilation
* | 34fcd5c commit 1 - scala hello, world
|/
* 3dd1718 (upstream/master) lab2 Git
* 0fea98c lab2 Git
| * fcb4f7c (origin/lab1, lab1) Added git merge strategies comparison
| * 42a1d18 Will it sign or will it not?
|/
* a107866 lab1 Intro
```

### List of commit messages

```
$ git log --pretty=format:"%s"
Commit C
Commit B
Commit A
Task 2 completed
Documentation for task 2
Third commit
Second commit
First commit
Task 1 complete
for loop in Scala
even shorter arg printer
Even shorter arg printer
Prettier version of scala while printer
Tested Scala while loop
Added scala script accepting args
Add gitignore to lab2, as it needs it
Added gitignore for artifacts from Scala compilation
commit 1 - scala hello, world
lab2 Git
lab2 Git
lab1 Intro
```

### How this visualization helps understand collaboration and branching?

This visualization makes it easier to understand how collaborators contribute in parallel, showing where branches diverge and merge. The commit graph clearly reveals the chronological and structural flow of work, making it easy to track side branches, stashes, and integration points.

# Task 4: Tagging a Commit

**Objective**: Learn how to create and push a Git tag to mark a specific state of your project.

1. **Tag the Current Commit**:

   * On your current branch (e.g., `main`), tag the latest commit as `v1.0.0`:

     ```sh
     git tag v1.0.0
     git push origin v1.0.0
     ```

2. **(Optional) Create Another Tag**:

   * Make one more commit and create a `v1.1.0` tag for additional practice.

3. **Documentation**:

   * In `submission2.md`, include:

     * The tag name(s) you created.
     * The command(s) used.
     * The associated commit hash(es).
     * A short sentence explaining the value of tagging in software development (e.g., versioning, CI/CD triggers, release notes).
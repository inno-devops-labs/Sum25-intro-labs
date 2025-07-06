# Task 1: Understanding Version Control Systems

## Commits

I have created several commits in the repository. Here is the output of the git log --oneline command:

```
80486de (HEAD -> master, origin/master, origin/HEAD) Update report_lab2.md
5124489 Create report_lab2.md
```

Each commit has a unique hash and message, which allows you to track changes.

## Checking objects using git cat-file

### Commit:

Team:

```
git cat-file -p 80486de
```

Conclusion:

```
tree 89034737d13834db75e79604b84a86edc8f4f9af
parent 512448968450c1dbd447b58d97a571c87e3f487f
author Kulikova-A18 <81427431+Kulikova-A18@users.noreply.github.com>
```

**Explanation:** This is the metadata of the commit, including the parent commit and the author.

### Tree:

Team:

```
git cat-file -p 89034737d13834db75e79604b84a86edc8f4f9af
```

Conclusion:

```
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35  README.md
```

The contents of the tree showing the files and their hashes.

### Blob:

Team:

```
git cat-file -p <blob_hash>
```

The blob contains the actual contents of the files in the repository.

# Task 2: Practice working with the Git Reset command

## 1. Creating a new branch

A new branch named git-reset-practice has been created.

```
vboxuser@xubu:~/Sum25-intro-labs$ git checkout -b git-reset-practice
Switched to a new branch 'git-reset-practice'
```

This command creates a new branch and switches the current work context to it. Now all commits will be saved in this branch.

## 2. Creating a series of commits

A series of three commits has been created:

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

Output of commands:

```
[git-reset-practice 0a0290a] First commit
```

Three commits have been created, each of which adds a new line to the file file.txt . The git add command adds changes to the index, and git commit commits changes to the history.

## 3. Push a new branch to a remote repository

The branch was sent to a remote repository.:

```
vboxuser@xubu:~/Sum25-intro-labs$ git push --set-upstream origin git-reset-practice
```

This command sends the current branch to the remote repository, setting it up for tracking. This allows you to synchronize changes with the deleted version of the branch.

## 4. Using git reset

## 4.1. Using git reset --soft

The command to reset the last commit has been executed:

```
vboxuser@xubu:~/Sum25-intro-labs$ git reset --soft HEAD~1
```

This command cancels the last commit, but leaves the changes in the index, which allows you to make additional edits before committing again.

## 4.2. Using git reset --hard

The command for a complete reset has been executed:

```
vboxuser@xubu:~/Sum25-intro-labs$ git reset --hard HEAD~1
HEAD is now at 80486de Update report_lab2.md
```

This command completely deletes the last commit and all related changes from the working directory and index. All changes made in the last commit are lost.

## 5. Using git reflog

Viewing the history of actions using git reflog:

```
vboxuser@xubu:~/Sum25-intro-labs$ git reflog
```

Command output:

```
80486de (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
429a2d4 (origin/master, origin/HEAD, master) HEAD@{1}: reset: moving to HEAD~1
0a0290a HEAD@{2}: reset: moving to HEAD~1
40b1144 HEAD@{3}: reset: moving to HEAD~1
4081f85 (origin/git-reset-practice) HEAD@{4}: commit: Third commit
```

The git reflog command shows the history of all actions in the repository, including resets. This allows you to restore previous states, if necessary.

## 6. Restoring the previous state

The following reset was used to restore the previous state:

```
vboxuser@xubu:~/Sum25-intro-labs$ git reset --hard b2ed6ed
HEAD is now at b2ed6ed part report_lab1_ru.md
```

# Task 3: Visualizing Git Commit History

## 1. Creating commits

we created three commits in our current branch using the following commands:

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

The result of executing commands:

```
vboxuser@xubu:~/Sum25-intro-labs$ echo "Commit A" > history.txt
vboxuser@xubu:~/Sum25-intro-labs$ git add history.txt
vboxuser@xubu:~/Sum25-intro-labs$ git commit -m "Commit A"
[HEAD c2e5d28] Commit A
 1 file changed, 1 insertion(+)

vboxuser@xubu:~/Sum25-intro-labs$ echo "Commit B" >> history.txt
vboxuser@xubu:~/Sum25-intro-labs$ git add history.txt
vboxuser@xubu:~/Sum25-intro-labs$ git commit -m "Commit B"
[HEAD 42eaf15] Commit B
 1 file changed, 1 insertion(+)

vboxuser@xubu:~/Sum25-intro-labs$ echo "Commit C" >> history.txt
vboxuser@xubu:~/Sum25-intro-labs$ git add history.txt
vboxuser@xubu:~/Sum25-intro-labs$ git commit -m "Commit C"
[HEAD c2e5d28] Commit C
 1 file changed, 1 insertion(+)
```

We also successfully sent the changes to the remote repository.:

```
git push origin HEAD:git-reset-practice
```

## 2. List of commit messages

• Commit A
• Commit B
• Commit C

## 3. The fixation schedule

executed the command to view the commit schedule:

```
git log --oneline --graph --all
```

The result of the command execution:

```
* c2e5d28 (HEAD, origin/git-reset-practice) Commit C
* 42eaf15 Commit B
* 0b6f364 Commit A
* 4081f85 (git-reset-practice) Third commit
* 40b1144 Second commit
* 0a0290a First commit
| * 126abb1 (origin/master, origin/HEAD) Update report_lab2.md
|/  
* 429a2d4 (master) Update report_lab2.md
```

the ``git log --oneline --graph --all`` command restores the repository state to the specified commit, deleting all changes after it.

# Task 4: Mark the commit

## Tags

### Tag names

- v1.0.0

### Commands used

```
git tag v1.0.0
git push origin v1.0.0
```

### Related commit hashes

Hash of the last commit using the ``git log --oneline`" command

![image](https://github.com/user-attachments/assets/b1307db5-b038-48c3-a3e4-352e9f109149)

### The importance of tagging in software development

Tagging allows you to manage software versions, makes it easier to track changes and simplify the deployment process, and can also serve as a trigger for CI/CD processes and the creation of release notes.

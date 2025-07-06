# Completion report "Lab 2: Version Control"

All information was provided in "submission2.md " (https://github.com/Kulikova-A18/Sum25-intro-labs/blob/master/submission2.md )

# Task 1: Understanding Version Control Systems

1.**Create and explore a repository**:

* Use the current repository and make multiple commits

![image](https://github.com/user-attachments/assets/e03b536e-0e3f-414a-b440-7f12750b56ac )

next, we check using the command 

``
git log --online
``

![image](https://github.com/user-attachments/assets/2160bd04-a0e6-4251-9952-50a104978379 )

text version

```
vboxuser@xubu:~/Sum25-intro-labs$ git log --oneline
update 80486de (HEAD -> master, origin, origin/SUPERVISOR) report_lab2.md
5124489 Create report_lab2.md
3b45527 Create report_lab2.md
abeafaa Merges the "inno-devops-labs:master" branch into the main one.
3dd1718 lab2 Git
0fea98c lab2 Git
ec7ac92 Delete lab1_ru.md
33113c8 Update and rename report_lab1_ru.md in report_lab1.md
87c87ad Create report_lab1.md
440a0c1 Create readme.md
5388aa8 Update report_lab1_ru.md
04f181b Is my second signed commit message
17ec118 create a new update report_lab1_ru.md from the screen
3698218 My signed commit message
part b2ed6ed report_lab1_ru.md
report on part 52c064b
3ad91cf Create report_lab1_ru.md
Update c93b5a6 lab1_ru.md
27ccd81 Create lab1_ru.md
a107866 Introduction to laboratory work 1

```

* Use the git cat file to check a large number of duplicate tasks, reports, and commits.

```
# git cat-file -p <blob_hash>

user vboxuser@xubu:~/Sum25-intro-labs$ git cat-file -p 80486de
tree 89034737d13834db75e79604b84a86edc8f4f9af
parent 512448968450c1dbd447b58d97a571c87e3f487f
author Kulikova-A18 <81427431+Kulikova-A18@users.noreply .github.com > 1749555843 +0300
GitHub sender <noreply@github.com > 1749555843 +0300
gpgsig -----LAUNCHES THE PGP SIGNATURE.-----

wsFcBAABCAAQBQJoSBqDCRC1aQ7uu5UhlAAAWxQQAEMbKyLEYMiCVpc+EZ5zZM5W
***
HF44P46puafL/QSpsIhf
=ph6a
-----FINAL PGP SIGNATURE-----


```

we use the Internet from the page "tree 89034737d13834db75e79604b84a86edc8f4f9af"

```
# git cat-file -p <hash of the tree>

user vboxuser@xubu:~/Sum25-intro-labs$ git cat-file -p 89034737d13834db75e79604b84a86edc8f4f9af 89034737d13834db75e79604b84a86edc8f4f9af
100644 binary object af7fda8ea32b60578a1103ce061a50d7f6f09a35 README.md
100644 big binary 7a94f7af59b8968be392288ea03179a24ffc9d9e lab1.md
100644 binary object 77e299c4cdb01bc31607befvide2036b56c3368515 lab2.md
100644 big binary 08c46b4b30dd44ee389f480c7efdbdeaffvide664e report_lab1.md
100644 big binary file 8b137891791fe96927ad78e64b0aad7bded08bdc report_lab2.md
040000 tree 17d6b482ebd5dc9e6965e64873a7a1fc76ecbdef en
100644 big binary 2137aab797c5d0680fbd7ad3a6dfe88455f952b2 submission1.md
```

```
# git cat-file -p <commit hash>

user vboxuser@xubu:~/Sum25-intro-labs$ git cat-file -p 52c064b
tree 9d62cede4f9bdb375feee1888cc2aa1fa832614a
parent element 3ad91cf7227694b16a324296dc128cc2319c7427
author Kulikova-A18 <81427431+Kulikova-A18@users.noreply .github.com> 1748754976 +0300
sender on GitHub <noreply@github.com > 1748754976 +0300
gpgsig -----START PGP SIGNING-----

In this video, I will tell you how to properly care for your hair.
****
KZdHeHzsk/tCWpXC8Jye
=mOXL
-----FINAL PGP SIGNATURE-----
```

---

# Task 2: Try to work with the new Git Reset

*****: Try using a special way to use the 'git reset` command.

1.**Create a new branch**:

* Create a new version called "git-reboot-practice" in your Git repository.

```
vboxuser@xubu:~/Sum25-intro-labs$ git checkout -b git-reset-practice
Moved to a new branch "git-reset-practice"
```

2.**Explore the advanced reset and re-logging options**:

* Create a series of commits:

```
echo "The first fixation" > file.txt
git add file.txt
git commit -m "First commit"

echo "The second fixation" >> file.txt
git add file.txt
git commit -m "Second commit"

echo "The Third fixation" >> file.txt
git add file.txt
git commit -m "The third commit"
```

output of commands:

```
vboxuser@xubu:~/Sum25-intro-labs$ echo "First commit" > file.txt
git add file.txt
git commit -m "First commit"

echo "The second fixation" >> file.txt
git add file.txt
git commit -m "Second commit"

echo "The Third fixation" >> file.txt
git add file.txt
git commit -m "The third commit"
[git-reset-practice 0a0290a] First commit
 Sender: vboxuser <vboxuser@xubu.myguest .virtualbox.org>
Your name and email address have been configured automatically
based on your username and hostname. Please check their accuracy.
You can disable this message by setting them explicitly.:

    git config --global user.name "Your name"
    git config --global user.email you@example.com

After that, you can fix the ID used for this commit using:

    git commit --amend --reset-author

 1 file changed, 1 insert(+)
creation mode 100644 file.txt
[git-reset-practice 40b1144] Second commit
 Sender: vboxuser <vboxuser@xubu.myguest .virtualbox.org>
Your name and email address have been configured automatically
based on your username and hostname. Please make sure they are correct.
You can disable this message by specifying them explicitly.:

    git config --global user.name "Your name"
    git config --global user.email address you@example.com

After that, you can fix the ID used for this commit using:

    git commit --amend --reset-author

 1 file changed, 1 insert(+)
[git-reset-practice 4081f85] Third commit.
 Sender: vboxuser <vboxuser@xubu.myguest .virtualbox.org>
Your name and email address have been configured automatically
based on your username and hostname. Please make sure they are correct.
You can disable this message by specifying them explicitly.:

    git config --global user.name "Your name"
    git config --global user.email address you@example.com

After that, you can fix the ID used for this commit using:

    git commit --amend --reset-author

 1 file changed, 1 insert(+)
vboxuser@xubu:~/Sum25-intro-labs$ git push
fatal: The current git-reset-practice branch does not have an upstream branch.
To start the current branch and set the remote control as upstream, use

    git push --set-upstream origin git-reset-practice

vboxuser@xubu:~/Sum25-intro-labs$ git push-setup-git source code-reset-practice
Enumeration of objects: 10, completed.
Object count: 100% (10/10), completed.
Delta compression using up to 4 streams
Object compression: 100% (6/6), done.
Object recording: 100% (9/9), 1.11 KB | 1.11 Mb/s, done.
Total 9 (delta 5), 0 reused (delta 0), 0
deleted packages reused: elimination of deviations: 100% (5/5), 1 local object added.
remote:
Remotely: Create a download request for "git-reset-practice" on GitHub by visiting:
remotely: https://github.com/Kulikova-A18/Sum25-intro-labs/pull/new/git-reset-practice
remotely: 
On github.com:Kulikova-A18/Sum25-intro-labs.git.
 * [new branch] git-reset-practice -> git-reset-practice
The "git-reset-practice" branch is configured to track the deleted "git-reset-practice" branch from "origin".
```

* Use "git reset --soft" and "git reset --hard" to understand how they affect the working directory and appearance.

```
vboxuser@xubu:~/Sum25-intro-labs$ git reset --soft HEAD~1
vboxuser@xubu:~/Sum25-intro-labs$ git reset --hard HEAD~1
The HEADER is now at update level 80486de report_lab2.md
```

* Use the "git reflog" to view and create additional messages.

```
vboxuser@xubu:~/Sum25-intro-labs$ git reflog
80486de (HEAD -> git-reset-practice) HEAD@{0}: reset: transition to HEAD~1
429a2d4 (start of countdown/master, start of countdown/MAIN ELEMENT, leading element) HEAD@{1}: reset: transition to HEAD~1
0a0290a HEAD@{2}: reset: switch to HEAD~1
40b1144 HEADER@{3}: reset: jump to HEADER~1
4081f85 (origin/git-reset-practice) HEADER@{4}: commit: Third commit
40b1144 HEADER@{5}: commit: Second commit
0a0290a HEADER@{6}: commit: First commit
429a2d4 (origin/master, origin/HEAD, master) HEAD@{7}: verification: transition from master to git-reset settings-practice
429a2d4 (origin/master, origin/HEAD, master) TITLE@{8}: transition: Fast forward
80486de (HEAD -> git-reset-practice) HEADER@{9}: transition: fast forward
04f181b HEADER@{10}: commit: My second signed commit message
17ec118 HEADER@{11}: output: Fast forward
3698218 HEADER@{12}: commit: My signed commit message
header@{13}: copy: Fast forward
52c064b HEADER@{14}: clone: from github.com:Kulikova-A18/Sum25-intro-labs.git
vboxuser@xubu:~/Sum25-intro-labs$ reset git -hard b2ed6ed
The title is now in the b2ed6ed section. report_lab1_ru.md
vboxuser@xubu:~/Sum25-intro-labs$
```

## Task 3: Visualizing the Git commit history

1.**Create multiple commits**:

* Make 3 or more simple commits in your current branch.:

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

result

```
boxuser@xubu:~/Sum25-intro-labs$ echo "Commit A" > history.txt
git add history.txt
git commit -m "Commit A"

echo "Commit B" >> history.txt
git add history.txt
git commit -m "Commit B"

echo "Commit C" >> history.txt
git add history.txt
git commit -m "Commit C"
[detached HEAD 5e20b78] Commit A
 Committer: vboxuser <vboxuser@xubu.myguest.virtualbox.org>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
 create mode 100644 history.txt
[detached HEAD 0b6f364] Commit B
 Committer: vboxuser <vboxuser@xubu.myguest.virtualbox.org>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
[detached HEAD 42eaf15] Commit C
 Committer: vboxuser <vboxuser@xubu.myguest.virtualbox.org>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
vboxuser@xubu:~/Sum25-intro-labs$ git push 
fatal: You are not currently on a branch.
To push the history leading to the current (detached HEAD)
state now, use

    git push origin HEAD:<name-of-remote-branch>

vboxuser@xubu:~/Sum25-intro-labs$ git push --set-upstream origin git-reset-practice
Branch 'git-reset-practice' set up to track remote branch 'git-reset-practice' from 'origin'.
Everything up-to-date
vboxuser@xubu:~/Sum25-intro-labs$ 
vboxuser@xubu:~/Sum25-intro-labs$ git push origin HEAD:git-reset-practice
Enumerating objects: 13, done.
Counting objects: 100% (13/13), done.
Delta compression using up to 4 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (12/12), 1.42 KiB | 1.42 MiB/s, done.
Total 12 (delta 7), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (7/7), completed with 1 local object.
To github.com:Kulikova-A18/Sum25-intro-labs.git
   4081f85..c2e5d28  HEAD -> git-reset-practice

```

![image](https://github.com/user-attachments/assets/e094fc78-2429-4e98-96d1-9f41c5e8838e)


2.**Study the commit schedule**:

* Run the following command to view a simple commit schedule:

```
git log --oneline --graph --all
```

result:

```
vboxuser@xubu:~/Sum25-intro-labs$ git log --oneline --graph --all
* c2e5d28 (HEAD, origin/git-reset-practice) Commit CC
* 42eaf15 Commit C
* 0b6f364 Commit B
* 5e20b78 Commit A
* 4081f85 (git-reset-practice) Third commit
* 40b1144 Second commit
* 0a0290a First commit
| * 126abb1 (origin/master, origin/HEAD) Update report_lab2.md
|/  
* 429a2d4 (master) Update report_lab2.md
* 80486de Update report_lab2.md
* 5124489 Create report_lab2.md
* 3b45527 Create report_lab2.md
*   abeafaa Merge branch 'inno-devops-labs:master' into master
|\  
| * 3dd1718 lab2 Git
| * 0fea98c lab2 Git
* | ec7ac92 Delete lab1_ru.md
* | 33113c8 Update and rename report_lab1_ru.md to report_lab1.md
* | 87c87ad Create report_lab1.md
* | 440a0c1 Create readme.md
* | 5388aa8 Update report_lab1_ru.md
* | 04f181b My second signed commit message
* | 17ec118 generate new Update report_lab1_ru.md with screen
* | 3698218 My signed commit message
* | b2ed6ed part report_lab1_ru.md
* | 52c064b part report
* | 3ad91cf Create report_lab1_ru.md
* | c93b5a6 Update lab1_ru.md
* | 27ccd81 Create lab1_ru.md
|/  
* a107866 lab1 Intro
```

3.**Optional branching**:

* Create a new branch, commit, and review the log again:

```
git checkout -b side-branch
echo "Branch commit" >> history.txt
git add history.txt
git commit -m "Side branch commit"
git checkout main
git log --oneline --graph --all
```

result:

```
vboxuser@xubu:~/Sum25-intro-labs$ git checkout -b side-branch
echo "Branch commit" >> history.txt
git add history.txt
git commit -m "Side branch commit"
git checkout main
git log --oneline --graph --all
Switched to a new branch 'side-branch'
[side-branch 538c180] Side branch commit
 Committer: vboxuser <vboxuser@xubu.myguest.virtualbox.org>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
error: pathspec 'main' did not match any file(s) known to git
* 538c180 (HEAD -> side-branch) Side branch commit
* c2e5d28 (origin/git-reset-practice) Commit CC
* 42eaf15 Commit C
* 0b6f364 Commit B
* 5e20b78 Commit A
* 4081f85 (git-reset-practice) Third commit
* 40b1144 Second commit
* 0a0290a First commit
| * 126abb1 (origin/master, origin/HEAD) Update report_lab2.md
|/  
* 429a2d4 (master) Update report_lab2.md
* 80486de Update report_lab2.md
* 5124489 Create report_lab2.md
* 3b45527 Create report_lab2.md
*   abeafaa Merge branch 'inno-devops-labs:master' into master
|\  
| * 3dd1718 lab2 Git
| * 0fea98c lab2 Git
* | ec7ac92 Delete lab1_ru.md
* | 33113c8 Update and rename report_lab1_ru.md to report_lab1.md
* | 87c87ad Create report_lab1.md
* | 440a0c1 Create readme.md
* | 5388aa8 Update report_lab1_ru.md
* | 04f181b My second signed commit message
* | 17ec118 generate new Update report_lab1_ru.md with screen
* | 3698218 My signed commit message
* | b2ed6ed part report_lab1_ru.md
* | 52c064b part report
* | 3ad91cf Create report_lab1_ru.md
* | c93b5a6 Update lab1_ru.md
* | 27ccd81 Create lab1_ru.md
|/  
* a107866 lab1 Intro

```

## Task 4: Mark the commit

1.**Mark the current commit**:

* In your current branch (for example, `main`), mark the last commit as `v1.0.0`:

```
git tag v1.0.0
git push origin v1.0.0
```

result

![image](https://github.com/user-attachments/assets/554017fe-2d6d-4a5b-b04d-f4f4325a3a93)

The names of the tags that you created using the `git tag` command

![image](https://github.com/user-attachments/assets/bd4a6d38-8df7-4b88-ba5e-e67877463648)

## Information about the author

The report was made by Kulikova Alyona specifically for "Integration and automation of the software development process (advanced course)".

If you have any questions or suggestions for improvement, do not hesitate to contact us!

Link to git: https://github.com/Kulikova-A18

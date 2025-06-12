# Task 1
First I would use `git log --oneline` to get a list of commits with their hashes.

```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git log --oneline
```
```
3ab61a8 (HEAD -> master, origin/master, origin/HEAD) Merge branch 'master' of github.com:JustSomeDude2001/Sum25-intro-labs Pulling changes to lab 2
120e06d fulfilling task 2 of lab 1
2a0b7ac Merge branch 'inno-devops-labs:master' into master
7818ad5 adding submission1.md with a signed commit
3dd1718 (upstream/master) lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro
```
Now i can use `git cat-file -p` to see the contents of a singular commit. Let's go to commit for addition of submission1.md file, where only task 1 is fulfilled, but not task 2.
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git cat-file -p 7818ad5
```
```
tree f56197ee8e86b6c01e007aaa5f084371db50c551
parent 0fea98cc519f60820f4c54f514b1596d5bf145b5
author JustSomeDude2001 <kim.yaroslavik@gmail.com> 1749146591 +0300
committer JustSomeDude2001 <kim.yaroslavik@gmail.com> 1749146591 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 [Censored for security by student, manually]
 -----END SSH SIGNATURE-----

adding submission1.md with a signed commit
```
Here I see `tree` hash that points to contents of the repo at time of commit, and `parent` that points to commit `lab2 Git` by Dmitriy Creed - previous commit that added the lab 2 item. Let's look at the `tree` using `git cat-file`
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git cat-file -p f56197ee8e86b6c01e007aaa5f084371db50c551
```
```
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
100644 blob f24ed86aebc62df9645a30d7531d071548c55a75    submission1.md
```
And there I see `blob` hashes that point to all files at the moment that commit was done. Finally if I look at `submission1.md` using `git cat-file`, I am going to see only task 1 fulfilled per description of my commits and history:
```
git cat-file -p f24ed86aebc62df9645a30d7531d071548c55a75
```
```
# Task 1: SSH Commit Signature Verification
## Benefits of signing commits
In general it is a case of verification.

- As mentioned on lab, signed commits are nowaays acknowledged as proof of authorship ever since the lawsuit between Linus Torwalds and Microsoft (if I remember correctly, could not find the lawsuit in question)
- Acts as a form of 2FA. Supposedly there is a trivial author spoofing possible due to Git's design via `git config user.email/name` [highlighted by Mike Gerwitz in 2012](https://mikegerwitz.com/2012/05/a-git-horror-story-repository-integrity-with-signed-commits). An additional verification via an SSH key used for signature helps ounteract that.
- (Anecdotally) GDPR regulation suggests commit signing as a standard way of signing off authorship. UK Government also requires that [all commits must be signed by the author](https://engineering.homeoffice.gov.uk/standards/signing-code-commits/#all-code-commits-must-be-cryptographically-signed-by-the-author-of-that-commit).
## SSH Key Generation
I did generate it, but I am not showing it because sources tell I shouldn't share anything about my keys.
## Making a Signed Commit
The commit with which this document was pushed is signed.
```
As can be seen, only task 1 is fulfilled in this file, at the moment of that commit.

---

And this concludes task 1, as I have emonstrated all 3 examples requested in the assignment:
```
# Example commands to inspect contents
git cat-file -p <blob_hash>
git cat-file -p <tree_hash>
git cat-file -p <commit_hash>
```

# Task 2

## Difference between soft and hard reset

`git reset -h` eplains the following difference:
```
    --soft                reset only HEAD
    --hard                reset HEAD, index and working tree
```
That means while soft reset only resets the git commits, the hard resets also resets changes applied by said commits.

### Experimentation
Initial state of the branch:
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ cat file.txt
```
```
First commit
Second commit
Third commit
```
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git log --oneline
```
```
c19e9ae (HEAD -> git-reset-practice) Third commit
5d4ddae Second commit
a311ade First commit
4eb6faa (origin/master, origin/HEAD, master) Fulfilling task 1 of lab 2
3ab61a8 Merge branch 'master' of github.com:JustSomeDude2001/Sum25-intro-labs Pulling changes to lab 2
120e06d fulfilling task 2 of lab 1
2a0b7ac Merge branch 'inno-devops-labs:master' into master
7818ad5 adding submission1.md with a signed commit
3dd1718 (upstream/master) lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro
```

So, first let's test the soft reset:
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git reset --soft HEAD~1
```
The result: commit has been reset, but the changes of that commit have not.

```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ cat file.txt
```
```
First commit
Second commit
Third commit
```
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git log --oneline
```
```
5d4ddae (HEAD -> git-reset-practice) Second commit
a311ade First commit
4eb6faa (origin/master, origin/HEAD, master) Fulfilling task 1 of lab 2
3ab61a8 Merge branch 'master' of github.com:JustSomeDude2001/Sum25-intro-labs Pulling changes to lab 2
120e06d fulfilling task 2 of lab 1
2a0b7ac Merge branch 'inno-devops-labs:master' into master
7818ad5 adding submission1.md with a signed commit
3dd1718 (upstream/master) lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro
```

Next (after going back to initial state), hard reset:
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git reset --hard HEAD~1
```
```
HEAD is now at 5d4ddae Second commit
```
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ cat file.txt
```
```
First commit
Second commit
```
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git log --oneline
```
```
5d4ddae (HEAD -> git-reset-practice) Second commit
a311ade First commit
4eb6faa (origin/master, origin/HEAD, master) Fulfilling task 1 of lab 2
3ab61a8 Merge branch 'master' of github.com:JustSomeDude2001/Sum25-intro-labs Pulling changes to lab 2
120e06d fulfilling task 2 of lab 1
2a0b7ac Merge branch 'inno-devops-labs:master' into master
7818ad5 adding submission1.md with a signed commit
3dd1718 (upstream/master) lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro
```
## Usage of reflog
For that, I have not put the branch back into initial state before experimentation with reset. `git reflog` shows history of my work with commits and resetting them:
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git reflog
```
```
5d4ddae (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
2d22201 HEAD@{1}: commit: Third commit
5d4ddae (HEAD -> git-reset-practice) HEAD@{2}: reset: moving to HEAD~1
c19e9ae HEAD@{3}: reset: moving to HEAD
c19e9ae HEAD@{4}: commit: Third commit
5d4ddae (HEAD -> git-reset-practice) HEAD@{5}: reset: moving to HEAD~1
4a71f84 HEAD@{6}: commit: Third commit
5d4ddae (HEAD -> git-reset-practice) HEAD@{7}: commit: Second commit
a311ade HEAD@{8}: commit: First commit
4eb6faa (origin/master, origin/HEAD, master) HEAD@{9}: checkout: moving from master to git-reset-practice
4eb6faa (origin/master, origin/HEAD, master) HEAD@{10}: commit: Fulfilling task 1 of lab 2
3ab61a8 HEAD@{11}: pull: Merge made by the 'ort' strategy.
120e06d HEAD@{12}: commit: fulfilling task 2 of lab 1
7818ad5 HEAD@{13}: commit: adding submission1.md with a signed commit
0fea98c HEAD@{14}: clone: from github.com:JustSomeDude2001/Sum25-intro-labs.git
```
I'll recover initial state of the branch before any resets using `git reset --hard 4a71f84`
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git reset --hard 4a71f84
```
```
HEAD is now at 4a71f84 Third commit
```
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git log --oneline
```
```
4a71f84 (HEAD -> git-reset-practice) Third commit
5d4ddae Second commit
a311ade First commit
4eb6faa (origin/master, origin/HEAD, master) Fulfilling task 1 of lab 2
3ab61a8 Merge branch 'master' of github.com:JustSomeDude2001/Sum25-intro-labs Pulling changes to lab 2
120e06d fulfilling task 2 of lab 1
2a0b7ac Merge branch 'inno-devops-labs:master' into master
7818ad5 adding submission1.md with a signed commit
3dd1718 (upstream/master) lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro
```
`git reflog` now reflects this reset back to initial state.
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git reflog
```
```
4a71f84 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to 4a71f84
5d4ddae HEAD@{1}: reset: moving to HEAD~1
2d22201 HEAD@{2}: commit: Third commit
5d4ddae HEAD@{3}: reset: moving to HEAD~1
c19e9ae HEAD@{4}: reset: moving to HEAD
c19e9ae HEAD@{5}: commit: Third commit
5d4ddae HEAD@{6}: reset: moving to HEAD~1
4a71f84 (HEAD -> git-reset-practice) HEAD@{7}: commit: Third commit
5d4ddae HEAD@{8}: commit: Second commit
a311ade HEAD@{9}: commit: First commit
4eb6faa (origin/master, origin/HEAD, master) HEAD@{10}: checkout: moving from master to git-reset-practice
4eb6faa (origin/master, origin/HEAD, master) HEAD@{11}: commit: Fulfilling task 1 of lab 2
3ab61a8 HEAD@{12}: pull: Merge made by the 'ort' strategy.
120e06d HEAD@{13}: commit: fulfilling task 2 of lab 1
7818ad5 HEAD@{14}: commit: adding submission1.md with a signed commit
0fea98c HEAD@{15}: clone: from github.com:JustSomeDude2001/Sum25-intro-labs.git
```

# Task 3
## Exploring a commit graph
After adding commits from the example, the tree now contains. The tree also shows the branch for task 2, and a branch I made by mistake - `main`, while trying to switch to `master`.
```
git log --oneline --graph --all
```
```
* 47dd6d0 (HEAD -> master) Commit C
* 72179ad Commit B
* e1e0606 Commit A
* caf432f (origin/master, origin/HEAD) Fulfilling task 2 of lab 2
| * 4a71f84 (main, git-reset-practice) Third commit
| * 5d4ddae Second commit
| * a311ade First commit
|/
* 4eb6faa Fulfilling task 1 of lab 2
*   3ab61a8 Merge branch 'master' of github.com:JustSomeDude2001/Sum25-intro-labs Pulling changes to lab 2
|\
| *   2a0b7ac Merge branch 'inno-devops-labs:master' into master
| |\
| | * 3dd1718 (upstream/master) lab2 Git
* | | 120e06d fulfilling task 2 of lab 1
|/ /
* / 7818ad5 adding submission1.md with a signed commit
|/
* 0fea98c lab2 Git
* a107866 lab1 Intro
```
## Optional Branching
Added the branch and its commits. They reflect properly on the tree made by the `git log`. Note that `side-branch` stays on the same vertical as `master` because master had no additional commits, and `git-reset-practice` goes off to the side because there were commits for the `master` branch not on it.
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ git log --oneline --graph --all
```
```
* a2deb53 (side-branch) Side branch commit
* 47dd6d0 (HEAD -> master) Commit C
* 72179ad Commit B
* e1e0606 Commit A
* caf432f (origin/master, origin/HEAD) Fulfilling task 2 of lab 2
| * 4a71f84 (main, git-reset-practice) Third commit
| * 5d4ddae Second commit
| * a311ade First commit
|/
* 4eb6faa Fulfilling task 1 of lab 2
*   3ab61a8 Merge branch 'master' of github.com:JustSomeDude2001/Sum25-intro-labs Pulling changes to lab 2
|\
| *   2a0b7ac Merge branch 'inno-devops-labs:master' into master
| |\
| | * 3dd1718 (upstream/master) lab2 Git
* | | 120e06d fulfilling task 2 of lab 1
|/ /
* / 7818ad5 adding submission1.md with a signed commit
|/
* 0fea98c lab2 Git
* a107866 lab1 Intro
```
## Reflection
Visualization tools are clearly applicable for following cases:
- Onboarding: It is easy to show how a good workflow looks on a commit tree - it shows commits with their comments, the branches, and how they merge.
- Diagnostics: It is easier to find a problem when all problems are mapped out on a map.
- Statistics: I use different visualization tools (Github Insights) to gather high-level statistics, such as storypoints done per sprint in a Github project.

# Task 4
## Tagging a commit
The commit with which the task 4 has been pushed is tagged as `v1.0.0`. Further elaborations for this task are tagged as `v1.1.0`.
## Documentation
- Created tag names: `v1.0.0`, `v1.1.0`
- Commands used: `git add`, `git commit`, `git tag`, `git push`
- Asociated commit hashes: 
- Value of tagging: helps keep track of history of changes in an easily human-readable way (versions), triggers CI/CD for checks if set up (e.g. on: push: tags: -'v*'), release documentation (example by DeepSeek `git tag -a v1.4.0 -m "Added user analytics dashboard"`), or easy rollbacks to old versions (example by DeepSeek `git checkout v1.3.5  # Revert to last stable release`).



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
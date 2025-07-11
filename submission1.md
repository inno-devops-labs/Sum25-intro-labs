# Lab 1:  Introduction to DevOps with Git

## Task 1: SSH Commit Signature Verification

Signed commites provides us with:
- Authenticity – proves the commit was really made by you (since without signing, anyone can fake your name in a commit)
- Integrity – ensures no one tampered with the commit after you made it
- Non-repudiation – prevents from denying changes later ("I didn’t write this!")
- Security – helps block malicious code in team projects
- Trust – makes work more reliable, especially in open-source

## Task 2: Merge Strategies in Git

### Standard Merge
**Pros**: Keeps all commits & branch info. Easy to track changes
**Cons**: Can make history messy with lots of merge commits

### Squash and Merge
**Pros**: Combines all commits into one, making history cleaner.
**Cons**: Loses details of individual commits (harder to debug).

### Rebase and Merge
**Pros**: Makes history straight & avoids extra merge commits.
**Cons**: Rewrites commit history (dangerous for shared branches).

### Why Standard Merge is Best for Teams
- Keeps full history – no lost commits
- Easy debugging – each change stays clear
- Safer – doesn’t rewrite history (unlike rebase)
- Fewer conflicts – fix conflicts once at merge, not per commit
- Clear teamwork – shows when features were added

### Disable Squash and Rebase Merge
![alt text](image.png)
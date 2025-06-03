# Lab 1: Introduction to DevOps with Git

## Task 1: Benefits of commit signing

The main benefits of commit signing are:
1. Commit signing makes sure that the person is really the author of the commit. For example, I can create a commit with any user name and email address but I won't be able to sign it without that person's private key.
2. Commit signing makes sure that nobody except the commit author can edit the commit or its metadata (e.g. creation time).

## Task 2: Merge strategies comparison

### Standard merge

Pros:
- You do not modify existing commits
- You keep the full commit history

Cons:
- You may have a complicated commit graph

### Squash and merge

Pros:
- You maintain linear project history
- You get clear commit history without unnecessary commits

Cons:
- You loose metadata about squashed commits (including original commit ids)
- If you continue working on the branch after squashing and merging, you may have to repeatedly resolve conflicts for each new pull request

### Rebase and merge

Pros:
- You maintain linear project history
- You keep the full commit history

Cons:
- You recreate all the commits from the feature branch and loose all the original commit signatures
- You may introduce conflicts if you rebase the branch that is being used by someone else

### Summary

The standard merge is often preferred in collaborative environments because it preserves full commit history and is safe.

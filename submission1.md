# Lab1 `submission.md`

## Why commit signing is crucial

The main thing the commit signing is used for is to verify the **integrity** and **authenticity** of commits

**1. Authenticity:**

Git, by default, allows users to set any name and email in their commit configuration. This means someone could impersonate another developer by simply configuring their Git client with that developer's details. So the commit signing proves that a commit was made by a specific, verified author, but not someone else. This helps prevent malicious actors from injecting code under a trusted name.

**2. Integrity:**

Commit signing also ensures that the content of the commit (the code changes, commit message, author, timestamp, etc) has not been changed since it was signed. This works because the cryptographic signature is actually a hash of the content of commits, so even if a single bit of the commit data changes after signing, the signature will no longer match, and verification will fail. This protects against accidental (or intentional) corruption of commits.

**In summary, commit signing provides:**

- **Trust:** It guarantees that the commit history is accurate and that commits come from trusted sources
- **Accountability:** It makes it harder for malicious contributions to go unnoticed
- **Security:** It is another layer of protection from attacks where attackers might try to inject malicious code by impersonating contributors or altering existing commits

## Comparison of Merge strategies

### 1. Standard Merge

Combines two branches by creating a merge commit.

- **Pros:**
  - Preserves histories of both branches: when a feature was branched off and when it was merged
  - Easy to identify all commits that were part of a specific feature or pull request
  - Doesn't rewrite commit history
- **Cons:**
  - Can result in complex commit graph in the main branch, especially with many small feature branches and frequent merges
  - If a feature branch contains many trivial commits, these are all preserved, potentially making the main history harder to read

### 2. Squash and Merge

Combines all commits from a feature branch into a single commit before merging.

- **Pros:**
  - Results in a linear, clean history on the target branch, where each commit represents a complete feature
  - Any issue can be reverted by reverting the single squashed commit
  - Hides intermediate, messy, or trivial commits
- **Cons:**
  - Potentially loose of context and detailed development history
  - Cannot pick a specific small change from the squashed feature, as it is not readily available as a separate commit

### 3. Rebase and Merge

Reapplies commits from a feature branch onto the base branch

- **Pros:**
  - Makes history straight
  - Avoids the creation of merge commits
- **Cons:**
  - Rebasing rewrites commit hashes, so can cause significant problems and confusion for collaborators
  - Does not allow to separate whether feature was actually developed sequentially or in parallel

### Why the Standard Merge Strategy is often preferred in collaborative environments

- It accurately reflects the project's development timeline, showing exactly when a branch was created, developed, and merged
- Does not rewrite history, which is quite important in shared branches
- Provide easy traceability and debugging, as it's easy to see all the commits that were part of that feature branch
- It is the most safest and straightforward way to integrate changes
- Team members can easily see how different lines of development have changed

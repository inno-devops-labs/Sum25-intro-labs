# ssh commit signature verification

### Objective: Understand the importance of commit signing using SSH keys and set up commit signature verification.

Benefits of signed commits:
- Commits, which are marked as verified helps users to be confident that the changes come from a trusted source.
- Sign is authomatically checks with cryptographic algorithms and verifies with open key.
- If intruder will try to fake commit it's status will change to 'Univerified'
- Github will save status even if key will be expired


## Merge Strategies in Git

### 1. Standard Merge
- **How it works**: Combines a branch with the main branch by creating a separate merge commit.
- **Pros**:
  - Preserves the full commit history.
  - Clearly shows when and which branches were merged.
- **Cons**:
  - The history can get noisy with many small commits.

### 2. Squash and Merge
- **How it works**: All commits from a feature branch are squashed into a single commit before merging into the main branch.
- **Pros**:
  - Clean commit history — one commit per feature.
- **Cons**:
  - Loses detailed commit history and individual authorship.

### 3. Rebase and Merge
- **How it works**: Reapplies commits from the feature branch onto the base branch, as if they were made directly on top of it.
- **Pros**:
  - Produces a linear and clean history.
- **Cons**:
  - Can be confusing in collaborative work.
  - Risky if used improperly, especially on shared branches.

---

### Why **Standard Merge** is often preferred in team environments:
- Maintains a complete development history.
- Makes it clear who merged what and when.
- Safe to use and does not rewrite history.

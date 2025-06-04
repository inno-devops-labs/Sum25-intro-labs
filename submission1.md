# Task 1: SSH Commit Signature Verification

## Benefits of Signing Commits

Signing commits with SSH keys ensures the authenticity and integrity of code contributions. It verifies that the commit was made by the claimed author, preventing unauthorized changes. This is crucial in collaborative projects to build trust, track contributions accurately, and enhance security by allowing verification of commit origins and detecting tampering.

Task 2: Merge Strategies in Git

Comparison of Merge Strategies

Standard Merge: Combines two branches by creating a merge commit, preserving the history of both. Pros: Maintains complete history, ideal for traceability in collaborative projects. Cons: Can result in a cluttered history with many merge commits.

Squash and Merge: Combines all commits from a feature branch into a single commit before merging. Pros: Produces a cleaner history. Cons: Loses individual commit details, which can complicate debugging.

Rebase and Merge: Reapplies feature branch commits onto the base branch, creating a linear history. Pros: Clean, linear history. Cons: Rewrites history, which can cause conflicts in collaborative settings.

Why Standard Merge is Preferred: In collaborative environments, standard merge is often preferred because it preserves the full commit history, making it easier to track changes and contributions without rewriting history, which can lead to confusion or conflicts.

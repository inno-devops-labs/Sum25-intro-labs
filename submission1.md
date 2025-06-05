## Why Sign Commits
Signing commits ensures that GitHub can verify the identity of the author. This prevents anyone from injecting malicious code under your name and guarantees the integrity of the project history. During code review or CI checks, a “Verified” badge makes it clear which changes were made by you.

## Comparison of Merge Strategies (merge, squash, rebase)
- **Merge (standard merge)**
  - Pros: Preserves the complete history, showing exactly when and where a feature branch was integrated.  
  - Cons: Generates extra merge commits, which can clutter the log if many feature branches are merged.

- **Squash and Merge (squash)**
  - Pros: Combines all commits from a feature branch into a single, clean commit. Ideal for keeping the main branch history concise.  
  - Cons: Loses individual commit details, making it harder to trace small incremental changes or bisect issues.

- **Rebase and Merge (rebase)**
  - Pros: Creates a linear history without merge commits, which looks clean and sequential.  
  - Cons: Rewrites commit hashes; if team members have already based work on the original branch, rebasing can create confusion and conflicts.

**Why standard Merge is often preferred in collaborative projects:**  
1. It does not rewrite history, so it’s safe for shared branches.  
2. Each merge commit clearly marks where a feature branch was integrated, which helps track high-level progress.  

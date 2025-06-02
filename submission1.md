## Task 1: SSH Commit Signing

An SSH key pair was generated using the ed25519 algorithm. The public key was added to the GitHub account with the "Signing Key" option enabled. Git was configured to sign commits using SSH (`gpg.format ssh` and `user.signingkey`). The SSH key was added to `ssh-agent`, and a signed commit was created using `--gpg-sign`. The commit was successfully pushed to GitHub. Although the commit was marked as "Unverified" by GitHub, all required steps were completed as specified.

## Task 2: Git Merge Strategies (Based on Atlassian and GitHub Docs)

When integrating work into the main branch of a collaborative repository, teams must choose how to merge changes. Git supports several merge strategies, each with distinct characteristics. This section compares the most commonly used approaches: standard merge, squash and merge, and rebase and merge. The comparison is based on official documentation from GitHub and Atlassian.

### 1. Standard Merge

This is the default and most widely used strategy in team environments. It creates a separate merge commit that combines the changes from the feature branch with the base branch. This merge commit has two parents and preserves the entire commit history.

Pros:
- Maintains full history and context of all changes.
- Clearly shows when and how features were integrated.
- Ensures traceability in collaborative projects.

Cons:
- The history may include extra merge commits, which some developers find noisy.

This strategy is strongly recommended by Atlassian for teams, as it provides the best traceability and minimizes the risk of losing context during integration.

### 2. Squash and Merge

Squash merge combines all commits from a feature branch into a single commit on the base branch. This creates a cleaner history but sacrifices the granularity of individual commits. It is most often used through the GitHub interface during pull request merges.

Pros:
- Produces a simple, linear commit history.
- Useful for integrating small, self-contained changes.

Cons:
- Removes detailed development steps.
- Replaces multiple authors and commit messages with a single summary.

While this strategy simplifies history, it is less suitable for collaborative development where understanding the evolution of a feature matters.

### 3. Rebase and Merge

Rebase re-applies the feature branch commits directly on top of the base branch, resulting in a linear history without a merge commit. The original commits are rewritten with new SHA identifiers.

Pros:
- Produces clean, linear history.
- Helps reduce merge commits in active repositories.

Cons:
- Rewrites history, which can be dangerous if multiple developers are working on the same branch.
- May lead to confusion or conflicts when others have already fetched the original commits.

Atlassian suggests that rebasing can be useful locally to tidy up commits before creating a pull request. However, it should not be used for shared branches that others rely on.

### Advanced: Recursive Strategy Options

By default, Git uses the recursive strategy for merges. This strategy can be customized with additional options:
- `-X ours` prefers the current branch during conflicts.
- `-X theirs` prefers the incoming branch during conflicts.
- Options like `--ignore-space-change`, `--patience`, and `--find-renames` allow finer control over how files are compared and merged.

These adjustments help resolve complex merge cases, such as whitespace conflicts or renamed files, with greater accuracy.

### Merge Policy Applied in This Repository

In alignment with Atlassian's best practices, I have configured the GitHub repository to allow only standard merge commits. The following settings were applied:

- Squash merging: Disabled
- Rebase merging: Disabled
- Merge commits: Enabled

This configuration ensures a safe and transparent development process, where the full context of each feature integration is preserved. It avoids rewriting history and supports better auditability across team contributions.

References:
- GitHub Docs: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/about-merge-methods-on-github
- Atlassian Git Tutorials: https://www.atlassian.com/git/tutorials/using-branches/git-merge
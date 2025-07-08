## Task 1: SSH Commit Signature Verification

### Why Signed Commits Are Important

Signed commits ensure the authenticity and integrity of changes in a Git repository. They allow collaborators to verify that a commit was truly created by the person it claims to be from, and that the commit hasn’t been tampered with.

In collaborative or open-source projects, unsigned commits could potentially be faked. Using signed commits provides:

- Trust: Developers and reviewers know changes come from a verified contributor.
- Security: Prevents malicious or impersonated commits.
- Accountability: Easier tracking of who introduced what changes.

GitHub recognizes signed commits and marks them with a Verified badge.

---

## Task 2: Comparison of Git Merge Strategies

| Strategy             | Description                                                                 | Pros                                                                 | Cons                                                                 |
|----------------------|-----------------------------------------------------------------------------|----------------------------------------------------------------------|----------------------------------------------------------------------|
| Merge (Default)      | Combines branches using a merge commit                                      | Keeps full commit history, simple to use                             | Can create a complex, "messy" history with many merge commits       |
| Squash and Merge     | Combines all commits from a branch into a single commit                     | Clean and compact history, ideal for small feature branches          | Original commit details are lost; authorship is partially hidden     |
| Rebase and Merge     | Reapplies commits from one branch onto another, creating a linear history   | Cleaner history, better for bisecting/debugging                      | Rewriting history can be risky; harder to trace original commits     |

### Why Standard Merge is Often Preferred

In team environments, standard merge is preferred because:

- It preserves the complete history of individual commits.
- It makes collaboration and code review easier.
- It avoids confusion caused by rewritten history (as with rebase).

While squash and rebase are useful in certain scenarios, they can hide valuable context in a team's development workflow.

---
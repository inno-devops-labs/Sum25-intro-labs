## Benefits of Signing Git Commits with SSH Keys

Signed commits are a critical part of maintaining code authenticity and integrity in collaborative environments. Here’s why:

1. **Authenticity & Trust**:  
   Signed commits confirm that a commit was authored by the verified identity of the developer. This helps teams trust that the code came from a legitimate contributor.

2. **Integrity Verification**:  
   With commit signing, you can verify that the commit has not been altered since it was created. This helps prevent malicious changes or tampering in the version history.

3. **Better Auditing and Compliance**:  
   In regulated or security-conscious environments, signed commits help satisfy compliance requirements (like SOC 2 or ISO 27001) and enhance traceability during audits.

4. **Visibility on Platforms like GitHub**:  
   GitHub displays a "Verified" badge for signed commits, increasing confidence in the commit's authenticity.

Commit signing can be done with **GPG keys** or **SSH keys**. Using SSH keys for this purpose is easier for users already using SSH for authentication.

### My git config

```
[user]
	signingkey = <private>
	email = <private>
	name = Slava Koshman
[commit]
	gpgSign = true
[gpg]
	format = ssh

```

> References:
> - [GitHub Docs on SSH Commit Verification](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification)  
> - [Atlassian Guide on Signing Commits](https://confluence.atlassian.com/bitbucketserver/sign-commits-and-tags-with-ssh-keys-1305971205.html)


---

## Git Merge Strategies: Comparison & Best Practices

When merging feature branches into a mainline branch (like `main` or `develop`), GitHub offers three primary strategies:

### 1. **Standard Merge (Create a Merge Commit)**

**How it works**:  
Git creates a new commit that combines the histories of both branches.

**Pros**:
- Maintains complete commit history.
- Clear context of when and how branches were integrated.
- Useful for understanding the progression of a feature and debugging.

**Cons**:
- Can lead to a "noisy" history with many commits and merge commits.
- Requires disciplined commit hygiene from contributors.

**Best for**:  
Collaborative teams that value traceability and detailed project history.

---

### 2. **Squash and Merge**

**How it works**:  
Combines all commits from the feature branch into a **single commit** on the target branch.

**Pros**:
- Cleaner commit history on the main branch.
- Ideal for small features or changes that don’t need detailed commit logs.

**Cons**:
- Loses granular commit history from the feature branch.
- Makes it harder to trace individual changes or authors.

**Best for**:  
Solo development, small fixes, or when commit quality is low.

---

### 3. **Rebase and Merge**

**How it works**:  
Reapplies each commit from the feature branch **on top of the target branch**, resulting in a linear history.

**Pros**:
- Creates a clean, linear history (good for short-lived branches).
- Easier to follow chronological progress.

**Cons**:
- Alters commit hashes (not safe for public/shared branches).
- Can be risky and confusing for beginners.

**Best for**:  
Advanced users who want a streamlined history and understand rebase risks.

---

### Why Standard Merge is Preferred in Teams

- **Auditability**: You retain the full history and author context.
- **Conflict Isolation**: Merge conflicts are handled once and clearly documented in the merge commit.
- **Team Workflow Compatibility**: Easier to trace which PR introduced a change — great for code reviews and debugging.

---

> Reference:
> - [GitHub: Merge, Squash, and Rebase](https://docs.github.com/en/pull-requests/collaborating-with-issues-and-pull-requests/about-pull-request-merge-squash-and-rebase)  
> - [Atlassian: Git Merge Strategies](https://www.atlassian.com/git/tutorials/using-branches/merge-strategy)

# Why Signing Commits is crucial for verifying the integrity and authenticity of commits

Signing commits using SSH keys (for example) is a way to prove the authenticity of the author and ensure the integrity of the commit content. It plays a crucial role in both the security and transparency of a project's version history.

Since SSH signing is easier to set up and is more widespread than GPG or S/MIME, it will be considered further.

## Benefits of Signing Commits with SSH

### 1. **Author Authentication**
Each developer uses a unique SSH key pair (private + public). Since the private key is securely stored on the computer and never shared, SSH commit signatures verify that the commit was actually made by the key holder — not by someone impersonating their name or email.

### 2. **Content Integrity**
A signed commit includes a cryptographic signature that reflects the exact content of the commit. Any change to the commit — even a single character — will break the signature. This ensures that commits cannot be altered without detection.

### 3. **Platform Verification**
Platforms like GitHub and Bitbucket automatically check commit signatures:
- They show signature status such as `Verified`, `Unverified`, or `Unknown key`.
- Projects can enforce rules to accept only signed commits or reject unsigned contributions.

This provides confidence during code review and repository maintenance.

### 4. **Resilience to Account Changes**
Unlike email- or account-based attribution, SSH-based signatures are independent of specific user accounts. Even if the author changes their GitHub username or loses access to their account, their past signed commits remain verifiable as long as the public key is accessible.

### 5. **Trust in Collaborative and Open Source Development**
SSH signatures help maintain a secure and trustworthy codebase, especially in projects with many contributors. They clearly show who made what change, and whether it can be trusted.

### 6. **Security Policy Integration**
Repositories and CI/CD pipelines can be configured to:
- Accept only verified commits and tags.
- Reject pull requests with unknown or invalid signatures.
- Block unsigned changes from unknown contributors.

---

# Merge Strategies Comparison

Git provides several strategies for integrating changes from one branch into another. The most common ones are:

### 🔹 Standard Merge
Creates a new merge commit that combines the histories of the two branches.
- **Pros**:
  - Preserves full commit history.
  - Clearly shows when and how branches were merged.
  - Ideal for collaborative environments where multiple contributors work on parallel branches.
- **Cons**:
  - History may become complex and harder to follow with many merge commits.

### 🔹 Squash and Merge
Collapses all the commits from a feature branch into a single commit before merging.
- **Pros**:
  - Keeps main branch history clean and linear.
  - Easier to revert a feature (since it’s a single commit).
- **Cons**:
  - Loses detailed commit history from the feature branch.
  - Makes it harder to trace individual changes and authorship.

### 🔹 Rebase and Merge
Reapplies the feature branch commits onto the base branch, one by one, creating a linear history.
- **Pros**:
  - Produces a clean, linear project history without merge commits.
  - Ideal for avoiding unnecessary branches in history.
- **Cons**:
  - Rewrites commit history, which can be dangerous if already shared with others.
  - Can cause conflicts that are harder to resolve than with standard merge.

---

### Why Standard Merge is Preferred in Collaborative Environments

In team settings, Standard Merge is often preferred because:
- It preserves individual commits and authorship, making it easier to review changes.
- It maintains context about how and when features were integrated.
- It avoids rewriting history, which is critical for avoiding conflicts in shared branches.
# Lab 1 Submission: DevOps with Git

## Task 1: SSH Commit Signature Verification

### Benefits of Signing Commits

Commit signing is a crucial security practice that provides several important benefits:

**Authentication and Identity Verification**
- Signed commits cryptographically prove that the commit was actually created by the claimed author
- Prevents impersonation attacks where someone could set their git config to any name/email
- Establishes a verifiable chain of trust for code changes

**Integrity Assurance**
- Signed commits detect if the commit content has been modified after creation
- Ensures that the code being reviewed hasn't been altered maliciously
- Provides a reliable audit trail for compliance and security reviews

**Security Benefits**
- Protects against supply chain attacks where malicious code could be injected
- Provides non-repudiation - authors cannot deny they made specific changes
- Critical for open-source projects where contributors may be unknown

### Setting Up SSH Commit Signing

**Step 1: Generate SSH Key**
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

**Step 2: Add SSH Key to GitHub**
1. Copy your public key: `cat ~/.ssh/id_ed25519.pub`
2. Go to GitHub Settings → SSH and GPG keys
3. Click "New SSH key" and paste your public key

**Step 3: Configure Git**
```bash
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgSign true
git config --global gpg.format ssh
```

**Step 4: Make Signed Commits**
```bash
git commit -S -m "Your signed commit message"
```

## Task 2: Merge Strategies in Git

### Comparison of Merge Strategies

**1. Standard Merge (Merge Commit)**
- Creates a new merge commit with two parent commits
- Preserves complete history of both branches
- Shows exactly when and how branches were integrated

*Pros:*
- Complete history preservation
- Clear branch visualization
- Easy to rollback entire features
- Great for collaborative development

*Cons:*
- Can create complex commit graphs
- Additional merge commits don't contain functional changes

**2. Squash and Merge**
- Combines all commits from feature branch into a single commit
- Creates clean, linear history on target branch
- Discards intermediate commit history

*Pros:*
- Clean, linear history
- Easy to revert entire features
- Eliminates "work in progress" commits

*Cons:*
- Loses detailed development history
- Harder to debug specific changes
- Large commits can be difficult to review

**3. Rebase and Merge**
- Replays commits from feature branch onto target branch
- Creates linear history without merge commits
- Preserves individual commits but changes relationships

*Pros:*
- Linear commit history
- Maintains individual commit messages
- No merge commit clutter

*Cons:*
- Rewrites commit history (changes SHAs)
- Loses branch context
- Can cause issues with shared branches

### Why Standard Merge is Preferred in Collaborative Environments

**Transparency and Accountability**
- Shows clear integration points for features
- Maintains visibility into team collaboration patterns
- Easy to track when pull requests were merged

**Safety and Reversibility**
- Can easily revert entire feature branches without losing history
- Non-destructive - doesn't rewrite or lose commit history
- Conflicts are resolved once at merge time

**Debugging and Maintenance**
- Easy to identify which branch introduced specific changes
- Maintains accurate timeline of feature development
- Works well with git bisect for debugging

**Team Workflow Compatibility**
- Works well when multiple people contribute to branches
- Aligns with pull request workflows
- Supports complex release branching strategies

## Repository Settings Configuration

To enforce standard merge strategy only:

1. Go to repository Settings on GitHub
2. Navigate to "Pull Requests" section
3. **Uncheck** "Allow squash merging"
4. **Uncheck** "Allow rebase merging"  
5. **Keep checked** "Allow merge commits"

This ensures that all merges use the standard merge strategy, maintaining full history and branch context for the team. 
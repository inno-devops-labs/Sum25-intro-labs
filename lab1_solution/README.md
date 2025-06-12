# Lab 1 Solution - DevOps with Git

This folder contains the complete solution for Lab 1: Introduction to DevOps with Git.
All .md files has been decorated and rephrased by chatgpt.

## 📁 Files Included

### 📋 `submission1.md`
**Main submission file** containing:
- **Task 1**: Comprehensive explanation of SSH commit signature verification
  - Benefits and importance of signed commits
  - Step-by-step setup instructions
  - Security considerations
- **Task 2**: Detailed analysis of Git merge strategies
  - Comparison of Standard Merge, Squash and Merge, and Rebase and Merge
  - Pros and cons of each strategy
  - Why Standard Merge is preferred in collaborative environments
  - Repository settings configuration instructions

### 🔧 `setup_ssh_signing.sh`
**Automated setup script** for SSH commit signing:
- Checks for existing SSH keys
- Generates new ed25519 SSH key if needed
- Configures Git for SSH signing
- Provides next steps for GitHub integration

**Usage:**
```bash
chmod +x setup_ssh_signing.sh
./setup_ssh_signing.sh
```

### 📖 `merge_strategies_guide.md`
**Quick reference guide** for Git merge strategies:
- Visual diagrams showing how each strategy works
- Command comparison table
- When to use each strategy
- Repository settings checklist
- Pro tips for effective branching

## 🎯 Lab Objectives Completed

### ✅ Task 1: SSH Commit Signature Verification
- [x] Researched and documented benefits of signed commits
- [x] Provided comprehensive setup instructions
- [x] Created automated setup script
- [x] Explained security implications

### ✅ Task 2: Merge Strategies Analysis
- [x] Analyzed all three merge strategies (Standard, Squash, Rebase)
- [x] Compared pros and cons of each approach
- [x] Explained why Standard Merge is preferred for collaboration
- [x] Provided repository configuration instructions


## 🔗 Additional Resources

- [GitHub SSH Commit Verification Documentation](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification)
- [Git Merge Strategies Documentation](https://git-scm.com/docs/git-merge)
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)

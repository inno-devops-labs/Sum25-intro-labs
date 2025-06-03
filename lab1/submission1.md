# Task 1

## Commit Signing

Commit signing is a way to cryptographically verify the identity of the author of a commit. Git supports multiple signing methods, including GPG and SSH keys. The signature is embedded in the commit and verified by platforms like GitHub and Bitbucket, which display a verification status (such as "Verified").

## Benefits of SSH Signing

### 1. Simple Setup

- SSH keys are already widely used for authentication with remote repositories.
- Does not require installing or configuring GPG, which can be complex, especially on Windows.
- Creating and adding SSH keys is quick and straightforward.

### 2. Enhanced Trust and Security

- Signed commits prove that the commit was created by a specific person (the SSH key owner).
- Helps prevent history tampering or malicious impersonation.

### 3. Platform Integration

- GitHub displays the signature status directly in pull requests and commit history.
- Commit signing can be enforced via branch protection rules.
- Bitbucket Server and Data Center (starting with version 8.8) also support SSH commit verification.

### 4. Reuse of Existing Keys

- The same SSH keys that are already used for repository access can be used again.
- No need to manage a separate GPG key.

### 5. Compliance and Audit Support

- Signed commits create a cryptographically verifiable trail of changes.
- Facilitates auditability and helps meet security and compliance requirements.

## Conclusion

Using SSH commit signatures is a  convenient way to prove authorship of code changes. It is especially valuable in collaborative development, open source projects, and environments with strong security requirements.


---

# Task 2

## Standard Merge

Creates a merge-commit and saves the change log of all branches

### Pros:

- Stores the full log of changes
- Is convenient for collaborative environments

### Cons:

- A large volume of merge-commits can clutter the commit history

## Squash and Merge

Combines all the commits in a branch before merging

### Pros:

- Increased history readability

### Cons:

- Information about intermediate commits is lost

## Rebase and Merge

Applies all commits over the base branch

### Pros:

- Linear history with no merge commits

### Cons:

- Can be dangerous in collaborative environments

## Why Standard Merge is Prefered

Because it:

- Saves the full commit history
- Allows for an easy management of who and when applied what changes
- Does not rewrite history, making it safe for collaborative projects
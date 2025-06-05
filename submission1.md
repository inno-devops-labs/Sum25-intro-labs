# ssh commit signature verification

### Objective: Understand the importance of commit signing using SSH keys and set up commit signature verification.

Benefits of signed commits:
- Commits, which are marked as verified helps users to be confident that the changes come from a trusted source.
- Sign is authomatically checks with cryptographic algorithms and verifies with open key.
- If intruder will try to fake commit it's status will change to 'Univerified'
- Github will save status even if key will be expired.

# Signing commits 

Signing commits cryptographically verifies:

- Authenticity: Confirms the commit was made by you (not an imposter).
- Integrity: Guarantees the commit content hasn't been altered since you signed it.
- Non-repudiation: Prevents you from later denying you made the commit. 

# Merging strategies

**Standard Merge**
- Combines branches with a merge commit.
- *Pros*: Preserves full commit history and context; clear integration points.
- *Cons*: History can become cluttered.

**Squash and Merge**
- Condenses all feature branch commits into one commit.
- *Pros*: Simplifies history.
- *Cons*: Loses granular commit details; obscures collaboration context.

**Rebase and Merge**
- Reapplies feature commits onto the base branch tip.
- *Pros*: Creates linear history.
- *Cons*: Alters commit hashes (risky for shared branches); loses original context.

**Why Standard Merge Is Preferred for Collaboration**
- Preserves complete history for auditing and issue tracking.
- Non-destructive (no hash changes), ensuring consistency.
- Explicitly documents feature integration points.
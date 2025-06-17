# Why Signing Commits Matters

## 1. Authenticity — Verifying Identity

When you sign a commit using SSH or GPG, you cryptographically attach your identity to that change. GitHub and other platforms display a “Verified” badge when they confirm the signature.

This protects against:

- Impersonation (e.g., someone pushing code pretending to be a trusted contributor)
- Insider threats, since it enforces accountability

> Example:
> Without a signature, anyone can push code under your name if they control your Git credentials. With SSH/GPG signing, even stolen credentials aren't enough — they need your private key.

## 2. Integrity — Tamper Protection

A signed commit includes a cryptographic hash of the commit data and your signature. If the commit is altered in any way, the signature will become invalid.

This prevents:

- Silent alterations after review
- Tampering in the CI/CD pipeline or via third-party access

## 3. Supply Chain Security

Organizations increasingly rely on contributions from multiple sources (open-source, contractors, distributed teams).

Signed commits help ensure:

- Only authorized identities contribute
- Provenance of code changes is trackable

This is crucial in light of attacks like SolarWinds, where attackers injected malicious code into trusted repositories.

## 4. Compliance and Audit Trails

Regulatory standards (e.g., SOC 2, ISO 27001, NIST) require traceability and secure code lifecycle practices.

Signed commits:

- Serve as immutable, verifiable audit logs
- Satisfy requirements for secure software development frameworks (SSDF)

## 5. Platform-Level Enforcement (e.g., GitHub)

GitHub allows repositories to require signed commits before accepting pull requests.

With [SSS](https://ru.wikipedia.org/wiki/SSH) or [GPG](https://ru.wikipedia.org/wiki/GnuPG)-based enforcement:

- You can block unsigned or unverified code
- Ensure only verified contributors merge changes

## Summary

Signing commits boosts trust, security, and traceability in your codebase. Whether for open-source or enterprise-scale development, it is a fundamental practice to defend against impersonation, tampering, and supply chain threats.

# Research Merge Strategies

Each merge strategy (Standard Merge, Squash, Rebase) serves different collaboration and history-cleanliness goals. Standard Merge is often preferred in collaborative teams because it preserves full context and commit history.

## Merge Strategy Comparison

|Strategy|Description|Pros|Cons|
|---|---|---|---|
|**Standard Merge**|Creates a merge commit combining two branches|✅ Retains full history  <br>✅ Clear source of changes  <br>✅ Good for audits|❌ Can create complex history in long-running projects|
|**Squash and Merge**|Combines all commits into a single one before merging|✅ Clean main branch  <br>✅ Easier to revert single features|❌ Original commit history lost  <br>❌ Harder to trace who contributed what|
|**Rebase and Merge**|Replays feature branch commits onto the base branch, then fast-forwards|✅ Linear, clean history  <br>✅ Maintains individual commits|❌ Loses original branch context  <br>❌ Risk of rewriting shared history|

## Why Standard Merge is preferred in collaborative environments

- Preserves context: You see exactly how and when a feature was merged.
- No history rewriting: Safe for multi-developer workflows.
- Merge commits clearly mark integration points, useful for code reviews, audits, and rollback scenarios.
- Easier to resolve and document merge conflicts once, rather than rebasing/cherry-picking each commit.

## Summary

- Use Standard Merge for safe, auditable, and team-friendly history.
- Use Squash for solo features or when history noise is too high.
- Use Rebase for clean linear history before merging—but avoid on shared branches to prevent chaos.

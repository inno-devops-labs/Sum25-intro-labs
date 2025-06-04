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

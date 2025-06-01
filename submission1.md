# Labik Pervyy

### Task 1: Why use signed commits?
I can list several reasons:
1. By default, Git allows its users to commit using any arbitrary name or e-mail as the claimed authorship, making it very easy to impersonate someone else. Using signed commits ensures that only the holder of a specific private key has the ability tp commit under specific name, thereby confirming its authorship.
2. It guarantees that the commit hasn't been tampered with by another user - for example, a malicious actor could fork the original repository, create their own commit containing the same metadata as the one in the original, and introduce a backdoor into the code. If this fork then goes public, and a user isn't careful, they could download and use the modified repository. If the original commit was signed though, it is significantly harder for the malicious actor to replicate it, as they would need the original author's private key for it.
3. Enforcing signed commits as a policy in a collaborative development environment provides a verifiable trail of who introduced what changes to the repository, aiding in audits and code reviews.

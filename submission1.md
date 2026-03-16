# Why to sign commits.
The very heart of the practice of signing commits with SSH or GPG keys is an assurance of the irrevocable integrity and authenticity of the code contributions in question. In signing commits, one gives cryptographic proof that changes have indeed been made by one and are untampered with, thus preventing impersonation and the building of trust in an individual's repository. In open-source projects or collaborative setups, where verification of the contributor's identity limits the injection of malicious code, this becomes all the more necessary. Signed commits, for their part, facilitate auditability by making it easier to pinpoint the origin of changes and keep a secure development workflow.


# Merge Strategies in Git
The classic merge strategy preserves a complete commit history by creating a merge commit. This is the ideal one in collaborative settings because it does maintain traceability and context. Squash and merge simplifies the history by reducing feature branch commits into one, yet that granularity of each step disappears, making debugging a little more difficult at times. Rebase and merge achieves a linear history by effectively reapplying my commits on top of the target branch. And it does pose that risk of rewriting public history causing conflicts for other collaborators. Standard merges are generally preferred in a team setting as it presents a clear record of branch integration without rewriting history and hence providing transparency and auditability for the ease of others.

![alt text](image.png)
![alt text](image-1.png)
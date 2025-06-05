# Labik Pervyy

### Task 1: Why use signed commits?
I can list several reasons:
1. By default, Git allows its users to commit using any arbitrary name or e-mail as the claimed authorship, making it very easy to impersonate someone else. Using signed commits ensures that only the holder of a specific private key has the ability tp commit under specific name, thereby confirming its authorship.
2. It guarantees that the commit hasn't been tampered with by another user - for example, a malicious actor could fork the original repository, create their own commit containing the same metadata as the one in the original, and introduce a backdoor into the code. If this fork then goes public, and a user isn't careful, they could download and use the modified repository. If the original commit was signed though, it is significantly harder for the malicious actor to replicate it, as they would need the original author's private key for it.
3. Enforcing signed commits as a policy in a collaborative development environment provides a verifiable trail of who introduced what changes to the repository, aiding in audits and code reviews.

### Task 2: Git Merge Strategies Comparison

#### 1. Standard Merge

Standard merge integrates one branch into another with a new merge commit that has the two branches as parents, preserving complete history. The benefits are as follows:
1. Standard merge preserves the commit history, so every individual commit remains accessible, which is very useful for debugging and understanding the workflow on the project.
2. It is easier to revert a full feature if needed by reverting the merge commit.
3. No history rewriting makes it significantly safer for branches shared between several developers (if old commits and their hashes disappear, any possible references to them will become meaningless; the history for different developers will also diverge, and recovering from that divergence might be problematic).

The problems with the standard merge:
1. History on very active projeccts requiring multiple merges in quick succession will generate many minor commits, making reading it difficult.
2. Merge commits can create a non‑linear graph, which may be difficult to interpret.

---

#### 2. Squash and Merge

In squash and merge all commits from the feature branch are squashed into a single commit which is then merged, so the branch's divergent structure is flattened.

Benefits:
1. Produces a concise, linear history on the branch you merge into.
2. Hides "noise" such as fix‑up commits or small WIP steps.
3. Cherry‑picking or rolling back a whole feature requires reverting just one commit.

Problems:

1. You lose granular commit information, making it harder to understand when or why a specific line changed.
2. You also lose commit-level metadata (authors, messages, timestamps), further complicating analysis and integration.
3. Merge commit hash differs from original commits, complicating cross‑branch comparisons.

---

#### 3. Rebase and Merge

Rebase and merge replays each commit from the head branch onto the tip of the base branch, then performs a fast‑forward merge (with no merge commit).

Benefits:
1. You get a perfectly linear history with original commit granularity intact.
2. Keeps blame annotations accurate without extra merge commits.
3. Allows resolving conflicts per commit, leading to smaller conflict scopes.
4. Allows rewriting history or integrating smaller commits into single commits, so you can perform clean-up of the branch while rebasing interactively.

Problems:
1. Commit hashes are still rewritten, which is dangerous on shared/public branches because it forces different developers to force‑push to tie together divergent histories.
2. Conflicts may need to be resolved repeatedly if many commits touch the same area.
3. Losing the original branch history can hinder understanding or the context of changes.

---

#### Why Standard Merge Is Often Preferred for Collaborative Environments:

1. It is good for safety, as the published history is never rewritten, avoiding force‑push accidents.
2. The merge commit essentially groups all the work on the head branch; you can revert or audit it alone.
3. Multiple developers can merge simultaneously without rebasing gymnastics.
4. Some organizations must retain full history of development for audit purposes, which squash or rebase can obscure or destroy.

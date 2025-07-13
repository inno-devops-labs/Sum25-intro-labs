# Lab 1 Submission

## 1. Benefits of SSH‐Signed Commits

1. **Authentication of Author**  
   By signing a commit with your private key, GitHub verifies that the author is you. This prevents someone from using your username on a shared repository.

2. **Integrity**  
   Each signed commit contains a cryptographic signature. If anyone modifies commit after it was signed, the signature no longer matches, so the server knows it’s been changed.

3. **Accountability in Teams**  
   In a team or open-source project, having every commit signed means that you can trace who authored each change.

4. 

## 2: Git Merge Strategies - A Quick Look

1. **Standard Merge (Merge Commit)**:
   
   * Creates a special "merge commit" that ties the histories of your feature branch and main branch together.
   * Keeps the full history of your feature branch, showing exactly when it was merged. Easy to undo the whole feature if needed.
   * Can make the main history look a bit cluttered with lots of merge bubbles if you merge often.

2. **Squash and Merge**:
   
   * Takes all the little commits you made on your feature branch and squishes them into *one single commit* on the main branch.
   * Keeps the main branch history super clean and tidy – one commit per feature.
   * You lose the detailed step-by-step history of how you built the feature.

3. **Rebase and Merge**:
   
   * Takes your feature branch commits and re-applies them, one by one, on top of the latest changes in the main branch. This makes your feature branch look like it was created *after* the latest main branch changes.
   * Results in a perfectly straight, linear history. No merge commits.
   * It rewrites history (changes your commit IDs), which can be confusing or problematic if others are using your feature branch. It also hides when the feature work *actually* happened in parallel.

**Why Standard Merge is Often a Good Default for Teams:**

Even though "squash" and "rebase" can make the history look cleaner, the **standard merge (with a merge commit)** is often preferred in teams because:

* **It's Honest**: It shows the true story – that work was done on a separate branch and then brought in.
* **Preserves Details**: You don't lose any of the individual steps or thoughts captured in your feature branch commits. This is helpful for understanding how a feature was built or for later debugging.
* **Feature Boundaries**: The merge commit clearly marks "this is when Feature X was added."

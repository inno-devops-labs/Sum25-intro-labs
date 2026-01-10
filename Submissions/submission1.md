# Task 1: SSH Commit Signature Verification

**Brief summary explaining the benefits of signing commits.**

Commits can be signed using GPG, SSH, or S/MIME. The main goal for signing commits is verification of authenticity. This ensures that commits were actually made by the claimed author, preventing impersonation. 

Also signing commits helps with:
   - Tamper Protection – Confirms that the commit content hasn’t been altered after signing. 
   - Trust & Integrity – Helps teams verify the legitimacy of changes, especially in open-source or collaborative projects. 
   - Compliance – Meets security requirements for organizations that mandate signed commits.

# Task 2: Merge Strategies in Git

- **Standard Merge**: Combines two branches by creating a merge commit.

    This retains the full development history and shows exactly when the merge occurred.

    History can become “noisy” with a large number of merges.

    Diagram:
    ```
    A---B---C---------G  (main)
             \       /
              D---E---F  (feature)
    ```

- **Squash and Merge**: Combines all commits from a feature branch into a single commit before merging.

    All commits from a branch are merged into a single commit that is applied to the main branch.

    It helps to make a clean history - one commit per feature.

    But the detailed history of changes within the branch is lost.

    Diagram:
    ```
    A---B---C---G  (main)
    ```

- **Rebase and Merge**: Reapplies commits from a feature branch onto the base branch.

    Consistently moves commits from the feature branch to the main branch on top of the most recent version of the main branch.

    This method creates a linear, clean history without merge commits. Leads to difficulties with conflicting rebases. Not recommended for public branches, because the history is changed.

    Diagram:
    ```
    A---B---C---D'---E'---F'  (main)
    ```


- **Authentication**: Confirms that the commit was actually made by the specified author
- **Integrity**: Ensures that the commit content has not been modified
- **Security**: Protects against authorship spoofing and malicious changes
- **Trust**: Increases confidence in the project's change history
- **Compliance**: Many corporate projects require signed commits


## Task 2: Merge Strategies in Git

### Merge Strategies:

#### 1. Standard Merge (Regular Merge)
- **Description**: Creates a merge commit, preserving the history of both branches
- **Pros**: Preserves complete history, easy to revert, all individual commits are visible
- **Cons**: Can create complex history with multiple branches

#### 2. Squash and Merge
- **Description**: All commits from the feature branch are combined into a single commit
- **Pros**: Clean linear history, one commit per feature
- **Cons**: Detailed development history of the feature is lost

#### 3. Rebase and Merge
- **Description**: Commits are moved to the top of the base branch without a merge commit
- **Pros**: Linear history without merge commits
- **Cons**: Rewrites history, can be dangerous in team collaboration

### Why Standard Merge is preferred in collaborative environments:

- **Transparency**: Clearly shows when and what changes were added
- **Safety**: Doesn't rewrite history, which is important in team work
- **Traceability**: Easier to find the source of bugs and revert changes
- **Context**: Preserves information about how the feature was developed

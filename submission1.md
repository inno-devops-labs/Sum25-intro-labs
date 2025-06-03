## Task 1

1. Verifies Authorship: Digitally signing commits confirms that the commit was made by the legitimate author, preventing impersonation
2. Ensures Integrity: Signed commits guarantee that the content has not been altered since it was signed, safeguarding against tampering.

**Summary**: By incorporating commit signing into your development workflow, you enhance the security and reliability of your codebase, fostering greater confidence among collaborators and users


## Task 2

### 1. Standard Merge
This combines two branches by creating a new commit that connects them.

Pros:

- Keeps the full history: you can see when a branch was created and when it was merged

- Easy to find all the commits related to one feature or pull request

- Doesn’t change any existing commits

Cons:

- The commit history can get messy, especially with many small branches

- If the feature branch has lots of small or unimportant commits, they all stay and make the history harder to read


### 2. Squash and Merge

This turns all commits from a branch into one single commit before merging

Pros:

- Creates a clean and simple history — one commit per feature

- Easy to undo a feature by removing just that one commit

- Hides messy or unimportant commit messages

Cons:

- You lose detailed history of how the feature was developed

- You cant go back and look at small changes within the feature they are all combined


### 3. Rebase and Merge
This moves all commits from the feature branch on top of the main branch, like they were written last

Pros:

- The history looks clean and straight

- No merge commits are created

Cons:

- Rebasing changes commit IDs, which can cause problems when working with others

- You can’t see whether a feature was developed at the same time as others or afterward


###  Why the standard merge strategy is often preferred in collaborative env.

- It doesn’t change history, which is safer for teamwork

- Makes it easier to find bugs or track changes by showing all related commits

- It’s the most reliable and easy to use way to combine code

- Helps everyone on the team understand how development has progressed


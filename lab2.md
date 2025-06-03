# Version Control

In this lab, you will learn about version control systems and their importance in collaborative software development. You will specifically focus on Git, one of the most widely used version control systems. Follow the tasks below to complete the lab assignment.

## Task 1: Understanding Version Control Systems

**Objective**: Understand how Git stores data.

1. **Create and Explore a Repository**:
   - Use the current repository and make a few commits.
   - Use `git cat-file` to inspect the contents of blobs, trees, and commits.

     ```sh
     # Example commands to inspect contents
     git cat-file -p <blob_hash>
     git cat-file -p <tree_hash>
     git cat-file -p <commit_hash>
     ```

   - Create a `submission3.md` file.
   - Provide the output in the `submission3.md` file.

## Task 2: Practice with Git Reset Command

**Objective**: Practice using different ways to use the `git reset` command.

1. **Create a New Branch**:
   - Create a new branch named "git-reset-practice" in your Git repository.

     ```sh
     git checkout -b git-reset-practice
     ```

2. **Explore Advanced Reset and Reflog Usage**:
   - Create a series of commits.

     ```sh
     echo "First commit" > file.txt
     git add file.txt
     git commit -m "First commit"
     
     echo "Second commit" >> file.txt
     git add file.txt
     git commit -m "Second commit"
     
     echo "Third commit" >> file.txt
     git add file.txt
     git commit -m "Third commit"
     ```

   - Use `git reset --hard` and `git reset --soft` to navigate the commit history.

     ```sh
     git reset --soft HEAD~1
     git reset --hard HEAD~1
     ```

   - Use `git reflog` to recover commits after a reset.

     ```sh
     git reflog
     git reset --hard <reflog_hash>
     ```

3. **Documentation**:
   - Document the steps taken and push the final state to GitHub.
   - Document your practice in the `submission3.md` file and include the following details:
     - Steps you took to perform the Git reset operations.
     - Explain the reset and reflog process in the `submission3.md`.
     - Examples and outputs of the commands executed.

## Additional Resources

- [Git Documentation](https://git-scm.com/doc)
- [Pro Git Book](https://git-scm.com/book/en/v2)

### Guidelines

- Use proper Markdown formatting for documentation files.
- Organize files with appropriate naming conventions.
- Create a Pull Request to the main branch of the repository with your completed lab assignment.

> Note: Actively explore and document your findings to gain hands-on experience with Git.

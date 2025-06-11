# Version Control

In this lab, you will learn about version control systems and their importance in collaborative software development. You will specifically focus on Git, one of the most widely used version control systems. Follow the tasks below to complete the lab assignment.

---

## Task 1: Understanding Version Control Systems

**Objective**: Understand how Git stores data.

1. **Create and Explore a Repository**:

   * Use the current repository and make a few commits.
   * Use `git cat-file` to inspect the contents of blobs, trees, and commits.

     ```sh
     # Example commands to inspect contents
     git cat-file -p <blob_hash>
     git cat-file -p <tree_hash>
     git cat-file -p <commit_hash>
     ```

2. **Documentation**:

   * Create a `submission2.md` file.
   * Provide the output and a short explanation of what each object represents.

---

## Task 2: Practice with Git Reset Command

**Objective**: Practice using different ways to use the `git reset` command.

1. **Create a New Branch**:

   * Create a new branch named `git-reset-practice` in your Git repository.

     ```sh
     git checkout -b git-reset-practice
     ```

2. **Explore Advanced Reset and Reflog Usage**:

   * Create a series of commits:

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

   * Use `git reset --soft` and `git reset --hard` to explore how they affect the working directory and history.

     ```sh
     git reset --soft HEAD~1
     git reset --hard HEAD~1
     ```

   * Use `git reflog` to view and recover previous commits.

     ```sh
     git reflog
     git reset --hard <reflog_hash>
     ```

3. **Documentation**:

   * Document all steps and push the final state to GitHub.
   * In `submission2.md`, include:

     * Steps you took for each reset command.
     * Screenshots or code outputs of `git log` and `git reflog`.
     * A brief explanation of what happened at each step.

---

## Task 3: Visualizing Git Commit History

**Objective**: Use Git’s log features to visualize your project’s commit history and branching.

1. **Create Several Commits**:

   * On your current branch, make 3 or more simple commits:

     ```sh
     echo "Commit A" > history.txt
     git add history.txt
     git commit -m "Commit A"

     echo "Commit B" >> history.txt
     git add history.txt
     git commit -m "Commit B"

     echo "Commit C" >> history.txt
     git add history.txt
     git commit -m "Commit C"
     ```

2. **Explore the Commit Graph**:

   * Run the following command to view a simple commit graph:

     ```sh
     git log --oneline --graph --all
     ```

3. **Optional Branching**:

   * Create a new branch, make a commit, and view the log again:

     ```sh
     git checkout -b side-branch
     echo "Branch commit" >> history.txt
     git add history.txt
     git commit -m "Side branch commit"
     git checkout main
     git log --oneline --graph --all
     ```

4. **Documentation**:

   * In `submission2.md`, include:

     * A copy-pasted or screenshot snippet of the commit graph.
     * The list of commit messages.
     * A short reflection (1–2 sentences) about how this visualization helps understand collaboration and branching.

---

## Task 4: Tagging a Commit

**Objective**: Learn how to create and push a Git tag to mark a specific state of your project.

1. **Tag the Current Commit**:

   * On your current branch (e.g., `main`), tag the latest commit as `v1.0.0`:

     ```sh
     git tag v1.0.0
     git push origin v1.0.0
     ```

2. **(Optional) Create Another Tag**:

   * Make one more commit and create a `v1.1.0` tag for additional practice.

3. **Documentation**:

   * In `submission2.md`, include:

     * The tag name(s) you created.
     * The command(s) used.
     * The associated commit hash(es).
     * A short sentence explaining the value of tagging in software development (e.g., versioning, CI/CD triggers, release notes).

---

## Bonus Task: GitHub Social Interactions 🌟

**Objective**: Understand GitHub’s social features and contribute to the course's collaborative culture.

1. **Star the Course Repository** ⭐️

   * Go to the GitHub page of the course repository.
   * Click the “Star” button at the top right.

2. **Follow Your Classmates, TAs, and the Professor** 👥

   * Visit the GitHub profiles of:

     * Your professor
     * Teaching assistants (TAs)
     * At least 3 classmates
   * Click the “Follow” button on each profile.

3. **Update `submission2.md`**

   * Add a section titled **"Task 3: GitHub Social Interactions"**.
   * Include:
     * 1–2 sentences about why social features on GitHub can be useful in open source or team-based projects.

---

## Additional Resources

* [Git Documentation](https://git-scm.com/doc)
* [Pro Git Book](https://git-scm.com/book/en/v2)

---

### Guidelines

* Use proper Markdown formatting for documentation files.
* Organize files with appropriate naming conventions.
* Create a Pull Request to the main branch of the repository with your completed lab assignment.

> Note: Actively explore and document your findings to gain hands-on experience with Git.

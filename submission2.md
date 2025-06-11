# Lab #2 Submission: Version Control

## Task 1: Understanding Version Control Systems

In this task, I explored the internal data structure of Git by inspecting its core objects: commits, trees, and blobs.

### Steps and Outputs

1.  **Created a new file and made a commit.**

    ```sh
    echo "This is a test file for Task 1." > submission3.md
    git add submission3.md
    git commit -m "feat: Add submission3.md for Task 1"
    ```

2.  **Found the latest commit hash using `git log`.**

    ```sh
    $ git log --oneline -1
    5d01d48 (HEAD -> main) feat: Add submission3.md for Task 1
    ```
    *(Note: My actual hash is `5d01d48`)*

3.  **Inspected the commit object.** This object points to a tree and a parent commit.

    ```sh
    $ git cat-file -p 5d01d48
    tree ce6cb72aa763d14e34e67d58ab79e22ac52ff8b6
    parent efc6877fdab405d139e890bed21f91d630b0043c
    author luzinsan <luzinsan@mail.ru> 1749623657 +0300
    committer luzinsan <luzinsan@mail.ru> 1749623657 +0300
    gpgsig -----BEGIN SSH SIGNATURE-----
    U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAg0twQmcR+2XkGEqeJ8tYgGTIviq
    qqdS34ZgmOvy2YvVsAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
    AAAAQGl2HyrMr4EKw99ebOyQo8YzQBUzHFK/BSQoc//e2JC8//SnTBxWRFEQB1lZl2op9q
    ocGnA1kUeiaZL0SQaOsws=
    -----END SSH SIGNATURE-----

    feat: Add submission3.md for Task 1
    ```

4.  **Inspected the tree object.** This object acts like a directory, listing the files and their content hashes (blobs).

    ```sh
    $ git cat-file -p ce6cb72
    100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
    100644 blob b36d534179329b51d46a7628e8cd8ea92a267fb4    image-1.png
    100644 blob e7040c435529d35fa5978e1bed9f1147a3bdfb60    image-2.png
    100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
    100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
    100644 blob a210efe728e18fd98f69d780672a821c2fa6e4fa    submission1.md
    100644 blob 34464d72c1f48a238a2cd4407bd2e69ebde932f8    submission3.md
    ```

5.  **Inspected the blob object.** This object contains the raw content of the file.

    ```sh
    $ git cat-file -p 34464d72c
    This is a test file for Task 1.
    ```

## Task 2: Practice with Git Reset Command

In this task, I practiced using `git reset` with `--soft` and `--hard` flags and learned how to recover from a hard reset using `git reflog`.

### Explanation of the Process

-   **`git reset --soft`**: This command moves the `HEAD` pointer to a specified commit but does not touch the staging area or the working directory. The changes from the "undone" commits are kept in the staging area, ready to be re-committed. It's useful for amending the last commit.
-   **`git reset --hard`**: This is a more drastic command. It moves the `HEAD` pointer and resets both the staging area and the working directory to match the specified commit. Any uncommitted changes and all changes from the "undone" commits are permanently discarded from the working tree.
-   **`git reflog`**: This is a safety net. Git keeps a log of every time the `HEAD` reference changes. `reflog` allows you to see this history of movements. Even if a commit is no longer reachable from any branch (`git log`), it often still exists in the reflog, allowing you to find its hash and restore it using `git reset --hard <hash>`.

### Steps and Outputs

1.  **Created a new branch and a series of three commits.**

    ```sh
    $ echo "Some commit" > test_reset.txt && git add test_reset.txt && git commit -m "feat: (first commit) added file for test the reset command"
    $ echo "Second commit" >> test_reset.txt && git add test_reset.txt && git commit -m "feat: second commit"
    $ echo "Third commit" >> test_reset.txt && git add test_reset.txt && git commit -m "feat: third commit"

    $ git log
    commit 38807e9444f1c26d823eacfa2abf66bbe5b28df7 (HEAD -> lab2)
    Author: luzinsan <luzinsan@mail.ru>
    Date:   Wed Jun 11 10:49:29 2025 +0300

        feat: third commit

    commit eb3e7eb9239a8203792369cccd3b1f893d8e3e54
    Author: luzinsan <luzinsan@mail.ru>
    Date:   Wed Jun 11 10:49:02 2025 +0300

        feat: second commit

    commit 20bfa6cdfc09bb93af2de175e09cd479d802cfcf
    Author: luzinsan <luzinsan@mail.ru>
    Date:   Wed Jun 11 09:56:31 2025 +0300

        feat: (first commit) added file for test the reset command
    ```

2.  **Performed a `git reset --soft` to undo the last commit.**

    ```sh
    $ git reset --soft HEAD~1

    $ git log --oneline
    eb3e7eb (HEAD -> lab2) feat: second commit
    20bfa6c feat: (first commit) added file for test the reset command
    db505ec doc: added report for task#1

    $ git status
    On branch lab2
    Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
            modified:   test_reset.txt
    ```
    The "Third commit" is gone from the log, but its changes are staged.

3.  **Performed a `git reset --hard` to discard the last commit.** (First, I recommitted the changes to have a clean state).

    ```sh
    $ git commit -m "feat: Third commit (restored)"
    $ git reset --hard HEAD~1

    $ git log --oneline
    eb3e7eb (HEAD -> lab2) feat: second commit
    20bfa6c feat: (first commit) added file for test the reset command
    db505ec doc: added report for task#1

    $ git status
    On branch lab2
    nothing to commit, working tree clean

    $ cat test_reset.txt
    Some commit
    Second commit
    ```
    The "Third commit" and its changes were completely removed from the working directory.

4.  **Recovered the "lost" commit using `git reflog`.**

    ```sh
    $ git reflog
    eb3e7eb (HEAD -> lab2) HEAD@{0}: reset: moving to HEAD~1
    4c4ceb3 HEAD@{1}: commit: feat: Third commit (restored)
    eb3e7eb (HEAD -> lab2) HEAD@{2}: reset: moving to HEAD~1
    38807e9 HEAD@{3}: commit: feat: third commit
    eb3e7eb (HEAD -> lab2) HEAD@{4}: commit: feat: second commit
    20bfa6c HEAD@{5}: commit (amend): feat: (first commit) added file for test the reset command
    20bfa6c HEAD@{5}: commit (amend): feat: (first commit) added file for test the reset command
    89b3003 HEAD@{6}: commit (amend): feat: added file for test the reset command
    5d447d4 HEAD@{7}: commit: feat: added file for test the command
    db505ec HEAD@{8}: commit: doc: added report for task#1
    ...

    # Found the hash of the lost commit (4c4ceb3) and restored it.
    $ git reset --hard 4c4ceb3

    $ git log --oneline
    4c4ceb3 (HEAD -> lab2) feat: Third commit (restored)
    eb3e7eb feat: second commit
    20bfa6c feat: (first commit) added file for test the reset command
    db505ec doc: added report for task#1
    5d01d48 feat: Add submission3.md for Task 1
    ```
    The commit was successfully recovered, demonstrating the power of the reflog.
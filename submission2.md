# Version Control

## Task 1: Understanding Version Control Systems

**Objective**: Understand how Git stores data.

First of all, I created a commit, which is displayed in the output of the `git log` command.

Output of this command about my commit is next:
```sh
commit c56dc286a0f37af31f5e941605c295a09f6851ee (HEAD -> lab2-solution)
Author: Gleb Stoyko <stojko.g@yandex.ru>
Date:   Thu Jun 12 20:49:34 2025 +0300

    Added first commit for lab2

```

In this output, we can see the hash of our commit.

The command `git cat-file -p <hash>` allows you to view the contents of a Git object:
- `commit` — commit metadata

- `tree` — list of files in this tree

- `blob` — file content (text, etc.)

Let's take a look at the commit metadata using the command:
```sh
git cat-file -p c56dc286a0f37af31f5e941605c295a09f6851ee
```

We received the following command output:
```sh
tree 7594f80568f9a8675ec8abfaba6c5dbb136a27f4
parent 1b6f9d55b4f7d0460f662b752e56aaa18c832568
author Gleb Stoyko <stojko.g@yandex.ru> 1749750574 +0300
committer Gleb Stoyko <stojko.g@yandex.ru> 1749750574 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgj7EltwWIu1Dhwce2e5vmse5sno
 guCeKPV1kNcdbJAtoAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQCKpgoNhVKjFnvQE2/fE+5eL5ShxinnQ4L1L/myvM6iHuidcrY1Mgl7t3hXbvHj9Qd
 fqcXi96jkxlKpsF8aPSQE=
 -----END SSH SIGNATURE-----

Added first commit for lab2
```

In this output we can see hash of tree, hash of previous commit and other useful information about the commit.

Let's take a look at the tree files using the command:
```sh
git cat-file -p 7594f80568f9a8675ec8abfaba6c5dbb136a27f4
```

We received the following command output:
```sh
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
100644 blob 30d74d258442c7c65512eafab474568dd706c430    lab2_task1_first_file.txt
100644 blob c97ae21f480aee4ed3a5e49fb405d4e64af49a79    submission1.md
```

In this output we can see file access rights, blobs and it's hashes and file names.

Let's see file `lab2_task1_first_file.txt` content using command:
```sh
git cat-file -p 30d74d258442c7c65512eafab474568dd706c430 
```

Output:
```sh
test
```

We have seen the contents of this file.

---

## Task 2: Practice with Git Reset Command

**Objective**: Practice using different ways to use the `git reset` command.

1. I created a new branch for the task with command `git checkout -b git-reset-practice`.

    Then I created three commits with changes to `file.txt`:
    ```sh
    echo "First commit" > file.txt
    git add file.txt
    git commit -m "First commit"

    echo "Second commit" > file.txt
    git add file.txt
    git commit -m "Second commit"

    echo "Third commit" > file.txt
    git add file.txt
    git commit -m "Third commit"
    ```

    We can see commit history after creating three commits with command `git log --oneline`. Output:
    ```sh
    1ac9672 (HEAD -> git-reset-practice) Third commit
    480da15 Second commit
    dd35df1 First commit
    ```

2. After using command `git reset --soft HEAD~1` we can see with command `git log --oneline` next output:
    ```sh
    480da15 (HEAD -> git-reset-practice) Second commit
    dd35df1 First commit
    ```

    **Conclusion**: The last commit was removed from history, but the changes are still staged.

3. After using command `git reset --hard HEAD~1` we can see with command `git log --oneline` next output:
    ```sh
    dd35df1 (HEAD -> git-reset-practice) First commit
    ```
    **Conclusion**: The last commit was removed from history and the working directory was reset.

4. After using command `git reflog` we can see next output:
    ```sh
    dd35df1 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
    480da15 HEAD@{1}: reset: moving to HEAD~1
    1ac9672 HEAD@{2}: commit: Third commit
    480da15 HEAD@{3}: commit: Second commit
    dd35df1 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
    d5222a5 (lab2-solution) HEAD@{5}: checkout: moving from lab2-solution to git-reset-practice
    ```

    `git reflog` records movements of HEAD. It allows us to recover commits that are no longer visible in `git log`, such as after a reset or rebase.
    
    We can recover our commits with command `git reset --hard <reflog_hash>`. Let's restore our commits using the commands:
    ```sh
    # Restore Second commit
    git reset --hard 480da15

    # Restore Third commit
    git reset --hard 1ac9672
    ```

    Let's see on output of `git log --oneline` command:
    ```sh
    1ac9672 (HEAD -> git-reset-practice) Third commit
    480da15 Second commit
    dd35df1 First commit
    ```
    We can see that our commits have been restored.

## Task 3: Visualizing Git Commit History

**Objective**: Use Git’s log features to visualize your project’s commit history and branching.

1. I created three new commits in my current branch using commands:
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

2. I run the `git log --oneline --graph --all` command to view a simple commit graph and got the next output:
    ```sh
    * 26d5d84 (HEAD -> lab2-solution) Commit C
    * 9693882 Commit B
    * c2dd2e9 Commit A
    *   c6fe13c Merge branch 'master' into lab2-solution New changes in lab2.md from main repository of this course
    |\  
    | * 3dd1718 (upstream/master, master) lab2 Git
    * | e228ed8 Small changes in Task2
    * | 9e487e6 Done Task2
    * | 1ac9672 (git-reset-practice) Third commit
    * | 480da15 Second commit
    * | dd35df1 First commit
    * | d5222a5 Created submission file for lab2 and done first task
    * | c56dc28 Added first commit for lab2
    * | 1b6f9d5 (origin/lab1-solution, lab1-solution) Added info about merge strategies
    * | 33ce7b8 Added info about importance of signed commits
    |/  
    * 0fea98c (origin/master, origin/HEAD) lab2 Git
    * a107866 lab1 Intro
    ```

3. I created a new branch, make a commit, and view the log again:
    ```sh
    git checkout -b side-branch
    echo "Branch commit" >> history.txt
    git add history.txt
    git commit -m "Side branch commit"
    git checkout lab2-solution
    git log --oneline --graph --all
    ```

    Output:
    ```sh
    * dbe163f (side-branch) Side branch commit
    * 26d5d84 (HEAD -> lab2-solution) Commit C
    * 9693882 Commit B
    * c2dd2e9 Commit A
    *   c6fe13c Merge branch 'master' into lab2-solution New changes in lab2.md from main repository of this course
    |\  
    | * 3dd1718 (upstream/master, master) lab2 Git
    * | e228ed8 Small changes in Task2
    * | 9e487e6 Done Task2
    * | 1ac9672 (git-reset-practice) Third commit
    * | 480da15 Second commit
    * | dd35df1 First commit
    * | d5222a5 Created submission file for lab2 and done first task
    * | c56dc28 Added first commit for lab2
    * | 1b6f9d5 (origin/lab1-solution, lab1-solution) Added info about merge strategies
    * | 33ce7b8 Added info about importance of signed commits
    |/  
    * 0fea98c (origin/master, origin/HEAD) lab2 Git
    * a107866 lab1 Intro
    ```

Using `git log --oneline --graph --all` provides a clear visual representation of the project history, making it easier to understand how different branches diverge and merge. This helps to track collaboration efforts and how contributions from different team members integrate into the main project.
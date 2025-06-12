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
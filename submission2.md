# Task 1: Understanding Version Control Systems

- git cat-file -p <blob_hash>
Prints the contents of a file (blob object). Shows the actual file data stored at that hash.
```bash
# git ls-tree HEAD README.md  # Directly get blob hash of README.md
git cat-file -p af7fda8ea32b60578a1103ce061a50d7f6f09a35

# DevOps Introduction Course: Learn the Fundamentals of DevOps

Welcome to the DevOps Introduction Course, where you will gain a solid foundation in DevOps principles and practical skills. This course is designed to provide you with a comprehensive understanding of DevOps and its key components. Through hands-on labs and lectures, you will learn about various topics such as version control, software distribution, CI/CD, containers, and cloud computing.
...
```

- git cat-file -p <tree_hash>
Prints the directory structure (tree object). Lists files/subdirectories with their permissions, types, and hashes.
```bash
# git ls-tree HEAD:./  # Inspect './' directory
# No directories in this repo
# 100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
# 100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
# 100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
# 100644 blob ee82f41affad8007c973c86a36a1a765332c68a8    lab3.md
```

- git cat-file -p <commit_hash>
Prints commit metadata. Shows author, date, commit message, and parent commit hash(es), plus the root tree hash for the snapshot.
```bash
# git rev-parse HEAD   # Directly get HEAD's commit hash
git cat-file -p e97e227389e1e76ebc881aa1aff3560469d356e3

tree a633650a1bf66fe809ea6ac45d594268d2ac5462
parent 3dd1718fc2372ae838773f8f780807faa26995bd
author Dmitriy Creed <creed@soramitsu.co.jp> 1749905857 +0300
committer Dmitriy Creed <creed@soramitsu.co.jp> 1749905857 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgpI1gCp6xYZHxTcaJQoIBFt1czX
 sk7920Nox85cTfRuIAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQJ5Gd7hahTItOhXPbD+rraGi0xcIscjfdfBKdpRqdT15ygmzcNC0AhWcCW2QLljejT
 RtrE+6CcUdpY5kpZQRDwE=
 -----END SSH SIGNATURE-----

Publish lab3 CI

Signed-off-by: Dmitriy Creed <creed@soramitsu.co.jp>
```
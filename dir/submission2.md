# Lab 2: Version Control

## Task 1: Understanding Version Control Systems

### Commands

List current log history:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git log
commit 4db366c7dfcd6bb9da9f854d8039926593a19632 (HEAD -> lab-02)
Author: Danil Andreev <61481131+FleshRazer@users.noreply.github.com>
Date:   Sun Jun 8 12:09:54 2025 +0300

    lab2 add submission file

commit 3dd1718fc2372ae838773f8f780807faa26995bd (upstream/master, master)
Author: Dmitriy Creed <creed@soramitsu.co.jp>
Date:   Thu Jun 5 17:49:49 2025 +0300

    lab2 Git
    
    Signed-off-by: Dmitriy Creed <creed@soramitsu.co.jp>

commit 0fea98cc519f60820f4c54f514b1596d5bf145b5 (origin/master, origin/HEAD)
Author: Dmitriy Creed <creed@soramitsu.co.jp>
Date:   Sun Jun 1 22:25:33 2025 +0300

    lab2 Git
    
    Signed-off-by: Dmitriy Creed <creed@soramitsu.co.jp>

commit a107866e91af12c22ef78d4c7ad53ae39135ef43
Author: Dmitriy Creed <creed@soramitsu.co.jp>
Date:   Thu May 29 20:48:58 2025 +0300

    lab1 Intro
    
    Signed-off-by: Dmitriy Creed <creed@soramitsu.co.jp>
```

List blobs and subtrees referenced by "lab2 Git" commit:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git ls-tree 3dd1718fc2372ae838773f8f780807faa26995bd
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
```

List blobs and subtrees referenced by the new commit:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git ls-tree 4db366c7dfcd6bb9da9f854d8039926593a19632
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
040000 tree f5089a2c79687a63ea864917977a7fea68a3b45b    dir
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
```

Inspect the commit:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git cat-file -p 4db366c7dfcd6bb9da9f854d8039926593a19632
tree e09b5bba51358046a5036d09c1081005a8387e5b
parent 3dd1718fc2372ae838773f8f780807faa26995bd
author Danil Andreev <61481131+FleshRazer@users.noreply.github.com> 1749373794 +0300
committer Danil Andreev <61481131+FleshRazer@users.noreply.github.com> 1749373794 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgaAkeOWP5wbPkJLnJ2qNAusFKrN
 TJNpJfEiPYDUFjfAEAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQMohKxzXmOdMxZrF0ufIWrkJBatf/VKdpPeg98etAiuzzyMNZjM8w/+cZ685GgJe3x
 ykbhitElwBlD4rynenvw4=
 -----END SSH SIGNATURE-----

lab2 add submission file
```

Inspect the subtree:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git cat-file -p f5089a2c79687a63ea864917977a7fea68a3b45b
100644 blob c15ebc8e860f9cd75ae747b41c250179d3045fe9    submission2.md
```

Inspect the blob:
```
danilandreev@Danils-MacBook-Air ms24-sum25-devops % git cat-file -p c15ebc8e860f9cd75ae747b41c250179d3045fe9
# Lab 2: Version Control
```

### Summary

- **Blobs** store file contents, one blob for each file. Each version of a file is also stored as a separate blob.

- **Trees** represent directory content and structure by referencing blobs and other trees.

- **Commits** represent a repository snapshot at a specific point of time. They reference a single tree object that represents the whole repository, parent commit, and other metadata.

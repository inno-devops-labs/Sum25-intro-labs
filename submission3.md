## Task 1

1. Create some log file and commit it to get hash code
   ~~~bash
   [lab2 9a2621f] feat: added the log file
   1 file changed, 2 insertions(+)
   create mode 100644 logs.txt
   ~~~

2. Use `git cat-file -p 9a2621f` to inspect the contents of commit
   ~~~bash
   tree e000d735f754aa15f192c77b58a1039e961c345f
   parent 0fea98cc519f60820f4c54f514b1596d5bf145b5
   author Slava Koshman <koshman2015@list.ru> 1749907903 +0500
   committer Slava Koshman <koshman2015@list.ru> 1749907903 +0500
   gpgsig -----BEGIN SSH SIGNATURE-----
   <SECURE SSH KEY>
   -----END SSH SIGNATURE-----

   feat: added the log file
   ~~~

2. Use `git cat-file -p e000d735f754aa15f192c77b58a1039e961c345f` to inspect the contents of tree
   ~~~bash
   100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35	README.md
   100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e	lab1.md
   100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb	lab2.md
   100644 blob 149a1a9f00f8c72786878cc1d3d977708404310c	logs.txt
   ~~~

2. Use `git cat-file -p 149a1a9f00f8c72786878cc1d3d977708404310c` to inspect the contents of blob
   ~~~bash
   Commit to test
   Commit to test 2
   ~~~

## Task 2

1. Let's go to the new branch and do some commits
2. Try the soft variant of reset `git reset --soft HEAD~1`
   ~~~bash
   Текущая ветка: git-reset-practice
   Изменения, которые будут включены в коммит:
   (используйте «git restore --staged <файл>...», чтобы убрать из индекса)
      изменено:      file.txt

   Изменения, которые не в индексе для коммита:
   (используйте «git add <файл>...», чтобы добавить файл в индекс)
   (используйте «git restore <файл>...», чтобы отменить изменения в рабочем каталоге)
      изменено:      lab2.md
      изменено:      submission3.md
   ~~~

   As the result we have a file commit reset to second commit with save data from commit 3
3. Try the hard variant of reset `git reset --hard HEAD~1` with reflog
   ~~~bash
   ade7fb9 HEAD@{0}: reset: moving to HEAD~1
   d38941a HEAD@{1}: reset: moving to HEAD~1
   451b755 HEAD@{2}: commit: Third commit
   d38941a HEAD@{3}: commit: Second commit
   ade7fb9 HEAD@{4}: commit: First commit
   7701021 HEAD@{5}: checkout: moving from lab2 to git-reset-practice
   7701021 HEAD@{6}: commit: feat: added the submision 3 file with hash information
   9a2621f HEAD@{7}: commit: feat: added the log file
   0fea98c HEAD@{8}: reset: moving to HEAD~1
   dda2342 HEAD@{9}: commit: feat: added the log file
   0fea98c HEAD@{10}: reset: moving to HEAD~2
   3d6a8f2 HEAD@{11}: commit: feat: added the log file
   654bde3 HEAD@{12}: commit: feat: added the log file
   0fea98c HEAD@{13}: checkout: moving from master to lab2
   0fea98c HEAD@{14}: checkout: moving from lab1 to master
   597a76d HEAD@{15}: commit: feat(ci): added configuration to signing the commits
   0fea98c HEAD@{16}: reset: moving to HEAD~2
   155f72c HEAD@{17}: reset: moving to HEAD
   155f72c HEAD@{18}: commit: feat(ci): added configuration to signing the commits
   2bce222 HEAD@{19}: commit: feat(ci): added configuration to signing the commits
   0fea98c HEAD@{20}: checkout: moving from master to lab1
   0fea98c HEAD@{21}: clone: from github.com:Slauva/devops-course.git
   ~~~
   As the result we have a file commit reset to first commit without save data from commit 2, 3
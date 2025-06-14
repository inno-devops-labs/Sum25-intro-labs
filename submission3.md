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

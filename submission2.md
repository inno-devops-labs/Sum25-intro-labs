# Task 1: Understanding Version Control Systems

## Steps and Outputs

- Created a test file `test_task1.txt` and made two commits:
- First commit: "Add test file for Task 1" (hash: 9257cf6)
- Second commit: "Update test file for Task 1" (hash: f8e91c4)

- Inspected objects using `git cat-file -p`:

- **Commit Object** (e.g., `f8e91c4`):
      ```
     tree 8fd83d6e34ab96b5e7e8571e373999dad73833bc
     parent 9257cf6b18f945f38be50269164ac8e0abb316dd
     author dadaxonEnigma <voiceofenigma19@gmail.com> 1749553811 +0300
     committer dadaxonEnigma <voiceofenigma19@gmail.com> 1749553811 +0300
     gpgsig -----BEGIN SSH SIGNATURE-----
     U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgE43ovcWo1vK41E3ZUoCPtX+U9Q
     fJ8xw1jCOdKHSssjIAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
     AAAAQGtIN2DXs+lC1ybjw+t5KhDpmQqgrUkGfE1N1Nh3J1BYTi3W9xP6AoE3y/XSHuoZeq
     xxmipgQliAC57nk0ZSUwY=
     -----END SSH SIGNATURE-----

     Update test file for Task 1
      ```

     **Explanation**: This represents the commit metadata, including the tree hash, parent commit hash, author and committer details (name, email, timestamp), SSH signature, and commit message. The timestamp (1749552721) corresponds to June 4, 2025, 17:45:21 EEST.

- **Tree Object** (e.g., `8fd83d6e34ab96b5e7e8571e373999dad73833bc`):
      ```
     100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
     100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
     100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
     100644 blob cb9cabe4b4336f314946b70d4fdb9ba770468c55    submission1.md
     100644 blob fda1ef79ebf3ba05137ce948ee6bc186c91bcc26    submission2.md
     100644 blob 3fa1dad2609a5b8f43224d51a530cd4564b52373    test_task1.txt
      ```
     **Explanation**: This represents the directory structure, listing files and their corresponding blob hashes.

- **Blob Object** (e.g., `3fa1dad2609a5b8f43224d51a530cd4564b52373`):
      ```
     ÿþThis is a test file for Lab 2 Task 1
     Second line for Task 1
      ```
     **Explanation**: This represents the raw content of the file `test_task1.txt`.

### Conclusion

 Git stores data as a series of objects: commits (metadata), trees (directory structure), and blobs (file contents), all identified by unique SHA-1 hashess

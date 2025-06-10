# Task 1: Understanding Version Control Systems

## Steps and Outputs

- Created a test file `test_task1.txt` and made two commits:
- First commit: "Add test file for Task 1" (hash: d9bcd2c)
- Second commit: "Update test file for Task 1" (hash: 41292ba)

- Inspected objects using `git cat-file -p`:

- **Commit Object** (e.g., `41292ba`):
    ```
     tree 4cc1a90926dafdb1115112a41a7464c985f50919
     parent d9bcd2cd84fcccb4fcd27de5f6885ea58075bd0e
     author dadaxonEnigma <voiceofenigma19@gmail.com> 1749552721 +0300
     committer dadaxonEnigma <voiceofenigma19@gmail.com> 1749552721 +0300
     gpgsig -----BEGIN SSH SIGNATURE-----
      U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgE43ovcWo1vK41E3ZUoCPtX+U9Q
      fJ8xw1jCOdKHSssjIAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
      AAAAQOmsOWfRP6a2sxGpOGK/JXejTmsAk3ahQ6zZBWVlsFGhPPgS6tqRj9MyLberar012e
      Plemc/HdEA4CZ3WhWqZgw=
     -----END SSH SIGNATURE-----

     Update test file for Task 1
     ```

     **Explanation**: This represents the commit metadata, including the tree hash, parent commit hash, author and committer details (name, email, timestamp), SSH signature, and commit message. The timestamp (1749552721) corresponds to June 4, 2025, 17:45:21 EEST.

- **Tree Object** (e.g., `4cc1a90926dafdb1115112a41a7464c985f50919`):
     ```
     100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
     100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
     100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
     100644 blob cb9cabe4b4336f314946b70d4fdb9ba770468c55    submission1.md
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

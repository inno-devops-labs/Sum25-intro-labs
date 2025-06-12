## Commit object
```bash
git cat-file -p df9cd60cd79cb2b770520c14148a474f113b95da
```
df9cd60cd79cb2b770520c14148a474f113b95da - hash of last commit found by git rev-parse HEAD

### Output:

tree be7836e06c8e5d120a7150ae99aeff7e9d80ae0b

parent 6d5f17e13fffcbe24b9c8b6d80022f11d37caafd

author beleet <mcpokon@gmail.com> 1749758976 +0200

committer beleet <mcpokon@gmail.com> 1749758976 +0200

gpgsig -----BEGIN SSH SIGNATURE-----

\<signature\>

 -----END SSH SIGNATURE-----

Add file2.txt

### Explanation:

The commit object stores a reference to the tree (snapshot), the author and committer, and the message.


## Tree object

```
git cat-file -p be7836e06c8e5d120a7150ae99aeff7e9d80ae0b
```

### Output 

100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md

100644 blob 8b137891791fe96927ad78e64b0aad7bded08bdc    file1.txt

100644 blob 8b137891791fe96927ad78e64b0aad7bded08bdc    file2.txt

100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md

100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md

100644 blob 007e00fafdabb9ae79bec4289ee6af18f4a713a3    submission1.md

### Explanation:

The tree object represents a directory. It lists the files and their associated blob hashes.


## Blob object

```
git cat-file -p af7fda8ea32b60578a1103ce061a50d7f6f09a35
```

Outputs nothing because file is empty

### Explanation:
The blob stores the actual contents of a file, in this case, file1.txt.

# Task 1: Understanding Version Control Systems

## Commit Object
```
git cat-file -p 93a9225

tree a17a081db94b628e3702dcdfc8d3e79cca8bd05f
parent e89e1d7e50a9ed71dfb6fd83a800fedb0ed5a827
author someilay <ismilioshyn@gmail.com> 1749758072 +0300
committer someilay <ismilioshyn@gmail.com> 1749758072 +0300

task 1 commit
```
**Explanation:**
The commit object contains metadata about the commit, such as the author, date, commit message, and references to the tree and parent commits.

## Tree Object
```
git cat-file -p a17a081db94b628e3702dcdfc8d3e79cca8bd05f

100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 93f5b7abf48c9066c6caef5bb22525be5de59b12    image-1.png
100644 blob 7130d3356196e7283fb5efdbe2feeb336c16c9d8    image.png
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
100644 blob 0ab3d9306b82333d3d9e67089ac12eaf26198b20    submission1.md
100644 blob 30d74d258442c7c65512eafab474568dd706c430    submission2.md
```
**Explanation:**
The tree object represents a directory listing (snapshot) of the project at a certain point in time. It contains references to blobs (files) and possibly other trees (subdirectories).

## Blob Object
```
git cat-file -p 30d74d258442c7c65512eafab474568dd706c430

test
```
**Explanation:**
The blob object stores the actual contents of a file. It does not contain any metadata about the file name or location—just the file data itself.
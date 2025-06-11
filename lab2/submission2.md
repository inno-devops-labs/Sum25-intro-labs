# Version Control

## Task 1: Understanding Version Control Systems

### Blob (Binary Large Object)

Blob is a raw file content (not the file name, not the path, just the content)

I added a title to the `submission2.md` file and commited that change.

```
❯ git ls-tree HEAD
100644 blob cf82bccef811740ae45601c1b4a0fe247b35dfce    submission2.md

❯ git cat-file -p cf82bccef811740ae45601c1b4a0fe247b35dfce
# Version Control
```

### Tree

- A directory listing: file names, file modes, and pointers to blobs and subtrees
- Acts like a UNIX directory, mapping names to blobs (files) or other trees (subdirectories)

```
❯ git ls-tree HEAD
100644 blob c53739c1581e02d94316e080fb2d7d5e5879ebad    .markdownlint.yaml
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
040000 tree c9d77be51decd725bec1566cd455a233276c1d5f    lab1
100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
040000 tree 506d1ac1b38743a91e588974f0b0878925b1460e    lab2

❯ git cat-file -p 506d1ac1b38743a91e588974f0b0878925b1460e
100644 blob 2e2ab7970f076892d95205a157f8d5dad0200b57    submission2.md
```

The blob hash changed cause I commited a blob part of `submission2.md`.

````
❯ git cat-file -p 2e2ab7970f076892d95205a157f8d5dad0200b57
# Version Control

## Task 1: Understanding Version Control Systems

### Blob (Binary Large Object)

Blob is a raw file content (not the file name, not the path, just the content)

I added a title to the `submission2.md` file and commited that change.

```
❯ git ls-tree HEAD
100644 blob cf82bccef811740ae45601c1b4a0fe247b35dfce    submission2.md

❯ git cat-file -p cf82bccef811740ae45601c1b4a0fe247b35dfce
# Version Control
```
````
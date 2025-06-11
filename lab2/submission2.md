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

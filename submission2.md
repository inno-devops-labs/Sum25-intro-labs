# Solution to Lab 2

by Dmitry Beresnev <d.beresnev@innopolis.university>

## Task 1

To display the blob hashes I use

```bash
git ls-tree HEAD
```

which results in

```text
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob df2328140b07882ea4ac53192aee403f5b2d31ab    commit_generator.sh
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
100644 blob 4bb4900818c1275f06b8996529dbcb3c0e9199bc    random.txt
```

To find a branch hash I use

```bash
git rev-parse lab2
```

which results in

```text
eb1f95a74781f346e337a0f40cec80693bfafca6
```

Finally, to find a tree hash I use

```bash
git cat-file -p eb1f95a74781f346e337a0f40cec80693bfafca6
```

which results in

```text
tree bc61f7ddff9797e4ca5083bad80745c1778d7695
parent ea14b4250de45d7e5320338e2bef7877c769d23b
author dsomni <pro100pro10010@gmail.com> 1749488583 +0300
committer dsomni <pro100pro10010@gmail.com> 1749488583 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgR1OEyAFzkl5AtbHQKhVOpPssNT
 J+nFypOoR5ynhpXnIAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQHqova+IYunGHZ7R6+feZUYsapw65SX/qmW7S50xMrt1ijwHsAo2lg4Ssp4bEZuzc+
 AP/6zQyfnNVmGDWo9qrQk=
 -----END SSH SIGNATURE-----

Add [commit generator] global
```

### Exploring blob

```bash
git cat-file -p 4bb4900818c1275f06b8996529dbcb3c0e9199bc
```

results in

```text
tdbdg
nGAyV
```

Therefore, a **blob** represents the raw content of a file

### Exploring tree

```bash
git cat-file -p 4bb4900818c1275f06b8996529dbcb3c0e9199bc
```

results in

```text
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob df2328140b07882ea4ac53192aee403f5b2d31ab    commit_generator.sh
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
100644 blob 4bb4900818c1275f06b8996529dbcb3c0e9199bc    random.txt
```

Therefore, a **tree** represents the root directory with the following information about files/directories (blobs):

- permission
- blob hash
- filename

### Exploring commit

```bash
git cat-file -p ea14b4250de45d7e5320338e2bef7877c769d23b
```

results in

```text
tree 55aa1c359596027b7f9b641b34febe666585afce
parent 45371d783799ba13a5572238c5f83f60c12efc32
author dsomni <pro100pro10010@gmail.com> 1749488548 +0300
committer dsomni <pro100pro10010@gmail.com> 1749488548 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgR1OEyAFzkl5AtbHQKhVOpPssNT
 J+nFypOoR5ynhpXnIAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQJyWg2prTwtd/i0XbhdySQaIPWgJ70L5dIeJYdjlmwHXCQsKmL2EzUmZKSpQjS0bzy
 BTZHvderuKRqkSjpVxMwM=
 -----END SSH SIGNATURE-----

Add [nGAyV] random.txt
```

Therefore, a **commit** contains the metadata about the snapshot:

- tree hash of the commit
- parent (previous) commit hash (if any)
- who made the commit and when (with ssh signature)
- commit message

## Task 2

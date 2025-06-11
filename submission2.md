# Git Object Descriptions

### Blob object

#### Sample commands and outputs:
```
$ git cat-file -p fcacba3c7b4e20bc91b4590f8a8cc19978fc908d
@main def m(args: String*) =
    args.foreach(arg => println(arg))
```

```
$ git cat-file -t fcacba3c7b4e20bc91b4590f8a8cc19978fc908d
blob
```
#### Short object description:
We can see that the blob object represents solely the content of a specific file contained at some point inside our repository. Git stores all the versions of our files, old and new, so even if the file is deleted locally, we can still retrieve any version of it from ```.git/objects``` directory.

### Tree object

#### Sample commands and outputs:
```
$ git cat-file -p b51937945eb0d7cc15828e9ae0eafc11805c9eaf
100644 blob 7e81440422e458f48b869097a9c0a99e457a62d6    echoargs.scala
100644 blob 3dc07ee8e835b729ab9b1d34d9d1ee9852cdd578    forargs.scala
100644 blob 19e3320376afbb2c622f224ad5289429bf0faa82    hello.scala
100644 blob a1a0ecac4fce05a36d76d8e2510fce822af53142    helloarg.scala
100644 blob a270ec1f6897f1f5e1c71cf1f10b9be6f201511b    pa.scala
100644 blob be34a5542083952f12d54f86037d23336e4e972c    printargs.scala
```

```
$ git cat-file -t b51937945eb0d7cc15828e9ae0eafc11805c9eaf
tree
```

#### Short object description:

The tree objects functions are similar to directories in UNIX filesystems. They contain one or more entries, each one covering the SHA-1 hash of a blob file or a subtree, with their associated modes, types and filenames.

A tree is normally created by Git when it takes account of the state of the staging area and writing a series of tree objects from it. The user can create their own tree objects by building their own staging area and the executing the command ```git write-tree```. If they wish, they can build a tree with different versions of files saved in the Git database by adding them through the ```git update-index --add --cacheinfo {address}``` command.

### Commit object

#### Sample commands and outputs:

```
$ git cat-file -p 3e9c2b4ea798889dae6e831428a554f587479673
tree b51937945eb0d7cc15828e9ae0eafc11805c9eaf
author Daru <daru191407@gmail.com> 1749685264 +0300
committer Daru <daru191407@gmail.com> 1749685264 +0300

for loop in Scala
```

```
$git cat-file -t 3e9c2b4ea798889dae6e831428a554f587479673
commit
```

#### Short object description:

The commit object contains the following information:
1. SHA-1 hash for the top-level tree for the snapshot of the project at the time of the commit.
2. Author/commiter information, utilizing user's ```user.name``` and ```user.email``` information, as well as the timestamp of the time of commit.
3. A blank line.
4. The commit message.

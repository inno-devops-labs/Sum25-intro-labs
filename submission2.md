## LAB 2
Nikita Yaneev n.yaneev@innopolis.unversity

New commit

### TASK 1

git cat-file -p <blob_hash> 

*This command shows the contents of the file.* 

``` 
git cat-file -p 6a0cf3824c3ebaa6ab9478ab7e65f9637e7fddd3
```
```
## LAB 2
Nikita Yaneev n.yaneev@innopolis.unversity

New commit
```

git cat-file -p <tree_hash>

*This command shows the structure of the files in the branch.*

```
git cat-file -p 678feae4e1a3ac5f29e79d96f33138eb48d56fdc
```

```
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 3dce38ab2076903506fd82f0668aa89cef32275b    image.png
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
100644 blob 6db11f151d8dce37cdc908e92d0af9610319b198    submission1.md
100644 blob 6a0cf3824c3ebaa6ab9478ab7e65f9637e7fddd3    submission2.md

```

git cat-file -p <commit_hash>

*This command shows us the general structure of the branch, its metadata , author, and last commit.*


```
git cat-file -p 3594ebf40ffc1b251a8259bfdfc536eda6459551
```

```

tree 678feae4e1a3ac5f29e79d96f33138eb48d56fdc
parent ab0afaa4fb04d0a9be328f964f78911c4cc22b58
author adbedlam <nyaneev@yandex.ru> 1749488972 +0300
committer adbedlam <nyaneev@yandex.ru> 1749488972 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgYGh7eh3bGznPAgFVCM0GiniQpZ
 v5OI0/PWM8sTc+AysAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQF1+I2pkcC76T0m3B4m3AYJPBZQJFo+9nEEWsk7oAgIZM+vhpocG5sd8hh+r0+EdBJ
 vredPc3eTKIDnjCAz1eAw=
 -----END SSH SIGNATURE-----

add commit

```

### TASK 2



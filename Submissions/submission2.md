# Task 1

1. `git cat-file -p <blob_hash>`

При помощи команды `echo 'test content' | git hash-object -w --stdin` создали blob файл и записали туда тестовую информацию

При помощи команды `git cat-file -p d670460b4b4aece5915caf5c68d12f560a9fe3e4` достали информацию из blob файла по хешу

2. `git cat-file -p <tree_hash>`

При помощи команды `git cat-file -p master^{tree}` достали всю информацию из дерева `master`

output:
```commandline
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
040000 tree 5a4a32162f6fbcbdad74ce3f2f6b37f28dc73568    Submissions
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
```

3. `git cat-file -p <commit_hash>`

При помощи команды `git log` узнали хеш коммита

При помощи команды `git cat-file -p a107866e91af12c22ef78d4c7ad53ae39135ef43` достали информацию о коммите

```commandline
tree d9f1fa38312ae16ca4276713e2d276a46d6993fd
author Dmitriy Creed <creed@soramitsu.co.jp> 1748540938 +0300
committer Dmitriy Creed <creed@soramitsu.co.jp> 1748540938 +0300

lab1 Intro

Signed-off-by: Dmitriy Creed <creed@soramitsu.co.jp>
```

# Task 2
1. Создание и переход на новую ветку 

```commandline
git checkout -b git-reset-practice
Switched to a new branch 'git-reset-practice'
```

2. Создание нового файла и запись информации в него 

```commandline
echo "First commit" > file.txt
git add file.txt
git commit -m "First commit"

echo "Second commit" >> file.txt
git add file.txt
git commit -m "Second commit"

echo "Third commit" >> file.txt
git add file.txt
git commit -m "Third commit"
[git-reset-practice 228dbd9] First commit
 2 files changed, 1 insertion(+)
 create mode 100644 Submissions/submission2.md
 create mode 100644 file.txt
[git-reset-practice 959a308] Second commit
 1 file changed, 1 insertion(+)
[git-reset-practice df350e4] Third commit
 1 file changed, 1 insertion(+)
```

3. `git reset --soft HEAD~1`

Указатель HEAD переместился на один коммит назад (т.е. теперь последний коммит — это Second commit).

Изменения из "Third commit" остались в индексе (staging area).

4. `git reset --hard HEAD~1`

Указатель HEAD снова переместился на один коммит назад (теперь остался только First commit).

Все изменения из Second commit и Third commit удалены из индекса и рабочего каталог

5. `git reflog`

При помощи команды `git reflog` определили хеш нужного коммита

И при помощи команды `git reset --hard df350e4` вернулись к нужному коммиту


## Task 3

1. Создание коммитов

При помощи команд:

```commandline
echo "Commit A" > history.txt
 git add history.txt
 git commit -m "Commit A"

 echo "Commit B" >> history.txt
 git add history.txt
 git commit -m "Commit B"

 echo "Commit C" >> history.txt
 git add history.txt
 git commit -m "Commit C"
```

Были созданы три коммита и записана история в файл `history.txt`

2. Simple commit graph

При помощи команды `git log --oneline --graph --all` был создан граф 

![img.png](img.png)



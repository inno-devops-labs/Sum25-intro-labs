## 1. Понимание Систем Управления Версиями

   * `git cat-file -p <commit_hash>` показывает информацию о коммите которая содержит метаданные, такие как автор, комментарий, дата и указатели на корневое дерево проекта и родительские коммиты. 

```
tempuser@Vostro-3500:~/Sum25-intro-labs$ git cat-file -p 6db983f
tree f9dd3d1e775d9644eed178bc162e09d16931ff66
parent 5eb6559ddd00beddd61d3792ab1e57e2b7208308
author Vladimir <askoldmax@gmail.com> 1748953083 +0700
committer Vladimir <askoldmax@gmail.com> 1748953083 +0700
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgDARvUSoP6J/ecL+ESolREEKnpQ
 SsIHfPQL6wbfiNpecAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQLGCiQLgGBAlz/WNPPSodMX0YZzhHzolvIBs22d+qscqUVMhkWMd+nn6zloTj4yjp3
 UwWnq4UyMeV2s3iJtYZAw=
 -----END SSH SIGNATURE-----

Test signed commit
```
   * `git cat-file -p <tree_hash>` выводит содержимое объекта типа tree. Объект tree представляет собой каталог или состояние рабочего каталога на определенный момент времени.

```
tempuser@Vostro-3500:~/Sum25-intro-labs$ git cat-file -p f9dd3d1e775d9644eed178bc162e09d16931ff66
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35	README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e	lab1.md
100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb	lab2.md
100644 blob 70347eed20085021a20261a92caf6ed0a1aa3f7b	submission1.md
```

   * Использование `git cat-file -p <blob_hash>` позволяет увидеть содержимое объекта типа blob, команда покажет содержимое файла, соответствующего данному хэшу.

```
tempuser@Vostro-3500:~/Sum25-intro-labs$ git cat-file -p af7fda8ea32b60578a1103ce061a50d7f6f09a35
# DevOps Introduction Course: Learn the Fundamentals of DevOps
...
```

## 2. Практика с Git Reset Command
   1. Создание новой ветки
```
tempuser@Vostro-3500:~/Sum25-intro-labs$ git checkout -b git-reset-practice
Переключились на новую ветку «git-reset-practice»
```
   2. Создание коммитов

```
tempuser@Vostro-3500:~/Sum25-intro-labs$ git log --oneline
59b991c (HEAD -> git-reset-practice) Third commit
e40a93d Second commit
1d420b6 First commit
```

   * `git reset --soft HEAD~1` отменит последний коммит, но оставит все изменения в индексе , готовыми к новому коммиту.

```
tempuser@Vostro-3500:~/Sum25-intro-labs$ git log --oneline
e40a93d (HEAD -> git-reset-practice) Second commit
1d420b6 First commit

tempuser@Vostro-3500:~/Sum25-intro-labs$ git status
Текущая ветка: git-reset-practice
Изменения, которые будут включены в коммит:
  (используйте «git restore --staged <файл>...», чтобы убрать из индекса)
	изменено:      file.txt
```
   * `git reset --hard HEAD~1` удалит последний коммит и все изменения в файлах , восстановив состояние из предыдущего коммита.

```
tempuser@Vostro-3500:~/Sum25-intro-labs$ git reset --hard HEAD~1
Указатель HEAD сейчас на коммите 1d420b6 First commit

tempuser@Vostro-3500:~/Sum25-intro-labs$ cat file.txt 
First commit
tempuser@Vostro-3500:~/Sum25-intro-labs$ git log --oneline
1d420b6 (HEAD -> git-reset-practice) First commit
```
   * `git reflog` покажет журнал всех изменений указателя HEAD. Используем его для восстановления коммитов.

```
tempuser@Vostro-3500:~/Sum25-intro-labs$ git reflog 
1d420b6 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
e40a93d HEAD@{1}: reset: moving to HEAD~1
59b991c HEAD@{2}: commit: Third commit
e40a93d HEAD@{3}: commit: Second commit
1d420b6 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit

tempuser@Vostro-3500:~/Sum25-intro-labs$ git reset --hard 59b991c
Указатель HEAD сейчас на коммите 59b991c Third commit

tempuser@Vostro-3500:~/Sum25-intro-labs$ git log --oneline
59b991c (HEAD -> git-reset-practice) Third commit
e40a93d Second commit
1d420b6 First commit
```

## 3. Визуализация истории коммитов
    * Создаем в текущей ветке файл и 3 коммита

```
tempuser@Vostro-3500:~/Sum25-intro-labs$ echo "Commit A" > history.txt
tempuser@Vostro-3500:~/Sum25-intro-labs$ git add history.txt
tempuser@Vostro-3500:~/Sum25-intro-labs$ git commit -m "Commit A"
[git-reset-practice 464db32] Commit A
 1 file changed, 1 insertion(+)
 create mode 100644 history.txt
tempuser@Vostro-3500:~/Sum25-intro-labs$ echo "Commit B" >> history.txt
tempuser@Vostro-3500:~/Sum25-intro-labs$ git add history.txt
tempuser@Vostro-3500:~/Sum25-intro-labs$ git commit -m "Commit B"
[git-reset-practice 1f54cbc] Commit B
 1 file changed, 1 insertion(+)
tempuser@Vostro-3500:~/Sum25-intro-labs$ echo "Commit C" >> history.txt
tempuser@Vostro-3500:~/Sum25-intro-labs$ git add history.txt
tempuser@Vostro-3500:~/Sum25-intro-labs$ git commit -m "Commit C"
[git-reset-practice ce3aed4] Commit C
 1 file changed, 1 insertion(+)
tempuser@Vostro-3500:~/Sum25-intro-labs$ git log --oneline
ce3aed4 (HEAD -> git-reset-practice) Commit C
1f54cbc Commit B
464db32 Commit A
```
    * Вывод истории коммитов в виде текстового графа командой `git log --oneline --graph --all`.

```
tempuser@Vostro-3500:~/Sum25-intro-labs$ git log --oneline --graph --all
* ce3aed4 (HEAD -> git-reset-practice) Commit C
* 1f54cbc Commit B
* 464db32 Commit A
* 59b991c (origin/git-reset-practice) Third commit
* e40a93d Second commit
* 1d420b6 First commit
* 6db983f (origin/master, origin/feature-master, origin/HEAD, master, feature-master) Test signed commit
* 5eb6559 Test signed commit
*   5893df6 Merge branch 'master' of github.com:askoldmax/Sum25-intro-labs
|\  
| * 1d16e4d Test signed commit
* | d22771f Test signed commit
|/  
* df40010 Test signed commit
* 4c3e646 Test 3 signed commit
* b9b99e1 Test 3 signed commit
* cc55850 Test 3 signed commit
* b609317 Test 2 signed commit
* 7d4fce9 Test 2 signed commit
* 4ac0774 Test signed commit
| * 3dd1718 (upstream/master, upstream/HEAD) lab2 Git
|/  
* 0fea98c lab2 Git
* a107866 lab1 Intro
```
 
    * Необязательное ветвление

```
tempuser@Vostro-3500:~/Sum25-intro-labs$ git log --oneline --graph --all
* e954f7d (side-branch) Side branch commit
* ce3aed4 (git-reset-practice) Commit C
* 1f54cbc Commit B
* 464db32 Commit A
...
```
Визуализация помогает понять совместную работу, показывая, как разные ветки представляют собой отдельные потоки работы, которые со временем объединяются, отражая взаимодействие и интеграцию изменений.


## 4. Добавление тега к коммиту

```
tempuser@Vostro-3500:~/Sum25-intro-labs$ git push origin v1.0.0
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To github.com:askoldmax/Sum25-intro-labs.git
 * [new tag]         v1.0.0 -> v1.0.0
tempuser@Vostro-3500:~/Sum25-intro-labs$ git log --oneline
6db983f (HEAD -> master, tag: v1.0.0, origin/master, origin/feature-master, origin/HEAD, feature-master) Test signed commit
5eb6559 Test signed commit
5893df6 Merge branch 'master' of github.com:askoldmax/Sum25-intro-labs
d22771f Test signed commit
1d16e4d Test signed commit
df40010 Test signed commit
4c3e646 Test 3 signed commit
b9b99e1 Test 3 signed commit
cc55850 Test 3 signed commit
b609317 Test 2 signed commit
7d4fce9 Test 2 signed commit
4ac0774 Test signed commit
0fea98c lab2 Git
a107866 lab1 Intro
```

Теги в разработке ПО помогают отслеживать версии, автоматизировать процессы CI/CD и структурировать заметки о релизах, отмечая важные этапы в истории проекта.

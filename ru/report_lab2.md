# Отчет по выполнению "Лабораторная работа 2: Управление версиями"

Вся документация была указана в "submission2.md" (https://github.com/Kulikova-A18/Sum25-intro-labs/blob/master/submission2.md)

## Задание 1: Понимание систем управления версиями

1.**Создать и изучить репозиторий**:

* Использовать текущий репозиторий и выполнить несколько коммитов

![image](https://github.com/user-attachments/assets/e03b536e-0e3f-414a-b440-7f12750b56ac)

далее проверяем с помощью команды 

```
git log --oneline 
```

![image](https://github.com/user-attachments/assets/2160bd04-a0e6-4251-9952-50a104978379)

текстовоый вариант

```
vboxuser@xubu:~/Sum25-intro-labs$ git log --oneline 
80486de (HEAD -> master, origin/master, origin/HEAD) Update report_lab2.md
5124489 Create report_lab2.md
3b45527 Create report_lab2.md
abeafaa Merge branch 'inno-devops-labs:master' into master
3dd1718 lab2 Git
0fea98c lab2 Git
ec7ac92 Delete lab1_ru.md
33113c8 Update and rename report_lab1_ru.md to report_lab1.md
87c87ad Create report_lab1.md
440a0c1 Create readme.md
5388aa8 Update report_lab1_ru.md
04f181b My second signed commit message
17ec118 generate new Update report_lab1_ru.md with screen
3698218 My signed commit message
b2ed6ed part report_lab1_ru.md
52c064b part report
3ad91cf Create report_lab1_ru.md
c93b5a6 Update lab1_ru.md
27ccd81 Create lab1_ru.md
a107866 lab1 Intro

```

* Использовать git cat-file для проверки содержимого больших двоичных объектов, деревьев и коммитов.

```
# git cat-file -p <blob_hash>

vboxuser@xubu:~/Sum25-intro-labs$ git cat-file -p 80486de
tree 89034737d13834db75e79604b84a86edc8f4f9af
parent 512448968450c1dbd447b58d97a571c87e3f487f
author Kulikova-A18 <81427431+Kulikova-A18@users.noreply.github.com> 1749555843 +0300
committer GitHub <noreply@github.com> 1749555843 +0300
gpgsig -----BEGIN PGP SIGNATURE-----

wsFcBAABCAAQBQJoSBqDCRC1aQ7uu5UhlAAAWxQQAEMbKyLEYMiCVpc+EZ5zZM5W
***
HF44P46puafL/QSpsIhf
=ph6a
-----END PGP SIGNATURE-----


```

используем информацию со строки  "tree 89034737d13834db75e79604b84a86edc8f4f9af"

```
# git cat-file -p <tree_hash>

vboxuser@xubu:~/Sum25-intro-labs$ git cat-file -p 89034737d13834db75e79604b84a86edc8f4f9af                                           89034737d13834db75e79604b84a86edc8f4f9af
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35	README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e	lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515	lab2.md
100644 blob 08c46b4b30dd44ee389f480c7efdbdeaff4e664e	report_lab1.md
100644 blob 8b137891791fe96927ad78e64b0aad7bded08bdc	report_lab2.md
040000 tree 17d6b482ebd5dc9e6965e64873a7a1fc76ecbdef	ru
100644 blob 2137aab797c5d0680fbd7ad3a6dfe88455f952b2	submission1.md
```

```
# git cat-file -p <commit_hash>

vboxuser@xubu:~/Sum25-intro-labs$ git cat-file -p 52c064b
tree 9d62cede4f9bdb375feee1888cc2aa1fa832614a
parent 3ad91cf7227694b16a324296dc128cc2319c7427
author Kulikova-A18 <81427431+Kulikova-A18@users.noreply.github.com> 1748754976 +0300
committer GitHub <noreply@github.com> 1748754976 +0300
gpgsig -----BEGIN PGP SIGNATURE-----

wsFcBAABCAAQBQJoO+IgCRC1aQ7uu5UhlAAAY98QAIrYVeLkqYFYcrqpiKrVJCKE
****
KZdHeHzsk/tCWpXC8Jye
=mOXL
-----END PGP SIGNATURE-----
```

---

## Задание 2: Попрактикуйтесь в работе с командой Git Reset

**Цель**: Попрактикуйтесь в использовании различных способов использования команды `git reset`.

1.**Создайте новую ветку**:

* Создайте новую ветку с именем "git-reset-practice" в вашем репозитории Git.

```
vboxuser@xubu:~/Sum25-intro-labs$ git checkout -b git-reset-practice
Switched to a new branch 'git-reset-practice'
```

2.**Изучите расширенные возможности сброса и повторного ведения журнала**:

* Создайте серию коммитов:

```
echo "First commit" > file.txt
git add file.txt
git commit -m "First commit"

echo "Second commit" >> file.txt
git add file.txt
git commit -m "Second commit"

echo "Third commit" >> file.txt
git add file.txt
git commit -m "Third commit"
```

вывод команд:

```
vboxuser@xubu:~/Sum25-intro-labs$ echo "First commit" > file.txt
git add file.txt
git commit -m "First commit"

echo "Second commit" >> file.txt
git add file.txt
git commit -m "Second commit"

echo "Third commit" >> file.txt
git add file.txt
git commit -m "Third commit"
[git-reset-practice 0a0290a] First commit
 Committer: vboxuser <vboxuser@xubu.myguest.virtualbox.org>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
 create mode 100644 file.txt
[git-reset-practice 40b1144] Second commit
 Committer: vboxuser <vboxuser@xubu.myguest.virtualbox.org>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
[git-reset-practice 4081f85] Third commit
 Committer: vboxuser <vboxuser@xubu.myguest.virtualbox.org>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
vboxuser@xubu:~/Sum25-intro-labs$ git push
fatal: The current branch git-reset-practice has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin git-reset-practice

vboxuser@xubu:~/Sum25-intro-labs$ git push --set-upstream origin git-reset-practice
Enumerating objects: 10, done.
Counting objects: 100% (10/10), done.
Delta compression using up to 4 threads
Compressing objects: 100% (6/6), done.
Writing objects: 100% (9/9), 1.11 KiB | 1.11 MiB/s, done.
Total 9 (delta 5), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (5/5), completed with 1 local object.
remote: 
remote: Create a pull request for 'git-reset-practice' on GitHub by visiting:
remote:      https://github.com/Kulikova-A18/Sum25-intro-labs/pull/new/git-reset-practice
remote: 
To github.com:Kulikova-A18/Sum25-intro-labs.git
 * [new branch]      git-reset-practice -> git-reset-practice
Branch 'git-reset-practice' set up to track remote branch 'git-reset-practice' from 'origin'.
```

* Используйте "git reset --soft" и "git reset --hard", чтобы изучить, как они влияют на рабочий каталог и историю.

```
vboxuser@xubu:~/Sum25-intro-labs$ git reset --soft HEAD~1
vboxuser@xubu:~/Sum25-intro-labs$ git reset --hard HEAD~1
HEAD is now at 80486de Update report_lab2.md
```

* Используйте "git reflog" для просмотра и восстановления предыдущих коммитов.

```
vboxuser@xubu:~/Sum25-intro-labs$ git reflog
80486de (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
429a2d4 (origin/master, origin/HEAD, master) HEAD@{1}: reset: moving to HEAD~1
0a0290a HEAD@{2}: reset: moving to HEAD~1
40b1144 HEAD@{3}: reset: moving to HEAD~1
4081f85 (origin/git-reset-practice) HEAD@{4}: commit: Third commit
40b1144 HEAD@{5}: commit: Second commit
0a0290a HEAD@{6}: commit: First commit
429a2d4 (origin/master, origin/HEAD, master) HEAD@{7}: checkout: moving from master to git-reset-practice
429a2d4 (origin/master, origin/HEAD, master) HEAD@{8}: pull: Fast-forward
80486de (HEAD -> git-reset-practice) HEAD@{9}: pull: Fast-forward
04f181b HEAD@{10}: commit: My second signed commit message
17ec118 HEAD@{11}: pull: Fast-forward
3698218 HEAD@{12}: commit: My signed commit message
b2ed6ed HEAD@{13}: pull: Fast-forward
52c064b HEAD@{14}: clone: from github.com:Kulikova-A18/Sum25-intro-labs.git
vboxuser@xubu:~/Sum25-intro-labs$ git reset --hard b2ed6ed
HEAD is now at b2ed6ed part report_lab1_ru.md
vboxuser@xubu:~/Sum25-intro-labs$
```

## Задача 3: Визуализация истории коммитов Git

1.**Создайте несколько коммитов**:

* В вашей текущей ветке сделайте 3 или более простых коммита:

```
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

результат

```
boxuser@xubu:~/Sum25-intro-labs$ echo "Commit A" > history.txt
git add history.txt
git commit -m "Commit A"

echo "Commit B" >> history.txt
git add history.txt
git commit -m "Commit B"

echo "Commit C" >> history.txt
git add history.txt
git commit -m "Commit C"
[detached HEAD 5e20b78] Commit A
 Committer: vboxuser <vboxuser@xubu.myguest.virtualbox.org>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
 create mode 100644 history.txt
[detached HEAD 0b6f364] Commit B
 Committer: vboxuser <vboxuser@xubu.myguest.virtualbox.org>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
[detached HEAD 42eaf15] Commit C
 Committer: vboxuser <vboxuser@xubu.myguest.virtualbox.org>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
vboxuser@xubu:~/Sum25-intro-labs$ git push 
fatal: You are not currently on a branch.
To push the history leading to the current (detached HEAD)
state now, use

    git push origin HEAD:<name-of-remote-branch>

vboxuser@xubu:~/Sum25-intro-labs$ git push --set-upstream origin git-reset-practice
Branch 'git-reset-practice' set up to track remote branch 'git-reset-practice' from 'origin'.
Everything up-to-date
vboxuser@xubu:~/Sum25-intro-labs$ 
vboxuser@xubu:~/Sum25-intro-labs$ git push origin HEAD:git-reset-practice
Enumerating objects: 13, done.
Counting objects: 100% (13/13), done.
Delta compression using up to 4 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (12/12), 1.42 KiB | 1.42 MiB/s, done.
Total 12 (delta 7), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (7/7), completed with 1 local object.
To github.com:Kulikova-A18/Sum25-intro-labs.git
   4081f85..c2e5d28  HEAD -> git-reset-practice

```

![image](https://github.com/user-attachments/assets/e094fc78-2429-4e98-96d1-9f41c5e8838e)


2.**Изучите график фиксации**:

* Запустите следующую команду, чтобы просмотреть простой график фиксации:

```
git log --oneline --graph --all
```

результат:

```
vboxuser@xubu:~/Sum25-intro-labs$ git log --oneline --graph --all
* c2e5d28 (HEAD, origin/git-reset-practice) Commit CC
* 42eaf15 Commit C
* 0b6f364 Commit B
* 5e20b78 Commit A
* 4081f85 (git-reset-practice) Third commit
* 40b1144 Second commit
* 0a0290a First commit
| * 126abb1 (origin/master, origin/HEAD) Update report_lab2.md
|/  
* 429a2d4 (master) Update report_lab2.md
* 80486de Update report_lab2.md
* 5124489 Create report_lab2.md
* 3b45527 Create report_lab2.md
*   abeafaa Merge branch 'inno-devops-labs:master' into master
|\  
| * 3dd1718 lab2 Git
| * 0fea98c lab2 Git
* | ec7ac92 Delete lab1_ru.md
* | 33113c8 Update and rename report_lab1_ru.md to report_lab1.md
* | 87c87ad Create report_lab1.md
* | 440a0c1 Create readme.md
* | 5388aa8 Update report_lab1_ru.md
* | 04f181b My second signed commit message
* | 17ec118 generate new Update report_lab1_ru.md with screen
* | 3698218 My signed commit message
* | b2ed6ed part report_lab1_ru.md
* | 52c064b part report
* | 3ad91cf Create report_lab1_ru.md
* | c93b5a6 Update lab1_ru.md
* | 27ccd81 Create lab1_ru.md
|/  
* a107866 lab1 Intro
```

3.**Необязательное ветвление**:

* Создайте новую ветвь, выполните фиксацию и просмотрите журнал еще раз:

```
git checkout -b side-branch
echo "Branch commit" >> history.txt
git add history.txt
git commit -m "Side branch commit"
git checkout main
git log --oneline --graph --all
```

результат:

```
vboxuser@xubu:~/Sum25-intro-labs$ git checkout -b side-branch
echo "Branch commit" >> history.txt
git add history.txt
git commit -m "Side branch commit"
git checkout main
git log --oneline --graph --all
Switched to a new branch 'side-branch'
[side-branch 538c180] Side branch commit
 Committer: vboxuser <vboxuser@xubu.myguest.virtualbox.org>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 1 insertion(+)
error: pathspec 'main' did not match any file(s) known to git
* 538c180 (HEAD -> side-branch) Side branch commit
* c2e5d28 (origin/git-reset-practice) Commit CC
* 42eaf15 Commit C
* 0b6f364 Commit B
* 5e20b78 Commit A
* 4081f85 (git-reset-practice) Third commit
* 40b1144 Second commit
* 0a0290a First commit
| * 126abb1 (origin/master, origin/HEAD) Update report_lab2.md
|/  
* 429a2d4 (master) Update report_lab2.md
* 80486de Update report_lab2.md
* 5124489 Create report_lab2.md
* 3b45527 Create report_lab2.md
*   abeafaa Merge branch 'inno-devops-labs:master' into master
|\  
| * 3dd1718 lab2 Git
| * 0fea98c lab2 Git
* | ec7ac92 Delete lab1_ru.md
* | 33113c8 Update and rename report_lab1_ru.md to report_lab1.md
* | 87c87ad Create report_lab1.md
* | 440a0c1 Create readme.md
* | 5388aa8 Update report_lab1_ru.md
* | 04f181b My second signed commit message
* | 17ec118 generate new Update report_lab1_ru.md with screen
* | 3698218 My signed commit message
* | b2ed6ed part report_lab1_ru.md
* | 52c064b part report
* | 3ad91cf Create report_lab1_ru.md
* | c93b5a6 Update lab1_ru.md
* | 27ccd81 Create lab1_ru.md
|/  
* a107866 lab1 Intro

```

## Задача 4: Пометить фиксацию

1.**Пометьте текущую фиксацию**:

* В вашей текущей ветке (например, `main`) пометьте последнюю фиксацию как `v1.0.0`:

```
git tag v1.0.0
git push origin v1.0.0
```

результат

![image](https://github.com/user-attachments/assets/554017fe-2d6d-4a5b-b04d-f4f4325a3a93)

Имена тегов, которые вы создали с помощью команды ```git tag```

![image](https://github.com/user-attachments/assets/bd4a6d38-8df7-4b88-ba5e-e67877463648)

## Информация об авторе

Отчет был выполнен Куликовой Аленой специально для "Интеграция и автоматизация процесса разработки ПО (углубленный курс)".

Если у вас есть вопросы или предложения по улучшению, не стесняйтесь обращаться!

Ссылка на git: https://github.com/Kulikova-A18

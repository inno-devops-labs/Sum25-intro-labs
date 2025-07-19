### 1. Исследование объекта blob
Output:  
just some text  
and another one  
and one more line  
  
Blob хранит содержимое файла. Важно, что при изменении файла создается новый blob  
  
### 2. Исследование объекта tree
Output:  
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md  
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md  
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md  
100644 blob 33e58253294a87c666b264274a4759d6cc4c9b4a    task1.md  
100644 blob bdacd7855b0b5faaa845cbceac4a999aa7a35b51    text.txt  
  
Tree хранит структуру каталогов. Запись содержит права доступа к файлу, тип и хеш объекта, имя файла или директории.  

### 3. Исследование объекта commit
Output:  
tree c8e935f996448b2b0ea1695a1f584b7267c4f6e3  
parent 8b71951db2603e5ed7d0d594e8e2bc58eacbaae7  
author kotosham <mishzlata@gmail.com> 1749848912 +0300  
committer kotosham <mishzlata@gmail.com> 1749848912 +0300  
gpgsig -----BEGIN SSH SIGNATURE-----  
...  
 -----END SSH SIGNATURE-----  
update text file  
  
Commit - состояние репозитория в определенный момент. Содержит ссылку на tree, родительский commit, информацию об авторе и времени, содержимое коммита.  

### 4. Git reset, reflog
```sh
git log --oneline
```
  
Output:  
```sh
299040f (HEAD -> git-reset-practice) Third commit  
ec934e7 Second commit  
8208350 First commit  
```
  
```sh
git reset --soft HEAD~1
git status
```
  
Output:  
```sh
On branch git-reset-practice  
Changes to be committed:  
  (use "git restore --staged <file>..." to unstage)  
        modified:   file.txt  
```
  
Third commit удален из истории. Изменения остались в индексе
  
```sh
git reset --hard HEAD~1
git reflog
```
  
Output:  
```sh
8208350 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1  
ec934e7 HEAD@{1}: reset: moving to HEAD~1  
299040f HEAD@{2}: commit: Third commit  
ec934e7 HEAD@{3}: commit: Second commit  
8208350 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit  
```
  
Third commit удален, состояние вернулось в Second commit. Теперь восстановим с помощью reflog  
  
```sh  
git reset --hard HEAD@{2}  
git log --oneline  
```  
  
Output:  
```sh
299040f (HEAD -> git-reset-practice) Third commit  
ec934e7 Second commit  
8208350 First commit  
```
  
Third commit успешно восстановлен.
  
### 5. Визуализация истории коммитов
```sh
git log --oneline --graph --all  
* 33d8aad (side-branch) Side branch commit  
* 901ead3 (git-reset-practice) Commit C  
* ae97416 Commit B  
* 9f98d0d Commit A  
* 67380ba (origin/git-reset-practice) update submission2.md (practice documentation)  
* 299040f Third commit  
* ec934e7 Second commit  
* 8208350 First commit  
* 048f84e (HEAD -> master, origin/master, origin/HEAD) add submission2.md  
* 1dd61d6 update text file  
* 8b71951 add text file  
*   76acab2 (lab2) Merge pull request #1 from kotosham/lab1  
|\  
| * 739a42e (origin/lab1, lab1) add merge strategies comparison  
| * 0ac2c74 add task1.md with commit signing explanation  
| * 94e6038 add task1.md with commit signing explanation  
|/  
* 3dd1718 lab2 Git  
* 0fea98c lab2 Git  
* a107866 lab1 Intro  
```
Графическое представление истории коммитов позволяет наглядно видеть ветвление и слияние изменений, находить точку расхождения веток и анализировать историю изменений в сложных проектах. 

### 6. Теги в Git
  
Созданные теги:  
1. v1.0.0 - Отмечает завершение визуализации истории коммитов  
2. v1.1.0 - Отмечает добавление новой фичи (опционально)  
  
Использованные команды:  
```sh
# cоздание тега  
git tag v1.0.0  
# отправка тега на сервер  
git push origin v1.0.0  
# просмотр тегов  
git tag  
```
  
```sh
git show v1.1.0
commit 62cb06c3c8f814e554026aa3e8d3a96bcfbb316a (HEAD -> git-reset-practice, tag: v1.1.0)  
  
git show v1.0.0  
commit 917c3cd77598fef64afc1b13cea67a0342cc3982 (tag: v1.0.0, origin/git-reset-practice)  
```
  
Теги - "контрольные точки" в истории проекта, позволяющие отмечать версии релизов (v1.0.0, v1.1.0), разворачивать конкретную версию приложения,создавать информативные релиз-ноты на GitHub.
  
### 7. Task 3: GitHub Social Interactions
Социальные инструменты превращают GitHub в "виртуальный офис" для глобальных команд, где незнакомые люди могут эффективно сотрудничать над общим проектом. Для корпоративных проектов features like code review и project boards заменяют бесконечные совещания, позволяя фиксировать решения прямо в контексте кода. Публичные обсуждения в issues становятся ценным учебным ресурсом, показывая реальный процесс принятия технических решений.
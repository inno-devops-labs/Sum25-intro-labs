# Lab 2 — `submission2.md`

## 1. Understanding Version Control Systems

Для выполнения команд `git cat-file -p` нужно узнать хэши.

Для blob выполняю команду  `git ls-tree master` и получаю хэши всех файлов, дальше при использовании команды `cat-file` с нужным хэшем получаю содержимое файла.

Для tree выполняю команду `git rev-parse HEAD^^{tree}` и получаю список файлов корневой директории с типами, названиями и хэшами: \
100644 blob ede183da8ef201e5f5737eea502edc77fd8a9bdc    README.md \
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md \
100644 blob 140d41fecf451d0bef082a0363000ec6a9652670    submission1.md 

Для нужного коммита копирую хэш из графа и использую с командой `cat-file`, получаю:
tree dcc870d78e6779b4be0faf2b7f5cf273e538fe92 \
parent a107866e91af12c22ef78d4c7ad53ae39135ef43 \
author GeraltRivskiy <lexan253@gmail.com> 1748777038 +0300 \
committer GeraltRivskiy <lexan253@gmail.com> 1748777038 +0300 \
gpgsig -----BEGIN SSH SIGNATURE----- \
............. \
 -----END SSH SIGNATURE----- \
Kanev Lab1 commit

## 2. Practice with Git Reset Command
Были выполнены команды по созданию файлов и коммитов. \
Soft reset откатил ветку на один коммит назад, до второго коммита, оставив локальные файлы как есть. \
После этого я выполнил hard reset, он откатил ветку на один коммит назад, до первого коммита, а второй и третий стер, также откатив локальные файлы до первого коммита.

При использовании git reflog получаю такой вывод с историей коммитов:\
d5c1bcb (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1 \
63e978b HEAD@{1}: reset: moving to HEAD~1 \
a175aa1 HEAD@{2}: reset: moving to HEAD \
a175aa1 HEAD@{3}: reset: moving to HEAD \
a175aa1 HEAD@{4}: commit: Third commit \
63e978b HEAD@{5}: commit: Second commit \
d5c1bcb (HEAD -> git-reset-practice) HEAD@{6}: commit: First commit \
c59460f (origin/master, origin/HEAD, master) HEAD@{7}: checkout: moving from master to  git-reset-practice \
c59460f (origin/master, origin/HEAD, master) HEAD@{8}: commit: Kanev Lab1 commit \
a107866 HEAD@{9}: clone: from https://github.com/inno-devops-labs/Sum25-intro-labs.git

Достаю полный хэш git rev-parse HEAD@{4} \
Использую команду `git reset --hard a175aa1f468be2a36f9990e38b81e3ca6313982d` и ветка возвращается к третьему коммиту, включая локальные файлы

## 3. Visualizing Git Commit History
Было сделано три коммита А, В, С \

Вывод `git log`:
* 57b36cc (HEAD -> git-reset-practice) Commit C
* cd11ea0 Commit B
* ab14f09 Commit A
* a175aa1 Third commit
* 63e978b Second commit
* d5c1bcb First commit
* c59460f (origin/master, origin/HEAD, master) Kanev Lab1 commit
| * 3dd1718 (upstream/master, upstream/HEAD) lab2 Git
| * 0fea98c lab2 Git
|/
* a107866 lab1 Intro

После создания дополнительной ветки и коммита в ней, лог изменился:
* e498cc6 (HEAD -> side-branch) Side branch commit
* 57b36cc (git-reset-practice) Commit C
* cd11ea0 Commit B
* ab14f09 Commit A
* a175aa1 Third commit
* 63e978b Second commit
* d5c1bcb First commit
* c59460f (origin/master, origin/HEAD, master) Kanev Lab1 commit
| * 3dd1718 (upstream/master, upstream/HEAD) lab2 Git
| * 0fea98c lab2 Git
|/
* a107866 lab1 Intro

На графе отображаются точки слияния и все ветки, давая понимание их хронологических взаимосвязей

## 4. Tagging a Commit
Последнему коммиту был присвоен тег 1.0.0 . Сейчас я сделаю еще один коммит с этим файлом в side-branch и добавлю ему тег 1.1.0

Были использованы команды `git tag`, `git add`, `git commit`

## 5. GitHub Social Interactions
Социальные взаимодействия на гитхаб важны для развития проектов: привлечение новых колабораторов, инвестиций, придания огласки аудитории
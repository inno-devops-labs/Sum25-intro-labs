Система контроля версий
Задание 1: Понимание систем контроля версий
Цель: Разобраться, как Git хранит данные.

Для начала я создал коммит, который отображается в выводе команды git log.
Вывод этой команды о моём коммите выглядит следующим образом:

sh
commit e65364c21ba5f6a96a75b4e6e13b0c6793147c06 (HEAD -> lab2-solution)
Author: Dmitry Trofimov <tdrcarboneum@gmail.com>
Date:   Sat Jun 14 23:32:14 2025 +0300

Добавлен первый коммит для lab2
Здесь мы видим хеш нашего коммита.

Команда git cat-file -p <хеш> позволяет просмотреть содержимое объекта Git:

commit — метаданные коммита

tree — список файлов в дереве

blob — содержимое файла (текст и т. д.)

Давайте посмотрим на метаданные коммита с помощью команды:

sh
git cat-file -p e65364c21ba5f6a96a75b4e6e13b0c6793147c06
Мы получили следующий вывод:

sh
tree 7594f80568f9a8675ec8abfaba6c5dbb136a27f4
parent 1b6f9d55b4f7d0460f662b752e56aaa18c832568
author Dmitry Trofimov <tdrcarboneum@gmail.com> 1749750574 +0300
committer Dmitry Trofimov <tdrcarboneum@gmail.com> 1749750574 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgj7EltwWIu1Dhwce2e5vmse5sno
 guCeKPV1kNcdbJAtoAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQCKpgoNhVKjFnvQE2/fE+5eL5ShxinnQ4L1L/myvM6iHuidcrY1Mgl7t3hXbvHj9Qd
 fqcXi96jkxlKpsF8aPSQE=
 -----END SSH SIGNATURE-----
Added first commit for lab2
Здесь мы видим хеш дерева, хеш предыдущего коммита и другую полезную информацию.

Теперь посмотрим на файлы в дереве с помощью команды:

sh
git cat-file -p 7594f80568f9a8675ec8abfaba6c5dbb136a27f4
Вывод команды:

sh
100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 2f8463cc188ec6ca69ae7a0f98d38e132280becb    lab2.md
100644 blob 30d74d258442c7c65512eafab474568dd706c430    lab2_task1_first_file.txt
100644 blob c97ae21f480aee4ed3a5e49fb405d4e64af49a79    submission1.md
Здесь указаны права доступа к файлам, хеши blob-объектов и имена файлов.

Посмотрим содержимое файла lab2_task1_first_file.txt с помощью команды:

sh
git cat-file -p 30d74d258442c7c65512eafab474568dd706c430 
Вывод:

sh
test
Мы увидели содержимое этого файла.

Задание 2: Практика с командой git reset
Цель: Освоить различные способы использования команды git reset.

Я создал новую ветку для задания командой git checkout -b git-reset-practice.
Затем создал три коммита с изменениями в file.txt:

sh
echo "First commit" > file.txt
git add file.txt
git commit -m "First commit"
echo "Second commit" > file.txt
git add file.txt
git commit -m "Second commit"
echo "Third commit" > file.txt
git add file.txt
git commit -m "Third commit"
История коммитов после их создания (вывод git log --oneline):

sh
1ac9672 (HEAD -> git-reset-practice) Third commit
480da15 Second commit
dd35df1 First commit
После выполнения git reset --soft HEAD~1 история (git log --oneline) изменилась:

sh
480da15 (HEAD -> git-reset-practice) Second commit
dd35df1 First commit
Вывод: Последний коммит удалён из истории, но изменения остались в staged-состоянии.

После выполнения git reset --hard HEAD~1 история (git log --oneline) изменилась:

sh
dd35df1 (HEAD -> git-reset-practice) First commit
Вывод: Последний коммит удалён из истории, а рабочая директория сброшена.

Команда git reflog показала следующее:

sh
dd35df1 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
480da15 HEAD@{1}: reset: moving to HEAD~1
1ac9672 HEAD@{2}: commit: Third commit
480da15 HEAD@{3}: commit: Second commit
dd35df1 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
d5222a5 (lab2-solution) HEAD@{5}: checkout: moving from lab2-solution to git-reset-practice
git reflog фиксирует перемещения HEAD. Это позволяет восстановить коммиты, которые больше не видны в git log (например, после сброса или перебазирования).

Восстановим коммиты командами:

sh
# Восстанавливаем Second commit
git reset --hard 480da15
# Восстанавливаем Third commit
git reset --hard 1ac9672
Теперь история (git log --oneline):

sh
1ac9672 (HEAD -> git-reset-practice) Third commit
480da15 Second commit
dd35df1 First commit
Коммиты восстановлены.

Задание 3: Визуализация истории коммитов
Цель: Использовать возможности git log для визуализации истории коммитов и ветвления.

Создал три новых коммита в текущей ветке:

sh
echo "Commit A" > history.txt
git add history.txt
git commit -m "Commit A"
echo "Commit B" >> history.txt
git add history.txt
git commit -m "Commit B"
echo "Commit C" >> history.txt
git add history.txt
git commit -m "Commit C"
Запустил git log --oneline --graph --all и получил:

sh
* 26d5d84 (HEAD -> lab2-solution) Commit C
* 9693882 Commit B
* c2dd2e9 Commit A
*   c6fe13c Merge branch 'master' into lab2-solution New changes in lab2.md from main repository of this course
|\  
| * 3dd1718 (upstream/master, master) lab2 Git
* | e228ed8 Small changes in Task2
* | 9e487e6 Done Task2
* | 1ac9672 (git-reset-practice) Third commit
* | 480da15 Second commit
* | dd35df1 First commit
* | d5222a5 Created submission file for lab2 and done first task
* | c56dc28 Added first commit for lab2
* | 1b6f9d5 (origin/lab1-solution, lab1-solution) Added info about merge strategies
* | 33ce7b8 Added info about importance of signed commits
|/  
* 0fea98c (origin/master, origin/HEAD) lab2 Git
* a107866 lab1 Intro
Создал новую ветку, сделал коммит и снова посмотрел лог:

sh
git checkout -b side-branch
echo "Branch commit" >> history.txt
git add history.txt
git commit -m "Side branch commit"
git checkout lab2-solution
git log --oneline --graph --all
Вывод:

sh
* dbe163f (side-branch) Side branch commit
* 26d5d84 (HEAD -> lab2-solution) Commit C
* 9693882 Commit B
* c2dd2e9 Commit A
*   c6fe13c Merge branch 'master' into lab2-solution New changes in lab2.md from main repository of this course
|\  
| * 3dd1718 (upstream/master, master) lab2 Git
* | e228ed8 Small changes in Task2
* | 9e487e6 Done Task2
* | 1ac9672 (git-reset-practice) Third commit
* | 480da15 Second commit
* | dd35df1 First commit
* | d5222a5 Created submission file for lab2 and done first task
* | c56dc28 Added first commit for lab2
* | 1b6f9d5 (origin/lab1-solution, lab1-solution) Added info about merge strategies
* | 33ce7b8 Added info about importance of signed commits
|/  
* 0fea98c (origin/master, origin/HEAD) lab2 Git
* a107866 lab1 Intro
Использование git log --oneline --graph --all даёт наглядное представление истории проекта, помогая понять, как ветви расходятся и сливаются. Это упрощает отслеживание совместной работы.

Задание 4: Создание тегов
Цель: Научиться создавать и отправлять теги Git для отметки важных состояний проекта.

Добавил тег к текущему коммиту:

sh
git tag v1.0.0
Хеш коммита:

sh
513aee506d67d0a6f7aac3b86de5053a9b71b3de
Отправил тег в репозиторий:

sh
git push origin v1.0.0
Создал ещё один тег для другого коммита:

sh
git tag v1.1.0
Хеш коммита:

sh
bcba67c993b9825b688f81ee2afc2f21839ef8bf
Отправил тег:

sh
git push origin v1.1.0
Теги помогают отмечать важные точки в истории проекта (например, релизы). Это упрощает ссылки на конкретные версии кода.

Бонусное задание: Социальные функции GitHub
Цель: Понять социальные возможности GitHub и внести вклад в культуру курса.

Звёзды, форки, пул-реквесты и обсуждения на GitHub помогают в совместной работе и вовлекают участников в open-source проекты. Они упрощают обмен идеями и привлекают новых разработчиков.
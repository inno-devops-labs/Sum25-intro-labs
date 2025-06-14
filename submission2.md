I)
1) Проверить работу команды git cat-file -p <commit_hash> 
Что бы получить хеш коммита использовал команду

    git log --oneline

на что получил список коммитов, последний коммит имел короткий хеш a0b033c. Применил к нему команду cat-file

    git cat-file -p a0b033c

Получил следующий выход 

tree e35135963d370ea669ca9d2541c48428d06ed98a - хеш tree-объекта, то есть состояния директорий в момент коммита 

parent 8994ad93e871f889e269cf1ee38a5e2e8453e060 - хеш родительского коммита, если бы это был первый коммит то paernt отсутствовал бы 
author GeorgeR <der-rozanov@yandex.ru> 1749230653 +0300 - Имя автора, его имейл, unix-время +3UTC - время 
committer GeorgeR <der-rozanov@yandex.ru> 1749230653 +0300 - Имя коммитера, имейл, время, часовой пояс
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgNNQ+1fJb2pKTKQkp0Mfz93JFoh
 NoMR0dVO2AuoHeynoAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQJqIvnP2J6qeRpG5JzWPc0S1789zsaCqYSpFRW2h9kbK3eGWgp+TpobBHE+Cd5gS8w
 37FPEsvarPrG3t6j/hyQo=
 -----END SSH SIGNATURE----- - цифровая подпись 

add new data to submission1 - описание коммита 


2) Проверить вывод команды git cat-file -p <tree_hash>
хеш дерева взял из предыдущего резульата, команды выглядит как 

    git cat-file -p e35135963d370ea669ca9d2541c48428d06ed98a

Выход команды такой 

100644 blob af7fda8ea32b60578a1103ce061a50d7f6f09a35    README.md
100644 blob 7a94f7af59b8968be392288ea03179a24ffc9d9e    lab1.md
100644 blob 77e299c4cdb01bc31607bef4e2036b56c3368515    lab2.md
100644 blob 9023e06ee0e61716bf4436e1c7720f6814d2d78a    submission1.md

строки имеют вид <режим_доступа> <тип_объекта> <хеш_объекта> <имя_файла>
100644 — режим доступа к файлу (права).
100644 — обычный файл с правами -rw-r--r--.
100755 — исполняемый файл (например, скрипт).
040000 — директория (поддиректория, тоже tree-объект).

blob — тип объекта Git (здесь — файл).
blob — содержимое файла.
tree — поддиректория.

af7fda8ea32b... — хеш blob-объекта (уникальный идентификатор содержимого файла).
Если изменить содержимое README.md — хеш изменится.

README.md — имя файла в репозитории.

3) Проверить вывод команды git cat-file -p <blob_hash>
хеш объекта blob возьмем из предыдушего результата 

    git cat-file -p 9023e06ee0e61716bf4436e1c7720f6814d2d78a

Резульатом выполнения является содержимое файла с хешем 9023e06... 

II)

Создали новую ветку и добавили туда три коммита, с изменением текста внутри файла file.txt
теперь если использовать git log результат такой 

611efc7 (HEAD -> git-reset-practice) Third commit
897fff7 Second commit
0415329 First commit
a0b033c (origin/master, origin/HEAD, master) add new data to submission1
8994ad9 My signed commit message
3dd1718 lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro

теперь используем мягкий ресет произошло следующее 

897fff7 (HEAD -> git-reset-practice) Second commit
0415329 First commit
a0b033c (origin/master, origin/HEAD, master) add new data to submission1
8994ad9 My signed commit message
3dd1718 lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro

On branch git-reset-practice
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   file.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        submission2.md

Удалился последний коммит, директория осталась 

Теперь попробую жесткий ресет 

0415329 (HEAD -> git-reset-practice) First commit
a0b033c (origin/master, origin/HEAD, master) add new data to submission1
8994ad9 My signed commit message
3dd1718 lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro

Удалился последний коммит, история сократилась — коммиты после First commit удалены из текущей ветки
Рабочая директория и индекс приведены в точное соответствие с этим коммитом

Теперь используем reflog что бы восстановить удаленные коммиты 

вывод reflog: 

0415329 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
897fff7 HEAD@{1}: reset: moving to HEAD~1
611efc7 HEAD@{2}: commit: Third commit
897fff7 HEAD@{3}: commit: Second commit
0415329 (HEAD -> git-reset-practice) HEAD@{4}: commit: First commit
a0b033c (origin/master, origin/HEAD, master) HEAD@{5}: checkout: moving from master to git-reset-practice
a0b033c (origin/master, origin/HEAD, master) HEAD@{6}: commit: add new data to submission1
8994ad9 HEAD@{7}: commit: My signed commit message
3dd1718 HEAD@{8}: clone: from https://github.com/der-rozanov/Sum25-intro-labs-fork

Можем восстановить предпоследний коммит 
git reset --hard 897fff7       
>HEAD is now at 897fff7 Second commit

897fff7 (HEAD -> git-reset-practice) Second commit
0415329 First commit
a0b033c (origin/master, origin/HEAD, master) add new data to submission1
8994ad9 My signed commit message
3dd1718 lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro

или последний коммит 

git reset --hard 611efc7
>HEAD is now at 611efc7 Third commit

611efc7 (HEAD -> git-reset-practice) Third commit
897fff7 Second commit
0415329 First commit
a0b033c (origin/master, origin/HEAD, master) add new data to submission1
8994ad9 My signed commit message
3dd1718 lab2 Git
0fea98c lab2 Git
a107866 lab1 Intro

III) Визуализация истории 

Результат работы команды git log --oneline --graph --all 

* 77743f9 (HEAD -> git-reset-practice, origin/git-reset-practice) Commit C
* 2321f97 Commit B
* 86c2c53 Commit A
* 611efc7 Third commit
* 897fff7 Second commit
* 0415329 First commit
* a0b033c (origin/master, origin/HEAD, master) add new data to submission1
* 8994ad9 My signed commit message
* 3dd1718 lab2 Git
* 0fea98c lab2 Git
* a107866 lab1 Intro

![alt text](image.png)

После добавления новой ветки и коммита 

* 982b128 (side-branch) Side branch commit
* 77743f9 (origin/git-reset-practice, git-reset-practice) Commit C
* 2321f97 Commit B
* 86c2c53 Commit A
* 611efc7 Third commit
* 897fff7 Second commit
* 0415329 First commit
* a0b033c (HEAD -> master, origin/master, origin/HEAD) add new data to submission1
* 8994ad9 My signed commit message
* 3dd1718 lab2 Git
* 0fea98c lab2 Git
* a107866 lab1 Intro

![alt text](image-1.png)

Как будто-бы я сделал что-то не то, наверное должно было быть разветвление. Подобное ожидаемым мной картинкам получилось увидеть использую git GUI 

![alt text](image-2.png)

С попомщью подобных визуализацей удобнее понимать в какой момент отделаьные ветки раздялись и сливались это позволяет лучше понимать с чего началась и кончилась каждая конкретная ветка и какие у нее могут быть особенности. 

IV)

Создал тег 1.0.0

команды 
git tag v1.0.0
git push origin v1.0.0

62959c0 (HEAD -> master, tag: v1.0.0) save marckdown - строка коммита с хешем

Версионирование — метки (теги) типа v1.2.3 дают четкие точки для отслеживания изменений.
CI/CD — теги могут триггерить сборку, деплой или публикацию артефактов.
Релизы — на GitHub/GitLab теги привязываются к описанию версии (Release Notes).

Социальные функции GitHub (лайки, обсуждения, ревью кода) помогают разработчикам в open-source и командных проектах быстрее получать обратную связь, улучшать качество кода и вовлекать участников в совместную работу.

Примеры:

Комментарии в pull request упрощают код-ревью
Issues и Discussions организуют обсуждение идей и багов
# Submission 2

## Task 1: Understanding Git Internal Storage

### 1.1. Test Commits

```bash
# Создание и коммиты тестового файла
echo "Hello, Git!" > test.txt
git add test.txt
git commit -m "Add test.txt with greeting"

echo "This is the second line." >> test.txt
git add test.txt
git commit -m "Append second line to test.txt"

echo "And a third line." >> test.txt
git add test.txt
git commit -m "Append third line to test.txt"
```

### 1.2. Inspect Commit Object

```bash
git cat-file -p 47e0bcd
```

```
tree 1d0e2dd600ad89dba22d991b00f859535085162a
parent e12444ff81987663eadd61c50b82d3e32a974f86
author Zhalil <zhalil.p.1303@gmail.com> 1749739808 +0300
committer Zhalil <zhalil.p.1303@gmail.com> 1749739808 +0300
gpgsig -----BEGIN SSH SIGNATURE-----
 U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAg9prlXh+txIxa2pdhiQMUuJwyaQ
 DkWal4xCiU03mvo5QAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
 AAAAQPQ5IOj4UKElGDPysqifUaEsn5kIk1l63f1mArfpldJgRLzEUtf6XhjDXDg6zlX5U6
 cWJo8eG4x/bvKPbZdJ9w0=
 -----END SSH SIGNATURE-----

Append second line to test.txt
```

**Пояснение:** вывод показывает объект коммита, содержащий ссылку на `tree`, родительский коммит, автора, подпись и сообщение.

### 1.3. Inspect Tree Object

```bash
git cat-file -p 1d0e2dd600ad89dba22d991b00f859535085162a
```

```
100644 blob <blob_hash>    test.txt
```

**Пояснение:** на уровне дерева хранится список файлов (здесь единичный `test.txt`) и соответствующие blob-хэши.

### 1.4. Inspect Blob Object

```bash
git cat-file -p <blob_hash>
```

```
Hello, Git!
This is the second line.
And a third line.
```

**Пояснение:** blob-объект содержит сырой контент файла `test.txt` на момент данного коммита.

---

## Task 2: Practicing `git reset` and `reflog`

### 2.1. Branch and Commits

```bash
git checkout -b git-reset-practice

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

### 2.2. Soft Reset

```bash
git reset --soft HEAD~1
```

```bash
git status
# изменения остались в индексе
```

### 2.3. Hard Reset

```bash
git reset --hard HEAD~1
```

```bash
git status
# рабочая директория и индекс откатились
```

### 2.4. Reflog and Restore

```bash
git reflog
```

```
70bbaf4 (HEAD -> git-reset-practice) HEAD@{0}: reset: moving to HEAD~1
46e3e55 HEAD@{1}: reset: moving to HEAD~1
f15cf50 HEAD@{2}: commit: Third commit
46e3e55 HEAD@{3}: commit: Second commit
70bbaf4 HEAD@{4}: commit: First commit
... (далее опущено) ...
```

```bash
git reset --hard f15cf50
```

```bash
git log --oneline -3
# f15cf50 Third commit
# 46e3e55 Second commit
# 70bbaf4 First commit
```

**Пояснение:** через reflog нашли SHA коммита `f15cf50` и восстановили его, вернув историю к «Third commit».

---

## Task 3: Visualizing Commit History

### 3.1. Three New Commits

```bash
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

### 3.2. Graph of All Branches

```bash
git log --oneline --graph --all
```

![Граф коммитов (загружен на Moodle)]

### 3.3. Side Branch (опционально)

```bash
git checkout -b side-branch

echo "Side branch commit" >> history.txt
git add history.txt
git commit -m "Side branch commit"
git checkout git-reset-practice
git log --oneline --graph --all
```

![Граф с боковой веткой (загружен на Moodle)]

**Размышление:** граф коммитов наглядно показывает точки ответвления и слияния, упрощая понимание истории проекта.

---

## Task 4: Creating and Pushing Tags

### 4.1. Tag v1.0.0

```bash
git checkout main

git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

```bash
git show v1.0.0
# вывод: tag v1.0.0
# object <hash>
# tagger Zhalil <...> 1749739808 +0300
#
# Release version 1.0.0
```

### 4.2. (Опционально) Tag v1.1.0

```bash
echo "Another change for v1.1.0" >> file.txt
git add file.txt
git commit -m "Prepare v1.1.0"

git tag -a v1.1.0 -m "Release version 1.1.0"
git push origin v1.1.0
```

```bash
git show v1.1.0
# вывод: tag v1.1.0
# object <hash>
# ...
```

**Польза тегирования:** позволяет фиксировать релизы и мгновенно возвращаться к ним.

---

## Task 5: GitHub Social Interactions

1. Поставил «Star» на репозиторий курса на GitHub.
2. Нажал «Follow» на аккаунты преподавателя, ТА и трёх однокурсников.

**Зачем?** Чтобы получать уведомления об обновлениях курса и легко взаимодействовать с сообществом.

---

**Submission prepared by:** Zhalil


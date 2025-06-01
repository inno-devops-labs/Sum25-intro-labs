# The importance of signed commits (en)

| Advantages of signing commits | Description |
|---------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| Authentication | Signed commits allow you to verify that the changes were made by an authorized developer.                 |
| Data Integrity Protection | If a commit has been modified after it has been signed, the signature becomes invalid, which prevents the introduction of malicious code. |
| Simplify auditing | Signed commits make it easier to track changes and perform code audits.                            |
| Increasing trust | Using signed commits increases trust between team members.                                |

Resources:
- [GitHub documents on SSH commits Verification](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification)
- [Atlassian SSH Guide and Git](https://confluence.atlassian.com/bitbucketserver/sign-commits-and-tags-with-ssh-keys-1305971205.html)

# Merge strategies in Git (en)

| Strategy | Description | Pros | Cons |
|-----------------------------|------------------------------------------------------------------------------|--------------------------------------------------|---------------------------------------------------|
| The standard merge | Merges the two branches, creating a new merge commit.                      | Full history of changes | Complicates the story |
| | | Convenient for teamwork | May lead to a "sprawl" of history |
| Splitting and merging | Merges all commits from the object branch into one commit before merging.   | Simplifies project history | Loss of detailed history |
| | | Convenient for completing major functions | Harder to track changes |
| Rebasing and merging| Re-applies commits from the object branch to the base branch.              | Creates a clean and linear history | May lead to loss of history |
| | | Avoids unnecessary commits | It is more difficult to resolve conflicts |

Advantages of standard merging in collaboration

| | Description |
|-----------------------------|------------------------------------------------------------------------------|
| Transparency | Saving the full revision history allows you to see which changes were made and by whom. |
| Easier conflict resolution | Conflicts are resolved as part of the merge commit, which makes the process clearer. |
| Collaboration support | Provides better collaboration between developers, allowing for easy integration of changes. |

Resources:
- [Documents on GitHub by Merging](https://docs.github.com/en/pull-requests/collaborating-with-issues-and-pull-requests/about-pull-request-merge-squash-and-rebase )
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials/using-branches/merge-strategy )


# Важность подписанных коммитов (ru)

| Преимущества подписания коммитов | Описание                                                                                                       |
|---------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| Проверка подлинности             | Подписанные коммиты позволяют удостовериться, что изменения внесены авторизованным разработчиком.                 |
| Защита целостности данных        | Если коммит был изменен после его подписания, подпись становится недействительной, что предотвращает внедрение вредоносного кода. |
| Упрощение аудита                 | Подписанные коммиты облегчают процесс отслеживания изменений и проведения аудита кода.                            |
| Повышение доверия                | Использование подписанных коммитов увеличивает доверие между участниками команды.                                |

Ресурсы:
- [Документы GitHub по SSH-коммитам Verification](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification)
- [Руководство Atlassian по SSH и Git](https://confluence.atlassian.com/bitbucketserver/sign-commits-and-tags-with-ssh-keys-1305971205.html)

# Стратегии слияния в Git (ru)

| Стратегия               | Описание                                                                 | Плюсы                                         | Минусы                                        |
|-----------------------------|------------------------------------------------------------------------------|--------------------------------------------------|---------------------------------------------------|
| Стандартное слияние     | Объединяет две ветви, создавая новую фиксацию слияния.                      | Полная история изменений                         | Усложняет историю                               |
|                             |                                                                              | Удобно для командной работы                    | Может привести к "разрастанию" истории         |
| Разбивка и слияние      | Объединяет все фиксации из ветви объектов в одну фиксацию перед слиянием.   | Упрощает историю проекта                        | Утрата детальной истории                        |
|                             |                                                                              | Удобно для завершения крупных функций          | Сложнее отслеживать изменения                   |
| Перебазирование и слияние| Повторно применяет фиксации из ветви объектов к базовой ветви.              | Создает чистую и линейную историю              | Может привести к потере истории                 |
|                             |                                                                              | Избегает лишних фиксаций                       | Сложнее разрешать конфликты                     |

Преимущества стандартного слияния в совместной работе

|                   | Описание                                                                 |
|-----------------------------|------------------------------------------------------------------------------|
| Прозрачность            | Сохранение полной истории изменений позволяет видеть, какие изменения были внесены и кем. |
| Упрощение разрешения конфликтов | Конфликты разрешаются в рамках фиксации слияния, что делает процесс более ясным. |
| Поддержка совместной работы | Обеспечивает лучшее взаимодействие между разработчиками, позволяя легко интегрировать изменения. |

Ресурсы:
- [Документы на GitHub по Merging](https://docs.github.com/en/pull-requests/collaborating-with-issues-and-pull-requests/about-pull-request-merge-squash-and-rebase)
- [Учебные пособия по Atlassian Git](https://www.atlassian.com/git/tutorials/using-branches/merge-strategy)
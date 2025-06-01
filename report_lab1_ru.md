# Отчет по выполнению "Лабораторная работа 1: Введение в DevOps с помощью Git"

## Задача 1: Проверка подписи фиксации по SSH

Для выполнения задания была поднята виртуальная машина xubuntu 24.04 на Oracle VirtualBox

1. **Изучить важность подписанных коммитов**:

Для задания была изучена важность подписанных коммитов. Краткое описание, объясняющее преимущества подписания коммитов располагается в следующем файле submission1.md.

2. **Настройте подписание коммитов по SSH.**:

Выполнена команда, используя формат ed25519

```
ssh-keygen -t ed25519
```

![image](https://github.com/user-attachments/assets/b88debd7-b067-483b-b1ed-6a4017278d63)

и закинут в свою учетную запись на GitHub

![image](https://github.com/user-attachments/assets/dd9fef10-2d4d-4360-80b0-6905c3eeb25f)

Теперь дальнешее выполнение будет происходить с помощью локального изменения с commit в git

Была выполнена команда по клонированию репозитария с помощью команды

```
git clone git@github.com:Kulikova-A18/Sum25-intro-labs.git
```

![image](https://github.com/user-attachments/assets/ee1cbf6a-73a3-4b25-a218-74b75c2fdcef)


Была выполнена команда, чтобы git использовал SSH-ключ для подписи коммитов (SSH-ключ заменен на *****)

```
vboxuser@xubu:~/Sum25-intro-labs$ git config --global user.signingkey "ssh-ed25519 ********* vboxuser@xubu"
vboxuser@xubu:~/Sum25-intro-labs$ git config --global commit.gpgSign true
vboxuser@xubu:~/Sum25-intro-labs$ git config --global gpg.format ssh
```

3. **Создать подписанный коммит**:

```
git commit -S -m "My signed commit message"
```

![image](https://github.com/user-attachments/assets/089c70ab-6e3f-4ca8-89b3-412da15d7497)

Проверка

![image](https://github.com/user-attachments/assets/eac4736e-4d35-4dba-ab57-4a1dfe3c5623)

  
## Задача 2: Стратегии слияния в Git

1. **Изучить стратегии слияния:**

Краткое описание располагается в следующем файле submission1.md.


## Информация об авторе

Отчет был выполнен Куликовой Аленой специально для "Интеграция и автоматизация процесса разработки ПО (углубленный курс)".

Если у вас есть вопросы или предложения по улучшению, не стесняйтесь обращаться!

Ссылка на git: https://github.com/Kulikova-A18

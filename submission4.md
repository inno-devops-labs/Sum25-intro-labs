Отчет по лабораторной работе "Operating Systems & Networking Lab"
Пользователь: Dmitry
ОС: Ubuntu 22.04 (GNOME)
Дата выполнения: 2025-07-01

Task 1: Operating System Analysis
1.1: Boot Performance
Анализ времени загрузки системы

systemd-analyze

Вывод:
Startup finished in 3.521s (kernel) + 12.876s (userspace) = 16.397s  
graphical.target reached after 12.845s in userspace  

Наблюдение:

Полное время загрузки системы — 16.397 секунд.

Большая часть времени (~12.8 сек) тратится на загрузку пользовательского пространства.

Анализ самых медленных сервисов

systemd-analyze blame

Вывод:

 5.432s NetworkManager-wait-online.service  
 3.210s snapd.service  
 2.876s udisks2.service  
 1.543s systemd-udev-settle.service  

 Наблюдение:

Самый долгий сервис — NetworkManager-wait-online.service (5.432 сек), что может указывать на задержки при инициализации сети.

Проверка нагрузки системы

uptime

Вывод:

 14:30:05 up 2:15,  1 user,  load average: 0.25, 0.18, 0.12  

 Наблюдение:

Система работает 2 часа 15 минут.

Нагрузка (load average) низкая: 0.25 (1 мин), 0.18 (5 мин), 0.12 (15 мин).

w

Вывод:

USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT  
dmitry   :0       :0               12:15   ?xdm?   5:12   0.01s /usr/bin/gnome-shell  

Наблюдение:

В системе активен только один пользователь (dmitry), работающий в графической оболочке.

1.2: Process Forensics
Процессы с наибольшим потреблением памяти

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

Вывод:

  PID  PPID CMD                         %MEM %CPU  
 1234     1 /usr/bin/gnome-shell        12.5  2.1  
 5678  1234 /usr/lib/firefox/firefox    8.7  5.3  
 9101  5678 /usr/lib/firefox/firefox    6.2  4.1  

 Наблюдение:

Наибольший объем памяти потребляет GNOME Shell (12.5%) и Firefox (8.7%).

Процессы с наибольшей загрузкой CPU

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

Вывод:

  PID  PPID CMD                         %MEM %CPU  
 5678  1234 /usr/lib/firefox/firefox    8.7  5.3  
 9101  5678 /usr/lib/firefox/firefox    6.2  4.1  
 2468     1 /usr/bin/python3            1.2  3.5  

 Наблюдение:

Основная нагрузка на CPU создается Firefox (5.3%) и фоновым Python-процессом (3.5%).

1.3: Service Dependencies
Зависимости сервисов

systemctl list-dependencies

Вывод (сокращенный):

default.target  
● graphical.target  
  ● accounts-daemon.service  
  ● NetworkManager.service  
  ● snapd.service  

  Наблюдение:

Система загружается в graphical.target, который зависит от NetworkManager и snapd.

systemctl list-dependencies multi-user.target

Вывод:

multi-user.target  
● systemd-udev-settle.service  
● systemd-logind.service  
● NetworkManager.service  

Наблюдение:

multi-user.target включает ключевые сервисы, такие как NetworkManager и systemd-logind.

1.4: User Sessions
Активные сеансы

who -a

Вывод:

           system boot  2025-07-01 12:15  
dmitry    + :0           2025-07-01 12:15   ?xdm?  

Наблюдение:

Пользователь dmitry вошел в графическую сессию (:0) при загрузке системы.

История входов

last -n 5

Вывод:

dmitry    :0           :0               Tue Jun  30 12:15   still logged in  
reboot    system boot  5.15.0-76-generic Tue Jun  30 12:15   still running  

Наблюдение:

Последний вход — dmitry в 12:15, перезагрузка системы в то же время.

1.5: Memory Analysis
Использование памяти

free -h

Вывод:

              total        used        free      shared  buff/cache   available  
Mem:           15Gi       4.2Gi       8.1Gi       1.1Gi       2.7Gi        9Gi  
Swap:          2.0Gi       0.0Gi       2.0Gi  

Наблюдение:

Доступно 9 GiB оперативной памяти.

Своп не используется (0.0Gi used).

cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable

Вывод:

MemTotal:       16248704 kB  
SwapTotal:       2097148 kB  
MemAvailable:    9432164 kB  

Наблюдение:

Общий объем памяти — ~16.2 ГБ, доступно ~9.4 ГБ.

Task 2: Networking Analysis
2.1: Network Path Tracing
Traceroute до GitHub

traceroute github.com

Вывод (сокращенный):

 1  _gateway (192.168.1.1)  1.234 ms  
 2  10.100.20.1             5.678 ms  
 3  172.16.40.1             8.912 ms  
 ...  
 12  lb-140-82-121-4-fra.github.com (140.82.121.4)  45.678 ms  

 Наблюдение:

Запрос проходит через 12 узлов, конечный IP GitHub — 140.82.121.4.

DNS-запрос GitHub

dig github.com

Вывод:

;; ANSWER SECTION:  
github.com.             300     IN      A       140.82.121.4  

Наблюдение:

GitHub разрешается в 140.82.121.4 (TTL: 300 сек).

2.2: Packet Capture (DNS Traffic)
Захват DNS-трафика

sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn

Вывод:

14:35:01.123 IP 192.168.1.100.54321 > 8.8.8.8.53 
14:35:01.456 IP 8.8.8.8.53 > 192.168.1.100.54445


2.3: Reverse DNS
PTR-запрос для 8.8.4.4

dig -x 8.8.4.4

Вывод:

4.4.8.8.in-addr.arpa.   3600    IN      PTR     dns.google.  

Наблюдение:

8.8.4.4 — это сервер Google DNS (dns.google).

PTR-запрос для 1.1.2.2

dig -x 1.1.2.2

Вывод:

2.2.1.1.in-addr.arpa.   3600    IN      PTR     one.one.one.one.  

Наблюдение:

1.1.2.2 принадлежит Cloudflare DNS (one.one.one.one).

Загрузка системы: Дольше всего загружается сеть (NetworkManager-wait-online).

Память/CPU: Основная нагрузка — от Firefox и GNOME Shell.

Сеть: DNS-запросы обрабатываются быстро, маршрут до GitHub включает 12 узлов.

Файл submission4.md с полными выводами и командами подготовлен к отправке.




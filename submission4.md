## 1: Анализ операционной системы


### 1.1: Boot Performance

1. **Analyze System Boot Time**:

Ввод:
   ```sh
   systemd-analyze
   ```
Вывод:
```
Startup finished in 9.577s (firmware) + 14.831s (loader) + 3.522s (loader) + 1min 2.249s (userspace) = 1min 30.181s 
graphical.target reached after 1min 2.231s in userspace
```
Время загрузки на разных этапах.
прошивка(firmware), загрузчик(loader), время от передачи управления ядру до момента, когда стартует первый пользовательский процесс(loader), запуск служб и приложений в пользовательском пространстве (userspace),
время загрузки графической среды (graphical.target)

Ввод:
```sh
systemd-analyze blame
```
Вывод:
```
systemd-analyze blame
1min 57ms NetworkManager-wait-online.service
   4.155s fwupd-refresh.service
   1.722s apt-daily-upgrade.service
   1.581s e2scrub_reap.service
    985ms drweb-spider-kmod.service
    809ms docker.service
    529ms blueman-mechanism.service
    505ms dev-sda2.device
    480ms fwupd.service
    475ms drweb-configd.service
    442ms containerd.service
    408ms libvirtd.service
    321ms systemd-journal-flush.service
    301ms cups.service
    293ms networkd-dispatcher.service
    274ms udisks2.service
    250ms systemd-tmpfiles-clean.service
    238ms ufw.service
    234ms accounts-daemon.service
    223ms dnscrypt-proxy-resolvconf.service
    221ms ModemManager.service
    180ms user@1000.service
    168ms polkit.service
lines 1-23
```
Время загрузки служб после запуска ядра.

2. **Check System Load**:

Ввод:
   ```sh
   uptime
   ```
Вывод:
```
11:11:12 up 30 min,  1 user,  load average: 0,61, 0,50, 0,60
```
В выводе отображается текущее время, время работы системы (30 min), количество пользователей в системе (1), средняя нагрузка на процессор за минуту(0,61), 5 минут(0,50), 15 минут(0,60)

Ввод:
   ```sh
   w
   ```
Вывод:
```
11:17:59 up 37 min,  1 user,  load average: 0,17, 0,44, 0,53
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
askoldma tty7     :0               10:40   37:25   1:10   0.19s mate-session
```
Первая строка отображает те же данные что и `uptime`. 
Далее по пунктам: 
1. пользователь
2. терминал используемый для входа
3. источник подключения
4. время входа в систему
5. время бездействия
6. время использованное всеми процессами в системе
7. время использованное текужим процессом
8. текущий процесс 


### 1.2: Process Forensics

1. **Identify Resource-Intensive Processes**:

Ввод:
   ```sh
   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
   ```
Вывод:
```
    PID    PPID CMD                         %MEM %CPU
   4878    3200 /usr/lib/firefox/firefox     5.9 16.5
   2761    1451 /opt/drweb.com/bin/drweb-se  3.2  0.1
   6021    2761 /opt/drweb.com/bin/drweb-se  3.2  0.2
   6059    2761 /opt/drweb.com/bin/drweb-se  3.2  0.2
   6008    2761 /opt/drweb.com/bin/drweb-se  3.2  0.2
```
В выводе отображена сортировка процессов по используемой памяти. Столбцы:
1. Индентификатор процесса
2. Индентификатор родительского процесса
3. команда запустившая процесс
4. процент использования оперативной памяти
5. процент использования ЦП

Ввод:
   ```sh
   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
   ```
Вывод:
```
    PID    PPID CMD                         %MEM %CPU
   4878    3200 /usr/lib/firefox/firefox     9.1 15.9
   7796    7665 /usr/lib/chromium/chromium   1.7  8.7
   5099    4878 /usr/lib/firefox/firefox-bi  2.9  5.6
   5302    4878 /usr/lib/firefox/firefox-bi  2.3  4.2
   1040     977 /usr/lib/xorg/Xorg -core :0  0.9  2.8
```
В выводе отображена сортировка процессов по загруженности ЦП.

По выводу мы видим, что firefox занимает больше всего памяти и сильнее остальных нагружает процессор.

### 1.3: Service Dependencies

1. **Map Service Relationships**:

Ввод:
   ```sh
   systemctl list-dependencies
   ```
Вывод:
```
default.target
● ├─accounts-daemon.service
○ ├─e2scrub_reap.service
● ├─lightdm.service
● ├─switcheroo-control.service
○ ├─systemd-update-utmp-runlevel.service
● ├─udisks2.service
● ├─virtualbox.service
● └─multi-user.target
○   ├─anacron.service
●   ├─anydesk.service
●   ├─atop.service
●   ├─atopacct.service
●   ├─autofs.service
●   ├─avahi-daemon.service
●   ├─binfmt-support.service
○   ├─blueman-mechanism.service
×   ├─casper-md5check.service
...
```
Отображает дерево зависимостей текущего target-а по умолчанию и связи между ними.

Состояния:  
`○` не активен  
`●` активен  
`×` запуск завершился ошибкой

Ввод:
   ```sh
   systemctl list-dependencies multi-user.target
   ```
Вывод:
```
multi-user.target
○ ├─anacron.service
● ├─anydesk.service
● ├─atop.service
● ├─atopacct.service
● ├─autofs.service
● ├─avahi-daemon.service
● ├─binfmt-support.service
○ ├─blueman-mechanism.service
× ├─casper-md5check.service
● ├─console-setup.service
● ├─containerd.service
● ├─cron.service
● ├─cups-browsed.service
...
```
Отображает дерево зависимостей для состояния multi-user.target

### 1.4: User Sessions

1. **Audit Login Activity**:
Ввод:
   ```sh
   who -a
   ```
Вывод:
```
           загрузка системы 2025-06-27 10:40
ВХОД   tty1         2025-06-27 10:40              1046 id=tty1
askoldmax + tty7         2025-06-27 10:40 01:14        2979 (:0)
           уровень выполнения 5 2025-06-27 10:41

```
Отображает дату и время загрузки системы (2025-06-27 10:40), пользователя и tty через который выполнен вход в графическую оболочку.
Ввод:
   ```sh
   last -n 5
   ```
Вывод:
```
askoldma tty7         :0               Fri Jun 27 10:40    gone - no logout
reboot   system boot  6.8.0-60-generic Fri Jun 27 10:40   still running
askoldma tty7         :0               Thu Jun 26 18:18 - 01:24  (07:06)
reboot   system boot  6.8.0-60-generic Thu Jun 26 18:18 - 01:24  (07:06)
askoldma tty7         :0               Thu Jun 26 16:24 - 17:52  (01:27)

wtmp begins Sat Apr  5 03:57:49 2025
```
Последние 5 записей о входе в систему + перезагрузки.

### 1.5: Memory Analysis

1. **Inspect Memory Allocation**:
Ввод:
   ```sh
   free -h
   ```
Вывод:
```
               total        used        free      shared  buff/cache   available
Память:       15Gi       5,9Gi       4,4Gi       697Mi       5,1Gi       8,5Gi
Подкачка:      2,0Gi          0B       2,0Gi

```
Вывод отображает использование оперативной памяти и подкачаи.
Столбцы: общий объем(total), сколько использовано(used), сколько свободно(free), разделяемая память для процессов(shared), используемая для буферов и кэша(buff/cache), доступная(available)

Ввод:
   ```sh
   cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
   ```
Вывод:
```
MemTotal:       16094320 kB
MemAvailable:    8723168 kB
SwapTotal:       2097148 kB
```
Отображет только общий объем, доступную память, swap

## Сетевой анализ

**Objective**: Perform network diagnostics including path tracing, DNS inspection, packet capture, and reverse lookups.

### 2.1: Network Path Tracing

1. **Traceroute Execution**:
Ввод:
   ```sh
   traceroute ya.ru
   ```
Вывод:
```
traceroute to ya.ru (5.255.255.242), 30 hops max, 60 byte packets
 1  _gateway (192.168.162.217)  8.858 ms  8.865 ms  9.031 ms
 2  * * *
 3  * * *
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  * * *
 9  * * *
10  178.176.152.161 (178.176.152.161)  106.147 ms  98.235 ms  106.231 ms
11  vla-32z7-ae4.yndx.net (93.158.172.35)  110.876 ms * *
12  * * vla1-e1-ae70.yndx.net (93.158.172.97)  84.634 ms
13  vla-32z8-ae2.yndx.net (93.158.172.39)  105.309 ms * vla-32z5-eth-trunk2.yndx.net (93.158.172.27)  100.815 ms
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * * *
24  * * *
25  * * *
26  * * *
27  * * *
28  * * *
29  * * *
30  * * *
```
Показывает маршрут до ya.ru с временем отклика на каждом этапе.

2. **DNS Resolution Check**:
Ввод:
   ```sh
   dig ya.ru
   ```
Вывод:
```
; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> ya.ru
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 52440
;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;ya.ru.				IN	A

;; ANSWER SECTION:
ya.ru.			85	IN	A	77.88.55.242
ya.ru.			85	IN	A	5.255.255.242
ya.ru.			85	IN	A	77.88.44.242

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Fri Jun 27 12:20:22 +07 2025
;; MSG SIZE  rcvd: 82

```
Запрос DNS-информации о домене ya.ru с целью получить записи типа A. Выводит ip адреса связанные с ya.ru.
### 2.2: Packet Capture

1. **Capture DNS Traffic**:
Ввод:
   ```sh
   sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
   ```
Вывод:
```
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
12:29:39.692645 lo    In  IP 127.0.0.1.56676 > 127.0.0.53.53: 47321+ [1au] Type65? duckduckgo.com. (43)
12:29:39.692682 lo    In  IP 127.0.0.1.50856 > 127.0.0.53.53: 56276+ [1au] Type65? ac.duckduckgo.com. (46)
12:29:39.692704 lo    In  IP 127.0.0.1.33634 > 127.0.0.53.53: 37496+ [1au] A? duckduckgo.com. (43)
12:29:39.692710 lo    In  IP 127.0.0.1.33634 > 127.0.0.53.53: 32122+ [1au] AAAA? duckduckgo.com. (43)
12:29:39.692820 wlp3s0 Out IP 192.168.162.152.37943 > 192.168.162.217.53: 3268+ Type65? duckduckgo.com. (32)
5 packets captured
27 packets received by filter
0 packets dropped by kernel
```
Захват 5 пакетов на всех интерфейсах в течении 10 секунд с фильтрацие по порту 53 (DNS)
### 2.3: Reverse DNS

1. **Perform PTR Lookups**:
Ввод:
   ```sh
   dig -x 8.8.4.4
   ```
Вывод:
```
; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 38254
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.		IN	PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.	6159	IN	PTR	dns.google.

;; Query time: 84 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Fri Jun 27 12:45:04 +07 2025
;; MSG SIZE  rcvd: 73

```
Получение PTR для 8.8.4.4, из вывода следует, что это dns.google
Ввод:
   ```sh
   dig -x 1.1.2.2
   ```
Вывод:
```
; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 47663
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.		IN	PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.		3600	IN	SOA	ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22229 7200 1800 604800 3600

;; Query time: 309 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Fri Jun 27 12:48:54 +07 2025
;; MSG SIZE  rcvd: 137

```
Из вывода следует, что обратной PTR-записи для 1.1.2.2 нет

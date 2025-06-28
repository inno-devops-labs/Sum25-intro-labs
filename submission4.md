# Lab 3 - Operating Systems & Networking Lab

## Task 1 - Operating Systems analysis

`systemd-analyze` выводит общее время последнего запуска системы: 
```
Startup finished in 19.010s (firmware) + 2.959s (loader) + 1.351s (kernel) + 39.723s (userspace) = 1min 3.044s 
graphical.target reached after 39.687s in userspace.
```

`systemd-analyze blame` выводит время каждого сервиса в отдельности:
```
4min 26.146s apt-daily-upgrade.service
3min 8.518s apt-daily.service
21.013s plymouth-quit-wait.service
13.940s fwupd-refresh.service
7.198s NetworkManager-wait-online.service
3.793s apparmor.service
2.500s snapd.apparmor.service
1.977s snapd.seeded.service
...
```

Через `uptime` и `w` видим аптайм устройства, пользователей
``` 
18:25:43 up 2 days,  7:09,  2 users,  load average: 2.17, 1.73, 2.95
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU  WHAT
alexey   tty2     -                12:01    2days  0.02s  0.02s /usr/libexec/gnome-session-binary --session=ubuntu
alexey            -                12:01    9:22   0.00s   ?    /usr/NX/bin/nxexec --node --user alexey --priority realtime --mode 0 --pid 49
```

`ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6` выводит процессы, их айди, название, занимаемую память и процессор. Можно сортировать по разным колонкам, передавая название в `sort`
```
    PID    PPID CMD                         %MEM %CPU
 136763  109708 /opt/yandex/browser/yandex_  4.9  1.5
 135761  110006 /snap/telegram-desktop/6691  4.3  1.1
 110006  109708 /usr/bin/gnome-shell         2.7 19.0
 188786  186255 /snap/code/195/usr/share/co  2.7  2.3
 191307  136787 /opt/yandex/browser/yandex_  2.7  8.4
```

`systemctl list-dependencies` позволяет вывести иерархию процессов, необходимых для запуска `systemd`
```
default.target
● ├─accounts-daemon.service
● ├─gdm.service
● ├─gnome-remote-desktop.service
● ├─power-profiles-daemon.service
● ├─switcheroo-control.service
○ ├─systemd-update-utmp-runlevel.service
● ├─udisks2.service
● └─multi-user.target
●   ├─AmneziaVPN.service
○   ├─anacron.service
●   ├─apport.service
...
```
`systemctl list-dependencies multi-user.target` делает то же самое, но для конкретного элемента

`who -а` дает посмотреть, кто сейчас авторизован на устройстве, а `last -n 5` выводит 5 последних входов
```
           загрузка системы 2025-06-25 11:16
alexey   ? seat0        2025-06-27 12:01   ?        109849 (login screen)
alexey   + tty2         2025-06-27 12:01  да�     109849 (tty2)
           уровень выполнения 5 2025-06-25 11:17
           pts/1        2025-06-25 11:24              7117 id=ts/1  терминал=0 выход=0
           pts/4        2025-06-27 18:18            187880 id=ts/4  терминал=0 выход=1
alexey   tty2         tty2             Fri Jun 27 12:01   still logged in
alexey   seat0        login screen     Fri Jun 27 12:01   still logged in
alexey   tty2         tty2             Wed Jun 25 11:16 - 22:03 (1+10:46)
alexey   seat0        login screen     Wed Jun 25 11:16 - 12:01 (2+00:44)
reboot   system boot  6.11.0-26-generi Wed Jun 25 11:16   still running

wtmp begins Sun Jan 26 20:29:20 2025
```

`free -h` показывает загрузку оперативной памяти
```
               total        used        free      shared  buff/cache   available
Память:         14Gi       6.5Gi       1.2Gi       249Mi       7.8Gi       8.4Gi
Подкачка:      4.0Gi       768Ki       4.0Gi
```

`cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable` тоже показывает загрузку памяти, но в целом под `cat` больше инфы 

## Task 2

`traceroute` позволяет исследовать путь пакета по сети до требуемого ресурса. После 8 узла пошли звездочки (выключил на 31ом), что означает отсутствие ответа от промежуточного хоста.
``` 
  1   10.8.0.1  68.627ms  70.267ms  69.887ms 
  2   10.2.0.1  70.286ms  71.092ms  67.833ms 
  3   185.8.178.2  69.835ms  69.986ms  69.788ms 
  4   185.8.179.35  69.899ms  80.053ms  69.721ms 
  5   185.1.222.21  69.800ms  72.577ms  67.167ms 
  6   *  *  * 
  7   94.103.180.24  78.316ms  170.366ms  209.798ms 
  8   45.153.82.39  89.491ms  89.878ms  90.297ms 
  9   *  *  * 
 10   *  *  * 
```
Так выглядит traceroute до адреса в локальной сети, отмечает только текущее устройство, с которого происходит запрос:
```
traceroute to 192.168.0.5 (192.168.0.5), 64 hops max
  1   192.168.0.245  3049.849ms !H  *  68.422ms !H 
```

`dig github.com` делает запрос к DNS-серверу и возвращает полученную информацию о домене: метаданные, айпи, время запроса и тд
```

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 29206
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             0       IN      A       140.82.121.3

;; Query time: 78 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Fri Jun 27 19:08:33 MSK 2025
;; MSG SIZE  rcvd: 55
```

`sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn` отлавливает первые 5 днс запросов или запросы за 10 секунд (смотря что наступит раньше), выводит о них информацию: время, порт, адреса и тд
```
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
19:13:25.286924 lo    In  IP 127.0.0.1.34291 > 127.0.0.53.53: 19168+ A? alive.github.com. (34)
19:13:25.287028 lo    In  IP 127.0.0.1.20297 > 127.0.0.53.53: 20949+ HTTPS? alive.github.com. (34)
19:13:25.287299 wg0   Out IP 10.8.0.122.44077 > 10.2.0.100.53: 59988+ [1au] A? alive.github.com. (45)
19:13:25.287374 tun0  Out IP 10.8.0.7.57077 > 10.186.0.11.53: 29753+ [1au] A? alive.github.com. (45)
19:13:25.287577 wg0   Out IP 10.8.0.122.40604 > 10.2.0.100.53: 22912+ [1au] HTTPS? alive.github.com. (45)
5 packets captured
8 packets received by filter
0 packets dropped by kernel
```

Команды типа `dig -x 8.8.4.4` делают обратный днс запрос, в ответ получаем, какое имя привязано к адресу. В данном случае это днс гугла. \
Для команды `dig -x 1.1.2.2` имеем отсутствие ответа (ANSWER: 0), что означает отсутствие привязанного к адресу имени. Но у нее есть секция Authority, которая говорит, кто отвечает за адрес.
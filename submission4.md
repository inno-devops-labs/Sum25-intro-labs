## Анализ операционной системы (WSL)
### 1.1 Boot Performance
```sh
systemd-analyze
```
Startup finished in 5.848s (userspace)
graphical.target reached after 5.808s in userspace
```sh
systemd-analyze blame
```
4min 37.200s apt-daily-upgrade.service
2min 8.386s motd-news.service
1min 14.716s apt-daily.service
4.144s snapd.seeded.service
3.260s snapd.service
2.791s landscape-client.service
1.207s e2scrub_all.service
958ms dev-sdd.device
763ms networkd-dispatcher.service
711ms logrotate.service
696ms man-db.service
550ms systemd-resolved.service
364ms systemd-timesyncd.service
...  
- Самые долгие сервисы: `apt-daily-upgrade.service` (4мин 37сек), `motd-news.service` (2мин 8сек), `apt-daily.service` (1мин 14сек)/ Это фоновые сервисы обновления системы, характерные для Ubuntu.
```sh
uptime
w
```
19:33:46 up 1:17, 1 user, load average: 0.00, 0.01, 0.00
19:33:52 up 1:17, 1 user, load average: 0.00, 0.01, 0.00
USER TTY FROM LOGIN@ IDLE JCPU PCPU WHAT
kotosham pts/1 - 18:19 1:14m 0.09s 0.07s -bash
- Система работает 1 час 17 минут с низкой нагрузкой и 1 активным пользователем.
- 1 активный пользователь (kotosham), подключенный через терминал с 18:19, время бездействия: 1 час 14 минут
### 1.2 Process Forensics
Топ процессов по памяти и cpu:
```sh
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
```
    PID    PPID CMD                         %MEM %CPU
    752       1 /usr/lib/snapd/snapd         0.9  0.1
    262       1 /usr/bin/python3 /usr/share  0.5  0.0
   3297       1 /usr/libexec/packagekitd     0.5  0.0
    217       1 /usr/bin/python3 /usr/bin/n  0.4  0.0
     65       1 /lib/systemd/systemd-journa  0.4  0.0
```sh
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
```
    PID    PPID CMD                         %MEM %CPU
      1       0 /sbin/init                   0.3  0.1
    104       1 snapfuse /var/lib/snapd/sna  0.2  0.1
    752       1 /usr/lib/snapd/snapd         0.9  0.1
      2       1 /init                        0.0  0.0
      8       2 plan9 --control-socket 7 --  0.0  0.0

- Самый ресурсоемкий процесс по памяти (0.9%) - snapd (менеджер пакетов Snap)
- Python-процессы используют 0.5% и 0.4% памяти
- Процесс init (PID 1) использует 0.1% CPU
- Процессы, связанные с snap, используют по 0.1% CPU
- Наиболее CPU-интенсивные процессы: `/sbin/init`, `snapfuse` и `snapd`
### 1.3 Service Dependencies
```sh
systemctl list-dependencies
```
default.target
● ├─apport.service
○ ├─display-manager.service
○ ├─systemd-update-utmp-runlevel.service
○ ├─wslg.service
● └─multi-user.target
●   ├─apport.service
●   ├─...
●   └─remote-fs.target

- Иерархическая структура сервисов

```sh
systemctl list-dependencies multi-user.target
```
multi-user.target
● ├─apport.service
● ├─avahi-daemon.service
● ├─console-setup.service
● ├─cron.service
● ├─dbus.service
○ ├─dmesg.service
○ ├─e2scrub_reap.service
○ ├─irqbalance.service
○ ├─landscape-client.service
○ ├─ModemManager.service
● ├─networkd-dispatcher.service
● ├─plymouth-quit-wait.service
● ├─plymouth-quit.service
● ├─rsyslog.service
● ├─snap-core20-2571.mount
● ├─snap-core20-2599.mount
● ├─snap-snapd-24505.mount
● ├─snap-snapd-24718.mount
○ ├─snapd.apparmor.service
○ ├─snapd.autoimport.service
○ ├─snapd.core-fixup.service
○ ├─snapd.recovery-chooser-trigger.service
● ├─snapd.seeded.service
● ├─snapd.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
● ├─systemd-resolved.service
○ ├─systemd-update-utmp-runlevel.service
● ├─systemd-user-sessions.service
○ ├─ua-reboot-cmds.service
○ ├─ubuntu-advantage.service
● ├─ufw.service
● ├─unattended-upgrades.service
● ├─wpa_supplicant.service
● ├─basic.target
○ │ ├─...
● │ └─...
● ├─getty.target
● └─remote-fs.target
- Ключевые сервисы для многопользовательского режима:
  - `systemd-logind.service` - управление сессиями
  - `systemd-resolved.service` - DNS-резолвинг
  - `dbus.service` - системная шина сообщений
  - `networkd-dispatcher.service` - управление сетью
  - `getty.target` - консольные входы
### 1.4 User Sessions
Активные сессии
```sh
who -a
```
           system boot  2025-06-27 18:19
           run-level 5  2025-06-27 18:19
LOGIN      console      2025-06-27 18:19               260 id=cons
LOGIN      tty1         2025-06-27 18:19               263 id=tty1
kotosham - pts/1        2025-06-27 18:19 01:16         539
```sh
last -n 5
```
kotosham pts/1                         Fri Jun 27 18:19   still logged in
reboot   system boot  6.6.87.2-microso Fri Jun 27 18:19   still running
kotosham pts/1                         Fri May 23 12:26 - crash (35+05:52)
reboot   system boot  5.15.167.4-micro Fri May 23 12:26   still running
kotosham pts/1                         Wed May 21 02:03 - crash (2+10:23)

wtmp begins Fri Mar 21 19:21:10 2025
- Текущая сессия активна с последней перезагрузки
- Предыдущие сессии завершались аварийно, потому что в wsl это происходит при закрытии терминала
```sh
free -h
```
               total        used        free      shared  buff/cache   available
Mem:           3.8Gi       351Mi       3.2Gi       4.0Mi       228Mi       3.3Gi
Swap:          1.0Gi          0B       1.0Gi
```sh
cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
```
MemTotal:        3966192 kB
MemAvailable:    3426684 kB
SwapTotal:       1048576 kB
- Физическая память ~ 3.78 GB
- Доступная память ~ 3.27 GB
- Общий swap ~ 1 GB
### Выводы
1. Система работает с минимальной нагрузкой (CPU <0.3%, RAM <10%)
2. Дольше всего загружаются сервисы обновления (apt-daily, motd-news)
3. Нет подозрительных процессов или несанкционированных сессий
4. Особенности WSL:
   - Отсутствует фаза загрузки ядра;
   - Случаются аварийные сессии в WSL при закрытии терминала.
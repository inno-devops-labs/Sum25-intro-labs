# Операционные системы и сети

## Задача 1: Анализ операционной системы

### 1.1 Производительность загрузки
```
user@user-VirtualBox:~$ systemd-analyze
Startup finished in 2.629s (kernel) + 23.425s (userspace) = 26.055s 
graphical.target reached after 23.415s in userspace
```
- Общее время загрузки системы

```
user@user-VirtualBox:~$ systemd-analyze blame
21.850s plymouth-quit-wait.service           ---- slowless
 2.144s docker.service                       ---- slowl
 2.011s snapd.seeded.service                 ---- slowl
 1.927s snapd.service                        ---- slowl
 1.486s vboxadd.service                      ---- slowl
```
- Топ 5 по медленных служб.

```
user@user-VirtualBox:~$ uptime
 23:14:11 up  2:53,  1 user,  load average: 0,03, 0,03, 0,00
```
- время работы системы и среднюю нагрузку

```
user@user-VirtualBox:~$ w          
 23:15:39 up  2:55,  1 user,  load average: 0,00, 0,02, 0,00
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
user     tty2     tty2             20:20    2:55m  0.06s  0.06s /usr/libexec/gnome-session-binary --session=ubuntu

```
- кто в системе и что загруженно 

### 1.2 Анализ процессов
```
user@user-VirtualBox:~$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    PID    PPID CMD                         %MEM %CPU
   1664    1229 /usr/bin/gnome-shell         7.2  1.3
   2203    1229 /usr/libexec/gsd-xsettings   1.3  0.0
    913       1 /usr/bin/dockerd -H fd:// -  1.2  0.1
   1978    1601 /usr/libexec/evolution-data  1.1  0.0
   2071    1664 /usr/bin/Xwayland :0 -rootl  1.1  0.0
```
- 6 процессов самое большее потребляет память. 


```
user@user-VirtualBox:~$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    PID    PPID CMD                         %MEM %CPU
   1664    1229 /usr/bin/gnome-shell         7.2  1.3
    750       1 /usr/bin/containerd          0.7  0.7
    438       1 /lib/systemd/systemd-oomd    0.1  0.4
   1150       1 /usr/bin/VBoxDRMClient       0.0  0.4
   4615       2 [kworker/0:1-mm_percpu_wq]   0.0  0.2

```
- 6 процессов по загрузке ЦПУ по убыванию.


### 1.3 Зависимости служб

```
user@user-VirtualBox:~$ systemctl list-dependencies
default.target
● ├─accounts-daemon.service
● ├─apport.service
● ├─gdm.service
● ├─power-profiles-daemon.service
● ├─switcheroo-control.service
○ ├─systemd-update-utmp-runlevel.service
● ├─udisks2.service
● └─multi-user.target
○   ├─anacron.service
●   ├─apport.service
●   ├─avahi-daemon.service
●   ├─console-setup.service
●   ├─containerd.service
●   ├─cron.service
●   ├─cups-browsed.service
●   ├─cups.path
●   ├─cups.service
●   ├─dbus.service
○   ├─dmesg.service
●   ├─docker.service
○   ├─e2scrub_reap.service
○   ├─grub-common.service
○   ├─grub-initrd-fallback.service
●   ├─irqbalance.service
●   ├─kerneloops.service
●   ├─ModemManager.service
●   ├─networkd-dispatcher.service
●   ├─NetworkManager.service
●   ├─nmbd.service
○   ├─open-vm-tools.service
●   ├─openvpn.service
●   ├─plymouth-quit-wait.service
○   ├─plymouth-quit.service
●   ├─rsyslog.service
○   ├─run-vmblock\x2dfuse.mount
○   ├─secureboot-db.service
●   ├─smbd.service
●   ├─snap-bare-5.mount
●   ├─snap-core22-1612.mount
●   ├─snap-core22-2010.mount
●   ├─snap-firefox-4848.mount
●   ├─snap-firefox-6316.mount
●   ├─snap-gnome\x2d42\x2d2204-176.mount
●   ├─snap-gnome\x2d42\x2d2204-202.mount
●   ├─snap-gtk\x2dcommon\x2dthemes-1535.mount
●   ├─snap-snap\x2dstore-1113.mount
●   ├─snap-snapd-21759.mount
●   ├─snap-snapd-24718.mount
●   ├─snap-snapd\x2ddesktop\x2dintegration-178.mount
●   ├─snap-snapd\x2ddesktop\x2dintegration-253.mount
●   ├─snapd.apparmor.service
○   ├─snapd.autoimport.service
○   ├─snapd.core-fixup.service
○   ├─snapd.recovery-chooser-trigger.service
●   ├─snapd.seeded.service
●   ├─snapd.service
●   ├─systemd-ask-password-wall.path
●   ├─systemd-logind.service
●   ├─systemd-oomd.service
●   ├─systemd-resolved.service
○   ├─systemd-update-utmp-runlevel.service
●   ├─systemd-user-sessions.service
○   ├─thermald.service
○   ├─ua-reboot-cmds.service
○   ├─ubuntu-advantage.service
●   ├─ufw.service
●   ├─unattended-upgrades.service
●   ├─vboxadd-service.service
●   ├─vboxadd.service
●   ├─whoopsie.path
●   ├─wpa_supplicant.service
●   ├─basic.target
●   │ ├─-.mount
○   │ ├─tmp.mount
●   │ ├─paths.target
●   │ │ ├─acpid.path
○   │ │ └─apport-autoreport.path
●   │ ├─slices.target
●   │ │ ├─-.slice
●   │ │ └─system.slice
●   │ ├─sockets.target
●   │ │ ├─acpid.socket
○   │ │ ├─apport-forward.socket
●   │ │ ├─avahi-daemon.socket
●   │ │ ├─cups.socket
●   │ │ ├─dbus.socket
●   │ │ ├─docker.socket
●   │ │ ├─snapd.socket
●   │ │ ├─systemd-initctl.socket
●   │ │ ├─systemd-journald-audit.socket
●   │ │ ├─systemd-journald-dev-log.socket
●   │ │ ├─systemd-journald.socket
●   │ │ ├─systemd-udevd-control.socket
●   │ │ ├─systemd-udevd-kernel.socket
●   │ │ └─uuidd.socket
●   │ ├─sysinit.target
●   │ │ ├─apparmor.service
●   │ │ ├─dev-hugepages.mount
●   │ │ ├─dev-mqueue.mount
●   │ │ ├─keyboard-setup.service
●   │ │ ├─kmod-static-nodes.service
●   │ │ ├─plymouth-read-write.service
●   │ │ ├─plymouth-start.service
●   │ │ ├─proc-sys-fs-binfmt_misc.automount
●   │ │ ├─setvtrgb.service
●   │ │ ├─sys-fs-fuse-connections.mount
●   │ │ ├─sys-kernel-config.mount
●   │ │ ├─sys-kernel-debug.mount
●   │ │ ├─sys-kernel-tracing.mount
○   │ │ ├─systemd-ask-password-console.path
●   │ │ ├─systemd-binfmt.service
○   │ │ ├─systemd-boot-system-token.service
●   │ │ ├─systemd-journal-flush.service
●   │ │ ├─systemd-journald.service
○   │ │ ├─systemd-machine-id-commit.service
●   │ │ ├─systemd-modules-load.service
○   │ │ ├─systemd-pstore.service
●   │ │ ├─systemd-random-seed.service
●   │ │ ├─systemd-sysctl.service
●   │ │ ├─systemd-sysusers.service
●   │ │ ├─systemd-timesyncd.service
●   │ │ ├─systemd-tmpfiles-setup-dev.service
●   │ │ ├─systemd-tmpfiles-setup.service
●   │ │ ├─systemd-udev-trigger.service
●   │ │ ├─systemd-udevd.service
●   │ │ ├─systemd-update-utmp.service
●   │ │ ├─cryptsetup.target
●   │ │ ├─local-fs.target
●   │ │ │ ├─-.mount
●   │ │ │ ├─boot-efi.mount
○   │ │ │ ├─systemd-fsck-root.service
●   │ │ │ └─systemd-remount-fs.service
●   │ │ ├─swap.target
●   │ │ │ └─swapfile.swap
●   │ │ └─veritysetup.target
●   │ └─timers.target
●   │   ├─anacron.timer
○   │   ├─apport-autoreport.timer
●   │   ├─apt-daily-upgrade.timer
●   │   ├─apt-daily.timer
●   │   ├─dpkg-db-backup.timer
●   │   ├─e2scrub_all.timer
●   │   ├─fstrim.timer
●   │   ├─fwupd-refresh.timer
●   │   ├─logrotate.timer
●   │   ├─man-db.timer
●   │   ├─motd-news.timer
○   │   ├─snapd.snap-repair.timer
●   │   ├─systemd-tmpfiles-clean.timer
○   │   ├─ua-timer.timer
●   │   ├─update-notifier-download.timer
●   │   └─update-notifier-motd.timer
●   ├─getty.target
○   │ ├─getty-static.service
○   │ └─getty@tty1.service
●   └─remote-fs.target
```
-  дерево зависимостей всех служб

```
user@user-VirtualBox:~$ systemctl list-dependencies multi-user.target
multi-user.target
○ ├─anacron.service
● ├─apport.service
● ├─avahi-daemon.service
● ├─console-setup.service
● ├─containerd.service
● ├─cron.service
● ├─cups-browsed.service
● ├─cups.path
● ├─cups.service
● ├─dbus.service
○ ├─dmesg.service
● ├─docker.service
○ ├─e2scrub_reap.service
○ ├─grub-common.service
○ ├─grub-initrd-fallback.service
● ├─irqbalance.service
● ├─kerneloops.service
● ├─ModemManager.service
● ├─networkd-dispatcher.service
● ├─NetworkManager.service
● ├─nmbd.service
○ ├─open-vm-tools.service
● ├─openvpn.service
● ├─plymouth-quit-wait.service
○ ├─plymouth-quit.service
● ├─rsyslog.service
○ ├─run-vmblock\x2dfuse.mount
○ ├─secureboot-db.service
● ├─smbd.service
● ├─snap-bare-5.mount
● ├─snap-core22-1612.mount
● ├─snap-core22-2010.mount
● ├─snap-firefox-4848.mount
● ├─snap-firefox-6316.mount
● ├─snap-gnome\x2d42\x2d2204-176.mount
● ├─snap-gnome\x2d42\x2d2204-202.mount
● ├─snap-gtk\x2dcommon\x2dthemes-1535.mount
● ├─snap-snap\x2dstore-1113.mount
● ├─snap-snapd-21759.mount
● ├─snap-snapd-24718.mount
● ├─snap-snapd\x2ddesktop\x2dintegration-178.mount
● ├─snap-snapd\x2ddesktop\x2dintegration-253.mount
● ├─snapd.apparmor.service
○ ├─snapd.autoimport.service
○ ├─snapd.core-fixup.service
○ ├─snapd.recovery-chooser-trigger.service
● ├─snapd.seeded.service
● ├─snapd.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
● ├─systemd-oomd.service
● ├─systemd-resolved.service
○ ├─systemd-update-utmp-runlevel.service
● ├─systemd-user-sessions.service
○ ├─thermald.service
○ ├─ua-reboot-cmds.service
○ ├─ubuntu-advantage.service
● ├─ufw.service
● ├─unattended-upgrades.service
● ├─vboxadd-service.service
● ├─vboxadd.service
● ├─whoopsie.path
● ├─wpa_supplicant.service
● ├─basic.target
● │ ├─-.mount
○ │ ├─tmp.mount
● │ ├─paths.target
● │ │ ├─acpid.path
○ │ │ └─apport-autoreport.path
● │ ├─slices.target
● │ │ ├─-.slice
● │ │ └─system.slice
● │ ├─sockets.target
● │ │ ├─acpid.socket
○ │ │ ├─apport-forward.socket
● │ │ ├─avahi-daemon.socket
● │ │ ├─cups.socket
● │ │ ├─dbus.socket
● │ │ ├─docker.socket
● │ │ ├─snapd.socket
● │ │ ├─systemd-initctl.socket
● │ │ ├─systemd-journald-audit.socket
● │ │ ├─systemd-journald-dev-log.socket
● │ │ ├─systemd-journald.socket
● │ │ ├─systemd-udevd-control.socket
● │ │ ├─systemd-udevd-kernel.socket
● │ │ └─uuidd.socket
● │ ├─sysinit.target
● │ │ ├─apparmor.service
● │ │ ├─dev-hugepages.mount
● │ │ ├─dev-mqueue.mount
● │ │ ├─keyboard-setup.service
● │ │ ├─kmod-static-nodes.service
● │ │ ├─plymouth-read-write.service
● │ │ ├─plymouth-start.service
● │ │ ├─proc-sys-fs-binfmt_misc.automount
● │ │ ├─setvtrgb.service
● │ │ ├─sys-fs-fuse-connections.mount
● │ │ ├─sys-kernel-config.mount
● │ │ ├─sys-kernel-debug.mount
● │ │ ├─sys-kernel-tracing.mount
○ │ │ ├─systemd-ask-password-console.path
● │ │ ├─systemd-binfmt.service
○ │ │ ├─systemd-boot-system-token.service
● │ │ ├─systemd-journal-flush.service
● │ │ ├─systemd-journald.service
○ │ │ ├─systemd-machine-id-commit.service
● │ │ ├─systemd-modules-load.service
○ │ │ ├─systemd-pstore.service
● │ │ ├─systemd-random-seed.service
● │ │ ├─systemd-sysctl.service
● │ │ ├─systemd-sysusers.service
● │ │ ├─systemd-timesyncd.service
● │ │ ├─systemd-tmpfiles-setup-dev.service
● │ │ ├─systemd-tmpfiles-setup.service
● │ │ ├─systemd-udev-trigger.service
● │ │ ├─systemd-udevd.service
● │ │ ├─systemd-update-utmp.service
● │ │ ├─cryptsetup.target
● │ │ ├─local-fs.target
● │ │ │ ├─-.mount
● │ │ │ ├─boot-efi.mount
○ │ │ │ ├─systemd-fsck-root.service
● │ │ │ └─systemd-remount-fs.service
● │ │ ├─swap.target
● │ │ │ └─swapfile.swap
● │ │ └─veritysetup.target
● │ └─timers.target
● │   ├─anacron.timer
○ │   ├─apport-autoreport.timer
● │   ├─apt-daily-upgrade.timer
● │   ├─apt-daily.timer
● │   ├─dpkg-db-backup.timer
● │   ├─e2scrub_all.timer
● │   ├─fstrim.timer
● │   ├─fwupd-refresh.timer
● │   ├─logrotate.timer
● │   ├─man-db.timer
● │   ├─motd-news.timer
○ │   ├─snapd.snap-repair.timer
● │   ├─systemd-tmpfiles-clean.timer
○ │   ├─ua-timer.timer
● │   ├─update-notifier-download.timer
● │   └─update-notifier-motd.timer
● ├─getty.target
○ │ ├─getty-static.service
○ │ └─getty@tty1.service
● └─remote-fs.target
```
- службы, необходимые для multi-user режима


### 1.4 Пользовательские сессии
```
user@user-VirtualBox:~$ who -a
           system boot  2025-06-25 20:20
user     + tty2         2025-06-25 20:20  old         1331 (tty2)
           run-level 5  2025-06-25 20:21
```
- Показывает всех текущих пользователей и их статус

```
user     tty2         tty2             Wed Jun 25 20:20   still logged in
reboot   system boot  6.8.0-60-generic Wed Jun 25 20:20   still running
user     tty2         tty2             Mon Jun 23 19:13 - down   (04:49)
reboot   system boot  6.8.0-60-generic Mon Jun 23 19:13 - 00:03  (04:49)
user     tty2         tty2             Wed Jun 18 19:57 - down  (1+22:02)

wtmp begins Wed Jun 18 19:19:10 2025
```
- Показывает последние 5 входов в систему

### 1.5 Анализ памяти

```
user@user-VirtualBox:~$ free -h
               total        used        free      shared  buff/cache   available
Mem:           5,7Gi       967Mi       3,1Gi        38Mi       1,6Gi       4,5Gi
Swap:          2,0Gi          0B       2,0Gi
```

- использование RAM и swap в читаемом формате

```
user@user-VirtualBox:~$ cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
MemTotal:        6003504 kB
MemAvailable:    4724688 kB
SwapTotal:       2097148 kB
```

- показывает конкретные параметры памяти

## Задача 2: Анализ сети

### 2.1 Трассировка маршрутов

```
user@user-VirtualBox:~$ traceroute github.com
traceroute to github.com (140.82.121.4), 30 hops max, 60 byte packets
 1  _gateway (192.168.110.1)  1.577 ms  3.597 ms  3.443 ms
 2  192.168.100.1 (192.168.100.1)  3.405 ms  3.372 ms  3.335 ms
 3  95.55.xxx.xxx (95.55.xxx.xxx)  6.362 ms  6.325 ms  6.286 ms
 4  bbn.212-48-204-150.nwtelecom.ru (212.48.204.150)  7.442 ms  7.410 ms  7.300 ms
 5  185.140.148.31 (185.140.148.31)  11.196 ms  10.979 ms 185.140.148.19 (185.140.148.19)  10.930 ms
 6  * * *
 7  217.161.68.33 (217.161.68.33)  52.408 ms  54.891 ms  53.214 ms
 8  telia-gw.fnt.cw.net (195.2.22.238)  45.483 ms  46.934 ms  45.377 ms
 9  github-ic-350972.ip.twelve99-cust.net (62.115.182.171)  49.742 ms  49.689 ms  49.639 ms
10  * * *
11  * * *
12  * * *
13  * * *
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
- все промежуточные узлы до github.com
- 1,2 моя локалка
- 3 выход в сеть 
- на 9 вход в инфру гитхаба
- дальше возможно болкировки traceroute

```
user@user-VirtualBox:~$ dig github.com

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 10460
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;github.com.			IN	A

;; ANSWER SECTION:
github.com.		15	IN	A	140.82.121.4

;; Query time: 8 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Wed Jun 25 23:50:38 MSK 2025
;; MSG SIZE  rcvd: 55

```
- DNS-записи для github.com


### 2.2 Захват пакетов

```
user@user-VirtualBox:~$ sudo timeout 15 tcpdump -c 5 -i any 'port 53' -nn
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
23:59:47.140287 lo    In  IP 127.0.0.1.38096 > 127.0.0.53.53: 42314+ [1au] A? github.com. (51)
23:59:47.140396 enp0s3 Out IP 192.168.110.157.48791 > 192.168.110.1.53: 62490+ A? github.com. (28)
23:59:47.148432 enp0s3 In  IP 192.168.110.1.53 > 192.168.110.157.48791: 62490 1/0/0 A 140.82.121.3 (44)
23:59:47.148983 lo    In  IP 127.0.0.53.53 > 127.0.0.1.38096: 42314 1/0/1 A 140.82.121.3 (55)

4 packets captured
6 packets received by filter
0 packets dropped by kernel

```
- Запрос A-записи (IPv4) для github.com

### 2.3 Обратный DNS
```
user@user-VirtualBox:~$ dig -x 8.8.4.4

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 18495
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.		IN	PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.	3607	IN	PTR	dns.google.

;; Query time: 7 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Thu Jun 26 00:05:23 MSK 2025
;; MSG SIZE  rcvd: 73
```

- IP-адрес 8.8.4.4 корректно зарегистрирован с обратной PTR-записью dns.google.


```
user@user-VirtualBox:~$ dig -x 1.1.2.2

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 51922
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.		IN	PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.		3600	IN	SOA	ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22226 7200 1800 604800 3600

;; Query time: 50 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Thu Jun 26 00:06:02 MSK 2025
;; MSG SIZE  rcvd: 137

```
-  для IP 1.1.2.2 не зарегистрировано обратное имя (NXDOMAIN)

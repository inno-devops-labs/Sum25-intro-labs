# Lab Assignment 4: Operating System and Network Analysis

## Task 1: Operating System Analysis

### 1.1 Boot Performance

┌──(kali㉿kali)-[~]
└─$ systemd-analyze                                
Startup finished in 6.067s (kernel) + 3.899s (userspace) = 9.966s 
graphical.target reached after 3.810s in userspace.
                                                                                                                                                                          
┌──(kali㉿kali)-[~]
└─$ systemd-analyze blame
750ms ufw.service
593ms phpsessionclean.service
496ms dev-sda1.device
442ms e2scrub_reap.service
435ms networking.service
418ms virtualbox-guest-utils.service
413ms run-rpc_pipefs.mount
340ms upower.service
338ms NetworkManager-wait-online.service
330ms systemd-logind.service
330ms dpkg-db-backup.service
315ms udisks2.service
307ms accounts-daemon.service
275ms ModemManager.service
272ms polkit.service
239ms NetworkManager.service
143ms systemd-udevd.service
140ms dbus.service
116ms user@1000.service
110ms systemd-journal-flush.service
 97ms colord.service
 92ms plymouth-start.service
 67ms lightdm.service
 61ms systemd-journald.service
 60ms systemd-udev-trigger.service
 54ms systemd-hostnamed.service
 53ms systemd-tmpfiles-setup-dev-early.service
 50ms plymouth-quit-wait.service
 43ms dev-disk-by\x2duuid-0bbff29a\x2d6dd3\x2d4db5\x2da3d4\x2d20ff54db6223.swap
 41ms systemd-tmpfiles-setup.service
 39ms user-runtime-dir@1000.service
 37ms systemd-remount-fs.service
 34ms rtkit-daemon.service
 33ms dev-hugepages.mount
 33ms dev-mqueue.mount
 33ms run-lock.mount
 31ms systemd-udev-load-credentials.service
 30ms NetworkManager-dispatcher.service
 29ms sys-kernel-debug.mount
 28ms systemd-binfmt.service
 28ms systemd-random-seed.service
 28ms sys-kernel-tracing.mount
 28ms systemd-modules-load.service
 27ms systemd-sysctl.service
 26ms keyboard-setup.service
 26ms kmod-static-nodes.service
 24ms e2scrub_all.service
 21ms rpc-statd-notify.service
 20ms modprobe@configfs.service
 20ms modprobe@drm.service
 20ms modprobe@efi_pstore.service
 19ms plymouth-read-write.service
 19ms console-setup.service
 19ms tmp.mount
 18ms systemd-tmpfiles-setup-dev.service
 17ms modprobe@fuse.service
 16ms ifupdown-pre.service
 15ms proc-sys-fs-binfmt_misc.mount
 11ms sys-fs-fuse-connections.mount
  9ms systemd-user-sessions.service
  6ms sys-kernel-config.mount


### 2. Check System Load:
┌──(kali㉿kali)-[~]
└─$ uptime 
 13:38:21 up 5 min,  2 users,  load average: 0.01, 0.04, 0.01
                                                                                                                                                                          
┌──(kali㉿kali)-[~]
└─$ w        
 13:38:23 up 5 min,  2 users,  load average: 0.01, 0.04, 0.01
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
kali              -                13:33    5:27   0.00s  0.04s lightdm --session-child 13 24
kali  

### 1.2: Process Forensics
### 1. Identify Resource-Intensive Processes:
┌──(kali㉿kali)-[~]
└─$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    PID    PPID CMD                         %MEM %CPU
    834     823 /usr/lib/xorg/Xorg :0 -seat  1.9  0.8
   1487       1 /usr/bin/qterminal           1.2  0.2
   1159    1014 xfwm4                        1.1  0.2
   1207    1014 xfdesktop                    1.0  0.1
   1215    1196 /usr/lib/x86_64-linux-gnu/x  0.7  0.1
                                                                                                                                                                          
┌──(kali㉿kali)-[~]
└─$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    PID    PPID CMD                         %MEM %CPU
    834     823 /usr/lib/xorg/Xorg :0 -seat  1.9  0.8
   1487       1 /usr/bin/qterminal           1.2  0.2
   1159    1014 xfwm4                        1.1  0.2
   1100    1099 /usr/bin/VBoxClient --draga  0.0  0.1
      1       0 /sbin/init splash            0.1  0.1

### 1.3: Service Dependencies
### 1. Map Service Relationships:
┌──(kali㉿kali)-[~]
└─$ systemctl list-dependencies
systemctl list-dependencies multi-user.target
default.target
● ├─accounts-daemon.service
● ├─lightdm.service
● └─multi-user.target
●   ├─console-setup.service
●   ├─cron.service
●   ├─dbus.service
○   ├─e2scrub_reap.service
●   ├─ModemManager.service
●   ├─networking.service
●   ├─NetworkManager.service
●   ├─plymouth-quit-wait.service
○   ├─plymouth-quit.service
○   ├─regenerate-ssh-host-keys.service
○   ├─smartmontools.service
●   ├─systemd-ask-password-wall.path
●   ├─systemd-logind.service
●   ├─systemd-user-sessions.service
●   ├─ufw.service
●   ├─virtualbox-guest-utils.service
●   ├─basic.target
●   │ ├─-.mount
●   │ ├─tmp.mount
●   │ ├─paths.target
●   │ ├─slices.target
●   │ │ ├─-.slice
●   │ │ └─system.slice
●   │ ├─sockets.target
●   │ │ ├─dbus.socket
●   │ │ ├─pcscd.socket
●   │ │ ├─sshd-unix-local.socket
●   │ │ ├─sshd-vsock.socket
●   │ │ ├─systemd-creds.socket
●   │ │ ├─systemd-hostnamed.socket
●   │ │ ├─systemd-initctl.socket
●   │ │ ├─systemd-journald-dev-log.socket
●   │ │ ├─systemd-journald.socket
○   │ │ ├─systemd-pcrextend.socket
○   │ │ ├─systemd-pcrlock.socket
●   │ │ ├─systemd-sysext.socket
●   │ │ ├─systemd-udevd-control.socket
●   │ │ └─systemd-udevd-kernel.socket
●   │ ├─sysinit.target
●   │ │ ├─dev-hugepages.mount
●   │ │ ├─dev-mqueue.mount
●   │ │ ├─haveged.service
●   │ │ ├─keyboard-setup.service
●   │ │ ├─kmod-static-nodes.service
○   │ │ ├─ldconfig.service
●   │ │ ├─plymouth-read-write.service
●   │ │ ├─plymouth-start.service
●   │ │ ├─proc-sys-fs-binfmt_misc.automount
●   │ │ ├─sys-fs-fuse-connections.mount
●   │ │ ├─sys-kernel-config.mount
●   │ │ ├─sys-kernel-debug.mount
●   │ │ ├─sys-kernel-tracing.mount
○   │ │ ├─systemd-ask-password-console.path
●   │ │ ├─systemd-binfmt.service
○   │ │ ├─systemd-firstboot.service
○   │ │ ├─systemd-hibernate-clear.service
○   │ │ ├─systemd-hwdb-update.service
○   │ │ ├─systemd-journal-catalog-update.service
●   │ │ ├─systemd-journal-flush.service
●   │ │ ├─systemd-journald.service
○   │ │ ├─systemd-machine-id-commit.service
●   │ │ ├─systemd-modules-load.service
○   │ │ ├─systemd-pcrmachine.service
○   │ │ ├─systemd-pcrphase-sysinit.service
○   │ │ ├─systemd-pcrphase.service
○   │ │ ├─systemd-pstore.service
●   │ │ ├─systemd-random-seed.service
●   │ │ ├─systemd-sysctl.service
○   │ │ ├─systemd-sysusers.service
○   │ │ ├─systemd-timesyncd.service
●   │ │ ├─systemd-tmpfiles-setup-dev-early.service
●   │ │ ├─systemd-tmpfiles-setup-dev.service
●   │ │ ├─systemd-tmpfiles-setup.service
○   │ │ ├─systemd-tpm2-setup-early.service
○   │ │ ├─systemd-tpm2-setup.service
●   │ │ ├─systemd-udev-trigger.service
●   │ │ ├─systemd-udevd.service
○   │ │ ├─systemd-update-done.service
●   │ │ ├─local-fs.target
●   │ │ │ ├─-.mount
●   │ │ │ ├─run-lock.mount
○   │ │ │ ├─systemd-fsck-root.service
●   │ │ │ ├─systemd-remount-fs.service
●   │ │ │ └─tmp.mount
●   │ │ └─swap.target
●   │ │   └─dev-disk-by\x2duuid-0bbff29a\x2d6dd3\x2d4db5\x2da3d4\x2d20ff54db6223.swap
●   │ └─timers.target
●   │   ├─apt-daily-upgrade.timer
●   │   ├─apt-daily.timer
●   │   ├─dpkg-db-backup.timer
●   │   ├─e2scrub_all.timer
●   │   ├─fstrim.timer
●   │   ├─logrotate.timer
●   │   ├─man-db.timer
●   │   ├─phpsessionclean.timer
●   │   ├─plocate-updatedb.timer
●   │   └─systemd-tmpfiles-clean.timer
●   ├─getty.target
○   │ ├─getty-static.service
●   │ └─getty@tty1.service
●   ├─nfs-client.target
○   │ ├─auth-rpcgss-module.service
●   │ ├─rpc-statd-notify.service
●   │ └─remote-fs-pre.target
●   ├─remote-fs.target
●   │ └─nfs-client.target
○   │   ├─auth-rpcgss-module.service
●   │   ├─rpc-statd-notify.service
●   │   └─remote-fs-pre.target
●   └─stunnel.target

### 1.4: User Sessions
### 1.Audit Login Activity:
┌──(kali㉿kali)-[~]
└─$ who -a

           system boot  2025-06-25 13:32
┌──(kali㉿kali)-[~]
└─$ last -n 5

Jun 25 13:32:54 kali systemd-logind[548]: New session c1 of user lightdm.
Jun 25 13:32:54 kali systemd-logind[548]: New session 1 of user lightdm.
Jun 25 13:33:02 kali systemd-logind[548]: New session 2 of user kali.
Jun 25 13:33:02 kali systemd-logind[548]: New session 3 of user kali.


### 1.5: Memory Analysis
### 1. Inspect Memory Allocation:
┌──(kali㉿kali)-[~]
└─$ free -h
cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
               total        used        free      shared  buff/cache   available
Mem:           8.0Gi       857Mi       6.5Gi       7.9Mi       962Mi       7.2Gi
Swap:          5.1Gi          0B       5.1Gi
MemTotal:        8406812 kB
MemAvailable:    7529068 kB
SwapTotal:       5353468 kB

### Summary of Resource Patterns

1. CPU/Memory: GUI processes (Xorg, xfwm4) are primary consumers.
2. Boot: Security/storage services cause delays.
3. Sessions: Quick login after boot.
4. Memory: Healthy allocation with no bottlenecks.

### 2.1: Трассировка сетевого пути
### 1. Выполнение трассировки :

──(kali㉿kali)-[~]
└─$ traceroute github.com
traceroute to github.com (140.82.121.xxx), 30 hops max, 60 byte packets
 1  Eltex.Home (192.168.1.xxx)  0.858 ms  0.594 ms  0.549 ms
 2  * * *
 3  * * *
...
### The traceroute doesn’t go beyond the first hop, but DNS is working.

 ### 2. Проверка разрешения DNS :
┌──(kali㉿kali)-[~]
└─$ dig github.com
;; communications error to 127.0.0.xxx#53: connection refused
;; communications error to 127.0.0.xxx#53: connection refused
;; communications error to 127.0.0.xxx#53: connection refused

; <<>> DiG 9.20.3-1-Debian <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 31439
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             60      IN      A       140.82.121.4

;; Query time: 8 msec
;; SERVER: 192.168.0.1#53(192.168.0.xxx) (UDP)
;; WHEN: Wed Jun 25 14:19:13 MSK 2025
;; MSG SIZE  rcvd: 44

### 2.2 Захват пакетов
### 1. Захват трафика DNS :

┌──(kali㉿kali)-[~]
└─$ sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
[sudo] password for kali: 
tcpdump: WARNING: any: That device doesn't support promiscuous mode
(Promiscuous mode not supported on the "any" device)
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes

0 packets captured
0 packets received by filter
0 packets dropped by kernel


### 2.3: Обратный DNS
### 1. Выполнение поиска PTR :

┌──(kali㉿kali)-[~]
└─$ dig -x 8.8.4.4
;; communications error to 127.0.0.xxx#53: connection refused
;; communications error to 127.0.0.xxx#53: connection refused
;; communications error to 127.0.0.xxx#53: connection refused

; <<>> DiG 9.20.3-1-Debian <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 6595
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   182     IN      PTR     dns.google.

;; Query time: 24 msec
;; SERVER: 192.168.0.xxx#53(192.168.0.xxx) (UDP)
;; WHEN: Wed Jun 25 14:21:41 MSK 2025
;; MSG SIZE  rcvd: 73

                                                                                                                                                                          
┌──(kali㉿kali)-[~]
└─$ dig -x 1.1.2.2
;; communications error to 127.0.0.xxx#53: connection refused
;; communications error to 127.0.0.xxx#53: connection refused
;; communications error to 127.0.0.xxx#53: connection refused

; <<>> DiG 9.20.3-1-Debian <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 34104
;; flags: qr rd ra ad; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.          IN      PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.         1765    IN      SOA     ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22225 7200 1800 604800 3600

;; Query time: 28 msec
;; SERVER: 192.168.0.xxx#53(192.168.0.xxx) (UDP)
;; WHEN: Wed Jun 25 14:21:45 MSK 2025
;; MSG SIZE  rcvd: 137

### Documentation for Networking Analysis

### 1. Network Paths

The traceroute stops at the router (192.168.1.1) and terminates – no further hops respond. However, since DNS queries are working and GitHub resolves, the problem isn’t with the internet connection itself, but with the provider or intermediate nodes blocking diagnostic ICMP packets.

### 2. DNS Queries

The local DNS (192.168.0.1) responds:

Resolves github.com in 8 ms.
PTR for 8.8.4.4 succeeds.
NXDOMAIN error for 1.1.2.2 – because it’s not a public IP.
An empty tcpdump capture indicates that there were no active DNS queries at the time of the capture.
### 3. Reverse Lookups

8.8.4.4: The PTR record confirms it’s a Google server (dns.google).
1.1.2.2: APNIC responds with NXDOMAIN – a reverse zone doesn’t exist for this IP, which is normal for non-public addresses.

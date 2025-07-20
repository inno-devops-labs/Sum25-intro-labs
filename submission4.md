## Lab4
Nikita Yaneev n.yaneev@innopolis.unversity

### Task 1.1
*Command*:

```
systemd-analyze

```

*Output*:

```
sumnios@Nikita:~$ systemd-analyze
Startup finished in 4.449s (userspace)
graphical.target reached after 4.433s in userspace.
```
---
*Command*:
```
systemd-analyze blame
```

*Output*:
```
sumnios@Nikita:~$ systemd-analyze blame
2.913s snap.docker.nvidia-container-toolkit.service
2.617s landscape-client.service
2.474s snapd.seeded.service
2.296s snapd.service
 675ms dpkg-db-backup.service
 476ms wsl-pro.service
 425ms dev-sdc.device
 290ms dbus.service
 271ms systemd-journal-flush.service
 266ms systemd-resolved.service
 257ms rsyslog.service
 192ms user@1000.service
 158ms e2scrub_reap.service
 143ms systemd-udevd.service
 118ms systemd-udev-trigger.service
 116ms systemd-logind.service
 115ms systemd-tmpfiles-setup.service
  94ms systemd-timesyncd.service
  77ms keyboard-setup.service
  76ms systemd-journald.service
  62ms dev-hugepages.mount
  61ms dev-mqueue.mount
  60ms sys-kernel-debug.mount
  59ms sys-kernel-tracing.mount
  52ms snap-core22-1981.mount
  50ms systemd-update-utmp.service
  49ms snap-core22-2010.mount
  46ms systemd-user-sessions.service
  43ms modprobe@configfs.service
  43ms modprobe@dm_mod.service
  42ms modprobe@drm.service
  41ms snap-docker-3221.mount
  41ms snap-docker-3265.mount
  40ms modprobe@efi_pstore.service
  39ms systemd-tmpfiles-setup-dev-early.service
  38ms modprobe@fuse.service
  37ms modprobe@loop.service
  33ms snap-snapd-24505.mount
  31ms snap-snapd-24718.mount
  29ms systemd-modules-load.service
  26ms systemd-remount-fs.service
  23ms setvtrgb.service
  21ms systemd-sysctl.service
  15ms user-runtime-dir@1000.service
  15ms systemd-tmpfiles-setup-dev.service
  15ms sys-fs-fuse-connections.mount
  11ms systemd-update-utmp-runlevel.service
  11ms console-setup.service
  10ms wsl-binfmt.service
   9ms snap.mount
   5ms snapd.socket
   ```

---
*Command*:
```
uptime
```

*Output*:
```
sumnios@Nikita:~$ uptime
 19:04:39 up 9 min,  1 user,  load average: 0.00, 0.02, 0.00
 ```
---

*Command*:
```
w
```
*Output*:
```
sumnios@Nikita:~$ w
 19:04:52 up 9 min,  1 user,  load average: 0.00, 0.02, 0.00
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU  WHAT
sumnios  pts/1    -                18:55    9:33   0.03s  0.02s -bash
```
---
#### Key observation:
- The system boots relatively quickly in 4.449s
- The slowest services during boot are:

    1) snap.docker.nvidia-container-toolkit.service (2.913s)

    2) landscape-client.service (2.617s)

    3) snapd.seeded.service (2.474s)


- System has been running for 9 minutes

- Load averages are very low

### Task 1.2

*Command*:

```
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
```

*Output*:
```
sumnios@Nikita:~$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    PID    PPID CMD                         %MEM %CPU
    509       1 dockerd --group docker --ex  1.0  0.0
    759     509 containerd --config /run/sn  0.6  0.1
    229       1 /usr/lib/snapd/snapd         0.5  0.0
    271       1 /usr/bin/python3 /usr/share  0.2  0.0
    119       1 snapfuse /var/lib/snapd/sna  0.2  0.3
```
---
*Command*:
```
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
```

*Output*:
```
sumnios@Nikita:~$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    PID    PPID CMD                         %MEM %CPU
    133       1 snapfuse /var/lib/snapd/sna  0.1  0.4
    119       1 snapfuse /var/lib/snapd/sna  0.2  0.3
      1       0 /sbin/init                   0.1  0.1
    759     509 containerd --config /run/sn  0.6  0.1
    509       1 dockerd --group docker --ex  1.0  0.0
```
---
#### Key observation:
- Docker-related processes are the top memory consumers
- Snap-related processes dominate CPU usage
- System processes are generally using minimal resources

### Task 1.3
*Command*:
```
systemctl list-dependencies
```

*Output*:
```
sumnios@Nikita:~$ systemctl list-dependencies
default.target
○ ├─display-manager.service
○ ├─systemd-update-utmp-runlevel.service
○ ├─wsl-binfmt.service
● └─multi-user.target
○   ├─apport.service
●   ├─console-setup.service
●   ├─cron.service
●   ├─dbus.service
○   ├─dmesg.service
○   ├─e2scrub_reap.service
○   ├─landscape-client.service
○   ├─networkd-dispatcher.service
●   ├─rsyslog.service
●   ├─snap-core22-1981.mount
●   ├─snap-core22-2010.mount
●   ├─snap-docker-3221.mount
●   ├─snap-docker-3265.mount
●   ├─snap-snapd-24505.mount
●   ├─snap-snapd-24718.mount
●   ├─snap.docker.dockerd.service
○   ├─snap.docker.nvidia-container-toolkit.service
○   ├─snapd.apparmor.service
○   ├─snapd.autoimport.service
○   ├─snapd.core-fixup.service
○   ├─snapd.recovery-chooser-trigger.service
●   ├─snapd.seeded.service
●   ├─snapd.service
●   ├─systemd-ask-password-wall.path
●   ├─systemd-logind.service
○   ├─systemd-update-utmp-runlevel.service
●   ├─systemd-user-sessions.service
○   ├─ua-reboot-cmds.service
○   ├─ubuntu-advantage.service
●   ├─unattended-upgrades.service
●   ├─wsl-pro.service
●   ├─basic.target
○   │ ├─tmp.mount
●   │ ├─paths.target
○   │ │ └─apport-autoreport.path
●   │ ├─slices.target
●   │ │ ├─-.slice
●   │ │ └─system.slice
●   │ ├─sockets.target
●   │ │ ├─apport-forward.socket
●   │ │ ├─dbus.socket
●   │ │ ├─snapd.socket
●   │ │ ├─ssh.socket
●   │ │ ├─systemd-initctl.socket
●   │ │ ├─systemd-journald-dev-log.socket
●   │ │ ├─systemd-journald.socket
○   │ │ ├─systemd-pcrextend.socket
●   │ │ ├─systemd-sysext.socket
●   │ │ ├─systemd-udevd-control.socket
●   │ │ ├─systemd-udevd-kernel.socket
●   │ │ └─uuidd.socket
●   │ ├─sysinit.target
○   │ │ ├─apparmor.service
●   │ │ ├─dev-hugepages.mount
●   │ │ ├─dev-mqueue.mount
●   │ │ ├─keyboard-setup.service
○   │ │ ├─kmod-static-nodes.service
○   │ │ ├─ldconfig.service
○   │ │ ├─proc-sys-fs-binfmt_misc.automount
●   │ │ ├─setvtrgb.service
●   │ │ ├─sys-fs-fuse-connections.mount
○   │ │ ├─sys-kernel-config.mount
●   │ │ ├─sys-kernel-debug.mount
●   │ │ ├─sys-kernel-tracing.mount
●   │ │ ├─systemd-ask-password-console.path
○   │ │ ├─systemd-binfmt.service
○   │ │ ├─systemd-firstboot.service
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
○   │ │ ├─systemd-random-seed.service
○   │ │ ├─systemd-repart.service
●   │ │ ├─systemd-resolved.service
●   │ │ ├─systemd-sysctl.service
○   │ │ ├─systemd-sysusers.service
●   │ │ ├─systemd-timesyncd.service
●   │ │ ├─systemd-tmpfiles-setup-dev-early.service
●   │ │ ├─systemd-tmpfiles-setup-dev.service
●   │ │ ├─systemd-tmpfiles-setup.service
○   │ │ ├─systemd-tpm2-setup-early.service
○   │ │ ├─systemd-tpm2-setup.service
●   │ │ ├─systemd-udev-trigger.service
●   │ │ ├─systemd-udevd.service
○   │ │ ├─systemd-update-done.service
●   │ │ ├─systemd-update-utmp.service
●   │ │ ├─cryptsetup.target
●   │ │ ├─integritysetup.target
●   │ │ ├─local-fs.target
●   │ │ │ └─systemd-remount-fs.service
●   │ │ ├─swap.target
●   │ │ └─veritysetup.target
●   │ └─timers.target
○   │   ├─apport-autoreport.timer
●   │   ├─apt-daily-upgrade.timer
●   │   ├─apt-daily.timer
●   │   ├─dpkg-db-backup.timer
●   │   ├─e2scrub_all.timer
○   │   ├─fstrim.timer
●   │   ├─logrotate.timer
●   │   ├─man-db.timer
●   │   ├─motd-news.timer
○   │   ├─snapd.snap-repair.timer
●   │   ├─systemd-tmpfiles-clean.timer
○   │   └─ua-timer.timer
●   ├─getty.target
●   │ ├─console-getty.service
○   │ ├─getty-static.service
●   │ └─getty@tty1.service
●   └─remote-fs.target

```
---

*Command*:
```
systemctl list-dependencies multi-user.target
```

*Output*:
```
sumnios@Nikita:~$ systemctl list-dependencies multi-user.target
multi-user.target
○ ├─apport.service
● ├─console-setup.service
● ├─cron.service
● ├─dbus.service
○ ├─dmesg.service
○ ├─e2scrub_reap.service
○ ├─landscape-client.service
○ ├─networkd-dispatcher.service
● ├─rsyslog.service
● ├─snap-core22-1981.mount
● ├─snap-core22-2010.mount
● ├─snap-docker-3221.mount
● ├─snap-docker-3265.mount
● ├─snap-snapd-24505.mount
● ├─snap-snapd-24718.mount
● ├─snap.docker.dockerd.service
○ ├─snap.docker.nvidia-container-toolkit.service
○ ├─snapd.apparmor.service
○ ├─snapd.autoimport.service
○ ├─snapd.core-fixup.service
○ ├─snapd.recovery-chooser-trigger.service
● ├─snapd.seeded.service
● ├─snapd.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
○ ├─systemd-update-utmp-runlevel.service
● ├─systemd-user-sessions.service
○ ├─ua-reboot-cmds.service
○ ├─ubuntu-advantage.service
● ├─unattended-upgrades.service
● ├─wsl-pro.service
● ├─basic.target
○ │ ├─tmp.mount
● │ ├─paths.target
○ │ │ └─apport-autoreport.path
● │ ├─slices.target
● │ │ ├─-.slice
● │ │ └─system.slice
● │ ├─sockets.target
● │ │ ├─apport-forward.socket
● │ │ ├─dbus.socket
● │ │ ├─snapd.socket
● │ │ ├─ssh.socket
● │ │ ├─systemd-initctl.socket
● │ │ ├─systemd-journald-dev-log.socket
● │ │ ├─systemd-journald.socket
○ │ │ ├─systemd-pcrextend.socket
● │ │ ├─systemd-sysext.socket
● │ │ ├─systemd-udevd-control.socket
● │ │ ├─systemd-udevd-kernel.socket
● │ │ └─uuidd.socket
● │ ├─sysinit.target
○ │ │ ├─apparmor.service
● │ │ ├─dev-hugepages.mount
● │ │ ├─dev-mqueue.mount
● │ │ ├─keyboard-setup.service
○ │ │ ├─kmod-static-nodes.service
○ │ │ ├─ldconfig.service
○ │ │ ├─proc-sys-fs-binfmt_misc.automount
● │ │ ├─setvtrgb.service
● │ │ ├─sys-fs-fuse-connections.mount
○ │ │ ├─sys-kernel-config.mount
● │ │ ├─sys-kernel-debug.mount
● │ │ ├─sys-kernel-tracing.mount
● │ │ ├─systemd-ask-password-console.path
○ │ │ ├─systemd-binfmt.service
○ │ │ ├─systemd-firstboot.service
○ │ │ ├─systemd-hwdb-update.service
○ │ │ ├─systemd-journal-catalog-update.service
● │ │ ├─systemd-journal-flush.service
● │ │ ├─systemd-journald.service
○ │ │ ├─systemd-machine-id-commit.service
● │ │ ├─systemd-modules-load.service
○ │ │ ├─systemd-pcrmachine.service
○ │ │ ├─systemd-pcrphase-sysinit.service
○ │ │ ├─systemd-pcrphase.service
○ │ │ ├─systemd-pstore.service
○ │ │ ├─systemd-random-seed.service
○ │ │ ├─systemd-repart.service
● │ │ ├─systemd-resolved.service
● │ │ ├─systemd-sysctl.service
○ │ │ ├─systemd-sysusers.service
● │ │ ├─systemd-timesyncd.service
● │ │ ├─systemd-tmpfiles-setup-dev-early.service
● │ │ ├─systemd-tmpfiles-setup-dev.service
● │ │ ├─systemd-tmpfiles-setup.service
○ │ │ ├─systemd-tpm2-setup-early.service
○ │ │ ├─systemd-tpm2-setup.service
● │ │ ├─systemd-udev-trigger.service
● │ │ ├─systemd-udevd.service
○ │ │ ├─systemd-update-done.service
● │ │ ├─systemd-update-utmp.service
● │ │ ├─cryptsetup.target
● │ │ ├─integritysetup.target
● │ │ ├─local-fs.target
● │ │ │ └─systemd-remount-fs.service
● │ │ ├─swap.target
● │ │ └─veritysetup.target
● │ └─timers.target
○ │   ├─apport-autoreport.timer
● │   ├─apt-daily-upgrade.timer
● │   ├─apt-daily.timer
● │   ├─dpkg-db-backup.timer
● │   ├─e2scrub_all.timer
○ │   ├─fstrim.timer
● │   ├─logrotate.timer
● │   ├─man-db.timer
● │   ├─motd-news.timer
○ │   ├─snapd.snap-repair.timer
● │   ├─systemd-tmpfiles-clean.timer
○ │   └─ua-timer.timer
● ├─getty.target
● │ ├─console-getty.service
○ │ ├─getty-static.service
● │ └─getty@tty1.service
● └─remote-fs.target
```
---

#### Key observation:
- The system uses systemd for service management
- Multi-user.target is the main target reached
- Network-related services are present but not heavily utilized
- Basic system services start first (sysinit.target)

### Task 1.4
*Command*:
```
who -a
```

*Output*:
```
sumnios@Nikita:~$ who -a
           system boot  2025-06-26 18:55
           run-level 5  2025-06-26 18:55
LOGIN      tty1         2025-06-26 18:55               259 id=tty1
LOGIN      console      2025-06-26 18:55               252 id=cons
sumnios  - pts/1        2025-06-26 18:55 00:23         708
```

---
*Command*:
```
last -n 5
```

*Output*:
```
sumnios@Nikita:~$ last -n 5
reboot   system boot  5.15.167.4-micro Thu Jun 26 18:55   still running
reboot   system boot  5.15.167.4-micro Wed Jun 25 10:26   still running
reboot   system boot  5.15.167.4-micro Mon Jun 23 14:14   still running
reboot   system boot  5.15.167.4-micro Fri Jun 20 20:25   still running
reboot   system boot  5.15.167.4-micro Wed Jun 11 11:52   still running

wtmp begins Tue Jan 21 17:03:39 2025
```
---

- Minimal user activity
- Regular reboots

### Task 1.5
*Command*:
```
free -h
```

*Output*:
```
sumnios@Nikita:~$ free -h
               total        used        free      shared  buff/cache   available
Mem:           7.4Gi       733Mi       6.6Gi       3.3Mi       291Mi       6.7Gi
Swap:          2.0Gi          0B       2.0Gi
```

---
*Command*:
```
cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
```

*Output*:
```
sumnios@Nikita:~$ cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
MemTotal:        7761944 kB
MemAvailable:    7010084 kB
SwapTotal:       2097152 kB
```

---
#### Key observation:
- System has plenty of available memory
- Only about 10% of memory is actively used


___
### Task 2.1

*Command*:
```
traceroute github.com
```

*Output*:
```
traceroute to github.com (140.82.113.3), 30 hops max, 60 byte packets
 1  Nikita.mshome.net (172.23.XXXX.XXXX)  2.495 ms  2.391 ms  2.271 ms
 2  XiaoQiang (192.168.XXXX.XXXX)  13.615 ms  13.478 ms  13.253 ms
 3  10.16.255.147 (10.16.255.147)  24.573 ms  24.411 ms  24.147 ms
 4  10.16.242.38 (10.16.242.38)  24.203 ms 10.16.242.34 (10.16.242.34)  24.127 ms 10.16.242.54 (10.16.242.54)  62.980 ms
 5  10.16.248.170 (10.16.248.170)  23.708 ms 10.16.248.206 (10.16.248.206)  23.707 ms 10.16.248.150 (10.16.248.150)  23.724 ms
 6  10.16.248.253 (10.16.248.253)  23.361 ms 10.16.248.130 (10.16.248.130)  41.022 ms 10.16.248.253 (10.16.248.253)  41.029 ms
 7  10.16.248.130 (10.16.248.130)  40.547 ms 188.254.80.81 (188.254.80.81)  11.727 ms 10.16.248.253 (10.16.248.253)  11.597 ms
 8  188.254.80.81 (188.254.80.81)  11.668 ms  20.870 ms  20.700 ms
 9  * * *
10  sto-b2-link.ip.twelve99.net (80.239.128.74)  168.535 ms  168.459 ms  168.355 ms
11  sto-bb2-link.ip.twelve99.net (62.115.140.216)  168.453 ms kbn-bb6-link.ip.twelve99.net (62.115.139.173)  168.237 ms sto-bb2-link.ip.twelve99.net (62.115.140.216)  168.291 ms
12  * war-b3-link.ip.twelve99.net (195.12.255.204)  167.979 ms *
13  war-b3-link.ip.twelve99.net (195.12.255.204)  135.152 ms *  134.947 ms
14  rest-b2-link.ip.twelve99.net (62.115.121.216)  242.206 ms prs-bb2-link.ip.twelve99.net (62.115.122.138)  119.252 ms rest-b2-link.ip.twelve99.net (62.115.121.216)  163.146 ms
15  ash-bb2-link.ip.twelve99.net (62.115.140.107)  167.614 ms github-ic-368832.ip.twelve99-cust.net (213.248.67.47)  162.833 ms *
16  github-ic-368832.ip.twelve99-cust.net (213.248.67.47)  162.674 ms * rest-b2-link.ip.twelve99.net (62.115.121.216)  166.961 ms
17  * * rest-b2-link.ip.twelve99.net (62.115.121.216)  255.663 ms
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
---

*Command*:
```
dig github.com
```

*Output*:
```
sumnios@Nikita:~$ dig github.com

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 45059
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             38      IN      A       140.82.113.3

;; Query time: 31 msec
;; SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
;; WHEN: Thu Jun 26 19:41:29 MSK 2025
;; MSG SIZE  rcvd: 55
```

---
*Path*:
- Local network (hops 1–2: 172.23.X.X, 192.168.X.X)
- Internal networks (hops 3–9: 10.16.X.X, 188.254.80.81)
- International transit via Twelve99
- Hop 4 (62.980 ms) and hop 6 (41.022 ms) suggest congestion or load balancing

*DNS Query*:
- Resolved to 140.82.113.3 (GitHub’s IP) with a TTL of 38 seconds
- Efficiency: Fast, using UDP  

### Task 2.2

*Command*:
```
sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn   
```

*Output*:
```
 WSL Doesn’t Have Full Access to Raw Network Interfaces
```

---

### Task 2.3

*Command*:
```
dig -x 8.8.4.4
```

*Output*:
```
sumnios@Nikita:~$ dig -x 8.8.4.4

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 16983
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   16955   IN      PTR     dns.google.

;; Query time: 0 msec
;; SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
;; WHEN: Thu Jun 26 19:53:27 MSK 2025
;; MSG SIZE  rcvd: 73
```

---

*Command*:
```
dig -x 1.1.2.2
```

*Output*:
```
sumnios@Nikita:~$ dig -x 1.1.2.2

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 45425
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.          IN      PTR

;; Query time: 10 msec
;; SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
;; WHEN: Thu Jun 26 19:53:43 MSK 2025
;; MSG SIZE  rcvd: 49
```

---
*Results*:

Success: 4.4.8.8.in-addr.arpa -> dns.google.

- Confirms Google’s DNS server, with a long TTL

 No PTR record found for 1.1.2.2.
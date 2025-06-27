
# Lab 4

Timur Nugaev

---

I don't have Linux, so I'm going to use my VPN server (via ssh) to complete this lab.

## Task 1: OS Analysis

### 1.1 Boot Performance

#### 1.1.1 `systemd-analyze`

```bash
root@timur:~# systemd-analyze
Startup finished in 1.392s (kernel) + 1.306s (initrd) + 4.002s (userspace) = 6.701s 
multi-user.target reached after 3.985s in userspace.
```

Total boot time: 6.701 s

Kernel took 1.392 s, initrd 1.306 s, userspace 4.002 s

#### 1.1.2 `systemd-analyze blame`

```bash
root@timur:~# systemd-analyze blame
7.027s apt-daily-upgrade.service
2.454s dev-rfkill.device
2.452s sys-devices-virtual-misc-rfkill.device
2.165s sys-devices-pci0000:00-0000:00:04.0-virtio1->
2.165s dev-vport1p1.device
2.164s dev-virtio\x2dports-org.qemu.guest_agent.0.d>
1.577s dev-disk-by\x2dpath-pci\x2d0000:00:01.1\x2da>
1.577s dev-disk-by\x2did-ata\x2dQEMU_DVD\x2dROM_QM0>
1.577s sys-devices-pci0000:00-0000:00:01.1-ata2-hos>
1.577s dev-disk-by\x2dpath-pci\x2d0000:00:01.1\x2da>
1.577s dev-disk-by\x2ddiskseq-11.device
1.577s dev-sr0.device
1.577s dev-cdrom.device
1.569s sys-devices-pci0000:00-0000:00:07.0-virtio4->
1.569s dev-disk-by\x2ddiskseq-9\x2dpart1.device
1.569s dev-disk-by\x2dpartlabel-p.legacy.device
1.569s dev-disk-by\x2dpath-virtio\x2dpci\x2d0000:00>
1.569s dev-disk-by\x2dpath-pci\x2d0000:00:07.0\x2dp>
1.569s dev-disk-by\x2dpartuuid-6efabece\x2d9d7e\x2d>
1.569s dev-vda1.device
1.525s ifupdown-pre.service
1.478s dev-disk-by\x2dpartlabel-p.UEFI.device
1.478s dev-disk-by\x2duuid-33E5\x2d73C7.device
1.478s dev-disk-by\x2dlabel-EFI.device
1.478s dev-vda2.device
1.478s sys-devices-pci0000:00-0000:00:07.0-virtio4->
1.478s dev-disk-by\x2dpath-virtio\x2dpci\x2d0000:00>
1.477s dev-disk-by\x2dpath-pci\x2d0000:00:07.0\x2dp>
1.477s dev-disk-by\x2dpartuuid-aa7630db\x2d16b4\x2d>
1.477s dev-disk-by\x2ddiskseq-9\x2dpart2.device
1.477s dev-disk-by\x2ddiskseq-9\x2dpart3.device
... (there is 210 lines total) ...
```

Slowest three units:

apt-daily-upgrade.service — 7.027 s

dev-rfkill.device — 2.454 s

sys-devices-virtual-misc-rfkill.device — 2.452 s

The daily upgrade service is the big bottleneck here


#### 1.1.3 `uptime` & `w`

```bash
root@timur:~# uptime
 21:22:08 up 79 days,  9:26,  1 user,  load average: 0.08, 0.06, 0.01

root@timur:~# w
 21:22:24 up 79 days,  9:26,  1 user,  load average: 0.06, 0.05, 0.01
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
root              80.74.24.162     21:19    5days  0.00s  0.16s sshd: r
```

Load averages are very low (<0.1)

Only 1 real user session (root via SSH)

---

### 1.2 Process Forensics

#### 1.2.1 Top processes by memory

```bash
root@timur:~# ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    PID    PPID CMD                         %MEM %CPU
3440903       1 /usr/sbin/mysqld            22.7  0.6
3489724       1 /usr/lib/systemd/systemd-jo  3.7  0.0
 472758       1 bin/core ispmgr              3.3  0.0
  42091       1 /usr/bin/dockerd -H fd:// -  2.8  0.1
  45317   45305 xray -config /opt/amnezia/x  2.7  0.6

```

Top 3 memory-hungry processes:

/usr/sbin/mysqld — 22.7 %

/usr/lib/systemd/systemd-journald — 3.7 %

bin/core ispmgr — 3.3 %


#### 1.2.2 Top processes by CPU

```bash
$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
root@timur:~# ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    PID    PPID CMD                         %MEM %CPU
 166111  166093 /opt/outline-server/bin/out  1.9  1.0
  45317   45305 xray -config /opt/amnezia/x  2.8  0.6
3440903       1 /usr/sbin/mysqld            22.7  0.6
  42091       1 /usr/bin/dockerd -H fd:// -  2.8  0.1
  41974       1 /usr/bin/containerd          1.2  0.0
```

Top 3 CPU-hungry processes:

/opt/outline-server/bin/out — 1.0 %

xray — 0.6 %

/usr/sbin/mysqld — 0.6 %

---

### 1.3 Service Dependencies

#### 1.3.1 `systemctl list-dependencies`

```bash
root@timur:~# systemctl list-dependencies
default.target
● ├─apache2.service
● ├─apport.service
● ├─atd.service
● ├─console-setup.service
● ├─containerd.service
● ├─cron.service
● ├─dbus.service
● ├─docker.service
● ├─dovecot.service
○ ├─e2scrub_reap.service
● ├─exim4.service
○ ├─grub-common.service
○ ├─grub-initrd-fallback.service
● ├─ihttpd.service
● ├─mysql.service
● ├─named.service
● ├─networking.service
● ├─nginx.service
● ├─ntpsec.service
● ├─php-fpm74.service
● ├─php8.3-fpm.service
○ ├─pollinate.service
● ├─proftpd.service
● ├─snapd.apparmor.service
○ ├─snapd.autoimport.service
○ ├─snapd.core-fixup.service
○ ├─snapd.recovery-chooser-trigger.service
● ├─snapd.seeded.service
○ ├─snapd.service
● ├─ssh.service
○ ├─ssl-cert.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
○ ├─systemd-update-utmp-runlevel.service
● ├─systemd-user-sessions.service
● ├─tuned.service
● ├─ubuntu-fan.service
● ├─unattended-upgrades.service
● ├─basic.target
● │ ├─-.mount
○ │ ├─tmp.mount
● │ ├─paths.target
○ │ │ └─apport-autoreport.path
● │ ├─slices.target
● │ │ ├─-.slice
● │ │ └─system.slice
● │ ├─sockets.target
○ │ │ ├─apport-forward.socket
● │ │ ├─dbus.socket
● │ │ ├─dm-event.socket
● │ │ ├─docker.socket
● │ │ ├─iscsid.socket
● │ │ ├─multipathd.socket
● │ │ ├─snapd.socket
● │ │ ├─ssh.socket
● │ │ ├─systemd-initctl.socket
● │ │ ├─systemd-journald-dev-log.socket
● │ │ ├─systemd-journald.socket
○ │ │ ├─systemd-pcrextend.socket
● │ │ ├─systemd-sysext.socket
● │ │ ├─systemd-udevd-control.socket
● │ │ └─systemd-udevd-kernel.socket
● │ ├─sysinit.target
○ │ │ ├─apparmor.service
● │ │ ├─blk-availability.service
● │ │ ├─dev-hugepages.mount
● │ │ ├─dev-mqueue.mount
● │ │ ├─dracut-shutdown.service
● │ │ ├─keyboard-setup.service
● │ │ ├─kmod-static-nodes.service
● │ │ ├─ldconfig.service
● │ │ ├─lvm2-lvmpolld.socket
● │ │ ├─multipathd.service
● │ │ ├─proc-sys-fs-binfmt_misc.automount
● │ │ ├─setvtrgb.service
● │ │ ├─sys-fs-fuse-connections.mount
● │ │ ├─sys-kernel-config.mount
● │ │ ├─sys-kernel-debug.mount
● │ │ ├─sys-kernel-tracing.mount
● │ │ ├─systemd-ask-password-console.path
● │ │ ├─systemd-binfmt.service
○ │ │ ├─systemd-firstboot.service
○ │ │ ├─systemd-hwdb-update.service
● │ │ ├─systemd-journal-catalog-update.service
● │ │ ├─systemd-journal-flush.service
● │ │ ├─systemd-journald.service
○ │ │ ├─systemd-machine-id-commit.service
● │ │ ├─systemd-modules-load.service
○ │ │ ├─systemd-pcrmachine.service
○ │ │ ├─systemd-pcrphase-sysinit.service
○ │ │ ├─systemd-pcrphase.service
○ │ │ ├─systemd-pstore.service
● │ │ ├─systemd-random-seed.service
○ │ │ ├─systemd-repart.service
● │ │ ├─systemd-resolved.service
● │ │ ├─systemd-sysctl.service
● │ │ ├─systemd-sysusers.service
○ │ │ ├─systemd-timesyncd.service
● │ │ ├─systemd-tmpfiles-setup-dev-early.service
● │ │ ├─systemd-tmpfiles-setup-dev.service
● │ │ ├─systemd-tmpfiles-setup.service
○ │ │ ├─systemd-tpm2-setup-early.service
○ │ │ ├─systemd-tpm2-setup.service
● │ │ ├─systemd-udev-trigger.service
● │ │ ├─systemd-udevd.service
● │ │ ├─systemd-update-done.service
● │ │ ├─systemd-update-utmp.service
● │ │ ├─cryptsetup.target
● │ │ ├─integritysetup.target
● │ │ ├─local-fs.target
● │ │ │ ├─-.mount
● │ │ │ ├─boot-efi.mount
● │ │ │ ├─systemd-fsck-root.service
● │ │ │ └─systemd-remount-fs.service
● │ │ ├─swap.target
● │ │ └─veritysetup.target
● │ └─timers.target
○ │   ├─apport-autoreport.timer
● │   ├─apt-daily-upgrade.timer
● │   ├─apt-daily.timer
● │   ├─dpkg-db-backup.timer
● │   ├─e2scrub_all.timer
● │   ├─exim4-base.timer
● │   ├─fstrim.timer
● │   ├─logrotate.timer
● │   ├─man-db.timer
● │   ├─motd-news.timer
● │   ├─ntpsec-rotate-stats.timer
● │   ├─phpsessionclean.timer
○ │   ├─snapd.snap-repair.timer
● │   └─systemd-tmpfiles-clean.timer
○ ├─cron.target
● ├─getty.target
○ │ ├─getty-static.service
● │ └─getty@tty1.service
● └─remote-fs.target

```

default.target pulls in web server (apache2), container runtimes (containerd, docker), mail services (dovecot, exim4), system timers and sockets, SSH, etc.

#### 1.3.2 `systemctl list-dependencies multi-user.target`

```bash
root@timur:~# systemctl list-dependencies multi-user.target
multi-user.target
● ├─apache2.service
● ├─apport.service
● ├─atd.service
● ├─console-setup.service
● ├─containerd.service
● ├─cron.service
● ├─dbus.service
● ├─docker.service
● ├─dovecot.service
○ ├─e2scrub_reap.service
● ├─exim4.service
○ ├─grub-common.service
○ ├─grub-initrd-fallback.service
● ├─ihttpd.service
● ├─mysql.service
● ├─named.service
● ├─networking.service
● ├─nginx.service
● ├─ntpsec.service
● ├─php-fpm74.service
● ├─php8.3-fpm.service
○ ├─pollinate.service
● ├─proftpd.service
● ├─snapd.apparmor.service
○ ├─snapd.autoimport.service
○ ├─snapd.core-fixup.service
○ ├─snapd.recovery-chooser-trigger.service
● ├─snapd.seeded.service
○ ├─snapd.service
● ├─ssh.service
○ ├─ssl-cert.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
○ ├─systemd-update-utmp-runlevel.service
● ├─systemd-user-sessions.service
● ├─tuned.service
● ├─ubuntu-fan.service
● ├─unattended-upgrades.service
● ├─basic.target
● │ ├─-.mount
○ │ ├─tmp.mount
● │ ├─paths.target
○ │ │ └─apport-autoreport.path
● │ ├─slices.target
● │ │ ├─-.slice
● │ │ └─system.slice
● │ ├─sockets.target
○ │ │ ├─apport-forward.socket
● │ │ ├─dbus.socket
● │ │ ├─dm-event.socket
● │ │ ├─docker.socket
● │ │ ├─iscsid.socket
● │ │ ├─multipathd.socket
● │ │ ├─snapd.socket
● │ │ ├─ssh.socket
● │ │ ├─systemd-initctl.socket
● │ │ ├─systemd-journald-dev-log.socket
● │ │ ├─systemd-journald.socket
○ │ │ ├─systemd-pcrextend.socket
● │ │ ├─systemd-sysext.socket
● │ │ ├─systemd-udevd-control.socket
● │ │ └─systemd-udevd-kernel.socket
● │ ├─sysinit.target
○ │ │ ├─apparmor.service
● │ │ ├─blk-availability.service
● │ │ ├─dev-hugepages.mount
● │ │ ├─dev-mqueue.mount
● │ │ ├─dracut-shutdown.service
● │ │ ├─keyboard-setup.service
● │ │ ├─kmod-static-nodes.service
● │ │ ├─ldconfig.service
● │ │ ├─lvm2-lvmpolld.socket
● │ │ ├─multipathd.service
● │ │ ├─proc-sys-fs-binfmt_misc.automount
● │ │ ├─setvtrgb.service
● │ │ ├─sys-fs-fuse-connections.mount
● │ │ ├─sys-kernel-config.mount
● │ │ ├─sys-kernel-debug.mount
● │ │ ├─sys-kernel-tracing.mount
● │ │ ├─systemd-ask-password-console.path
● │ │ ├─systemd-binfmt.service
○ │ │ ├─systemd-firstboot.service
○ │ │ ├─systemd-hwdb-update.service
● │ │ ├─systemd-journal-catalog-update.service
● │ │ ├─systemd-journal-flush.service
● │ │ ├─systemd-journald.service
○ │ │ ├─systemd-machine-id-commit.service
● │ │ ├─systemd-modules-load.service
○ │ │ ├─systemd-pcrmachine.service
○ │ │ ├─systemd-pcrphase-sysinit.service
○ │ │ ├─systemd-pcrphase.service
○ │ │ ├─systemd-pstore.service
● │ │ ├─systemd-random-seed.service
○ │ │ ├─systemd-repart.service
● │ │ ├─systemd-resolved.service
● │ │ ├─systemd-sysctl.service
● │ │ ├─systemd-sysusers.service
○ │ │ ├─systemd-timesyncd.service
● │ │ ├─systemd-tmpfiles-setup-dev-early.service
● │ │ ├─systemd-tmpfiles-setup-dev.service
● │ │ ├─systemd-tmpfiles-setup.service
○ │ │ ├─systemd-tpm2-setup-early.service
○ │ │ ├─systemd-tpm2-setup.service
● │ │ ├─systemd-udev-trigger.service
● │ │ ├─systemd-udevd.service
● │ │ ├─systemd-update-done.service
● │ │ ├─systemd-update-utmp.service
● │ │ ├─cryptsetup.target
● │ │ ├─integritysetup.target
● │ │ ├─local-fs.target
● │ │ │ ├─-.mount
● │ │ │ ├─boot-efi.mount
● │ │ │ ├─systemd-fsck-root.service
● │ │ │ └─systemd-remount-fs.service
● │ │ ├─swap.target
● │ │ └─veritysetup.target
● │ └─timers.target
○ │   ├─apport-autoreport.timer
● │   ├─apt-daily-upgrade.timer
● │   ├─apt-daily.timer
● │   ├─dpkg-db-backup.timer
● │   ├─e2scrub_all.timer
● │   ├─exim4-base.timer
● │   ├─fstrim.timer
● │   ├─logrotate.timer
● │   ├─man-db.timer
● │   ├─motd-news.timer
● │   ├─ntpsec-rotate-stats.timer
● │   ├─phpsessionclean.timer
○ │   ├─snapd.snap-repair.timer
● │   └─systemd-tmpfiles-clean.timer
○ ├─cron.target
● ├─getty.target
○ │ ├─getty-static.service
● │ └─getty@tty1.service
● └─remote-fs.target
```

service chains: Apache2 -> networking, containerd/docker -> sockets.target, SSH -> ssh.socket, etc.

---

### 1.4 User Sessions

#### 1.4.1 `who -a`

```bash
root@timur:~# who -a
           system boot  2025-04-09 11:55
           run-level 3  2025-04-09 11:55
LOGIN      tty1         2025-04-09 11:55              1006 id=tty1
root     - pts/0        2025-06-27 21:19   .        878102 (80.74.24.162)
```

How many users are logged in now? 1 (root)

When did they log in? root at 21:19 on June 27, 2025

#### 1.4.2 `last -n 5`

```bash
root@timur:~# last -n 5
root     pts/0        80.74.24.162     Fri Jun 27 21:19   still logged in
root     pts/0        77.79.156.185    Wed Apr  9 12:09 - 12:37  (00:28)
reboot   system boot  6.8.0-50-generic Wed Apr  9 11:55   still running

wtmp begins Wed Apr  9 11:55:34 2025
```


Recent login history:
only root sessions and last reboot on Apr 9, 2025


---

### 1.5 Memory Analysis

#### 1.5.1 `free -h`

```bash
root@timur:~# free -h
               total        used        free      shared  buff/cache   available
Mem:           1.8Gi       1.2Gi        91Mi        14Mi       690Mi       591Mi
Swap:             0B          0B          0B

```

Total vs used vs free memory: 1.8 GiB total, 1.2 GiB used, 91 MiB free

Swap used: 0 B

#### 1.5.2 `/proc/meminfo`

```bash
root@timur:~# cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
MemTotal:        1850996 kB
MemAvailable:     597332 kB
SwapTotal:             0 kB
```

MemTotal ~1.85 GiB, MemAvailable ~0.57 GiB, SwapTotal 0 kB

Memory is a bit tight: ~600 MiB free, but no swap is good

---

## Task 2: Networking Analysis

### 2.1 Tracing & DNS

#### 2.1.1 `traceroute github.com`

```bash
root@timur:~# traceroute github.com
traceroute to github.com (140.82.121.4), 64 hops max
  1   10.0.0.1  0.071ms  0.031ms  0.030ms 
  2   *  *  * 
  3   146.0.72.234  0.702ms  0.494ms  0.181ms 
  4   185.1.160.9  0.298ms  0.264ms  0.266ms 
  5   *  *  * 
  6   *  *  * 
  7   *  *  * 
  8   94.103.180.24  6.016ms  5.999ms  5.981ms 
  9   45.153.82.37  6.325ms  6.140ms  6.250ms 
 10   45.153.82.39  7.432ms  6.810ms  6.538ms 
 11   *  *  * 
 12   *  *  * 
 13   *  *  * 
 14   *  *  * 
 15   *  *  * 
 16   *  *  * 
 17   *  *  * 
 18   *  *  * 
 19   *  *  * 
 20   *  *  * 
 21   *  *  * 
 22   *  *  * 
 23   *  *  * 
 24   *  *  * 
 25   *  *  * 
 26   *  *  * 
 27   *  *  * 
 28   *  *  * 
 29   *  *  * 
 30   *  *  * 
 31   *  *  * 
 32   *  *  * 
 33   *  *  * 
 34   *  *  * 
 35   *  *  * 
 36   *  *  * 
 37   *  *  * 
 38   *  *  * 
 39   *  *  * 
 40   *  *  * 
 41   *  *  * 
 42   *  *  * 
 43   *  *  * 
 44   *  *  * 
 45   *  *  * 
 46   *  *  * 
 47   *  *  * 
 48   *  *  * 
 49   *  *  * 
 50   *  *  * 
 51   *  *  * 
 52   *  *  * 
 53   *  *  * 
 54   *  *  * 
 55   *  *  * 
 56   *  *  * 
 57   *  *  * 
 58   *  *  * 
 59   *  *  * 
 60   *  *  * 
 61   *  *  * 
 62   *  *  * 
 63   *  *  * 
 64   *  *  * 
```

* Number of hops: 64
* Responded: 10
* Avg latency for responding hops: 3ms

#### 2.1.2 `dig github.com +short`

```bash
root@timur:~# dig github.com +short
140.82.121.4
```

there is 1 A record: 140.82.121.4

---

### 2.2 Packet Capture

#### 2.2.1 `sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn`

```bash
root@timur:~# sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
21:59:27.436632 vetha526b5d P   IP 172.29.172.2.56825 > 1.1.1.1.53: 22877+ [1au] AAAA? www.googletagmanager.com. (53)
21:59:27.436632 amn0  In  IP 172.29.172.2.56825 > 1.1.1.1.53: 22877+ [1au] AAAA? www.googletagmanager.com. (53)
21:59:27.436673 ens3  Out IP 80.74.24.162.56825 > 1.1.1.1.53: 22877+ [1au] AAAA? www.googletagmanager.com. (53)
21:59:27.437622 vetha526b5d P   IP 172.29.172.2.57869 > 1.1.1.1.53: 34776+ [1au] A? www.googletagmanager.com. (53)
21:59:27.437622 amn0  In  IP 172.29.172.2.57869 > 1.1.1.1.53: 34776+ [1au] A? www.googletagmanager.com. (53)
5 packets captured
17 packets received by filter
0 packets dropped by kernel
```

Example DNS query:

Query for AAAA

www.googletagmanager.com

from 172.29.172.2

no response

---

### 2.3 Reverse DNS

#### 2.3.1 `dig -x 8.8.4.4 +short`

```bash
root@timur:~# dig -x 8.8.4.4 +short
dns.google.
```

#### 2.3.2 `dig -x 1.1.2.2 +short`

```bash
root@timur:~# dig -x 1.1.2.2 +short
root@timur:~# dig -x 1.1.2.2

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 23215
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.		IN	PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.		1701	IN	SOA	ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22230 7200 1800 604800 3600

;; Query time: 7 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Fri Jun 27 22:01:38 CEST 2025
;; MSG SIZE  rcvd: 137
```

PTR for 8.8.4.4: dns.google.

PTR for 1.1.2.2: none (NXDOMAIN)
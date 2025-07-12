# Lab 4

## Boot Performance

### System Boot Time

```
systemd-analyze
```

The overall startup time is 1 min 38 sec which is long for a bit.

The most long stage of system startup is firmware - more than 50 sec, userspace launched for 14.5 sec.

```
Startup finished in 50.436s (firmware) + 30.653s (loader) + 2.544s (kernel) + 14.549s (userspace) = 1min 38.183s 
graphical.target reached after 14.522s in userspace.
```

```
systemd-analyze blame
```

mdcheck_start.service startuped for almost 3 hours, which is very long i quess it can be happen because of i made raid0 from raid1 before last restart

motd-news.service startaped for too long as well, i guess this service can be postponed

Other services startuped quite fast

```
2h 38min 513ms mdcheck_start.service
   1min 2.244s motd-news.service
        8.258s elasticsearch.service
        6.139s fstrim.service
        2.165s postgresql@16-main.service
        1.116s apt-daily-upgrade.service
         743ms docker.service
         716ms systemd-journal-flush.service
         517ms snapd.apparmor.service
         405ms apt-daily.service
         307ms ufw.service
         181ms snapd.seeded.service
         148ms snapd.service
         148ms apparmor.service
         146ms man-db.service
         133ms dev-md2.device
         128ms boot-efi.mount
         125ms containerd.service
         110ms user@0.service
          84ms update-notifier-download.service
          62ms apport.service
          60ms lvm2-monitor.service
          59ms rsyslog.service
          53ms systemd-udev-trigger.service
          43ms sysstat-summary.service
          35ms e2scrub_reap.service
          33ms systemd-resolved.service
          32ms systemd-tmpfiles-clean.service
          32ms systemd-networkd-wait-online.service
          31ms update-notifier-motd.service
          31ms logrotate.service
          28ms dpkg-db-backup.service
          26ms polkit.service
          24ms keyboard-setup.service
          24ms multipathd.service
          23ms systemd-remount-fs.service
          22ms systemd-udevd.service
          22ms systemd-timesyncd.service
          20ms mosquitto.service
          18ms systemd-networkd.service
          16ms systemd-journald.service
          16ms proc-sys-fs-binfmt_misc.mount
          15ms docker.socket
          14ms systemd-logind.service
          13ms plymouth-read-write.service
          13ms ssh.service
          13ms dev-hugepages.mount
          12ms grub-common.service
          12ms plymouth-quit.service
          12ms dev-mqueue.mount
          12ms alsa-restore.service
          10ms sys-kernel-debug.mount
          10ms dbus.service
          10ms systemd-fsck@dev-disk-by\x2duuid-490E\x2d1FB5.service
           9ms sys-kernel-tracing.mount
           9ms systemd-user-sessions.service
           8ms systemd-tmpfiles-setup.service
           8ms thermald.service
           7ms systemd-tmpfiles-setup-dev-early.service
           7ms systemd-sysctl.service
           6ms e2scrub_all.service
           6ms kmod-static-nodes.service
           6ms user-runtime-dir@0.service
           5ms sysstat-collect.service
           5ms grub-initrd-fallback.service
           5ms modprobe@configfs.service
           5ms dev-disk-by\x2duuid-47264a91\x2dba2c\x2d4589\x2da9e1\x2d48f4186b4fb4.swap
           5ms sysstat.service
           5ms modprobe@dm_mod.service
           4ms boot.mount
           4ms modprobe@drm.service
           4ms systemd-modules-load.service
           4ms systemd-update-utmp.service
           4ms systemd-tmpfiles-setup-dev.service
           4ms modprobe@efi_pstore.service
           4ms systemd-update-utmp-runlevel.service
           4ms modprobe@loop.service
           4ms console-setup.service
           3ms modprobe@fuse.service
           3ms postgresql.service
           3ms systemd-random-seed.service
           3ms systemd-binfmt.service
           3ms plymouth-quit-wait.service
           2ms finalrd.service
           2ms setvtrgb.service
           2ms sys-fs-fuse-connections.mount
           2ms sys-kernel-config.mount
           2ms atd.service
           2ms lxd-installer.socket
           1ms snapd.socket
         115us blk-availability.service
```

```
uptime
```

System works for 48 days - nice in terms of stability.

average load is high, i guess it is because of docker and elasticsearch services.

```
 19:09:00 up 48 days,  8:16, 10 users,  load average: 3.43, 3.16, 2.79
```


```
w
```

JCPU/PCPU are pretty low, it means that they are not load system too much.

```
 19:10:12 up 48 days,  8:17, 10 users,  load average: 1.94, 2.76, 2.68
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU  WHAT
root              <ip>             00:23   26:59m  0.00s  0.06s sshd: root@pts/8
root              <ip>             00:24   26:59m  0.00s  8:55  sshd: root@notty
root              <ip>             10:53   26:59m  0.00s  3.62s sshd: root@notty
```


### Process Forensics

```
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
``` 

Elasticsearch service loads a lot of memory and cpu;
Also a lot of CPU is busy by currently working python sript.

```
    PID    PPID CMD                         %MEM %CPU
   2059    1364 /usr/share/elasticsearch/jd 67.1  115
2232284       1 /root/searcher/venv/bin/pyt 11.1  4.6
2733261       1 python3 <___________>.py     0.3 80.3
1592221       1 /root/searcher/venv/bin/pyt  0.2  0.8
2832327 1886567 postgres: 16/main: postgres  0.2  0.0
```

```
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
```

```
    PID    PPID CMD                         %MEM %CPU
   2059    1364 /usr/share/elasticsearch/jd 68.0  115
2733261       1 python3 <___________>.py     0.3 80.3
2232284       1 /root/searcher/venv/bin/pyt 11.0  4.6
    237       2 [kswapd0]                    0.0  1.3
1592221       1 /root/searcher/venv/bin/pyt  0.2  0.8
```


### Service Dependencies

Can't say nothing about it tbh

```
systemctl list-dependencies
```

```
default.target
○ ├─display-manager.service
○ ├─systemd-update-utmp-runlevel.service
● └─multi-user.target
●   ├─apport.service
●   ├─atd.service
●   ├─console-setup.service
●   ├─containerd.service
●   ├─cron.service
●   ├─dbus.service
○   ├─dmesg.service
●   ├─docker.service
○   ├─e2scrub_reap.service
●   ├─elasticsearch.service
●   ├─fail2ban.service
○   ├─grub-common.service
○   ├─grub-initrd-fallback.service
●   ├─lxd-installer.socket
●   ├─mosquitto.service
○   ├─networkd-dispatcher.service
○   ├─open-vm-tools.service
●   ├─plymouth-quit-wait.service
●   ├─plymouth-quit.service
○   ├─pollinate.service
●   ├─postgresql.service
●   ├─rsyslog.service
●   ├─snapd.apparmor.service
○   ├─snapd.autoimport.service
○   ├─snapd.core-fixup.service
○   ├─snapd.recovery-chooser-trigger.service
●   ├─snapd.seeded.service
○   ├─snapd.service
○   ├─ssl-cert.service
●   ├─sysstat.service
●   ├─systemd-ask-password-wall.path
●   ├─systemd-logind.service
●   ├─systemd-networkd.service
○   ├─systemd-update-utmp-runlevel.service
●   ├─systemd-user-sessions.service
●   ├─thermald.service
○   ├─ua-reboot-cmds.service
○   ├─ubuntu-advantage.service
●   ├─ufw.service
●   ├─unattended-upgrades.service
●   ├─basic.target
●   │ ├─-.mount
○   │ ├─tmp.mount
●   │ ├─paths.target
●   │ │ ├─acpid.path
○   │ │ ├─apport-autoreport.path
○   │ │ └─tpm-udev.path
●   │ ├─slices.target
●   │ │ ├─-.slice
●   │ │ └─system.slice
●   │ ├─sockets.target
●   │ │ ├─acpid.socket
○   │ │ ├─apport-forward.socket
●   │ │ ├─dbus.socket
●   │ │ ├─dm-event.socket
●   │ │ ├─docker.socket
●   │ │ ├─iscsid.socket
●   │ │ ├─multipathd.socket
●   │ │ ├─snapd.socket
●   │ │ ├─ssh.socket
●   │ │ ├─systemd-initctl.socket
●   │ │ ├─systemd-journald-dev-log.socket
●   │ │ ├─systemd-journald.socket
●   │ │ ├─systemd-networkd.socket
○   │ │ ├─systemd-pcrextend.socket
●   │ │ ├─systemd-sysext.socket
●   │ │ ├─systemd-udevd-control.socket
●   │ │ ├─systemd-udevd-kernel.socket
●   │ │ └─uuidd.socket
●   │ ├─sysinit.target
●   │ │ ├─apparmor.service
●   │ │ ├─blk-availability.service
●   │ │ ├─dev-hugepages.mount
●   │ │ ├─dev-mqueue.mount
●   │ │ ├─finalrd.service
●   │ │ ├─keyboard-setup.service
●   │ │ ├─kmod-static-nodes.service
○   │ │ ├─ldconfig.service
●   │ │ ├─lvm2-lvmpolld.socket
●   │ │ ├─lvm2-monitor.service
●   │ │ ├─multipathd.service
○   │ │ ├─open-iscsi.service
●   │ │ ├─plymouth-read-write.service
○   │ │ ├─plymouth-start.service
●   │ │ ├─proc-sys-fs-binfmt_misc.automount
●   │ │ ├─setvtrgb.service
●   │ │ ├─sys-fs-fuse-connections.mount
●   │ │ ├─sys-kernel-config.mount
●   │ │ ├─sys-kernel-debug.mount
●   │ │ ├─sys-kernel-tracing.mount
●   │ │ ├─systemd-ask-password-console.path
●   │ │ ├─systemd-binfmt.service
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
●   │ │ ├─systemd-random-seed.service
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
●   │ │ │ ├─-.mount
●   │ │ │ ├─boot-efi.mount
●   │ │ │ ├─boot.mount
●   │ │ │ └─systemd-remount-fs.service
●   │ │ ├─swap.target
●   │ │ │ └─dev-disk-by\x2duuid-47264a91\x2dba2c\x2d4589\x2da9e1\x2d48f4186b4fb4.swap
●   │ │ └─veritysetup.target
●   │ └─timers.target
○   │   ├─apport-autoreport.timer
●   │   ├─apt-daily-upgrade.timer
●   │   ├─apt-daily.timer
●   │   ├─dpkg-db-backup.timer
●   │   ├─e2scrub_all.timer
●   │   ├─fstrim.timer
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
●   │ └─getty@tty1.service
●   └─remote-fs.target
```


```
systemctl list-dependencies multi-user.target
```

```
multi-user.target
● ├─apport.service
● ├─atd.service
● ├─console-setup.service
● ├─containerd.service
● ├─cron.service
● ├─dbus.service
○ ├─dmesg.service
● ├─docker.service
○ ├─e2scrub_reap.service
● ├─elasticsearch.service
● ├─fail2ban.service
○ ├─grub-common.service
○ ├─grub-initrd-fallback.service
● ├─lxd-installer.socket
● ├─mosquitto.service
○ ├─networkd-dispatcher.service
○ ├─open-vm-tools.service
● ├─plymouth-quit-wait.service
● ├─plymouth-quit.service
○ ├─pollinate.service
● ├─postgresql.service
● ├─rsyslog.service
● ├─snapd.apparmor.service
○ ├─snapd.autoimport.service
○ ├─snapd.core-fixup.service
○ ├─snapd.recovery-chooser-trigger.service
● ├─snapd.seeded.service
○ ├─snapd.service
○ ├─ssl-cert.service
● ├─sysstat.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
● ├─systemd-networkd.service
○ ├─systemd-update-utmp-runlevel.service
● ├─systemd-user-sessions.service
● ├─thermald.service
○ ├─ua-reboot-cmds.service
○ ├─ubuntu-advantage.service
● ├─ufw.service
● ├─unattended-upgrades.service
● ├─basic.target
● │ ├─-.mount
○ │ ├─tmp.mount
● │ ├─paths.target
● │ │ ├─acpid.path
○ │ │ ├─apport-autoreport.path
○ │ │ └─tpm-udev.path
● │ ├─slices.target
● │ │ ├─-.slice
● │ │ └─system.slice
● │ ├─sockets.target
● │ │ ├─acpid.socket
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
● │ │ ├─systemd-networkd.socket
○ │ │ ├─systemd-pcrextend.socket
● │ │ ├─systemd-sysext.socket
● │ │ ├─systemd-udevd-control.socket
● │ │ ├─systemd-udevd-kernel.socket
● │ │ └─uuidd.socket
● │ ├─sysinit.target
● │ │ ├─apparmor.service
● │ │ ├─blk-availability.service
● │ │ ├─dev-hugepages.mount
● │ │ ├─dev-mqueue.mount
● │ │ ├─finalrd.service
● │ │ ├─keyboard-setup.service
● │ │ ├─kmod-static-nodes.service
○ │ │ ├─ldconfig.service
● │ │ ├─lvm2-lvmpolld.socket
● │ │ ├─lvm2-monitor.service
● │ │ ├─multipathd.service
○ │ │ ├─open-iscsi.service
● │ │ ├─plymouth-read-write.service
○ │ │ ├─plymouth-start.service
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
○ │ │ ├─systemd-journal-catalog-update.service
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
● │ │ │ ├─-.mount
● │ │ │ ├─boot-efi.mount
● │ │ │ ├─boot.mount
● │ │ │ └─systemd-remount-fs.service
● │ │ ├─swap.target
● │ │ │ └─dev-disk-by\x2duuid-47264a91\x2dba2c\x2d4589\x2da9e1\x2d48f4186b4fb4.swap
● │ │ └─veritysetup.target
● │ └─timers.target
○ │   ├─apport-autoreport.timer
● │   ├─apt-daily-upgrade.timer
● │   ├─apt-daily.timer
● │   ├─dpkg-db-backup.timer
● │   ├─e2scrub_all.timer
● │   ├─fstrim.timer
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
● │ └─getty@tty1.service
● └─remote-fs.target
```


### User Sessions

System started at May 18 and did't restarted, here I got a lot of unfinished sessions, it can be considered as problem maybe, i should check it, maybe I should consider automatic logout.


```
who -a
```

```
           system boot  2025-05-18 10:52
LOGIN      tty1         2025-05-18 10:52              1386 id=tty1
           run-level 5  2025-05-18 10:53
           pts/0        2025-05-18 13:11              2749 id=ts/0  term=0 exit=0
           pts/15       2025-05-23 22:16            367618 id=s/15  term=0 exit=0
           pts/22       2025-05-28 01:04            653580 id=s/22  term=0 exit=0
           pts/9        2025-07-05 10:23           2769582 id=ts/9  term=0 exit=0
           pts/16       2025-06-09 14:43           1402086 id=s/16  term=0 exit=0
           pts/17       2025-06-08 10:36           1336413 id=s/17  term=0 exit=0
root     - pts/8        2025-07-05 00:23 20:11     2724057 (109.252.173.35)
           pts/25       2025-06-09 14:43           1402507 id=s/25  term=0 exit=0
           pts/31       2025-06-10 21:00           1511853 id=s/31  term=0 exit=0
           pts/32       2025-07-04 04:07           2661054 id=s/32  term=0 exit=0
           pts/10       2025-07-04 12:47           2682214 id=s/10  term=0 exit=0
           pts/34       2025-07-04 23:33           2720976 id=s/34  term=0 exit=0
           pts/36       2025-07-05 20:13           2832674 id=s/36  term=0 exit=0
           pts/37       2025-07-05 16:47           2809976 id=s/37  term=0 exit=0
           pts/38       2025-07-05 16:47           2811522 id=s/38  term=0 exit=0
```

```
last -n 5
```

Here we can find a lot of connections from same IP, because of script.

```
root     pts/36       <ip>             Sat Jul  5 20:13 - 20:13  (00:00)
root     pts/36       <ip>             Sat Jul  5 19:23 - 19:26  (00:03)
root     pts/36       <ip>             Sat Jul  5 17:55 - 17:57  (00:02)
root     pts/36       <ip>             Sat Jul  5 17:43 - 17:44  (00:01)
root     pts/38       <ip>             Sat Jul  5 16:47 - 16:47  (00:00)

wtmp begins Mon Feb 10 12:58:38 2025
```

### Memory Analysis

```
free -h
```

Toral memory is ~62 GiB

Actively using ~28 GiB

Free ~1.2 Gib and Available 34 Gib, which count buffers and cache also

High load on swap is the result of elasticsearch service utilization.

```
               total        used        free      shared  buff/cache   available
Mem:            62Gi        28Gi       1.2Gi       146Mi        33Gi        34Gi
Swap:           31Gi        24Gi       7.8Gi
```

```
cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
```

```
MemTotal:       65611940 kB
MemAvailable:   35773088 kB
SwapTotal:      33520636 kB
```


## Networking Analysys

### Network Path Tracing

```
traceroute github.com
```

1 - local hop 

2 - hop to helsinki hel1

3 - hop to frankfurt fra

then i got just * * *

time of hops increased after third from 0.5 to 20 ms

```
traceroute to github.com (140.82.121.4), 30 hops max, 60 byte packets
 1  static.xx.xx.xx.xx.clients.your-server.de (xx.xx.xx.xx)  0.538 ms  0.657 ms  0.515 ms
 2  core32.hel1.hetzner.com (213.239.237.157)  0.541 ms  0.391 ms  0.524 ms
 3  core8.fra.hetzner.com (213.239.224.153)  20.333 ms  20.326 ms core9.fra.hetzner.com (213.239.224.166)  20.250 ms
 4  140.82.127.140 (140.82.127.140)  27.187 ms  27.179 ms 140.82.127.142 (140.82.127.142)  28.092 ms
 5-30  * * *
```

```
dig github.com
```

```

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 19136
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 8, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             41      IN      A       140.82.121.4

;; AUTHORITY SECTION:
github.com.             752     IN      NS      dns4.p08.nsone.net.
github.com.             752     IN      NS      ns-1283.awsdns-32.org.
github.com.             752     IN      NS      ns-1707.awsdns-21.co.uk.
github.com.             752     IN      NS      ns-421.awsdns-52.com.
github.com.             752     IN      NS      ns-520.awsdns-01.net.
github.com.             752     IN      NS      dns1.p08.nsone.net.
github.com.             752     IN      NS      dns2.p08.nsone.net.
github.com.             752     IN      NS      dns3.p08.nsone.net.

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sat Jul 05 20:48:19 CEST 2025
;; MSG SIZE  rcvd: 278
```

### Packet Capture

```
sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
```

All packets go through loopback interface, uses local DNS resolver (systemd-resolved) 127.0.0.53.

Client asks for bith ipv4 and ipv6 addresses

So, dns traffic is local. I can find here additional re-request after 2 seconds, it needs for additional research.

```
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
21:01:29.353072 lo    In  IP 127.0.0.1.56979 > 127.0.0.53.53: 52577+ [1au] A? api.XXX.org. (45)
21:01:29.353084 lo    In  IP 127.0.0.1.56979 > 127.0.0.53.53: 18534+ [1au] AAAA? api.XXX.org. (45)
21:01:29.353213 lo    In  IP 127.0.0.53.53 > 127.0.0.1.56979: 52577 1/0/1 A 149.154.167.220 (61)
21:01:29.353260 lo    In  IP 127.0.0.53.53 > 127.0.0.1.56979: 18534 1/0/1 AAAA 2001:67c:4e8:f004::9 (73)
21:01:31.273876 lo    In  IP 127.0.0.1.35147 > 127.0.0.53.53: 3059+ [1au] A? api.XXX.org. (45)
5 packets captured
16 packets received by filter
0 packets dropped by kernel
```

### Reverse DNS

IP 8.8.4.4 (one of Google's public DNS) resolves successfully to the PTR record dns.google. — this means that this IP has a valid reverse DNS record.

IP 1.1.2.2 does not have a PTR record (response: NXDOMAIN). This means that this IP does not have a reverse DNS record configured, or it is hidden.

```
dig -x 8.8.4.4
```

```
; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 20211
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   41624   IN      PTR     dns.google.

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sat Jul 05 21:17:09 CEST 2025
;; MSG SIZE  rcvd: 73
```

```
dig -x 1.1.2.2
```

```
; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 49180
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.          IN      PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.         1963    IN      SOA     ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22240 7200 1800 604800 3600

;; Query time: 224 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sat Jul 05 21:17:22 CEST 2025
;; MSG SIZE  rcvd: 137

```

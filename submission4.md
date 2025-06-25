# Lab 4: Operating Systems & Networking Lab

All tasks for this lab will be performed on the Windows 11 OS with WSL 2 on Ubuntu.

## Task 1: Operating System Analysis

### 1.1: Boot Performance

1. **Analyze System Boot Time**:

Command:
```sh
systemd-analyze
```
Output:
```sh
Startup finished in 1.810s (userspace)
graphical.target reached after 1.781s in userspace
```

Command:
```sh
systemd-analyze blame
```
Output:
```sh
769ms docker.service
475ms snap.lxd.activate.service
474ms dev-sdc.device
278ms snapd.service
212ms containerd.service
182ms networkd-dispatcher.service
115ms systemd-resolved.service
106ms udisks2.service
90ms systemd-udev-trigger.service
86ms systemd-logind.service
85ms systemd-networkd.service
84ms snapd.seeded.service
78ms ModemManager.service
76ms user@1000.service
66ms ssh.service
59ms keyboard-setup.service
57ms e2scrub_reap.service
57ms systemd-udevd.service
49ms apport.service
48ms polkit.service
37ms systemd-journald.service
35ms systemd-journal-flush.service
34ms dev-hugepages.mount
33ms dev-mqueue.mount
32ms rsyslog.service
32ms sys-kernel-debug.mount
31ms sys-kernel-tracing.mount
28ms systemd-remount-fs.service
27ms systemd-networkd-wait-online.service
25ms kmod-static-nodes.service
24ms modprobe@chromeos_pstore.service
23ms modprobe@drm.service
22ms systemd-tmpfiles-setup.service
22ms modprobe@efi_pstore.service
21ms modprobe@fuse.service
21ms modprobe@pstore_blk.service
20ms modprobe@pstore_zone.service
20ms modprobe@ramoops.service
19ms ubuntu-fan.service
18ms binfmt-support.service
16ms systemd-sysctl.service
13ms plymouth-quit.service
12ms plymouth-read-write.service
12ms systemd-update-utmp.service
12ms systemd-user-sessions.service
12ms systemd-binfmt.service
12ms systemd-sysusers.service
12ms console-setup.service
11ms finalrd.service
11ms systemd-tmpfiles-setup-dev.service
11ms setvtrgb.service
11ms snap-core20-1587.mount
7ms snap-lxd-22923.mount
7ms docker.socket
7ms snap-snapd-16292.mount
6ms user-runtime-dir@1000.service
6ms ufw.service
6ms systemd-update-utmp-runlevel.service
4ms snap.mount
4ms plymouth-quit-wait.service
3ms modprobe@configfs.service
3ms sys-fs-fuse-connections.mount
2ms snapd.socket
90us blk-availability.service
```

**Conclusion**:
The system boots in under 2 seconds to graphical.target, which indicates excellent performance. However, container and Snap-related services contribute disproportionately to total boot time, with docker.service, snap.lxd.activate.service, and snapd.service being the top three delays. Optimizing or disabling unneeded Snap services or containers could reduce boot time further.

2. **Check System Load**:

Command:
```sh
uptime
```
Output:
```sh
00:39:09 up 12 min,  1 user,  load average: 0.00, 0.00, 0.00
```

Command:
```sh
w
```
Output:
```sh
00:39:12 up 12 min,  1 user,  load average: 0.00, 0.00, 0.00
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
nikolay  pts/1    -                00:26   12:54   0.02s  0.01s -bash
```

**Conclusion**:

The system has been up for 12 minutes with a single active user (nikolay). Load averages are consistently 0.00, indicating no CPU demand or system contention. The user is logged in via a local pseudoterminal and is idle, running a basic Bash shell. The system is in a clean, low-activity state.

### 1.2: Process Forensics

1. **Identify Resource-Intensive Processes**:

Command:
```sh
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
```
Output:
```sh
    PID    PPID CMD                         %MEM %CPU
    410       1 /usr/bin/dockerd -H fd:// -  0.8  0.0
    322       1 /usr/bin/containerd          0.5  0.2
    162       1 /usr/lib/snapd/snapd         0.3  0.0
    315       1 /usr/bin/python3 /usr/share  0.2  0.0
    159       1 /usr/bin/python3 /usr/bin/n  0.2  0.0
```

Command:
```sh
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
```
Output:
```sh
    PID    PPID CMD                         %MEM %CPU
    322       1 /usr/bin/containerd          0.5  0.2
      1       0 /sbin/init                   0.1  0.0
      2       1 /init                        0.0  0.0
      6       2 plan9 --control-socket 7 --  0.0  0.0
     55       1 /lib/systemd/systemd-journa  0.1  0.0
```

**Conclusion**:
The system exhibits minimal resource usage, with all active processes being system-level daemons. dockerd consumes the most memory (0.8%), while containerd is the only process using noticeable CPU (0.2%). No runaway tasks or high-impact applications are present.

### 1.3: Service Dependencies

1. **Map Service Relationships**:

Command:
```sh
systemctl list-dependencies
```
Output:
```sh
default.target
● ├─apport.service
○ ├─display-manager.service
○ ├─systemd-update-utmp-runlevel.service
● ├─udisks2.service
○ ├─wslg.service
● └─multi-user.target
●   ├─apport.service
●   ├─binfmt-support.service
●   ├─console-setup.service
●   ├─containerd.service
●   ├─cron.service
●   ├─dbus.service
○   ├─dmesg.service
●   ├─docker.service
○   ├─e2scrub_reap.service
○   ├─irqbalance.service
○   ├─lxd-agent.service
●   ├─ModemManager.service
●   ├─networkd-dispatcher.service
○   ├─open-vm-tools.service
●   ├─plymouth-quit-wait.service
●   ├─plymouth-quit.service
○   ├─pollinate.service
●   ├─rsyslog.service
○   ├─secureboot-db.service
●   ├─snap-core20-1587.mount
●   ├─snap-lxd-22923.mount
●   ├─snap-snapd-16292.mount
○   ├─snap.lxd.activate.service
○   ├─snapd.aa-prompt-listener.service
○   ├─snapd.apparmor.service
○   ├─snapd.autoimport.service
○   ├─snapd.core-fixup.service
○   ├─snapd.recovery-chooser-trigger.service
●   ├─snapd.seeded.service
●   ├─snapd.service
●   ├─ssh.service
●   ├─systemd-ask-password-wall.path
●   ├─systemd-logind.service
●   ├─systemd-networkd.service
●   ├─systemd-resolved.service
○   ├─systemd-update-utmp-runlevel.service
●   ├─systemd-user-sessions.service
○   ├─ua-reboot-cmds.service
○   ├─ubuntu-advantage.service
●   ├─ubuntu-fan.service
●   ├─ufw.service
●   ├─unattended-upgrades.service
●   ├─basic.target
●   │ ├─-.mount
○   │ ├─tmp.mount
●   │ ├─paths.target
○   │ │ └─apport-autoreport.path
●   │ ├─slices.target
●   │ │ ├─-.slice
●   │ │ └─system.slice
●   │ ├─sockets.target
●   │ │ ├─apport-forward.socket
●   │ │ ├─dbus.socket
●   │ │ ├─dm-event.socket
●   │ │ ├─docker.socket
●   │ │ ├─iscsid.socket
○   │ │ ├─multipathd.socket
●   │ │ ├─snap.lxd.daemon.unix.socket
●   │ │ ├─snap.lxd.user-daemon.unix.socket
●   │ │ ├─snapd.socket
●   │ │ ├─systemd-initctl.socket
●   │ │ ├─systemd-journald-audit.socket
●   │ │ ├─systemd-journald-dev-log.socket
●   │ │ ├─systemd-journald.socket
●   │ │ ├─systemd-networkd.socket
●   │ │ ├─systemd-udevd-control.socket
●   │ │ ├─systemd-udevd-kernel.socket
●   │ │ └─uuidd.socket
●   │ ├─sysinit.target
○   │ │ ├─apparmor.service
●   │ │ ├─blk-availability.service
●   │ │ ├─dev-hugepages.mount
●   │ │ ├─dev-mqueue.mount
●   │ │ ├─finalrd.service
●   │ │ ├─keyboard-setup.service
●   │ │ ├─kmod-static-nodes.service
●   │ │ ├─lvm2-lvmpolld.socket
○   │ │ ├─lvm2-monitor.service
○   │ │ ├─multipathd.service
○   │ │ ├─open-iscsi.service
●   │ │ ├─plymouth-read-write.service
○   │ │ ├─plymouth-start.service
○   │ │ ├─proc-sys-fs-binfmt_misc.automount
●   │ │ ├─setvtrgb.service
●   │ │ ├─sys-fs-fuse-connections.mount
○   │ │ ├─sys-kernel-config.mount
●   │ │ ├─sys-kernel-debug.mount
●   │ │ ├─sys-kernel-tracing.mount
●   │ │ ├─systemd-ask-password-console.path
●   │ │ ├─systemd-binfmt.service
○   │ │ ├─systemd-boot-system-token.service
●   │ │ ├─systemd-journal-flush.service
●   │ │ ├─systemd-journald.service
○   │ │ ├─systemd-machine-id-commit.service
○   │ │ ├─systemd-modules-load.service
○   │ │ ├─systemd-pstore.service
○   │ │ ├─systemd-random-seed.service
●   │ │ ├─systemd-sysctl.service
●   │ │ ├─systemd-sysusers.service
○   │ │ ├─systemd-timesyncd.service
●   │ │ ├─systemd-tmpfiles-setup-dev.service
●   │ │ ├─systemd-tmpfiles-setup.service
●   │ │ ├─systemd-udev-trigger.service
●   │ │ ├─systemd-udevd.service
●   │ │ ├─systemd-update-utmp.service
●   │ │ ├─cryptsetup.target
●   │ │ ├─local-fs.target
●   │ │ │ ├─-.mount
○   │ │ │ ├─systemd-fsck-root.service
×   │ │ │ └─systemd-remount-fs.service
●   │ │ ├─swap.target
●   │ │ └─veritysetup.target
●   │ └─timers.target
○   │   ├─apport-autoreport.timer
●   │   ├─apt-daily-upgrade.timer
●   │   ├─apt-daily.timer
●   │   ├─dpkg-db-backup.timer
●   │   ├─e2scrub_all.timer
○   │   ├─fstrim.timer
○   │   ├─fwupd-refresh.timer
●   │   ├─logrotate.timer
●   │   ├─man-db.timer
●   │   ├─motd-news.timer
○   │   ├─snapd.snap-repair.timer
●   │   ├─systemd-tmpfiles-clean.timer
●   │   ├─ua-timer.timer
●   │   ├─update-notifier-download.timer
●   │   └─update-notifier-motd.timer
●   ├─getty.target
●   │ ├─console-getty.service
○   │ ├─getty-static.service
●   │ └─getty@tty1.service
●   └─remote-fs.target
```

Command:
```sh
systemctl list-dependencies multi-user.target
```
Output:
```sh
multi-user.target
● ├─apport.service
● ├─binfmt-support.service
● ├─console-setup.service
● ├─containerd.service
● ├─cron.service
● ├─dbus.service
○ ├─dmesg.service
● ├─docker.service
○ ├─e2scrub_reap.service
○ ├─irqbalance.service
○ ├─lxd-agent.service
● ├─ModemManager.service
● ├─networkd-dispatcher.service
○ ├─open-vm-tools.service
● ├─plymouth-quit-wait.service
● ├─plymouth-quit.service
○ ├─pollinate.service
● ├─rsyslog.service
○ ├─secureboot-db.service
● ├─snap-core20-1587.mount
● ├─snap-lxd-22923.mount
● ├─snap-snapd-16292.mount
○ ├─snap.lxd.activate.service
○ ├─snapd.aa-prompt-listener.service
○ ├─snapd.apparmor.service
○ ├─snapd.autoimport.service
○ ├─snapd.core-fixup.service
○ ├─snapd.recovery-chooser-trigger.service
● ├─snapd.seeded.service
● ├─snapd.service
● ├─ssh.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
● ├─systemd-networkd.service
● ├─systemd-resolved.service
○ ├─systemd-update-utmp-runlevel.service
● ├─systemd-user-sessions.service
○ ├─ua-reboot-cmds.service
○ ├─ubuntu-advantage.service
● ├─ubuntu-fan.service
● ├─ufw.service
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
● │ │ ├─apport-forward.socket
● │ │ ├─dbus.socket
● │ │ ├─dm-event.socket
● │ │ ├─docker.socket
● │ │ ├─iscsid.socket
○ │ │ ├─multipathd.socket
● │ │ ├─snap.lxd.daemon.unix.socket
● │ │ ├─snap.lxd.user-daemon.unix.socket
● │ │ ├─snapd.socket
● │ │ ├─systemd-initctl.socket
● │ │ ├─systemd-journald-audit.socket
● │ │ ├─systemd-journald-dev-log.socket
● │ │ ├─systemd-journald.socket
● │ │ ├─systemd-networkd.socket
● │ │ ├─systemd-udevd-control.socket
● │ │ ├─systemd-udevd-kernel.socket
● │ │ └─uuidd.socket
● │ ├─sysinit.target
○ │ │ ├─apparmor.service
● │ │ ├─blk-availability.service
● │ │ ├─dev-hugepages.mount
● │ │ ├─dev-mqueue.mount
● │ │ ├─finalrd.service
● │ │ ├─keyboard-setup.service
● │ │ ├─kmod-static-nodes.service
● │ │ ├─lvm2-lvmpolld.socket
○ │ │ ├─lvm2-monitor.service
○ │ │ ├─multipathd.service
○ │ │ ├─open-iscsi.service
● │ │ ├─plymouth-read-write.service
○ │ │ ├─plymouth-start.service
○ │ │ ├─proc-sys-fs-binfmt_misc.automount
● │ │ ├─setvtrgb.service
● │ │ ├─sys-fs-fuse-connections.mount
○ │ │ ├─sys-kernel-config.mount
● │ │ ├─sys-kernel-debug.mount
● │ │ ├─sys-kernel-tracing.mount
● │ │ ├─systemd-ask-password-console.path
● │ │ ├─systemd-binfmt.service
○ │ │ ├─systemd-boot-system-token.service
● │ │ ├─systemd-journal-flush.service
● │ │ ├─systemd-journald.service
○ │ │ ├─systemd-machine-id-commit.service
○ │ │ ├─systemd-modules-load.service
○ │ │ ├─systemd-pstore.service
○ │ │ ├─systemd-random-seed.service
● │ │ ├─systemd-sysctl.service
● │ │ ├─systemd-sysusers.service
○ │ │ ├─systemd-timesyncd.service
● │ │ ├─systemd-tmpfiles-setup-dev.service
● │ │ ├─systemd-tmpfiles-setup.service
● │ │ ├─systemd-udev-trigger.service
● │ │ ├─systemd-udevd.service
● │ │ ├─systemd-update-utmp.service
● │ │ ├─cryptsetup.target
● │ │ ├─local-fs.target
● │ │ │ ├─-.mount
○ │ │ │ ├─systemd-fsck-root.service
× │ │ │ └─systemd-remount-fs.service
● │ │ ├─swap.target
● │ │ └─veritysetup.target
● │ └─timers.target
○ │   ├─apport-autoreport.timer
● │   ├─apt-daily-upgrade.timer
● │   ├─apt-daily.timer
● │   ├─dpkg-db-backup.timer
● │   ├─e2scrub_all.timer
○ │   ├─fstrim.timer
○ │   ├─fwupd-refresh.timer
● │   ├─logrotate.timer
● │   ├─man-db.timer
● │   ├─motd-news.timer
○ │   ├─snapd.snap-repair.timer
● │   ├─systemd-tmpfiles-clean.timer
● │   ├─ua-timer.timer
● │   ├─update-notifier-download.timer
● │   └─update-notifier-motd.timer
● ├─getty.target
● │ ├─console-getty.service
○ │ ├─getty-static.service
● │ └─getty@tty1.service
● └─remote-fs.target
```

**Conclusion**:
The `multi-user.target` orchestrates the system's core service stack, including networking, security, container runtimes, Snap-based service mounts, and scheduled jobs. Services like `docker`, `snapd`, `containerd`, and `ModemManager` are all actively managed. Several optional services are listed but inactive. One service (`systemd-remount-fs.service`) is marked as failed, although it doesn’t impact current functionality. Overall, the system dependency tree appears coherent and stable, with a moderate reliance on Snap and container technologies due to using WSL.

### 1.4: User Sessions

1. **Audit Login Activity**:

Command:
```sh
who -a
```
Output:
```sh
           system boot  2025-06-26 00:26
           run-level 5  2025-06-26 00:26
LOGIN      tty1         2025-06-26 00:26               380 id=tty1
LOGIN      console      2025-06-26 00:26               365 id=cons
nikolay  - pts/1        2025-06-26 00:26 00:26         762
           pts/2        2025-06-26 00:28               775 id=ts/2  term=0 exit=0
```

Command:
```sh
last -n 5
```
Output:
```sh
nikolay  pts/1                         Thu Jun 26 00:26   still logged in
reboot   system boot  6.6.87.2-microso Thu Jun 26 00:26   still running
nikolay  pts/1                         Thu Jun 26 00:22 - crash  (00:04)
reboot   system boot  6.6.87.2-microso Thu Jun 26 00:22   still running

wtmp begins Thu Jun 26 00:22:09 2025
```

**Conclusion**:
The system has undergone two recent boots within a short window, due to a controlled restart after introduced changes to the WSL configuration. The current session by user `nikolay` has been active since the last boot (00:26) and remains stable. All login activity is local and legitimate, with no indication of unauthorized access or unusual behavior. The use of TTYs and pseudoterminals is consistent with terminal-based WSL operation.

### 1.5: Memory Analysis

1. **Inspect Memory Allocation**:

Command:
```sh
free -h
```
Output:
```sh
               total        used        free      shared  buff/cache   available
Mem:           7.8Gi       421Mi       7.0Gi       3.0Mi       329Mi       7.2Gi
Swap:             0B          0B          0B
```

Command:
```sh
cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
```
Output:
```sh
MemTotal:        8132828 kB
MemAvailable:    7546132 kB
SwapTotal:             0 kB
```

**Conclusion**:
The system is allocated approximately 8 GiB of RAM, of which less than 0.5 GiB is currently used. With over 7 GiB available, there is no memory pressure. Swap space is disabled (0 kB), as I have set it so in the WSL configuration. The high available memory and low usage align with prior findings of low process and system load.

## Task 2: Networking Analysis

### 2.1: Network Path Tracing

1. **Traceroute Execution**:

Command:
```sh
traceroute github.com
```
Output:
```sh
traceroute to github.com (140.82.121.3), 64 hops max
  1   192.168.160.XXX  0.306ms  0.171ms  0.139ms
  2   10.91.48.XXX  3.622ms  2.233ms  2.598ms
  3   10.252.6.XXX  3.228ms  3.248ms  *
  4   188.170.164.34  408.333ms  12.281ms  *
  5   *  *  *
  6   *  *  *
  7   *  *  *
  8   *  *  *
  9   *  83.169.204.78  73.488ms  53.665ms
 10   194.68.128.180  74.604ms  353.310ms  98.799ms
 11   94.103.180.3  85.408ms  54.659ms  92.001ms
 12   94.103.180.2  55.709ms  119.323ms  78.753ms
 13   *  *  *
 14   *  *  *
 15   *  *  *
 16   *  *  *
 17   94.103.180.24  81.122ms  *  1034.252ms
 18   45.153.82.39  63.223ms  141.072ms  94.532ms
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

**Conclusion**:
The traceroute to `github.com` (IP: 140.82.121.3) traverses at least 18 visible hops before responses are blocked. The route passes through local NAT (192.168.x, 10.x), internal ISP routers, and multiple public IPs associated with intermediate carriers. Latency is low overall but spikes at hop 4 and hop 17, possibly due to congestion or peering delays. The final destination is not reached, likely due to GitHub’s network dropping ICMP traceroute probes. No routing loops or failures are evident up to hop 18.

2. **DNS Resolution Check**:

Command:
```sh
dig github.com
```
Output:
```sh
; <<>> DiG 9.18.1-1ubuntu1.3-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 32806
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             32      IN      A       140.82.121.4

;; Query time: 475 msec
;; SERVER: 10.255.255.XXX#53(10.255.255.XXX) (UDP)
;; WHEN: Thu Jun 26 01:23:31 MSK 2025
;; MSG SIZE  rcvd: 55
```

**Conclusion**:
The DNS query for `github.com` successfully resolved to the IPv4 address 140.82.121.4, with a TTL of 32 seconds and a total resolution time of 475 ms. The DNS server used (10.255.255.XXX) is likely a local or ISP-provided resolver within a NATed environment. The low TTL suggests that GitHub dynamically balances client traffic through distributed CDN nodes. The resolution status `NOERROR` confirms a valid response, and no signs of DNS misconfiguration or hijacking were observed.

### 2.2: Packet Capture

1. **Capture DNS Traffic**:

Command:
```sh
sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
```
Output:
```sh
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
01:28:02.684769 lo    In  IP 10.255.255.XXX.58048 > 10.255.255.XXX.53: 19160+ [1au] A? github.com. (51)
01:28:02.823517 lo    In  IP 10.255.255.XXX.53 > 10.255.255.XXX.58048: 19160 1/0/1 A 140.82.121.4 (55)

2 packets captured
4 packets received by filter
0 packets dropped by kernel
```

**Conclusion**:
Two DNS packets were captured during a live query for github.com. Both packets were exchanged locally over the loopback interface, indicating the use of a local DNS forwarder or resolver (IP: `10.255.255.XXX`). The query was for an A record, and the response returned a valid IPv4 address `140.82.121.4` within 139 milliseconds. This demonstrates successful DNS resolution and highlights the use of internal DNS infrastructure within the WSL networking environment.

### 2.3: Reverse DNS

1. **Perform PTR Lookups**:

Command:
```sh
dig -x 8.8.4.4
```
Output:
```sh
; <<>> DiG 9.18.1-1ubuntu1.3-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 35575
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   65922   IN      PTR     dns.google.

;; Query time: 147 msec
;; SERVER: 10.255.255.XXX#53(10.255.255.XXX) (UDP)
;; WHEN: Thu Jun 26 01:30:43 MSK 2025
;; MSG SIZE  rcvd: 73
```

Command:
```sh
dig -x 1.1.2.2
```
Output:
```sh
; <<>> DiG 9.18.1-1ubuntu1.3-Ubuntu <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 55004
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.          IN      PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.         900     IN      SOA     ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22226 7200 1800 604800 3600

;; Query time: 515 msec
;; SERVER: 10.255.255.XXX#53(10.255.255.XXX) (UDP)
;; WHEN: Thu Jun 26 01:31:25 MSK 2025
;; MSG SIZE  rcvd: 137
```

**Conclusion**:
A successful reverse DNS lookup on `8.8.4.4` yielded `dns.google.`, confirming Google’s proper configuration of PTR records for public DNS infrastructure. In contrast, the lookup on `1.1.2.2` returned an NXDOMAIN, indicating the absence of a PTR record despite a valid authority zone (`ns.apnic.net`). This is typical for non-public or minimally maintained IP addresses. The resolution time for both queries was reasonable, with no signs of DNS failure or misrouting.
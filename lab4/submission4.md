# Operating Systems & Networking Lab

In this lab, you'll analyze operating system fundamentals including boot performance, resource utilization, and service dependencies, while conducting network diagnostics through path tracing, DNS inspection, and packet capture to develop core DevOps infrastructure skills.

Lab setup information:

```bash
sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ hostnamectl
 Static hostname: sam-home-pc
       Icon name: computer-container
         Chassis: container ☐
      Machine ID: 779f24b620a6401690e14619791396d2
         Boot ID: ec5fc1e915fe47d586fb6f5d927c1c27
  Virtualization: wsl
Operating System: Ubuntu 24.04.2 LTS
          Kernel: Linux 5.15.153.1-microsoft-standard-WSL2
    Architecture: x86-64
```

## Task 1: Operating System Analysis

**Objective**: Analyze key OS components including boot performance, resource usage, services, sessions, and memory management.

1. **Analyze System Boot Time**:

    ```sh
    systemd-analyze
    systemd-analyze blame
    ```

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ systemd-analyze
    Startup finished in 1.240s (userspace) 
    graphical.target reached after 1.234s in userspace.
    ```

    Observation:
    - Boot time is extremely fast (~1.2s) — likely due to minimal services and WSL2 environment which skips firmware and full kernel boot.

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ systemd-analyze blame
    698ms landscape-client.service
    265ms snapd.seeded.service
    203ms snapd.service
    141ms wsl-pro.service
    135ms dev-sdc.device
    91ms systemd-journal-flush.service
    85ms systemd-resolved.service
    80ms user@1000.service
    78ms systemd-udev-trigger.service
    68ms rsyslog.service
    65ms systemd-tmpfiles-clean.service
    57ms systemd-udevd.service
    47ms mosquitto.service
    45ms systemd-logind.service
    41ms systemd-timesyncd.service
    36ms e2scrub_reap.service
    33ms dbus.service
    32ms keyboard-setup.service
    32ms systemd-journald.service
    20ms systemd-tmpfiles-setup-dev-early.service
    19ms systemd-tmpfiles-setup.service
    17ms dev-hugepages.mount
    17ms dev-mqueue.mount
    16ms sys-kernel-debug.mount
    16ms sys-kernel-tracing.mount
    13ms systemd-sysctl.service
    12ms modprobe@configfs.service
    11ms modprobe@dm_mod.service
    11ms systemd-modules-load.service
    11ms modprobe@drm.service
    10ms modprobe@efi_pstore.service
    10ms modprobe@fuse.service
    10ms modprobe@loop.service
    8ms systemd-remount-fs.service
    7ms setvtrgb.service
    6ms user-runtime-dir@1000.service
    6ms systemd-update-utmp.service
    6ms systemd-user-sessions.service
    5ms console-setup.service
    5ms systemd-tmpfiles-setup-dev.service
    4ms systemd-update-utmp-runlevel.service
    3ms wsl-binfmt.service
    3ms sys-fs-fuse-connections.mount
    754us snapd.socket
    ```

    Observation:
    - `landscape-client` is the slowest service (~700ms) — used for system monitoring and can be disabled if not needed.
    - `snapd` stack also contributes notably — common on Ubuntu systems.

2. **Check System Load**:

    ```sh
    uptime
    w
    ```

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ uptime
    19:23:49 up 27 min,  1 user,  load average: 0.00, 0.00, 0.00
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ w
    19:23:51 up 27 min,  1 user,  load average: 0.00, 0.00, 0.00
    USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU  WHAT
    sam      pts/1    -                18:56   27:43   0.01s  0.01s -bash
    ```

    Observation:
    - Load average is idle (0.00) — system is under no stress.
    - One active user session (sam), idle for 27 minutes.

### 1.2: Process Forensics

1. **Identify Resource-Intensive Processes**:

   ```sh
   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
   ```

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    PID    PPID CMD                         %MEM %CPU
    201       1 /usr/bin/python3 /usr/share  0.1  0.0
     52       1 /usr/lib/systemd/systemd-jo  0.1  0.0
    162       1 /usr/libexec/wsl-pro-servic  0.0  0.0
      1       0 /sbin/init                   0.0  0.0
    140       1 /usr/lib/systemd/systemd-re  0.0  0.0
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    PID    PPID CMD                         %MEM %CPU
      1       0 /sbin/init                   0.0  0.0
    176       1 /usr/sbin/mosquitto -c /etc  0.0  0.0
     94       1 /usr/lib/systemd/systemd-ud  0.0  0.0
    151       1 @dbus-daemon --system --add  0.0  0.0
     52       1 /usr/lib/systemd/systemd-jo  0.1  0.0
   ```

    Observation:
    - Top memory-consuming process: Python3 script (PID 201) using 0.1% memory.
    - No process currently consumes measurable CPU — consistent with system idling.
    - Most active daemon is mosquitto, a lightweight MQTT broker (I used it in my test project).

### 1.3: Service Dependencies

1. **Map Service Relationships**:

    ```sh
    systemctl list-dependencies
    systemctl list-dependencies multi-user.target
    ```

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ systemctl list-dependencies
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
    ●   ├─mosquitto.service
    ○   ├─networkd-dispatcher.service
    ●   ├─rsyslog.service
    ○   ├─snapd.apparmor.service
    ○   ├─snapd.autoimport.service
    ○   ├─snapd.core-fixup.service
    ○   ├─snapd.recovery-chooser-trigger.service
    ●   ├─snapd.seeded.service
    ○   ├─snapd.service
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

    Observation:
    - `default.target` links to `multi-user.target`, indicating headless or minimal graphical environment.
    - Core services: `snapd`, `mosquitto`, `dbus`, `rsyslog`, `cron`, `unattended-upgrades`.

    WSL-Specific Insight:
    - Services like `wsl-pro.service` and `systemd-logind.service` are adapted for WSL2.
    - No traditional `network.target` or `display-manager.service` active — aligned with containerized behavior.

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ systemctl list-dependencies multi-user.target
    multi-user.target
    ○ ├─apport.service
    ● ├─console-setup.service
    ● ├─cron.service
    ● ├─dbus.service
    ○ ├─dmesg.service
    ○ ├─e2scrub_reap.service
    ○ ├─landscape-client.service
    ● ├─mosquitto.service
    ○ ├─networkd-dispatcher.service
    ● ├─rsyslog.service
    ○ ├─snapd.apparmor.service
    ○ ├─snapd.autoimport.service
    ○ ├─snapd.core-fixup.service
    ○ ├─snapd.recovery-chooser-trigger.service
    ● ├─snapd.seeded.service
    ○ ├─snapd.service
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

    Observation:
    - Encompasses essential daemons like `cron`, `dbus`, `rsyslog`, and time sync.
    - Several systemd timers (e.g., `apt-daily.timer`, `logrotate.timer`) ensure periodic maintenance.
    - Snap-related services dominate dependency tree — typical of Ubuntu's default packaging system.

### 1.4: User Sessions

1. **Audit Login Activity**:

    ```sh
    who -a
    last -n 5
    ```

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ who -a
               system boot  2025-07-07 18:56
               run-level 5  2025-07-07 18:56
    LOGIN      tty1         2025-07-07 18:56               179 id=tty1
    LOGIN      console      2025-07-07 18:56               169 id=cons
    sam      - pts/1        2025-07-07 18:56 00:34         349
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ last -n 5
    reboot   system boot  5.15.153.1-micro Mon Jul  7 18:56   still running
    reboot   system boot  5.15.153.1-micro Mon Jul  7 13:00   still running
    reboot   system boot  5.15.153.1-micro Mon Jul  7 02:30   still running
    reboot   system boot  5.15.153.1-micro Mon Jul  7 00:42   still running
    reboot   system boot  5.15.153.1-micro Sun Jul  6 22:52   still running

    wtmp begins Tue Apr  1 07:37:07 2025
    ```

    Observation:
    - Frequent system reboots — likely due to WSL2 resets or container restarts.
    - One persistent user (sam) in this session.

### 1.5: Memory Analysis

1. **Inspect Memory Allocation**:

    ```sh
    free -h
    cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
    ```

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ free -h
                   total        used        free      shared  buff/cache   available
    Mem:            15Gi       631Mi        14Gi       3.0Mi       156Mi        14Gi
    Swap:          4.0Gi          0B       4.0Gi
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
    MemTotal:       16100540 kB
    MemAvailable:   15453740 kB
    SwapTotal:       4194304 kB
    ```

    Observation:
    - Very low memory usage (~4%) — consistent with idle system.
    - No swap in use — system has ample physical memory available.

    Answer:
    - No memory pressure observed.
    - Buff/cache usage is low (~150 MiB), indicating minimal disk operations.

## Task 2: Networking Analysis

**Objective**: Perform network diagnostics including path tracing, DNS inspection, packet capture, and reverse lookups.

### 2.1: Network Path Tracing

1. **Traceroute Execution**:

    ```sh
    traceroute github.com
    ```

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ traceroute github.com
    traceroute to github.com (140.82.121.4), 30 hops max, 60 byte packets                                                                                                                                      
    1  172.28.64.1 (172.28.64.1)  0.212 ms  0.198 ms  0.216 ms - WSL
    2  192.168.0.1 (192.168.0.1)  0.573 ms  0.773 ms  0.821 ms - my PC
    3  10.16.255.135 (10.16.255.135)  1.624 ms  1.489 ms  1.699 ms
    4  10.16.248.225 (10.16.248.225)  1.589 ms 10.16.249.41 (10.16.249.41)  2.121 ms 10.16.248.209 (10.16.248.209)  1.870 ms
    5  10.16.248.150 (10.16.248.150)  1.944 ms 10.16.248.218 (10.16.248.218)  3.822 ms 10.16.248.206 (10.16.248.206)  3.874 ms
    6  10.16.248.130 (10.16.248.130)  2.236 ms 10.16.248.253 (10.16.248.253)  1.732 ms 10.16.248.134 (10.16.248.134)  1.638 ms
    7  188.254.80.85 (188.254.80.85)  14.144 ms 188.254.80.81 (188.254.80.81)  15.225 ms 188.254.80.85 (188.254.80.85)  14.053 ms
    8  95.167.92.165 (95.167.92.165)  23.627 ms 95.167.92.161 (95.167.92.161)  24.024 ms  23.719 ms - ROSTELECOMNET
    9  * * *
    10  217.161.68.33 (217.161.68.33)  60.609 ms  60.589 ms  60.581 ms
    11  * * *
    12  github-ic-350972.ip.twelve99-cust.net (62.115.182.171)  60.078 ms  59.490 ms  59.528 ms - VODAFONE
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

    Anakysis of the path:

    ```txt
    1  172.28.64.1         ← WSL internal virtual interface
    2  192.168.0.1         ← Local home router (gateway)
    3–6 10.16.x.x          ← Private ISP backbone subnets (RFC1918)
    7  188.254.80.X        ← Public IPs, likely ISP carrier-grade NAT (CG-NAT)
    8  95.167.92.X         ← Rostelecom network
    10 217.161.68.33       ← Tier-1/2 ISP transit provider
    12 62.115.182.171      ← Vodafone/Twelve99, GitHub’s CDN edge partner
    13–30 * * *            ← ICMP replies blocked (standard practice in production CDNs)
    ```

    Key Insight:
    - The network begins with WSL and NAT into your local router.
    - Then it traverses internal ISP infrastructure (10.x addresses).
    - Public routing appears at hop 7 with carrier NATed IPs.
    - Rostelecom is confirmed as the ISP, handing off to higher-tier transit.
    - GitHub likely uses ICMP filtering or firewalling at the edge to avoid diagnostics, hence the timeout from hop 13 onward.

2. **DNS Resolution Check**:

    ```sh
    dig github.com
    ```

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ dig github.com
                    
    ; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> github.com
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 58811
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 1232
    ;; QUESTION SECTION:
    ;github.com.                    IN      A

    ;; ANSWER SECTION:
    github.com.             27      IN      A       140.82.121.3

    ;; Query time: 10 msec
    ;; SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
    ;; WHEN: Mon Jul 07 20:13:00 MSK 2025
    ;; MSG SIZE  rcvd: 55
    ```

    Key Insight:
    - DNS is working properly and resolves GitHub’s A record (IPv4).
    - 10.255.255.254 is a private DNS resolver—could be internal ISP DNS.
    - The single A record suggests GitHub's GeoDNS is routing my to the nearest content distribution node.
    - Very fast response time (10 ms) implies local caching, either in my network or upstream.

### 2.2: Packet Capture

1. **Capture DNS Traffic**:

    ```sh
    sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
    ```

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
    tcpdump: data link type LINUX_SLL2
    tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
    listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes

    0 packets captured
    0 packets received by filter
    0 packets dropped by kernel`
    ```

    **Expected**: capture DNS (UDP/TCP port 53) traffic.
    **Result**: 0 packets captured.

    Reason: WSL2 Network Isolation
    > WSL2 runs in a lightweight VM, not a real Linux kernel attached to your physical network stack.

    That means:
    - Actual DNS queries never touch Linux interfaces (eth0, lo, etc.).
    - Instead, Windows handles DNS, and forwards results to WSL2.
    - As a result, tcpdump inside WSL2 doesn't see any traffic to/from port 53.

### 2.3: Reverse DNS

1. **Perform PTR Lookups**:

    ```sh
    dig -x 8.8.4.4
    dig -x 1.1.2.2
    ```

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ dig -x 8.8.4.4

    ; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> -x 8.8.4.4
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 5407
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 1232
    ;; QUESTION SECTION:
    ;4.4.8.8.in-addr.arpa.          IN      PTR

    ;; ANSWER SECTION:
    4.4.8.8.in-addr.arpa.   15295   IN      PTR     dns.google.

    ;; Query time: 0 msec
    ;; SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
    ;; WHEN: Tue Jul 08 23:38:43 MSK 2025
    ;; MSG SIZE  rcvd: 73

    ```

    This confirms Google properly maintains reverse DNS records for its public resolvers.

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ dig -x 1.1.2.2

    ; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> -x 1.1.2.2
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 22048
    ;; flags: qr rd ra ad; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 1232
    ;; QUESTION SECTION:
    ;2.2.1.1.in-addr.arpa.          IN      PTR

    ;; AUTHORITY SECTION:
    1.in-addr.arpa.         922     IN      SOA     ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22242 7200 1800 604800 3600

    ;; Query time: 69 msec
    ;; SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
    ;; WHEN: Tue Jul 08 23:39:44 MSK 2025
    ;; MSG SIZE  rcvd: 137
    ```

    The IP is from APNIC (Asia-Pacific Network Information Centre) and doesn’t resolve. This is expected for many non-public DNS servers or placeholders.

    ```bash
    sam@sam-home-pc:/mnt/c/Users/Admin/Sum25-intro-labs$ dig -x 77.88.8.3

    ; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> -x 77.88.8.3
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47167
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 1232
    ;; QUESTION SECTION:
    ;3.8.88.77.in-addr.arpa.                IN      PTR

    ;; ANSWER SECTION:
    3.8.88.77.in-addr.arpa. 30      IN      PTR     secondary.family.dns.yandex.ru.

    ;; Query time: 40 msec
    ;; SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
    ;; WHEN: Tue Jul 08 23:40:54 MSK 2025
    ;; MSG SIZE  rcvd: 95
    ```

    Yandex maintains PTRs for its recursive DNS servers. This helps with logging, filtering, and spam protection.

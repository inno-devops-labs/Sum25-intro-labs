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

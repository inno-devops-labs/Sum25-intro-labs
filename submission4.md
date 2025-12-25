# Lab work on operating systems and networks

## Task 1: Operating system analysis

The created action System Analysis was taken https://github.com/Kulikova-A18/Sum25-intro-labs/actions/runs/15816176937

### Let's look at the job boot_performance

```
Run echo "=== Boot Performance ==="
  echo "=== Boot Performance ==="
  echo "Systemd Analyze:"
  systemd-analyze
  echo "Blame:"
  systemd-analyze blame
  echo "Uptime:"
  uptime
  echo "Current Users:"
  w
  shell: /usr/bin/bash -e {0}
=== Boot Performance ===
Systemd Analyze:
Startup finished in 1.746s (kernel) + 13.160s (userspace) = 14.906s 
graphical.target reached after 12.657s in userspace.
Blame:
2.672s cloud-init.service
2.483s docker.service
2.457s cloud-init-local.service
1.452s cloud-config.service
1.290s systemd-networkd-wait-online.service
1.258s snapd.seeded.service
1.118s snapd.service
 939ms php8.3-fpm.service
 818ms dev-sdb1.device
 631ms containerd.service
 617ms phpsessionclean.service
 591ms walinuxagent-network-setup.service
 570ms user@1001.service
 546ms udisks2.service
 520ms chrony.service
 477ms podman-clean-transient.service
 475ms podman-restart.service
 467ms polkit.service
 449ms cloud-final.service
 432ms networkd-dispatcher.service
 405ms rsyslog.service
 390ms systemd-logind.service
 313ms ModemManager.service
 293ms grub-common.service
 235ms dpkg-db-backup.service
 201ms logrotate.service
 194ms user-runtime-dir@1001.service
 168ms systemd-udev-trigger.service
 154ms dev-hugepages.mount
 148ms dev-mqueue.mount
 143ms sys-kernel-debug.mount
 138ms sys-kernel-tracing.mount
 138ms nvmf-autoconnect.service
 137ms dbus.service
 137ms e2scrub_reap.service
 132ms apparmor.service
 131ms systemd-resolved.service
 127ms podman.service
 124ms systemd-journald.service
 122ms keyboard-setup.service
 111ms kmod-static-nodes.service
 110ms systemd-fsck-root.service
 104ms lvm2-monitor.service
  95ms modprobe@configfs.service
  89ms modprobe@dm_mod.service
  85ms systemd-modules-load.service
  82ms modprobe@drm.service
  82ms systemd-user-sessions.service
  76ms modprobe@efi_pstore.service
  76ms sphinxsearch.service
  71ms multipathd.service
  70ms modprobe@fuse.service
  67ms sysstat.service
  64ms modprobe@loop.service
  61ms systemd-udevd.service
  60ms systemd-binfmt.service
  59ms modprobe@nvme_fabrics.service
  52ms plymouth-quit.service
  52ms systemd-tmpfiles-setup.service
  50ms docker.socket
  48ms podman-auto-update.service
  47ms systemd-remount-fs.service
  46ms systemd-journal-flush.service
  43ms grub-initrd-fallback.service
  39ms systemd-fsck@dev-disk-by\x2duuid-B8E1\x2d3A86.service
  39ms plymouth-quit-wait.service
  33ms lxd-installer.socket
  32ms systemd-networkd.service
  32ms setvtrgb.service
  30ms plymouth-read-write.service
  30ms finalrd.service
  30ms systemd-tmpfiles-setup-dev-early.service
  30ms snapd.socket
  30ms sys-fs-fuse-connections.mount
  29ms console-setup.service
  26ms sys-kernel-config.mount
  24ms systemd-sysctl.service
  23ms snapd.apparmor.service
  23ms systemd-fsck@dev-disk-by\x2dlabel-BOOT.service
  21ms boot.mount
  21ms ufw.service
  15ms systemd-tmpfiles-setup-dev.service
  12ms systemd-random-seed.service
  12ms systemd-update-utmp-runlevel.service
  10ms systemd-update-utmp.service
   8ms proc-sys-fs-binfmt_misc.mount
   8ms boot-efi.mount
   7ms systemd-fsck@dev-disk-cloud-azure_resource\x2dpart1.service
   5ms ephemeral-disk-warning.service
   5ms e2scrub_all.service
  23us blk-availability.service
Uptime:
 05:38:51 up 5 min,  0 user,  load average: 0.08, 0.05, 0.02
Current Users:
 05:38:51 up 5 min,  0 user,  load average: 0.08, 0.05, 0.02
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU  WHAT
```

Systemd Analyze:

- Startup Time:
Total system boot time was 14.906 seconds, of which 1.746 seconds was kernel boot time and 13.160 seconds was user boot time.

- Graphical Target:
The graphical environment was reached in 12.657 seconds.

Blame:

A list of services and their startup times, indicating how long each service took during boot. The longest were:

- cloud-init.service: 2.672 seconds
- docker.service: 2.483 seconds
- cloud-init-local.service: 2.457 seconds

Uptime:

The system has been running for 5 minutes, with a current load average of 0.08, 0.05, 0.02.

Current Users:

There are currently no active users, the system has been loaded for 5 minutes.

### Let's look at job resource_intensive_processes

```
Run echo "=== Resource-Intensive Processes ==="
  echo "=== Resource-Intensive Processes ==="
  echo "Top Memory Consumers:"
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
  echo "Top CPU Consumers:"
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
  shell: /usr/bin/bash -e {0}
=== Resource-Intensive Processes ===
Top Memory Consumers:
    PID    PPID CMD                         %MEM %CPU
   1837     839 /opt/runner/provisioner/etc  1.0 32.4
   1865    1850 /home/runner/runners/2.325.  0.6 78.2
    839       1 /opt/runner/provisioner/pro  0.6  0.9
   1850     839 /home/runner/runners/2.325.  0.5 42.9
   1151       1 /usr/bin/dockerd -H fd:// -  0.4  0.0
Top CPU Consumers:
    PID    PPID CMD                         %MEM %CPU
   1865    1850 /home/runner/runners/2.325.  0.6 77.7
   1850     839 /home/runner/runners/2.325.  0.5 42.9
   1837     839 /opt/runner/provisioner/etc  1.0 32.3
      1       0 /sbin/init                   0.0  1.2
    839       1 /opt/runner/provisioner/pro  0.6  0.9
```

Top processes by memory consumption:

- Displays a list of processes sorted by memory usage (%MEM).
- Most resource-intensive processes:

1 Process with PID 1837 uses 1.0% of memory and 32.4% of CPU.

2 Process with PID 1865 uses 0.6% of memory and 78.2% of CPU.

3 Other processes with less consumption.

Top processes by CPU consumption:

- Displays a list of processes sorted by CPU usage (%CPU).
- Most resource-intensive processes:

1 Process with PID 1865 uses 0.6% of memory and 77.7% of CPU.

2 Process with PID 1850 uses 0.5% of memory and 42.9% of CPU.

3 Other processes with less consumption.

### View job service_dependencies

```
Run echo "=== Service Dependencies ==="
  echo "=== Service Dependencies ==="
  systemctl list-dependencies
  systemctl list-dependencies multi-user.target
  shell: /usr/bin/bash -e {0}
=== Service Dependencies ===
default.target
○ ├─display-manager.service
○ ├─nvmefc-boot-connections.service
○ ├─nvmf-autoconnect.service
○ ├─podman-auto-update.service
○ ├─podman-clean-transient.service
● ├─podman-restart.service
○ ├─podman.service
● ├─sphinxsearch.service
○ ├─systemd-update-utmp-runlevel.service
● ├─udisks2.service
● └─multi-user.target
○   ├─apport.service
●   ├─chrony.service
●   ├─console-setup.service
●   ├─containerd.service
●   ├─cron.service
●   ├─dbus.service
○   ├─dmesg.service
●   ├─docker.service
○   ├─e2scrub_reap.service
●   ├─ephemeral-disk-warning.service
○   ├─grub-common.service
○   ├─grub-initrd-fallback.service
○   ├─hv-fcopy-daemon.service
●   ├─hv-kvp-daemon.service
○   ├─hv-vss-daemon.service
●   ├─lxd-installer.socket
●   ├─ModemManager.service
●   ├─networkd-dispatcher.service
○   ├─open-vm-tools.service
●   ├─php8.3-fpm.service
●   ├─plymouth-quit-wait.service
●   ├─plymouth-quit.service
○   ├─pollinate.service
●   ├─rsyslog.service
●   ├─runner-provisioner.service
○   ├─secureboot-db.service
●   ├─snapd.apparmor.service
○   ├─snapd.autoimport.service
○   ├─snapd.core-fixup.service
○   ├─snapd.recovery-chooser-trigger.service
●   ├─snapd.seeded.service
○   ├─snapd.service
●   ├─sphinxsearch.service
○   ├─ssl-cert.service
●   ├─sysstat.service
●   ├─systemd-ask-password-wall.path
●   ├─systemd-logind.service
●   ├─systemd-networkd.service
○   ├─systemd-update-utmp-runlevel.service
●   ├─systemd-user-sessions.service
○   ├─ua-reboot-cmds.service
○   ├─ubuntu-advantage.service
●   ├─ufw.service
●   ├─walinuxagent.service
●   ├─basic.target
●   │ ├─-.mount
○   │ ├─tmp.mount
●   │ ├─paths.target
○   │ │ ├─apport-autoreport.path
○   │ │ └─tpm-udev.path
●   │ ├─slices.target
●   │ │ ├─-.slice
●   │ │ └─system.slice
●   │ ├─sockets.target
○   │ │ ├─apport-forward.socket
●   │ │ ├─dbus.socket
●   │ │ ├─dm-event.socket
●   │ │ ├─docker.socket
●   │ │ ├─iscsid.socket
●   │ │ ├─multipathd.socket
●   │ │ ├─podman.socket
●   │ │ ├─snapd.socket
●   │ │ ├─ssh.socket
●   │ │ ├─systemd-coredump.socket
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
●   │ │ ├─haveged.service
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
●   │ │ │ ├─systemd-fsck-root.service
●   │ │ │ └─systemd-remount-fs.service
●   │ │ ├─swap.target
●   │ │ └─veritysetup.target
●   │ └─timers.target
○   │   ├─apport-autoreport.timer
●   │   ├─dpkg-db-backup.timer
●   │   ├─e2scrub_all.timer
●   │   ├─fstrim.timer
○   │   ├─fwupd-refresh.timer
●   │   ├─logrotate.timer
●   │   ├─man-db.timer
●   │   ├─motd-news.timer
●   │   ├─phpsessionclean.timer
●   │   ├─podman-auto-update.timer
○   │   ├─snapd.snap-repair.timer
●   │   ├─systemd-tmpfiles-clean.timer
○   │   ├─ua-timer.timer
●   │   ├─update-notifier-download.timer
●   │   └─update-notifier-motd.timer
●   ├─cloud-init.target
●   │ ├─cloud-config.service
●   │ ├─cloud-final.service
●   │ ├─cloud-init-local.service
●   │ └─cloud-init.service
●   ├─getty.target
○   │ ├─getty-static.service
●   │ ├─getty@tty1.service
●   │ └─serial-getty@ttyS0.service
●   └─remote-fs.target
●     └─mnt.mount
multi-user.target
○ ├─apport.service
● ├─chrony.service
● ├─console-setup.service
● ├─containerd.service
● ├─cron.service
● ├─dbus.service
○ ├─dmesg.service
● ├─docker.service
○ ├─e2scrub_reap.service
● ├─ephemeral-disk-warning.service
○ ├─grub-common.service
○ ├─grub-initrd-fallback.service
○ ├─hv-fcopy-daemon.service
● ├─hv-kvp-daemon.service
○ ├─hv-vss-daemon.service
● ├─lxd-installer.socket
● ├─ModemManager.service
● ├─networkd-dispatcher.service
○ ├─open-vm-tools.service
● ├─php8.3-fpm.service
● ├─plymouth-quit-wait.service
● ├─plymouth-quit.service
○ ├─pollinate.service
● ├─rsyslog.service
● ├─runner-provisioner.service
○ ├─secureboot-db.service
● ├─snapd.apparmor.service
○ ├─snapd.autoimport.service
○ ├─snapd.core-fixup.service
○ ├─snapd.recovery-chooser-trigger.service
● ├─snapd.seeded.service
○ ├─snapd.service
● ├─sphinxsearch.service
○ ├─ssl-cert.service
● ├─sysstat.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
● ├─systemd-networkd.service
○ ├─systemd-update-utmp-runlevel.service
● ├─systemd-user-sessions.service
○ ├─ua-reboot-cmds.service
○ ├─ubuntu-advantage.service
● ├─ufw.service
● ├─walinuxagent.service
● ├─basic.target
● │ ├─-.mount
○ │ ├─tmp.mount
● │ ├─paths.target
○ │ │ ├─apport-autoreport.path
○ │ │ └─tpm-udev.path
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
● │ │ ├─podman.socket
● │ │ ├─snapd.socket
● │ │ ├─ssh.socket
● │ │ ├─systemd-coredump.socket
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
● │ │ ├─haveged.service
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
● │ │ │ ├─systemd-fsck-root.service
● │ │ │ └─systemd-remount-fs.service
● │ │ ├─swap.target
● │ │ └─veritysetup.target
● │ └─timers.target
○ │   ├─apport-autoreport.timer
● │   ├─dpkg-db-backup.timer
● │   ├─e2scrub_all.timer
● │   ├─fstrim.timer
○ │   ├─fwupd-refresh.timer
● │   ├─logrotate.timer
● │   ├─man-db.timer
● │   ├─motd-news.timer
● │   ├─phpsessionclean.timer
● │   ├─podman-auto-update.timer
○ │   ├─snapd.snap-repair.timer
● │   ├─systemd-tmpfiles-clean.timer
○ │   ├─ua-timer.timer
● │   ├─update-notifier-download.timer
● │   └─update-notifier-motd.timer
● ├─cloud-init.target
● │ ├─cloud-config.service
● │ ├─cloud-final.service
● │ ├─cloud-init-local.service
● │ └─cloud-init.service
● ├─getty.target
○ │ ├─getty-static.service
● │ ├─getty@tty1.service
● │ └─serial-getty@ttyS0.service
● └─remote-fs.target
●   └─mnt.mount
```

### Wiew job user_sessions_audit

```
Run echo "=== User Sessions ==="
  echo "=== User Sessions ==="
  who -a
  last -n 5
  shell: /usr/bin/bash -e {0}
=== User Sessions ===
           system boot  2025-06-23 05:33
           run-level 5  2025-06-23 05:33
LOGIN      tty1         2025-06-23 05:33               921 id=tty1
LOGIN      ttyS0        2025-06-23 05:33               914 id=tyS0
reboot   system boot  6.11.0-1015-azur Mon Jun 23 05:33   still running

wtmp begins Wed Jun 18 12:32:13 2025
```

The ``` who -a ``` command displays current user sessions and system state information.

- system boot

The system was booted on 23 June 2025 at 05:33.

- run-level 5

The system is in run-level 5 (usually the GUI).

- LOGIN tty1 and ttyS0

The two terminals where users logged in were also logged in on 23 June 2025.

The ``` last -n 5 ``` command shows the last five login records.

- reboot

The system was rebooted on 23 June 2025, the kernel version is 6.11.0-1015-azur, the system is still running.

The ``` wtmp ``` command indicates that the login log (wtmp) starts on 18 June 2025.

### Let's look at job memory_analysis

```
Run echo "=== Memory Allocation ==="
  echo "=== Memory Allocation ==="
  free -h
  echo "Memory Info:"
  cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
  shell: /usr/bin/bash -e {0}
=== Memory Allocation ===
               total        used        free      shared  buff/cache   available
Mem:            15Gi       1.0Gi       9.9Gi        55Mi       5.2Gi        14Gi
Swap:          4.0Gi          0B       4.0Gi
Memory Info:
MemTotal:       16379560 kB
MemAvailable:   15333200 kB
SwapTotal:       4194300 kB
```

The ``` free -h ``` command displays RAM and swap usage in a human-readable format:

- Mem (RAM):

```
• Total: 15 GiB
• Used: 1.0 GiB
• Free: 9.9 GiB
• Total available memory (including cache): 14 GiB
```

- Swap (Swap):

```
• Total: 4.0 GiB
• Used: 0 B
```

The ``` cat /proc/meminfo ``` command displays additional memory data:

- MemTotal: Total RAM - 16,379,560 KB
- MemAvailable: Available RAM - 15,333,200 KB
- SwapTotal: Total Swap - 4,194,300 KB

## Task 2: Network Analysis

The created action Network Analysis was taken [https://github.com/Kulikova-A18/Sum25-intro-labs/actions/runs/15816176937](https://github.com/Kulikova-A18/Sum25-intro-labs/actions/runs/15816176924)

### Let's look at the job traceroute_and_dns

```
Run echo "=== Traceroute ==="
  echo "=== Traceroute ==="
  traceroute github.com || echo "Error occurred during Traceroute step"
  shell: /usr/bin/bash -e {0}
=== Traceroute ===
traceroute to github.com (140.82.113.3), 30 hops max, 60 byte packets
 1  * * *
 2  * * *
 3  * * *
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  * * *
 9  * * *
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

the command tries to trace a route to the IP address github.com (140.82.113.3) with a maximum of 30 hops and a packet size of 60 bytes. All 30 hops return * * *, which means that no response could be received from the intermediate nodes (possibly due to ICMP blocking or network issues).

using local machine (some addresses will be closed ``` **.**.** ```)

```
alyona@alyona:~$   traceroute github.com || echo "Error occurred during Traceroute step"
traceroute to github.com (140.82.121.3), 30 hops max, 60 byte packets
 1  _gateway (**.**.**.4)  1.542 ms  1.482 ms  1.468 ms
 2 **.**.**.5 (**.**.**.5)  3.674 ms  3.817 ms  5.766 ms
 3  **.**.**.1 (**.**.**.1)  5.748 ms  5.736 ms  5.724 ms
 4  ixgbe-151-gw-access-city.dapl.ru (93.188.46.1)  5.712 ms  6.672 ms  6.661 ms
 5  ae0-50-atlas.dapl.ru (93.188.40.229)  4.471 ms  5.664 ms  5.653 ms
 6  109-73-40-29.in-addr.mastertelecom.ru (109.73.40.29)  6.612 ms  6.869 ms  6.709 ms
 7  195.68.147.145 (195.68.147.145)  5.745 ms  6.790 ms  6.671 ms
 8  * * *
 9  * * *
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

- The traceroute command was executed to determine the route to github.com (IP 140.82.121.3).
- The first 7 hops (nodes) successfully displayed the response time.
- From the 8th hop to the 30th, all responses are missing (marked as * * *). This may indicate blocking of ICMP packets or network problems.

Then there was work with dns

```
Run echo "=== DNS Resolution ==="
echo "=== DNS Resolution ==="
dig github.com || echo "Error occurred during DNS Resolution step"
shell: /usr/bin/bash -e {0}
=== DNS Resolution ===

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 30788
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;github.com. IN A

;; ANSWER SECTION:
github.com. 57 IN A 140.82.112.3

;; Query time: 1 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Jun 23 05:39:35 UTC 2025
;; MSG SIZE rcvd: 55
```

Executed command to check DNS resolution of domain github.com using dig utility.

- Output shows that the request was successful (status: NOERROR).
- Found IP address github.com: 140.82.112.3.
- Request execution time was 1 ms.
- Used local DNS server (127.0.0.53).

### Let's look at job packet_capture

```
Run echo "=== Generating DNS Traffic ==="
  echo "=== Generating DNS Traffic ==="
  dig github.com || echo "Error occurred during DNS Traffic Generation step"
  
  echo "=== Packet Capture ==="
  sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn || echo "Error occurred during Packet Capture step"
  shell: /usr/bin/bash -e {0}
=== Generating DNS Traffic ===

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 45728
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;github.com.			IN	A

;; ANSWER SECTION:
github.com.		7	IN	A	140.82.113.4

;; Query time: 1 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Jun 23 05:39:45 UTC 2025
;; MSG SIZE  rcvd: 55

=== Packet Capture ===
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
0 packets captured
0 packets received by filter
0 packets dropped by kernel

Error occurred during Packet Capture step
```

Generating DNS traffic:

- Running dig to query the IP address of the domain github.com.
- The request is successful, and a response is received with the IP address 140.82.113.4 and the status NOERROR.

Capturing packets:

- Using tcpdump to capture DNS packets on port 53 for 10 seconds.
- However, no packets were received during the packet capture, indicating that there was no traffic.

### View job reverse_dns_lookup

```
Run echo "=== Reverse DNS Lookup ==="
echo "=== Reverse DNS Lookup ==="
dig -x 8.8.4.4 || echo "Error occurred during Reverse DNS Lookup for 8.8.4.4 step" 
shell: /usr/bin/bash -e {0}
=== Reverse DNS Lookup ===

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 11778
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa. IN PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa. 1800 IN PTR dns.google.

;; Query time: 96 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Jun 23 05:40:08 UTC 2025
;; MSG SIZE rcvd: 73
```

This code performs a reverse DNS query for the IP address 8.8.4.4 and returns a successful response indicating that this address matches the domain dns.google..

```
Run dig -x 1.1.1.1 || echo "Error occurred during Reverse DNS Lookup for 1.1.1.1 step" 
dig -x 1.1.1.1 || echo "Error occurred during Reverse DNS Lookup for 1.1.1.1 step" 
shell: /usr/bin/bash -e {0}

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> -x 1.1.1.1
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 34106
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;1.1.1.1.in-addr.arpa. IN PTR

;; ANSWER SECTION:
1.1.1.1.in-addr.arpa. 1800 IN PTR one.one.one.one.

;; Query time: 111 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Jun 23 05:40:09 UTC 2025
;; MSG SIZE rcvd: 78

```

This code performs a reverse DNS query for the IP address 1.1.1.1, which successfully returns the domain name one.one.one.one.

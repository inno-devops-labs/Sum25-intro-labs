# Lab 04

<details style="margin-bottom: 1rem;">
<summary> (Click to expand)</summary>

```bash

```

</details>

## Task 1.1

```bash
➜  ~ systemd-analyze 
Startup finished in 11.704s (firmware) + 9.581s (loader) + 5.293s (kernel) + 1min 14.580s (userspace) = 1min 41.159s 
graphical.target reached after 23.746s in userspace
```
<details style="margin-bottom: 1rem;">
<summary>systemd-analyze blame (Click to expand)</summary>

```bash
➜  ~ systemd-analyze blame
1min 37.650s fstrim.service
     20.544s plymouth-quit-wait.service
      6.353s NetworkManager-wait-online.service
      5.684s docker.service
      2.011s snapd.seeded.service
      1.914s snapd.service
      1.487s plymouth-read-write.service
      1.371s fwupd.service
      1.169s vboxdrv.service
      1.155s systemd-backlight@backlight:intel_backlight.service
      1.007s dev-nvme0n1p5.device
       989ms logrotate.service
       763ms dev-loop34.device
       756ms dev-loop33.device
       749ms dev-loop31.device
       749ms dev-loop29.device
       748ms dev-loop30.device
       746ms dev-loop28.device
       745ms dev-loop27.device
       742ms dev-loop26.device
       741ms dev-loop25.device
       735ms dev-loop23.device
       730ms dev-loop22.device
       728ms dev-loop21.device
       723ms dev-loop20.device
       721ms dev-loop19.device
       717ms dev-loop18.device
       710ms dev-loop16.device
       708ms dev-loop15.device
       704ms dev-loop14.device
       700ms dev-loop13.device
       696ms dev-loop12.device
       687ms dev-loop9.device
       686ms dev-loop8.device
       601ms dev-loop7.device
       596ms dev-loop6.device
       590ms dev-loop4.device
       586ms dev-loop2.device
       585ms dev-loop0.device
       579ms dev-loop1.device
       331ms networkd-dispatcher.service
       322ms containerd.service
       256ms snapd.apparmor.service
       240ms accounts-daemon.service
       233ms udisks2.service
       227ms systemd-logind.service
       223ms user@1000.service
       207ms bluetooth.service
       190ms ModemManager.service
       181ms systemd-journal-flush.service
       160ms systemd-udev-trigger.service
       149ms fwupd-refresh.service
       147ms systemd-resolved.service
       138ms systemd-udevd.service
       126ms systemd-oomd.service
       110ms power-profiles-daemon.service
       103ms boot-efi.mount
       102ms switcheroo-control.service
       101ms systemd-timesyncd.service
        99ms iio-sensor-proxy.service
        99ms gdm.service
        96ms NetworkManager.service
        95ms keyboard-setup.service
        95ms systemd-journald.service
        93ms upower.service
        89ms apparmor.service
        86ms avahi-daemon.service
        85ms e2scrub_reap.service
        85ms rtkit-daemon.service
        84ms update-notifier-download.service
        84ms cups.service
        81ms plymouth-start.service
        80ms apport.service
        77ms systemd-rfkill.service
        77ms systemd-modules-load.service
        75ms grub-common.service
        73ms polkit.service
        60ms snap-bare-5.mount
        58ms secureboot-db.service
        58ms snap-code-174.mount
        58ms thermald.service
        57ms snap-code-194.mount
        56ms gpu-manager.service
        55ms snap-core18-2846.mount
        54ms snap-core18-2855.mount
        53ms systemd-remount-fs.service
        52ms snap-core20-2571.mount
        51ms snap-core22-1908.mount
        50ms snap-core22-1963.mount
        49ms snap-core24-1006.mount
        47ms wpa_supplicant.service
        45ms snap-curl-2312.mount
        44ms snap-figma\x2dlinux-189.mount
        43ms snap-figma\x2dlinux-197.mount
        42ms snap-firefox-5239.mount
        41ms xl2tpd.service
        41ms colord.service
        41ms snap-firefox-5987.mount
        39ms snap-ghidra-29.mount
        37ms systemd-fsck@dev-disk-by\x2duuid-D282\x2d04B9.service
        37ms snap-gnome\x2d3\x2d28\x2d1804-198.mount
        36ms snap-gnome\x2d3\x2d38\x2d2004-143.mount
        34ms snap-gnome\x2d42\x2d2204-176.mount
        33ms snap-gnome\x2d42\x2d2204-202.mount
        33ms systemd-tmpfiles-setup.service
        32ms systemd-random-seed.service
        32ms snap-gtk\x2dcommon\x2dthemes-1535.mount
        31ms snap-core24-1055.mount
        30ms snap-notion\x2dsnap\x2dreborn-51.mount
        30ms packagekit.service
        29ms rsyslog.service
        28ms snap-snap\x2dstore-1113.mount
        28ms snap-snap\x2dstore-1216.mount
        27ms snap-snapd-23771.mount
        26ms modprobe@fuse.service
        26ms snap-snapd-24505.mount
        26ms binfmt-support.service
        25ms snap-snapd\x2ddesktop\x2dintegration-247.mount
        24ms snap-snapd\x2ddesktop\x2dintegration-253.mount
        23ms grub-initrd-fallback.service
        22ms snap-telegram\x2ddesktop-6752.mount
        22ms snap-mesa\x2d2404-887.mount
        22ms snap-telegram\x2ddesktop-6691.mount
        21ms dev-loop38.device
        21ms snap-core20-2599.mount
        21ms modprobe@configfs.service
        20ms snap-core18-2923.mount
        20ms systemd-binfmt.service
        20ms snap-zotero\x2dsnap-109.mount
        20ms kerneloops.service
        19ms kmod-static-nodes.service
        18ms sys-kernel-tracing.mount
        18ms snap-gnome\x2d46\x2d2404-117.mount
        18ms dev-mqueue.mount
        18ms sys-kernel-debug.mount
        18ms systemd-sysusers.service
        18ms snap-curl-2324.mount
        18ms dev-hugepages.mount
        17ms var-snap-firefox-common-host\x2dhunspell.mount
        16ms snap-ghidra-33.mount
        14ms snap-notion\x2dsnap\x2dreborn-52.mount
        14ms systemd-update-utmp.service
        14ms snap-zotero\x2dsnap-112.mount
        12ms user-runtime-dir@1000.service
        12ms alsa-restore.service
        12ms systemd-tmpfiles-setup-dev.service
        11ms proc-sys-fs-binfmt_misc.mount
        10ms systemd-sysctl.service
         9ms sys-fs-fuse-connections.mount
         8ms systemd-user-sessions.service
         7ms console-setup.service
         6ms motd-news.service
         6ms e2scrub_all.service
         6ms systemd-update-utmp-runlevel.service
         5ms vboxweb-service.service
         4ms swapfile.swap
         4ms vboxautostart-service.service
         3ms ufw.service
         3ms openvpn.service
         3ms modprobe@drm.service
         3ms setvtrgb.service
         3ms dev-loop37.device
         2ms sys-kernel-config.mount
         2ms vboxballoonctrl-service.service
         2ms dev-loop39.device
         1ms modprobe@efi_pstore.service
         1ms docker.socket
       581us snapd.socket
```

</details>

```bash
➜  ~ uptime
 13:40:17 up 17 min,  1 user,  load average: 1,67, 2,03, 1,47
```

```bash
➜  ~ w
 13:40:30 up 17 min,  1 user,  load average: 1,71, 2,03, 1,48
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
vmakh    tty2     tty2             13:23   17:31   0.02s  0.02s /usr/libexec/gnome-session-binary --
```

**Key Observations:**
- The system boot time is approximately 1 minute and 41 seconds.
- The `fstrim.service` took the longest time to start (1 minute and 37 seconds).
- The `graphical.target` was reached after 23.746 seconds in userspace.
- System load averages over the last 1, 5, and 15 minutes are 1.67, 2.03, and 1.47, respectively.
- One user is currently logged in.

**Analysis:**
- The boot time analysis indicates that the system takes a significant amount of time to fully boot, with `fstrim.service` being a notable outlier.
- The system load averages suggest moderate system activity, with a slight increase in the 5-minute average.

## Task 1.2

```bash
➜  ~ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    PID    PPID CMD                         %MEM %CPU
  82163    1609 /snap/telegram-desktop/6752  3.8 17.0
   8281    7708 /snap/code/194/usr/share/co  3.2  6.9
  36370    1117 /opt/yandex/browser/yandex_  3.0  5.2
   8455    8429 /home/vmakh/.vscode/extensi  2.2  1.4
   8251    7711 /snap/code/194/usr/share/co  2.2  6.7
```

```bash
➜  ~ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    PID    PPID CMD                         %MEM %CPU
  84201   36401 /opt/yandex/browser/yandex_  1.4 16.6
    879       1 avahi-daemon: running [ProB  0.0  9.5
  82163    1609 /snap/telegram-desktop/6752  4.0  9.4
   8251    7711 /snap/code/194/usr/share/co  2.2  7.5
  80972   36401 /opt/yandex/browser/yandex_  1.8  7.5
```

**Key Observations:**
- The top memory-consuming process is `/snap/telegram-desktop/6752` with 3.8% memory usage.
- The top CPU-consuming process is `/opt/yandex/browser/yandex_b` with 16.6% CPU usage.

**Analysis:**
- Resource-intensive processes have been identified, which can help in optimizing system performance by managing these processes.
- High CPU usage by certain processes may indicate the need for further investigation to ensure they are not causing system slowdowns.

## Task 1.3

<details style="margin-bottom: 1rem;">
<summary> (Click to expand)</summary>

```bash
➜  ~ systemctl list-dependencies
default.target
● ├─accounts-daemon.service
● ├─apport.service
● ├─gdm.service
● ├─ollama.service
● ├─power-profiles-daemon.service
● ├─switcheroo-control.service
○ ├─systemd-update-utmp-runlevel.service
● ├─udisks2.service
● ├─xl2tpd.service
● └─multi-user.target
○   ├─anacron.service
●   ├─apport.service
●   ├─avahi-daemon.service
●   ├─binfmt-support.service
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
●   ├─openvpn.service
●   ├─plymouth-quit-wait.service
○   ├─plymouth-quit.service
●   ├─rsyslog.service
○   ├─secureboot-db.service
●   ├─snap-bare-5.mount
●   ├─snap-code-174.mount
●   ├─snap-code-194.mount
●   ├─snap-core18-2855.mount
●   ├─snap-core18-2923.mount
●   ├─snap-core20-2571.mount
●   ├─snap-core20-2599.mount
●   ├─snap-core22-1908.mount
●   ├─snap-core22-1963.mount
●   ├─snap-core24-1006.mount
●   ├─snap-core24-1055.mount
●   ├─snap-curl-2312.mount
●   ├─snap-curl-2324.mount
●   ├─snap-figma\x2dlinux-189.mount
●   ├─snap-figma\x2dlinux-197.mount
●   ├─snap-firefox-5239.mount
●   ├─snap-firefox-5987.mount
●   ├─snap-ghidra-29.mount
●   ├─snap-ghidra-33.mount
●   ├─snap-gnome\x2d3\x2d28\x2d1804-198.mount
●   ├─snap-gnome\x2d3\x2d38\x2d2004-143.mount
●   ├─snap-gnome\x2d42\x2d2204-176.mount
●   ├─snap-gnome\x2d42\x2d2204-202.mount
●   ├─snap-gnome\x2d46\x2d2404-117.mount
●   ├─snap-gtk\x2dcommon\x2dthemes-1535.mount
●   ├─snap-mesa\x2d2404-887.mount
●   ├─snap-notion\x2dsnap\x2dreborn-51.mount
●   ├─snap-notion\x2dsnap\x2dreborn-52.mount
●   ├─snap-snap\x2dstore-1113.mount
●   ├─snap-snap\x2dstore-1216.mount
●   ├─snap-snapd-23771.mount
●   ├─snap-snapd-24505.mount
●   ├─snap-snapd\x2ddesktop\x2dintegration-247.mount
●   ├─snap-snapd\x2ddesktop\x2dintegration-253.mount
●   ├─snap-telegram\x2ddesktop-6691.mount
●   ├─snap-telegram\x2ddesktop-6752.mount
●   ├─snap-zotero\x2dsnap-109.mount
●   ├─snap-zotero\x2dsnap-112.mount
○   ├─snapd.aa-prompt-listener.service
●   ├─snapd.apparmor.service
○   ├─snapd.autoimport.service
○   ├─snapd.core-fixup.service
○   ├─snapd.recovery-chooser-trigger.service
●   ├─snapd.seeded.service
●   ├─snapd.service
●   ├─strongswan-starter.service
●   ├─systemd-ask-password-wall.path
●   ├─systemd-logind.service
●   ├─systemd-oomd.service
●   ├─systemd-resolved.service
○   ├─systemd-update-utmp-runlevel.service
●   ├─systemd-user-sessions.service
●   ├─thermald.service
○   ├─ua-reboot-cmds.service
○   ├─ubuntu-advantage.service
●   ├─ufw.service
●   ├─unattended-upgrades.service
●   ├─var-snap-firefox-common-host\x2dhunspell.mount
●   ├─vboxautostart-service.service
●   ├─vboxballoonctrl-service.service
●   ├─vboxdrv.service
●   ├─vboxweb-service.service
●   ├─whoopsie.path
●   ├─wpa_supplicant.service
●   ├─xl2tpd.service
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

</details>


<details style="margin-bottom: 1rem;">
<summary> (Click to expand)</summary>

```bash
➜  ~ systemctl list-dependencies multi-user.target
multi-user.target
○ ├─anacron.service
● ├─apport.service
● ├─avahi-daemon.service
● ├─binfmt-support.service
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
● ├─openvpn.service
● ├─plymouth-quit-wait.service
○ ├─plymouth-quit.service
● ├─rsyslog.service
○ ├─secureboot-db.service
● ├─snap-bare-5.mount
● ├─snap-code-174.mount
● ├─snap-code-194.mount
● ├─snap-core18-2855.mount
● ├─snap-core18-2923.mount
● ├─snap-core20-2571.mount
● ├─snap-core20-2599.mount
● ├─snap-core22-1908.mount
● ├─snap-core22-1963.mount
● ├─snap-core24-1006.mount
● ├─snap-core24-1055.mount
● ├─snap-curl-2312.mount
● ├─snap-curl-2324.mount
● ├─snap-figma\x2dlinux-189.mount
● ├─snap-figma\x2dlinux-197.mount
● ├─snap-firefox-5239.mount
● ├─snap-firefox-5987.mount
● ├─snap-ghidra-29.mount
● ├─snap-ghidra-33.mount
● ├─snap-gnome\x2d3\x2d28\x2d1804-198.mount
● ├─snap-gnome\x2d3\x2d38\x2d2004-143.mount
● ├─snap-gnome\x2d42\x2d2204-176.mount
● ├─snap-gnome\x2d42\x2d2204-202.mount
● ├─snap-gnome\x2d46\x2d2404-117.mount
● ├─snap-gtk\x2dcommon\x2dthemes-1535.mount
● ├─snap-mesa\x2d2404-887.mount
● ├─snap-notion\x2dsnap\x2dreborn-51.mount
● ├─snap-notion\x2dsnap\x2dreborn-52.mount
● ├─snap-snap\x2dstore-1113.mount
● ├─snap-snap\x2dstore-1216.mount
● ├─snap-snapd-23771.mount
● ├─snap-snapd-24505.mount
● ├─snap-snapd\x2ddesktop\x2dintegration-247.mount
● ├─snap-snapd\x2ddesktop\x2dintegration-253.mount
● ├─snap-telegram\x2ddesktop-6691.mount
● ├─snap-telegram\x2ddesktop-6752.mount
● ├─snap-zotero\x2dsnap-109.mount
● ├─snap-zotero\x2dsnap-112.mount
○ ├─snapd.aa-prompt-listener.service
● ├─snapd.apparmor.service
○ ├─snapd.autoimport.service
○ ├─snapd.core-fixup.service
○ ├─snapd.recovery-chooser-trigger.service
● ├─snapd.seeded.service
● ├─snapd.service
● ├─strongswan-starter.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
● ├─systemd-oomd.service
● ├─systemd-resolved.service
○ ├─systemd-update-utmp-runlevel.service
● ├─systemd-user-sessions.service
● ├─thermald.service
○ ├─ua-reboot-cmds.service
○ ├─ubuntu-advantage.service
● ├─ufw.service
● ├─unattended-upgrades.service
● ├─var-snap-firefox-common-host\x2dhunspell.mount
● ├─vboxautostart-service.service
● ├─vboxballoonctrl-service.service
● ├─vboxdrv.service
● ├─vboxweb-service.service
● ├─whoopsie.path
● ├─wpa_supplicant.service
● ├─xl2tpd.service
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

</details>

**Key Observations:**
- The system has numerous services and dependencies, with many related to snap packages.
- Key services include `apport.service`, `avahi-daemon.service`, `containerd.service`, and `docker.service`.

**Analysis:**
- The extensive list of services and dependencies highlights the complexity of the system's service management.
- Understanding service relationships is crucial for troubleshooting and optimizing system performance.

## Task 1.4

```bash
➜  ~ who -a                                                           
           загрузка системы 2025-07-28 13:22
vmakh    + tty2         2025-07-28 13:23 00:34        1219 (tty2)
           уровень выполнения 5 2025-07-28 13:23
```

```bash
➜  ~ last -n 5
vmakh    tty2         tty2             Mon Jul 28 13:23   still logged in
reboot   system boot  6.8.0-59-generic Mon Jul 28 13:22   still running
vmakh    tty2         tty2             Thu Jul 10 18:37 - down   (00:01)
reboot   system boot  6.8.0-59-generic Thu Jul 10 18:37 - 18:38  (00:01)
vmakh    tty2         tty2             Thu Jun 26 17:39 - down   (00:09)

wtmp begins Wed Sep 13 11:07:04 2023
```

**Key Observations:**
- The system was booted at 13:22 on July 28, 2025.
- User `vmakh` logged in at 13:23 and is still logged in.
- The last five logins include system reboots and user logins, with the most recent login being at 13:23.

**Analysis:**
- The login activity audit provides insights into user sessions and system uptime, which is useful for tracking system usage and potential unauthorized access.

## Task 1.5

```bash
➜  ~ free -h
               total        used        free      shared  buff/cache   available
Память:       15Gi       4,9Gi       574Mi       574Mi         9Gi       9,6Gi
Подкачка:      2,0Gi       1,0Mi       2,0Gi
```

```bash
➜  ~    cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable

MemTotal:       16221200 kB
MemAvailable:   10060968 kB
SwapTotal:       2097148 kB
```

**Key Observations:**
- The system has a total of 15 GiB of memory, with 4.9 GiB used, 574 MiB free, and 9 GiB available.
- Swap space totals 2.0 GiB, with only 1.0 MiB used.
- Key memory metrics from `/proc/meminfo` include `MemTotal`, `MemAvailable`, and `SwapTotal`.

**Analysis:**
- The memory usage indicates that the system has sufficient available memory, with minimal swap usage suggesting efficient memory management.
- Monitoring memory allocation helps in ensuring that the system does not run out of memory, which could lead to performance degradation.

## Task 2.1

```bash
➜  ~ traceroute github.com 
traceroute to github.com (140.82.121.3), 30 hops max, 60 byte packets
 1  _gateway (10.90.120.1)  0.095 ms  0.107 ms  0.097 ms
 2  10.252.5.2 (10.252.5.2)  0.578 ms * *
 3  10.252.6.1 (10.252.6.1)  0.356 ms  0.319 ms  0.362 ms
 4  188.170.164.34 (188.170.164.34)  4.258 ms  4.352 ms  4.343 ms
 5  * * *
 6  * * *
 7  * * *
 8  * * *
 9  83.169.204.82 (83.169.204.82)  39.822 ms 83.169.204.78 (83.169.204.78)  39.798 ms  36.980 ms
10  netnod-ix-ge-a-sth-1500.inter.link (194.68.123.180)  37.849 ms netnod-ix-ge-b-sth-1500.inter.link (194.68.128.180)  39.381 ms netnod-ix-ge-a-sth-1500.inter.link (194.68.123.180)  37.403 ms
11  * * *
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  r1-fra3-de.as5405.net (94.103.180.24)  56.810 ms  56.594 ms  57.071 ms
18  cust-sid435.r1-fra3-de.as5405.net (45.153.82.39)  51.929 ms cust-sid436.fra3-de.as5405.net (45.153.82.37)  61.332 ms cust-sid435.r1-fra3-de.as5405.net (45.153.82.39)  51.931 ms
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

```bash
➜  ~ dig github.com

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 46865
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;github.com.			IN	A

;; ANSWER SECTION:
github.com.		35	IN	A	140.82.121.3

;; Query time: 5 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Jul 28 14:07:01 MSK 2025
;; MSG SIZE  rcvd: 55

```


**Key Observations:**
- The traceroute to `github.com` shows the path taken by packets, with several hops and varying response times.
- The DNS resolution for `github.com` returns the IP address `140.82.121.3`.

**Analysis:**
- Traceroute execution helps in identifying network paths and potential bottlenecks or failures in the network route.
- DNS resolution is crucial for ensuring that domain names are correctly translated to IP addresses, which is fundamental for network communication.

## Task 2.2

```bash
➜  ~    sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
14:08:38.982237 lo    In  IP 127.0.0.1.48981 > 127.0.0.53.53: 62443+ [1au] A? unleash.codeium.com. (48)
14:08:38.982254 lo    In  IP 127.0.0.1.48981 > 127.0.0.53.53: 12260+ [1au] AAAA? unleash.codeium.com. (48)
14:08:38.982509 wlp0s20f3 Out IP 10.91.72.124.51331 > 10.90.128.11.53: 40342+ [1au] A? unleash.codeium.com. (48)
14:08:38.982607 lo    In  IP 127.0.0.53.53 > 127.0.0.1.48981: 62443 1/0/1 A 35.223.238.178 (64)
14:08:38.982753 wlp0s20f3 Out IP 10.91.72.124.55978 > 10.90.128.11.53: 39734+ [1au] AAAA? unleash.codeium.com. (48)
5 packets captured
14 packets received by filter
0 packets dropped by kernel
```

**Key Observations:**
- The packet capture shows DNS traffic, with queries and responses for the domain `unleash.codeium.com`.
- The capture includes both IPv4 and IPv6 queries.

**Analysis:**
- Capturing DNS traffic provides insights into the types of DNS queries being made and their responses, which is useful for network diagnostics and security analysis.
- Sanitizing IPs in packet captures ensures that sensitive information is not exposed.

## Task 2.3

```bash
➜  ~ dig -x 8.8.4.4

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 37880
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.		IN	PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.	76260	IN	PTR	dns.google.

;; Query time: 19 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Jul 28 14:10:00 MSK 2025
;; MSG SIZE  rcvd: 73

```

```bash
➜  ~ dig -x 1.1.2.2

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 56248
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.		IN	PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.		3013	IN	SOA	ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22357 7200 1800 604800 3600

;; Query time: 492 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Jul 28 14:10:26 MSK 2025
;; MSG SIZE  rcvd: 137

```


**Key Observations:**
- The reverse DNS lookup for `8.8.4.4` returns `dns.google`, indicating it is a Google DNS server.
- The reverse DNS lookup for `1.1.2.2` returns an `NXDOMAIN` status, indicating no PTR record exists for this IP.

**Analysis:**
- Performing reverse DNS lookups helps in identifying the domain names associated with IP addresses, which is useful for network diagnostics and security.
- The absence of a PTR record for `1.1.2.2` suggests that this IP address does not have a reverse DNS entry, which might be expected for certain types of servers or network configurations.
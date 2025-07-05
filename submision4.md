## Task 1

### 1.1

Command `systemd-analyze`

~~~bash
Startup finished in 9.161s (firmware) + 2.548s (loader) + 4.446s (kernel) + 12.763s (userspace) = 28.919s 
graphical.target reached after 12.711s in userspace.
~~~

Command `systemd-analyze blame`

~~~bash
7.516s plymouth-quit-wait.service
6.766s NetworkManager-wait-online.service
2.203s docker.service
1.198s dev-nvme1n1p3.device
 999ms NetworkManager.service
 882ms systemd-journald.service
 484ms systemd-modules-load.service
 408ms systemd-udev-trigger.service
 372ms systemd-udev-load-credentials.service
 340ms systemd-remount-fs.service
 269ms modprobe@fuse.service
 268ms systemd-tmpfiles-setup-dev-early.service
 260ms systemd-tmpfiles-setup.service
 242ms user@1000.service
 241ms lvm2-monitor.service
 240ms modprobe@drm.service
 240ms containerd.service
 199ms apparmor.service
 178ms udisks2.service
 166ms systemd-journal-flush.service
 159ms systemd-tmpfiles-clean.service
 148ms polkit.service
 137ms plymouth-start.service
 130ms var-lib-snapd-snap-core20-2318.mount
 129ms var-lib-snapd-snap-core20-2379.mount
 115ms boot-efi.mount
 112ms systemd-fsck@dev-disk-by\x2duuid-D2DD\x2d6EF9.service
 111ms plymouth-read-write.service
 105ms systemd-random-seed.service
 101ms upower.service
  99ms systemd-timesyncd.service
  96ms systemd-udevd.service
  96ms systemd-tmpfiles-setup-dev.service
  93ms accounts-daemon.service
  86ms systemd-userdbd.service
  84ms ufw.service
  76ms pamac-daemon.service
  72ms var-lib-snapd-snap-snapd-21759.mount
  71ms cups.service
  66ms bluetooth.service
  66ms user-runtime-dir@1000.service
  66ms alsa-restore.service
  65ms tmp.mount
  64ms systemd-vconsole-setup.service
  62ms systemd-rfkill.service
  58ms systemd-logind.service
  57ms systemd-update-utmp.service
  55ms kmod-static-nodes.service
  55ms modprobe@configfs.service
  55ms systemd-user-sessions.service
  53ms systemd-sysctl.service
  49ms power-profiles-daemon.service
  48ms wpa_supplicant.service
  43ms modprobe@dm_mod.service
  41ms colord.service
  37ms ModemManager.service
  35ms dbus-broker.service
  33ms docker.socket
  26ms sys-fs-fuse-connections.mount
  25ms sys-kernel-config.mount
  17ms systemd-hostnamed.service
  14ms dev-hugepages.mount
  14ms gdm.service
  13ms dev-mqueue.mount
  13ms sys-kernel-debug.mount
  12ms sys-kernel-tracing.mount
   7ms snapd.socket
   5ms rtkit-daemon.service
   3ms proc-sys-fs-binfmt_misc.mount
   2ms modprobe@loop.service
~~~

**Observation**:
- `plymouth-quit-wait.service` - Plymouth is the application which provides the graphical "splash" screen when booting and shutting down an Ubuntu system.
- `NetworkManager-wait-online.service` - Is a network service

All them is take the most time to boot.

Command `uptime`

~~~bash
 22:50:55 up  5:42,  1 user,  load average: 0,79, 0,75, 0,60
~~~

Command `w`

~~~bash
 22:51:13 up  5:42,  1 user,  load average: 0,57, 0,70, 0,59
USER     TTY       LOGIN@   IDLE   JCPU   PCPU  WHAT
slauva   tty2      20:09    2:42m  3:15   0.03s /usr/lib/gnome-session-binary
~~~

**Observation**:
- System is lightly loaded with one active sessions

### 1.2

Command `ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6`

~~~bash
    PID    PPID CMD                         %MEM %CPU
   3169    2275 /usr/lib/firefox/firefox --  1.3 19.6
   2403    2275 /usr/bin/gnome-shell         0.8  4.9
   2618    2380 /home/slauva/.local/share/J  0.7  0.3
   3333    3169 /usr/lib/firefox/firefox -c  0.7  1.1
   4485    3169 /usr/lib/firefox/firefox -c  0.6 10.5
~~~

Command `ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6`

~~~bash
    PID    PPID CMD                         %MEM %CPU
   3169    2275 /usr/lib/firefox/firefox --  1.3 19.6
  15136   15077 /opt/visual-studio-code/cod  0.4 11.9
   3260    3169 /usr/lib/firefox/firefox -c  0.1 10.6
   4485    3169 /usr/lib/firefox/firefox -c  0.6 10.5
  15106   15074 /opt/visual-studio-code/cod  0.4  5.1
~~~

**Observation**:
- Here we can observe, that browser and telegram used most of memory

### 1.3

Command `systemctl list-dependencies`

~~~bash
default.target
● ├─gdm.service
● └─multi-user.target
●   ├─AmneziaVPN.service
●   ├─apparmor.service
●   ├─cups.path
●   ├─cups.service
●   ├─dbus-broker.service
●   ├─docker.service
●   ├─ModemManager.service
●   ├─NetworkManager.service
●   ├─plymouth-quit-wait.service
○   ├─plymouth-quit.service
●   ├─systemd-ask-password-wall.path
●   ├─systemd-logind.service
●   ├─systemd-user-sessions.service
●   ├─touchegg.service
●   ├─ufw.service
●   ├─var-lib-snapd-snap-core20-2318.mount
●   ├─var-lib-snapd-snap-core20-2379.mount
●   ├─var-lib-snapd-snap-snapd-21759.mount
●   ├─basic.target
●   │ ├─-.mount
●   │ ├─tmp.mount
●   │ ├─paths.target
●   │ ├─slices.target
●   │ │ ├─-.slice
●   │ │ └─system.slice
●   │ ├─sockets.target
●   │ │ ├─cups.socket
●   │ │ ├─dbus.socket
●   │ │ ├─dirmngr@etc-pacman.d-gnupg.socket
●   │ │ ├─dm-event.socket
●   │ │ ├─gpg-agent-browser@etc-pacman.d-gnupg.socket
●   │ │ ├─gpg-agent-extra@etc-pacman.d-gnupg.socket
●   │ │ ├─gpg-agent-ssh@etc-pacman.d-gnupg.socket
●   │ │ ├─gpg-agent@etc-pacman.d-gnupg.socket
●   │ │ ├─keyboxd@etc-pacman.d-gnupg.socket
●   │ │ ├─snapd.socket
●   │ │ ├─sshd-unix-local.socket
●   │ │ ├─systemd-bootctl.socket
●   │ │ ├─systemd-coredump.socket
●   │ │ ├─systemd-creds.socket
●   │ │ ├─systemd-hostnamed.socket
●   │ │ ├─systemd-importd.socket
●   │ │ ├─systemd-journald-dev-log.socket
●   │ │ ├─systemd-journald.socket
○   │ │ ├─systemd-pcrextend.socket
○   │ │ ├─systemd-pcrlock.socket
●   │ │ ├─systemd-sysext.socket
●   │ │ ├─systemd-udevd-control.socket
●   │ │ ├─systemd-udevd-kernel.socket
●   │ │ └─systemd-userdbd.socket
●   │ ├─sysinit.target
●   │ │ ├─dev-hugepages.mount
●   │ │ ├─dev-mqueue.mount
●   │ │ ├─kmod-static-nodes.service
○   │ │ ├─ldconfig.service
●   │ │ ├─lvm2-lvmpolld.socket
●   │ │ ├─lvm2-monitor.service
●   │ │ ├─plymouth-read-write.service
●   │ │ ├─plymouth-start.service
●   │ │ ├─proc-sys-fs-binfmt_misc.automount
●   │ │ ├─sys-fs-fuse-connections.mount
●   │ │ ├─sys-kernel-config.mount
●   │ │ ├─sys-kernel-debug.mount
●   │ │ ├─sys-kernel-tracing.mount
○   │ │ ├─systemd-ask-password-console.path
○   │ │ ├─systemd-binfmt.service
○   │ │ ├─systemd-boot-random-seed.service
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
●   │ │ ├─systemd-random-seed.service
○   │ │ ├─systemd-repart.service
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
○   │ │ │ ├─systemd-fsck-root.service
●   │ │ │ ├─systemd-remount-fs.service
●   │ │ │ └─tmp.mount
●   │ │ ├─swap.target
●   │ │ └─veritysetup.target
●   │ └─timers.target
●   │   ├─archlinux-keyring-wkd-sync.timer
●   │   ├─btrfs-balance.timer
●   │   ├─btrfs-scrub.timer
●   │   ├─btrfs-trim.timer
●   │   ├─fstrim.timer
●   │   ├─logrotate.timer
●   │   ├─man-db.timer
○   │   ├─pacman-filesdb-refresh.timer
●   │   ├─pamac-cleancache.timer
●   │   ├─pamac-mirrorlist.timer
●   │   ├─shadow.timer
●   │   └─systemd-tmpfiles-clean.timer
●   ├─getty.target
○   │ └─getty@tty1.service
●   └─remote-fs.target
○     └─var-lib-machines.mount
~~~

Command `systemctl list-dependencies multi-user.target`

~~~bash
multi-user.target
● ├─AmneziaVPN.service
● ├─apparmor.service
● ├─cups.path
● ├─cups.service
● ├─dbus-broker.service
● ├─docker.service
● ├─ModemManager.service
● ├─NetworkManager.service
● ├─plymouth-quit-wait.service
○ ├─plymouth-quit.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
● ├─systemd-user-sessions.service
● ├─touchegg.service
● ├─ufw.service
● ├─var-lib-snapd-snap-core20-2318.mount
● ├─var-lib-snapd-snap-core20-2379.mount
● ├─var-lib-snapd-snap-snapd-21759.mount
● ├─basic.target
● │ ├─-.mount
● │ ├─tmp.mount
● │ ├─paths.target
● │ ├─slices.target
● │ │ ├─-.slice
● │ │ └─system.slice
● │ ├─sockets.target
● │ │ ├─cups.socket
● │ │ ├─dbus.socket
● │ │ ├─dirmngr@etc-pacman.d-gnupg.socket
● │ │ ├─dm-event.socket
● │ │ ├─gpg-agent-browser@etc-pacman.d-gnupg.socket
● │ │ ├─gpg-agent-extra@etc-pacman.d-gnupg.socket
● │ │ ├─gpg-agent-ssh@etc-pacman.d-gnupg.socket
● │ │ ├─gpg-agent@etc-pacman.d-gnupg.socket
● │ │ ├─keyboxd@etc-pacman.d-gnupg.socket
● │ │ ├─snapd.socket
● │ │ ├─sshd-unix-local.socket
● │ │ ├─systemd-bootctl.socket
● │ │ ├─systemd-coredump.socket
● │ │ ├─systemd-creds.socket
● │ │ ├─systemd-hostnamed.socket
● │ │ ├─systemd-importd.socket
● │ │ ├─systemd-journald-dev-log.socket
● │ │ ├─systemd-journald.socket
○ │ │ ├─systemd-pcrextend.socket
○ │ │ ├─systemd-pcrlock.socket
● │ │ ├─systemd-sysext.socket
● │ │ ├─systemd-udevd-control.socket
● │ │ ├─systemd-udevd-kernel.socket
● │ │ └─systemd-userdbd.socket
● │ ├─sysinit.target
● │ │ ├─dev-hugepages.mount
● │ │ ├─dev-mqueue.mount
● │ │ ├─kmod-static-nodes.service
○ │ │ ├─ldconfig.service
● │ │ ├─lvm2-lvmpolld.socket
● │ │ ├─lvm2-monitor.service
● │ │ ├─plymouth-read-write.service
● │ │ ├─plymouth-start.service
● │ │ ├─proc-sys-fs-binfmt_misc.automount
● │ │ ├─sys-fs-fuse-connections.mount
● │ │ ├─sys-kernel-config.mount
● │ │ ├─sys-kernel-debug.mount
● │ │ ├─sys-kernel-tracing.mount
○ │ │ ├─systemd-ask-password-console.path
○ │ │ ├─systemd-binfmt.service
○ │ │ ├─systemd-boot-random-seed.service
○ │ │ ├─systemd-firstboot.service
○ │ │ ├─systemd-hibernate-clear.service
○ │ │ ├─systemd-hwdb-update.service
○ │ │ ├─systemd-journal-catalog-update.service
● │ │ ├─systemd-journal-flush.service
● │ │ ├─systemd-journald.service
○ │ │ ├─systemd-machine-id-commit.service
● │ │ ├─systemd-modules-load.service
○ │ │ ├─systemd-pcrmachine.service
○ │ │ ├─systemd-pcrphase-sysinit.service
○ │ │ ├─systemd-pcrphase.service
● │ │ ├─systemd-random-seed.service
○ │ │ ├─systemd-repart.service
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
○ │ │ │ ├─systemd-fsck-root.service
● │ │ │ ├─systemd-remount-fs.service
● │ │ │ └─tmp.mount
● │ │ ├─swap.target
● │ │ └─veritysetup.target
● │ └─timers.target
● │   ├─archlinux-keyring-wkd-sync.timer
● │   ├─btrfs-balance.timer
● │   ├─btrfs-scrub.timer
● │   ├─btrfs-trim.timer
● │   ├─fstrim.timer
● │   ├─logrotate.timer
● │   ├─man-db.timer
○ │   ├─pacman-filesdb-refresh.timer
● │   ├─pamac-cleancache.timer
● │   ├─pamac-mirrorlist.timer
● │   ├─shadow.timer
● │   └─systemd-tmpfiles-clean.timer
● ├─getty.target
○ │ └─getty@tty1.service
● └─remote-fs.target
○   └─var-lib-machines.mount
~~~

**Observation**:
- `multi-user.target` includes critical services like `NetworkManager` and `ssh`. They are essential for remote and multi-user environments. Here we see only multi-user.target branch

### 1.4

Command `who -a`

~~~bash
           system boot  2025-07-05 20:08
slauva   ? seat0        2025-07-05 20:09   ?          2308 (login screen)
slauva   ? :1           2025-07-05 20:09   ?          2308 (:1)
~~~

Command `last -n 5`

~~~bash
slauva   :1           :1               Sat Jul  5 20:09   still logged in
slauva   seat0        login screen     Sat Jul  5 20:09   still logged in
reboot   system boot  6.6.74-1-MANJARO Sat Jul  5 20:08   still running
slauva   :1           :1               Sat Jul  5 16:09 - down   (00:05)
slauva   seat0        login screen     Sat Jul  5 16:09 - down   (00:05)

wtmp begins Fri Feb 23 08:33:40 2024
~~~

### 1.5

Command `free -h`

~~~bash

               total        used        free      shared  buff/cache   available
Mem:            62Gi       6,6Gi        52Gi       138Mi       4,6Gi        55Gi
Swap:             0B          0B          0B
~~~

Command `cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable`

~~~bash
MemTotal:       65676040 kB
MemAvailable:   58741988 kB
SwapTotal:             0 kB
~~~

---

## Task 2

### 2.2

Command `dig github.com`

~~~bash
; <<>> DiG 9.20.4 <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 27626
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 6ff504a891cdbf21861709886869843e80156bfa2566cb03 (good)
;; QUESTION SECTION:
;github.com.			IN	A

;; ANSWER SECTION:
github.com.		33	IN	A	140.82.121.4

;; Query time: 3 msec
;; SERVER: 10.90.137.30#53(10.90.137.30) (UDP)
;; WHEN: Sat Jul 05 22:59:58 MSK 2025
;; MSG SIZE  rcvd: 83
~~~

### 2.3

Command `dig github.com`

~~~bash
; <<>> DiG 9.20.4 <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 63211
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: d4bd6c1b066dc9240cb481726869848357b07df6d45ff833 (good)
;; QUESTION SECTION:
;github.com.			IN	A

;; ANSWER SECTION:
github.com.		44	IN	A	140.82.121.3

;; Query time: 0 msec
;; SERVER: 10.90.137.30#53(10.90.137.30) (UDP)
;; WHEN: Sat Jul 05 23:01:07 MSK 2025
;; MSG SIZE  rcvd: 83
~~~

### 2.4

Command `dig -x 8.8.4.4`

~~~bash

; <<>> DiG 9.20.4 <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 42772
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: e5d1cbe273c1efb69e87c10c686984cbc88fd8438b15d85d (good)
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.		IN	PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.	85400	IN	PTR	dns.google.

;; Query time: 0 msec
;; SERVER: 10.90.137.30#53(10.90.137.30) (UDP)
;; WHEN: Sat Jul 05 23:02:19 MSK 2025
;; MSG SIZE  rcvd: 101

~~~

**Observation**:
DNS successfully resolved `github.com` to IP `140.82.114.3`.
- `opcode`: QUERY: Standard DNS query.
- `status`: NOERROR: The query was successful; no errors occurred.
- `flags`: qr rd ra:
- `qr`: This is a response.
- `rd`: Recursion desired (you asked the DNS server to resolve it fully).
- `ra`: Recursion available (server supports recursive queries).
- `QUERY`: 1: One question was asked.
- `ANSWER`: 1: One answer was returned.
- `AUTHORITY`: 0: No authoritative server info included.
- `ADDITIONAL`: 1: One extra record (like EDNS info) was included.

Command `dig -x 8.8.4.4`

~~~bash

; <<>> DiG 9.20.4 <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 19139
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 93567728549938a477248f34686984db5d5e2ff92ac19fb9 (good)
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.		IN	PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.		900	IN	SOA	ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22240 7200 1800 604800 3600

;; Query time: 440 msec
;; SERVER: 10.90.137.30#53(10.90.137.30) (UDP)
;; WHEN: Sat Jul 05 23:02:35 MSK 2025
;; MSG SIZE  rcvd: 165

~~~

## Final Notes
* All commands executed on Ubuntu 24.10 with KDE on Wayland
* No sensitive process or private IPs logged.
* Boot optimization could target `fstrim.service` or `NetworkManager-wait-online` (but i highly don't recomment)
* Networking tools functioned as expected; DNS resolution and reverse lookups were consistent.
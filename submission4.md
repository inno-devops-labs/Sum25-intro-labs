# 1
> systemd-analyze
Startup finished in 3.649s (firmware) + 3.964s (loader) + 1.095s (kernel) + 6.358s (initrd) + 19.379s (userspace) = 34.447s 
graphical.target reached after 19.362s in userspace.
# 2
> systemd-analyze blame
13.891s akmods.service
11.114s plymouth-quit-wait.service
 7.234s sys-devices-platform-serial8250-serial8250:0-serial8250:0.3-tty-ttyS3.device
 7.234s dev-ttyS3.device
 7.221s sys-devices-platform-serial8250-serial8250:0-serial8250:0.1-tty-ttyS1.device
 7.221s dev-ttyS1.device
 7.218s sys-devices-platform-serial8250-serial8250:0-serial8250:0.0-tty-ttyS0.device
 7.218s dev-ttyS0.device
 7.215s sys-devices-platform-MSFT0101:00-tpmrm-tpmrm0.device
 7.215s dev-tpmrm0.device
# 3
> uptime
  w
 17:33:36 up 18:25,  2 users,  load average: 0,49, 0,64, 0,44
 17:33:36 up 18:25,  2 users,  load average: 0,49, 0,64, 0,44
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
ivan     tty2      Пт23   18:25m  0.00s   ?    /usr/libexec/gnome-session-binary
ivan               Пт23    3:33   0.00s  1.86s /usr/lib/systemd/systemd --user
# 4
> ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    PID    PPID CMD                         %MEM %CPU
  10382    2678 /usr/lib64/firefox/firefox   5.7  3.1
  11681   10382 /usr/lib64/firefox/firefox   4.5  2.8
  11036   11035 /app/bin/Telegram            4.3  4.9
  12174    5747 /usr/lib64/chromium-browser  4.2 10.8
   2678    1669 /usr/bin/gnome-shell         3.2  0.4

> ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    PID    PPID CMD                         %MEM %CPU
  14358   14357 /app/bin/easyeffects --gapp  3.0 14.1
  12174    5747 /usr/lib64/chromium-browser  4.2 10.4
  11036   11035 /app/bin/Telegram            4.3  4.6
  11681   10382 /usr/lib64/firefox/firefox   5.0  3.2
  10382    2678 /usr/lib64/firefox/firefox   5.9  3.2
# 5
> systemctl list-dependencies multi-user.target
multi-user.target
● ├─abrt-journal-core.service
● ├─abrt-oops.service
○ ├─abrt-vmcore.service
● ├─abrt-xorg.service
● ├─abrtd.service
● ├─akmods.service
● ├─AmneziaVPN.service
○ ├─audit-rules.service
● ├─auditd.service
● ├─avahi-daemon.service
● ├─chronyd.service
● ├─cups.path
● ├─docker.service
● ├─firewalld.service
○ ├─flatpak-add-fedora-repos.service
● ├─lm_sensors.service
● ├─mcelog.service
○ ├─mdmonitor.service
● ├─ModemManager.service
● ├─mongod.service
● ├─NetworkManager.service
● ├─plymouth-quit-wait.service
○ ├─plymouth-quit.service
● ├─postgresql.service
● ├─snap.tor-snowflake.snowflake.service
● ├─sshd.service
○ ├─sssd.service
● ├─sysstat.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
● ├─systemd-resolved.service
○ ├─systemd-update-utmp-runlevel.service
● ├─systemd-user-sessions.service
● ├─thermald.service
● ├─tuned.service
● ├─var-lib-snapd-snap-core-17200.mount
● ├─var-lib-snapd-snap-core-17210.mount
● ├─var-lib-snapd-snap-core20-2496.mount
● ├─var-lib-snapd-snap-core20-2582.mount
● ├─var-lib-snapd-snap-core24-739.mount
● ├─var-lib-snapd-snap-core24-988.mount
● ├─var-lib-snapd-snap-hello\x2dworld-29.mount
● ├─var-lib-snapd-snap-riseup\x2dvpn-179.mount
● ├─var-lib-snapd-snap-riseup\x2dvpn-184.mount
● ├─var-lib-snapd-snap-snapd-23771.mount
● ├─var-lib-snapd-snap-snapd-24505.mount
● ├─var-lib-snapd-snap-tor\x2dsnowflake-75.mount
● ├─var-lib-snapd-snap-tor\x2dsnowflake-90.mount
× ├─vboxdrv.service
○ ├─vboxservice.service
○ ├─virtqemud.service
○ ├─vmtoolsd.service
● ├─waydroid-container.service
× ├─wg-quick@wg0.service
● ├─basic.target
● │ ├─-.mount
● │ ├─low-memory-monitor.service
○ │ ├─rpmdb-migrate.service
○ │ ├─rpmdb-rebuild.service
● │ ├─tmp.mount
● │ ├─paths.target
● │ ├─slices.target
● │ │ ├─-.slice
● │ │ └─system.slice
● │ ├─sockets.target
● │ │ ├─avahi-daemon.socket
● │ │ ├─cups.socket
● │ │ ├─dbus.socket
● │ │ ├─dm-event.socket
● │ │ ├─iscsid.socket
● │ │ ├─iscsiuio.socket
● │ │ ├─pcscd.socket
● │ │ ├─snapd.socket
● │ │ ├─sshd-unix-local.socket
● │ │ ├─sssd-kcm.socket
● │ │ ├─systemd-bootctl.socket
● │ │ ├─systemd-coredump.socket
● │ │ ├─systemd-creds.socket
● │ │ ├─systemd-hostnamed.socket
● │ │ ├─systemd-importd.socket
● │ │ ├─systemd-initctl.socket
● │ │ ├─systemd-journald-audit.socket
● │ │ ├─systemd-journald-dev-log.socket
● │ │ ├─systemd-journald.socket
○ │ │ ├─systemd-pcrextend.socket
○ │ │ ├─systemd-pcrlock.socket
● │ │ ├─systemd-sysext.socket
● │ │ ├─systemd-udevd-control.socket
● │ │ ├─systemd-udevd-kernel.socket
● │ │ ├─systemd-userdbd.socket
● │ │ ├─virtinterfaced.socket
● │ │ ├─virtnetworkd.socket
● │ │ ├─virtnodedevd.socket
● │ │ ├─virtnwfilterd.socket
● │ │ ├─virtproxyd.socket
● │ │ ├─virtqemud-admin.socket
● │ │ ├─virtqemud-ro.socket
● │ │ ├─virtqemud.socket
● │ │ ├─virtsecretd.socket
● │ │ └─virtstoraged.socket
● │ ├─sysinit.target
● │ │ ├─dev-hugepages.mount
● │ │ ├─dev-mqueue.mount
● │ │ ├─dracut-shutdown.service
○ │ │ ├─iscsi-onboot.service
○ │ │ ├─iscsi-starter.service
● │ │ ├─kmod-static-nodes.service
○ │ │ ├─ldconfig.service
● │ │ ├─lvm2-lvmpolld.socket
● │ │ ├─lvm2-monitor.service
● │ │ ├─plymouth-read-write.service
● │ │ ├─plymouth-start.service
● │ │ ├─proc-sys-fs-binfmt_misc.automount
○ │ │ ├─selinux-autorelabel-mark.service
● │ │ ├─sys-fs-fuse-connections.mount
● │ │ ├─sys-kernel-config.mount
● │ │ ├─sys-kernel-debug.mount
● │ │ ├─sys-kernel-tracing.mount
○ │ │ ├─systemd-ask-password-console.path
● │ │ ├─systemd-binfmt.service
○ │ │ ├─systemd-boot-random-seed.service
● │ │ ├─systemd-boot-update.service
○ │ │ ├─systemd-firstboot.service
○ │ │ ├─systemd-hibernate-clear.service
○ │ │ ├─systemd-hwdb-update.service
○ │ │ ├─systemd-journal-catalog-update.service
● │ │ ├─systemd-journal-flush.service
● │ │ ├─systemd-journald.service
○ │ │ ├─systemd-machine-id-commit.service
● │ │ ├─systemd-modules-load.service
● │ │ ├─systemd-network-generator.service
○ │ │ ├─systemd-pcrmachine.service
○ │ │ ├─systemd-pcrphase-sysinit.service
○ │ │ ├─systemd-pcrphase.service
● │ │ ├─systemd-random-seed.service
○ │ │ ├─systemd-repart.service
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
● │ │ │ ├─systemd-remount-fs.service
● │ │ │ └─tmp.mount
● │ │ ├─swap.target
● │ │ │ ├─dev-zram0.swap
● │ │ │ └─swapfile.swap
● │ │ └─veritysetup.target
● │ └─timers.target
● │   ├─fstrim.timer
● │   ├─logrotate.timer
● │   ├─plocate-updatedb.timer
● │   ├─raid-check.timer
● │   ├─systemd-tmpfiles-clean.timer
● │   └─unbound-anchor.timer
● ├─getty.target
○ │ └─getty@tty1.service
● ├─nfs-client.target
○ │ ├─auth-rpcgss-module.service
● │ ├─rpc-statd-notify.service
● │ └─remote-fs-pre.target
● └─remote-fs.target
○   ├─var-lib-machines.mount
●   └─nfs-client.target
○     ├─auth-rpcgss-module.service
●     ├─rpc-statd-notify.service
●     └─remote-fs-pre.target
# 6

> who -a
           загрузка системы 2025-06-27 23:07
ivan     ? seat0        2025-06-27 23:08   ?          2551
ivan     + tty2         2025-06-27 23:08 18:31        2551
# 7
> last -n 5
ivan     tty2         tty2             Fri Jun 27 23:08   still logged in
ivan     seat0        login screen     Fri Jun 27 23:08   still logged in
reboot   system boot  6.16.0-0.rc2.24. Fri Jun 27 23:07   still running
ivan     tty2         tty2             Thu Jun 26 20:30 - down   (00:01)
ivan     seat0        login screen     Thu Jun 26 20:30 - down   (00:01)

wtmp begins Fri Jun 20 20:27:36 2025
# 8
> free -h
               total        used        free      shared  buff/cache   available
Mem:           7,1Gi       5,3Gi       239Mi       1,5Gi       3,4Gi       1,9Gi
Swap:           15Gi       2,3Gi        12Gi

# 9
> cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
MemTotal:        7491064 kB
MemAvailable:    1960448 kB
SwapTotal:      15879160 kB

# 10
> traceroute github.com
traceroute to github.com (140.82.121.3), 30 hops max, 60 byte packets
 1  _gateway (10.91.48.1)  2.321 ms  2.285 ms  2.276 ms
 2  10.252.6.1 (10.252.6.1)  2.269 ms  2.260 ms  2.253 ms
 3  188.170.164.34 (188.170.164.34)  6.355 ms  6.347 ms  6.340 ms
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  83.169.204.82 (83.169.204.82)  49.744 ms 83.169.204.78 (83.169.204.78)  47.566 ms  44.166 ms
 9  netnod-ix-ge-a-sth-1500.inter.link (194.68.123.180)  40.855 ms  40.830 ms  40.670 ms
10  r1-cph1-dk.as5405.net (94.103.180.38)  61.661 ms  58.438 ms  63.711 ms
11  * * *
12  r3-ber1-de.as5405.net (94.103.180.2)  64.935 ms  67.345 ms  65.074 ms
13  * * *
14  * * *
15  * * *
16  * * *
17  r1-fra3-de.as5405.net (94.103.180.24)  69.125 ms  72.427 ms  69.097 ms
18  cust-sid435.r1-fra3-de.as5405.net (45.153.82.39)  72.412 ms cust-sid436.fra3-de.as5405.net (45.153.82.37)  63.135 ms cust-sid435.r1-fra3-de.as5405.net (45.153.82.39)  59.665 ms
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
# 11
> dig github.com

; <<>> DiG 9.18.36 <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 14705
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;github.com.			IN	A

;; ANSWER SECTION:
github.com.		1	IN	A	140.82.121.4

;; Query time: 3 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sat Jun 28 17:41:15 MSK 2025
;; MSG SIZE  rcvd: 55
# 12
> sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
[sudo] пароль для ivan: 
tcpdump: WARNING: any: That device doesn't support promiscuous mode
(Promiscuous mode not supported on the "any" device)
dropped privs to tcpdump
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
17:41:45.153166 lo    In  IP 127.0.0.1.44157 > 127.0.0.53.53: 35040+ [1au] A? google.com. (51)
17:41:45.153423 wlo1  Out IP 10.91.60.3.36236 > 10.90.137.30.53: 62470+ [1au] A? google.com. (39)
17:41:45.157621 wlo1  In  IP 10.90.137.30.53 > 10.91.60.3.36236: 62470 2/0/1 CNAME forcesafesearch.google.com., A 216.239.38.120 (85)
17:41:45.157743 lo    In  IP 127.0.0.53.53 > 127.0.0.1.44157: 35040 2/0/1 CNAME forcesafesearch.google.com., A 216.239.38.120 (85)
17:41:46.887521 wlo1  Out IP 10.91.60.3.47576 > 10.90.137.30.53: 49198+ [1au] A? alive.github.com. (45)
5 packets captured
14 packets received by filter
0 packets dropped by kernel

# 13
> dig -x 8.8.4.4
  dig -x 1.1.2.2

; <<>> DiG 9.18.36 <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 17492
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.		IN	PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.	45351	IN	PTR	dns.google.

;; Query time: 7 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sat Jun 28 17:42:09 MSK 2025
;; MSG SIZE  rcvd: 73


; <<>> DiG 9.18.36 <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 4353
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.		IN	PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.		900	IN	SOA	ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22230 7200 1800 604800 3600

;; Query time: 502 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sat Jun 28 17:42:10 MSK 2025
;; MSG SIZE  rcvd: 137

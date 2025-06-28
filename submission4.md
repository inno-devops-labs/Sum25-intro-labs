# Operating Systems & Networking Lab Submission

## Task 1: Operating System Analysis

### 1.1: Boot Performance Analysis

I analyzed the system boot performance using `systemd-analyze` commands to understand the startup process and identify potential bottlenecks.

**System Boot Time Analysis:**

```bash
$ systemd-analyze
Startup finished in 3.299s (firmware) + 2.408s (loader) + 4.174s (kernel) + 7.005s (userspace) = 16.887s
graphical.target reached after 6.770s in userspace.
```

**Key Observations:**

- Total boot time: 16.887 seconds
- Firmware initialization: 3.299s
- Bootloader: 2.408s
- Kernel initialization: 4.174s
- Userspace services: 7.005s
- Graphical target reached in 6.770s

**Service Blame Analysis:**

```bash
$ systemd-analyze blame
2min 2.803s reflector.service
     3.841s NetworkManager-wait-online.service
      721ms NetworkManager.service
      636ms docker.service
      289ms containerd.service
      249ms ananicy.service
      233ms tlp.service
      232ms dev-nvme0n1p2.device
      187ms wg-quick@wg0.service
      156ms user@1000.service
      149ms accounts-daemon.service
      109ms udisks2.service
      109ms polkit.service
      108ms upower.service
      105ms ModemManager.service
       90ms systemd-logind.service
       78ms systemd-tmpfiles-setup.service
       77ms systemd-fsck@dev-disk-by\x2duuid-26B8\x2d4DBF.service
       72ms systemd-tmpfiles-clean.service
       70ms systemd-udev-trigger.service
       66ms systemd-udevd.service
       62ms lvm2-monitor.service
       61ms postgresql.service
       59ms systemd-resolved.service
```

**Critical Findings:**

- **reflector.service** is the biggest bottleneck, taking over 2 minutes to complete
- **NetworkManager-wait-online.service** adds 3.8 seconds to boot time
- Docker and container services contribute to boot delay

### 1.2: System Load Analysis

**Current System Load:**

```bash
$ uptime
 15:53:47 up  2:18,  1 user,  load average: 1,15, 1,38, 1,43
```

**User Activity:**

```bash
$ w
 15:53:51 up  2:18,  1 user,  load average: 1,15, 1,38, 1,43
USER     TTY       LOGIN@   IDLE   JCPU   PCPU  WHAT
luzinsan tty2      13:36    2:18m 21:14   0.01s /usr/lib/sddm/sddm-helper --socke
```

**Analysis:**

- System has been running for 2 hours and 18 minutes
- Load averages show moderate system activity (1.15, 1.38, 1.43)
- Single user session active since 13:36
- User has been idle for 2 hours and 18 minutes

### 1.3: Process Forensics

**Top Memory-Consuming Processes:**

```bash
$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    PID    PPID CMD                         %MEM %CPU
 191134   30623 /tmp/.mount_VSCodeAlCWdj/us  6.8  5.4
   4215       1 /usr/lib/firefox/firefox ht  5.9 13.5
    909     902 /usr/lib/Xorg -nolisten tcp  5.2 15.3
 162947    4215 /usr/lib/firefox/firefox -c  4.9  0.7
  30813   30662 /tmp/.mount_VSCodeAlCWdj/us  4.8  8.5
```

**Top CPU-Consuming Processes:**

```bash
$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    PID    PPID CMD                         %MEM %CPU
    909     902 /usr/lib/Xorg -nolisten tcp  5.4 15.3
   4215       1 /usr/lib/firefox/firefox ht  5.0 13.5
  30813   30662 /tmp/.mount_VSCodeAlCWdj/us  4.7  8.4
 165705  165562 /opt/gitkraken/gitkraken --  2.9  7.1
   4394    4215 /usr/lib/firefox/firefox -c  3.5  6.2
```

**Resource Utilization Patterns:**

- **Xorg** is the highest CPU consumer (15.3%) with moderate memory usage (5.4%)
- **Firefox** processes are significant resource consumers (13.5% CPU, 5.9% memory)
- **VSCode** processes show moderate resource usage (5.4-8.5% CPU, 4.8-6.8% memory)
- **GitKraken** contributes to CPU load (7.1%)

### 1.4: Service Dependencies

**Default Target Dependencies:**

```bash
$ systemctl list-dependencies
default.target
● ├─sddm-plymouth.service
● └─multi-user.target
●   ├─avahi-daemon.service
○   ├─choose-mirror.service
●   ├─cups.path
●   ├─cups.service
●   ├─dbus-broker.service
●   ├─docker.service
○   ├─hv_fcopy_daemon.service
○   ├─hv_kvp_daemon.service
○   ├─hv_vss_daemon.service
●   ├─ModemManager.service
●   ├─NetworkManager.service
●   ├─nohang.service
○   ├─pacman-init.service
●   ├─plymouth-quit-wait.service
●   ├─plymouth-quit.service
×   ├─postgresql.service
○   ├─reflector.service
○   ├─snapd.apparmor.service
●   ├─sshd.service
●   ├─systemd-ask-password-wall.path
●   ├─systemd-logind.service
```

**Multi-User Target Dependencies:**

```bash
$ systemctl list-dependencies multi-user.target
multi-user.target
● ├─avahi-daemon.service
○ ├─choose-mirror.service
● ├─cups.path
● ├─cups.service
● ├─dbus-broker.service
● ├─docker.service
○ ├─hv_fcopy_daemon.service
○ ├─hv_kvp_daemon.service
○ ├─hv_vss_daemon.service
● ├─ModemManager.service
● ├─NetworkManager.service
● ├─nohang.service
○ ├─pacman-init.service
● ├─plymouth-quit-wait.service
● ├─plymouth-quit.service
× ├─postgresql.service
○ ├─reflector.service
○ ├─snapd.apparmor.service
● ├─sshd.service
● ├─systemd-ask-password-wall.path
● ├─systemd-logind.service
● ├─systemd-resolved.service
● ├─systemd-user-sessions.service
```

**Service Relationship Analysis:**

- **Active services (●)**: Core system services like NetworkManager, Docker, SSH, CUPS
- **Inactive services (○)**: Optional services like reflector, pacman-init
- **Failed services (×)**: PostgreSQL service failed to start
- **Docker ecosystem**: Docker and containerd services are active
- **Network services**: NetworkManager, systemd-resolved, ModemManager active

### 1.5: User Sessions Audit

**Current Login Activity:**

```bash
$ who -a
           system boot  2025-06-28 13:35
luzinsan + tty2         2025-06-28 13:36 02:19        1478 (:0)
```

**Recent Login History:**

```bash
$ last -n 5
luzinsan tty2         :0               Sat Jun 28 13:36   still logged in
reboot   system boot  6.13.1-arch1-1   Sat Jun 28 13:35   still running
luzinsan tty2         :0               Tue Jun 17 00:46 - crash (11+12:49)
reboot   system boot  6.13.1-arch1-1   Tue Jun 17 00:46   still running
luzinsan tty2         :0               Sat Jun 14 16:15 - crash (2+08:30)
```

**Session Analysis:**

- Current session started at 13:36 on June 28, 2025
- User logged in via tty2 with display :0
- Previous sessions show system crashes on June 17 and June 14
- Session has been active for 2 hours and 19 minutes

### 1.6: Memory Analysis

**Memory Usage Overview:**

```bash
$ free -h
               total        used        free      shared  buff/cache   available
Mem:           7,6Gi       5,9Gi       860Mi       700Mi       1,9Gi       1,7Gi
Swap:            9Gi       4,0Gi       6,0Gi
```

**Detailed Memory Information:**

```bash
$ cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
MemTotal:        7924872 kB
MemAvailable:    1527456 kB
SwapTotal:      10485756 kB
```

**Memory Utilization Analysis:**

- **Total RAM**: 7.6GB (7,924,872 kB)
- **Used Memory**: 5.9GB (77.6% of total)
- **Available Memory**: 1.7GB (1,527,456 kB)
- **Swap Usage**: 4.0GB out of 9GB total (44.4% utilization)
- **Buffer/Cache**: 1.9GB
- **Shared Memory**: 700MB

**Critical Observations:**

- High memory usage (77.6% of RAM)
- Significant swap usage (4GB) indicates memory pressure
- Only 1.7GB available for new processes
- System may benefit from memory optimization

---

## Task 2: Networking Analysis

### 2.1: Network Path Tracing

**Traceroute to GitHub:**

```bash
$ traceroute github.com
traceroute to github.com (140.82.121.3), 30 hops max, 60 byte packets
 1  _gateway (192.168.193.190)  2.370 ms  2.313 ms  2.521 ms
 2  * 10.242.254.22 (10.242.254.22)  149.329 ms *
 3  * * *
 4  10.242.255.29 (10.242.255.29)  152.136 ms 10.242.255.35 (10.242.255.35)  152.080 ms 10.242.255.29 (10.242.255.29)  152.107 ms
 5  * * *
 6  10.242.16.254 (10.242.16.254)  149.041 ms  71.756 ms  69.936 ms
 7  172.25.247.32 (172.25.247.32)  50.089 ms 172.25.246.32 (172.25.246.32)  49.904 ms 172.25.247.32 (172.25.247.32)  50.043 ms
 8  172.25.129.161 (172.25.129.161)  49.875 ms 172.25.129.163 (172.25.129.163)  61.556 ms  61.333 ms
 9  telia.inet2.ru (85.112.122.15)  61.575 ms 185.211.156.227 (185.211.156.227)  61.060 ms telia.inet2.ru (85.112.112.15)  61.329 ms
10  telia.inet2.ru (85.112.122.15)  62.050 ms sto-bb1-link.ip.twelve99.net (62.115.143.24)  80.162 ms telia.inet2.ru (85.112.122.15)  61.283 ms
11  ffm-bb1-link.ip.twelve99.net (62.115.143.29)  112.158 ms sto-bb1-link.ip.twelve99.net (62.115.143.24)  80.116 ms ffm-bb1-link.ip.twelve99.net (62.115.143.29)  114.420 ms
12  * ffm-bb1-link.ip.twelve99.net (62.115.143.29)  89.200 ms *
13  * github-ic-350972.ip.twelve99-cust.net (62.115.182.171)  92.779 ms ffm-b11-link.ip.twelve99.net (62.115.124.117)  86.510 ms
14  github-ic-350972.ip.twelve99-cust.net (62.115.182.171)  90.328 ms * *
15  * * *

```

**Network Path Analysis:**

- **Local Gateway**: 192.168.193.190 (2.3ms latency)
- **ISP Network**: 10.242.x.x range (149-152ms latency)
- **Backbone**: 172.25.x.x range (49-61ms latency)
- **International Transit**: Telia (85.112.122.15) and Twelve99 networks
- **Destination**: GitHub via Twelve99 customer network
- **Total Path**: 14 hops to reach GitHub infrastructure
- **Latency Pattern**: High latency in ISP network (149ms), then stable around 50-90ms

### 2.2: DNS Resolution Analysis

**DNS Query for GitHub:**

```bash
$ dig github.com

; <<>> DiG 9.20.5 <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 11412
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags; udp: 65494
;; QUESTION SECTION:
;github.com.			IN	A

;; ANSWER SECTION:
github.com.		24	IN	A	140.82.121.3

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sat Jun 28 15:57:11 MSK 2025
;; MSG SIZE  rcvd: 55
```

**DNS Analysis:**

- **Query Type**: A record for github.com
- **Response**: 140.82.121.3
- **TTL**: 24 seconds (very short TTL for load balancing)
- **DNS Server**: Local resolver (127.0.0.53)
- **Query Time**: 0ms (cached response)
- **Flags**: Recursive query with recursion available

### 2.3: Packet Capture Analysis

**DNS Traffic Capture (First Run):**

```bash
$ sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
tcpdump: WARNING: any: That device doesn't support promiscuous mode
(Promiscuous mode not supported on the "any" device)
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
15:57:54.733582 wlan0 Out IP 192.168.193.191.54517 > 192.168.193.190.53: 13982+ AAAA? api2direct.cursor.sh. (38)
15:57:54.733608 wlan0 Out IP 192.168.193.191.38810 > 192.168.193.190.53: 2313+ A? api2direct.cursor.sh. (38)
15:57:54.957530 wlan0 In  IP 192.168.193.190.53 > 192.168.193.191.54517: 13982 0/0/0 (38)
15:57:55.034708 wlan0 In  IP 192.168.193.190.53 > 192.168.193.191.38810: 2313 8/0/0 A 44.218.214.175, A 54.90.56.198, A 184.73.136.155, A 18.208.61.91, A 54.165.50.148, A 98.82.84.33, A 52.207.181.123, A 98.83.83.141 (166)

4 packets captured
4 packets received by filter
0 packets dropped by kernel
```

**DNS Traffic Capture (Second Run):**

```bash
$ sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
tcpdump: WARNING: any: That device doesn't support promiscuous mode
(Promiscuous mode not supported on the "any" device)
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
15:58:10.585776 lo    In  IP 127.0.0.1.54611 > 127.0.0.53.53: 26136+ [1au] A? github.com. (51)
15:58:10.585963 lo    In  IP 127.0.0.53.53 > 127.0.0.1.54611: 26136 1/0/1 A 140.82.121.3 (55)

2 packets captured
4 packets received by filter
0 packets dropped by kernel
```

**Packet Capture Analysis:**

- **First Capture**: Shows DNS queries for api2direct.cursor.sh (VSCode-related)
  - AAAA query (IPv6) returned no results
  - A query (IPv4) returned 8 different IP addresses (load balancing)
- **Second Capture**: Shows local DNS query for github.com
  - Query from 127.0.0.1 to local DNS resolver (127.0.0.53)
  - Successful resolution to 140.82.121.3
- **Network Interface**: wlan0 for external queries, lo for local queries
- **DNS Server**: 192.168.193.190 (gateway) for external, 127.0.0.53 for local

### 2.4: Reverse DNS Analysis

**Reverse DNS for 8.8.4.4 (Google DNS):**

```bash
$ dig -x 8.8.4.4

; <<>> DiG 9.20.5 <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 53347
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.		IN	PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.	9588	IN	PTR	dns.google.

;; Query time: 75 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sat Jun 28 15:58:33 MSK 2025
;; MSG SIZE  rcvd: 73
```

**Reverse DNS for 1.1.2.2 (Cloudflare DNS):**

```bash
$ dig -x 1.1.2.2

; <<>> DiG 9.20.5 <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 63090
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags; udp: 65494
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.		IN	PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.		1797	IN	SOA	ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22230 7200 1800 604800 3600

;; Query time: 102 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sat Jun 28 15:58:53 MSK 2025
;; MSG SIZE  rcvd: 137
```

**Reverse DNS Comparison:**

- **8.8.4.4**: Successfully resolves to `dns.google.` (Google's public DNS)
- **1.1.2.2**: Returns NXDOMAIN (no reverse DNS record exists)
- **Query Times**: 75ms for Google DNS, 102ms for Cloudflare DNS
- **Authority**: APNIC (Asia Pacific Network Information Centre) manages the 1.1.2.2 reverse zone
- **TTL**: Google DNS has 9588 seconds TTL, Cloudflare has no record

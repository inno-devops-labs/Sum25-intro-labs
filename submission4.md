# Operating Systems & Networking Lab

## Task 1: Operating System Analysis

**Objective**: Analyze key OS components including boot performance, resource usage, services, sessions, and memory management.

### 1.1: Boot Performance

1. **Analyze System Boot Time**:

Input:
   ```sh
   systemd-analyze
   systemd-analyze blame > blame_output.txt
   ```

Output for `systemd-analyze`:
```
Startup finished in 14.450s (userspace)
graphical.target reached after 14.341s in userspace
```

Output for `systemd-analyze blame`:
```
6.729s landscape-client.service
2.437s dev-sdd.device
2.278s snapd.seeded.service
2.003s snapd.service
1.922s systemd-journal-flush.service
1.660s networkd-dispatcher.service
1.321s systemd-udev-trigger.service
1.005s systemd-sysctl.service
 896ms rsyslog.service
 732ms systemd-logind.service
 723ms systemd-sysusers.service
 646ms apport.service
...
# See rest in blame_output.txt
```

2. **Check System Load**:

Input:
   ```sh
   uptime
   w
   ```

Output for `uptime`:
```
23:02:35 up 18 min,  1 user,  load average: 0.00, 0.03, 0.04
```

Output for `w`:
```
23:02:36 up 18 min,  1 user,  load average: 0.00, 0.03, 0.04
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
justsome pts/1    -                22:45   16:55   0.08s  0.04s -bash
```

### 1.2: Process Forensics

1. **Identify Resource-Intensive Processes**:

Input:
   ```sh
   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
   ```

Output for first command (Top by memory usage):
```
    PID    PPID CMD                         %MEM %CPU
    291       1 /usr/bin/python3 /usr/share  0.2  0.0
    908       1 /usr/libexec/packagekitd     0.2  0.0
    254       1 /usr/bin/python3 /usr/bin/n  0.2  0.0
    103       1 /lib/systemd/systemd-journa  0.2  0.0
    236       1 /lib/systemd/systemd-resolv  0.1  0.0
```

Output for second command (Top by CPU usage)
```
    PID    PPID CMD                         %MEM %CPU
      7       2 plan9 --control-socket 7 --  0.0  0.4
      1       0 /sbin/init                   0.1  0.1
      2       1 /init                        0.0  0.0
    103       1 /lib/systemd/systemd-journa  0.2  0.0
    134       1 /lib/systemd/systemd-udevd   0.0  0.0
```

### 1.3: Service Dependencies

1. **Map Service Relationships**:

Input:
   ```sh
   systemctl list-dependencies > task1.3.1-output.txt
   systemctl list-dependencies multi-user.target > task1.3.2-output.txt
   ```

Output for first command:
```
default.target
● ├─apport.service
○ ├─display-manager.service
○ ├─systemd-update-utmp-runlevel.service
○ ├─wslg.service
● └─multi-user.target
●   ├─apport.service
●   ├─console-setup.service
●   ├─cron.service
●   ├─dbus.service
○   ├─dmesg.service
○   ├─e2scrub_reap.service
○   ├─irqbalance.service
○   ├─landscape-client.service
...
# More in task1.3.1-output.txt
```

Output for second command:
```
multi-user.target
● ├─apport.service
● ├─console-setup.service
● ├─cron.service
● ├─dbus.service
○ ├─dmesg.service
○ ├─e2scrub_reap.service
○ ├─irqbalance.service
○ ├─landscape-client.service
● ├─networkd-dispatcher.service
● ├─plymouth-quit-wait.service
● ├─plymouth-quit.service
● ├─rsyslog.service
...
# More in task1.3.2-output.txt
```

### 1.4: User Sessions

1. **Audit Login Activity**:

Input:
   ```sh
   who -a
   last -n 5
   ```

Output of `who -a`
```
           system boot  2025-06-28 22:45
LOGIN      tty1         2025-06-28 22:45               278 id=tty1
LOGIN      console      2025-06-28 22:45               268 id=cons
justsomedude - pts/1        2025-06-28 22:45 00:34         438
           run-level 5  2025-06-28 22:45
```

Output of `last -n 5`
```
justsome pts/1                         Sat Jun 28 22:45   still logged in
reboot   system boot  6.6.87.2-microso Sat Jun 28 22:45   still running
justsome pts/1                         Sat Jun 28 22:28 - crash  (00:16)
reboot   system boot  6.6.87.2-microso Sat Jun 28 22:28   still running
justsome pts/1                         Thu Jun 19 20:55 - crash (9+01:32)
```

### 1.5: Memory Analysis

1. **Inspect Memory Allocation**:

Input:
   ```sh
   free -h
   cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
   ```

Output of `free -h`
```
               total        used        free      shared  buff/cache   available
Mem:           7.7Gi       325Mi       7.2Gi       3.0Mi       136Mi       7.2Gi
Swap:          2.0Gi          0B       2.0Gi
```

Output of second command:
```
MemTotal:        8048856 kB
MemAvailable:    7560260 kB
SwapTotal:       2097152 kB
```

## Task 2: Networking Analysis

**Objective**: Perform network diagnostics including path tracing, DNS inspection, packet capture, and reverse lookups.

### 2.1: Network Path Tracing

1. **Traceroute Execution**:

Input:
   ```sh
   traceroute github.com
   ```

Output:
```
justsomedude@DESKTOP-VD06QG9:~/Sum25-intro-labs$ traceroute github.com
traceroute to github.com (140.82.121.###), 30 hops max, 60 byte packets
 1  DESKTOP-VD06QG9.mshome.net (172.26.128.###)  0.418 ms  0.362 ms  0.298 ms
 2  10.91.0.### (10.91.0.###)  4.846 ms  4.836 ms  4.813 ms
 3  10.252.6.### (10.252.6.###)  4.830 ms  4.817 ms  4.765 ms
 4  188.170.164.### (188.170.164.###)  8.350 ms  8.304 ms  8.292 ms
 5  * * *
 6  * * *
 7  * * *
 8  * * *
 9  83.169.204.### (83.169.204.###)  52.439 ms 83.169.204.### (83.169.204.###)  44.518 ms  44.499 ms
10  netnod-ix-ge-b-sth-1500.inter.link (194.68.128.###)  47.198 ms  45.973 ms netnod-ix-ge-a-sth-1500.inter.link (194.68.123.###)  46.385 ms
11  r1-cph1-dk.as5405.net (94.103.180.###)  64.243 ms  71.441 ms  64.170 ms
12  r4-ber1-de.as5405.net (94.103.180.###)  64.331 ms  71.319 ms  64.263 ms
13  r3-ber1-de.as5405.net (94.103.180.###)  64.214 ms  63.896 ms  70.898 ms
14  * * *
15  * * *
16  * * *
17  * * *
18  r1-fra3-de.as5405.net (94.103.180.###)  63.835 ms  63.748 ms  63.583 ms
19  cust-sid436.fra3-de.as5405.net (45.153.82.###)  64.739 ms cust-sid435.r1-fra3-de.as5405.net (45.153.82.###)  65.895 ms cust-sid436.fra3-de.as5405.net (45.153.82.###)  89.706 ms
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

2. **DNS Resolution Check**:

Input:
   ```sh
   dig github.com
   ```

Output:
```
; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 21023
;; flags: qr rd ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             0       IN      A       140.82.121.###

;; Query time: 33 msec
;; SERVER: 172.26.128.###53(172.26.128.###) (UDP)
;; WHEN: Sat Jun 28 23:36:41 MSK 2025
;; MSG SIZE  rcvd: 54
```
- GitHub's IP Management:
    - IP 140.82.121.### (vs 140.82.121.### in traceroute)
    - TTL=0 confirms active IP management
- DNS Security:
    - `ad` flag: DNSSEC validation succeeded
- WSL-Specific Behavior:
    - Resolver IP 172.26.128.### is WSL's virtual switch

### 2.2: Packet Capture

1. **Capture DNS Traffic**:

Input:
   ```sh
   sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
   ```

Output:
```
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
23:53:04.617026 eth0  In  IP 172.26.128.###.51303 > 172.26.130.###.53: Flags [S], seq 1073457033, win 64240, options [mss 1460,nop,wscale 8,nop,nop,sackOK], length 0
23:53:04.617065 eth0  Out IP 172.26.130.###.53 > 172.26.128.###.51303: Flags [R.], seq 0, ack 1073457034, win 0, length 0
23:53:05.141360 eth0  In  IP 172.26.128.###.51303 > 172.26.130.###.53: Flags [S], seq 1073457033, win 64240, options [mss 1460,nop,wscale 8,nop,nop,sackOK], length 0
23:53:05.141383 eth0  Out IP 172.26.130.###.53 > 172.26.128.###.51303: Flags [R.], seq 0, ack 1, win 0, length 0
23:53:05.661571 eth0  In  IP 172.26.128.###.51303 > 172.26.130.###.53: Flags [S], seq 1073457033, win 64240, options [mss 1460,nop,wscale 8,nop,nop,sackOK], length 0
5 packets captured
6 packets received by filter
0 packets dropped by kernel
```

### 2.3: Reverse DNS

1. **Perform PTR Lookups**:

Input:
   ```sh
   dig -x 8.8.4.4
   dig -x 1.1.2.2
   ```

Output for first command:
```; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 8916
;; flags: qr rd ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   0       IN      PTR     dns.google.

;; Query time: 24 msec
;; SERVER: 172.26.128.###53(172.26.128.###) (UDP)
;; WHEN: Sat Jun 28 23:55:41 MSK 2025
;; MSG SIZE  rcvd: 82
```
- Reverse DNS Mechanics:
    - IP 8.8.4.### → Reversed to 4.4.8.8.in-addr.arpa
- Google's DNS Infrastructure:
    - 8.8.4.### resolves to dns.google
- TTL=0 Significance:
    - Prevents caching of DNS results
- DNSSEC Validation:
    - `ad` flag confirms verification
- WSL DNS Proxy Behavior:
    - Resolver IP 172.26.128.### is WSL's virtual switch

Output for second command:
```
; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 23263
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.          IN      PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.         898     IN      SOA     ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22230 7200 1800 604800 3600

;; Query time: 1532 msec
;; SERVER: 172.26.128.###53(172.26.128.###) (UDP)
;; WHEN: Sat Jun 28 23:58:38 MSK 2025
;; MSG SIZE  rcvd: 137
```
- IP Address Ownership:
    - 1.1.2.### belongs to APNIC
- NXDOMAIN Meaning:
    - No PTR record configured
- SOA Record Significance:
    - ns.apnic.net is ultimate authority
- Performance Analysis:
    - 1532 ms query time
- Cloudflare DNS vs. Reverse DNS:
    1.1.2.### → No PTR record

# IP Censorship
All IPs have been sanitized using DeepSeek.
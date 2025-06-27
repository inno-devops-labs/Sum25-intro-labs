# Lab 4: Operating Systems & Networking Lab

## Task 1: Operating System Analysis

### 1.1 Boot Performance

#### 1 Analyze System Boot Time

**Command:** `systemd-analyze`  
```sh
Startup finished in 2.200s (userspace) 
graphical.target reached after 2.156s in userspace
```
We just get a time to boot our system. If we use `systemd-analyze blame`, we get time to boot each of services, like:

```sh
34.788s apt-daily-upgrade.service
 1.671s snapd.seeded.service
 1.258s snapd.service
  415ms networkd-dispatcher.service
  409ms logrotate.service
  388ms systemd-logind.service
  349ms dev-sdd.device
  191ms systemd-resolved.service
  121ms user@1000.service
  108ms systemd-udev-trigger.service
   77ms systemd-journal-flush.service
   75ms e2scrub_reap.service
   61ms systemd-udevd.service
   57ms keyboard-setup.service
```

#### 2 Check System Load

**Command:** `uptime`
```sh
12:50:57 up 23 min,  1 user,  load average: 0.05, 0.10, 0.09
```
Getting information about using time and average load for last 1-2 minutes.

**Command:** `w`
```sh
12:55:22 up 28 min,  1 user,  load average: 0.19, 0.16, 0.11
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
dm_lin   pts/1    -                12:27   28:00   0.02s  0.01s -bash
```

This command work as uptime + information about user

### 1.2 Process Forensics

#### 1 Identify Resource-Intensive Processes

**Command:** `ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6`

```sh
    PID    PPID CMD                         %MEM %CPU
    579       575 /home/user/.vscode-server  2.2  2.7
   6395       579 /home/user/.vscode-server  2.1  3.9
    337     245 /snap/ubuntu-desktop-instal  1.0  0.4
   2633       579 /home/user/.vscode-server  0.9  0.2
   6382       579 /home/user/.vscode-server  0.7  0.0
```

Shows information about processes and how it load the system and sort it by memory load

**Command:** `ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6`

```sh
    PID    PPID CMD                         %MEM %CPU
   6395       579 /home/user/.vscode-server  2.3  3.1
      1       0 /lib/systemd/systemd --syst  0.1  1.2
    579       575 /home/user/.vscode-server  2.2  0.9
    478     337 python3 /snap/ubuntu-deskto  0.4  0.5
    337     245 /snap/ubuntu-desktop-instal  1.0  0.2
```

Actually the same, but sorting by CPU load

### 1.3 Service Dependencies

#### 1 Map Service Relationships

**Command:** `systemctl list-dependencies`

```sh
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
lines 1-11...skipping...
...
```

It shows dependencies of default service, and we can choose other one service like:

**Command:** `systemctl list-dependencies multi-user.target`

```sh
multi-user.target
● ├─apport.service
● ├─console-setup.service
● ├─cron.service
● ├─dbus.service
○ ├─dmesg.service
○ ├─e2scrub_reap.service
○ ├─irqbalance.service
● ├─networkd-dispatcher.service
● ├─plymouth-quit-wait.service
● ├─plymouth-quit.service
● ├─rsyslog.service
● ├─snap-bare-5.mount
● ├─snap-core22-1963.mount
● ├─snap-core22-2010.mount
● ├─snap-gtk\x2dcommon\x2dthemes-1535.mount
● ├─snap-snapd-24505.mount
lines 1-17...skipping...
...
```

### 1.4 User Sessions

#### 1 Audit Login Activity

**Command:** `who -a`

```sh
           system boot  2025-06-27 12:27
           run-level 5  2025-06-27 12:27
LOGIN      console      2025-06-27 12:27               274 id=cons
LOGIN      tty1         2025-06-27 12:27               279 id=tty1
dm_lin   - pts/1        2025-06-27 12:27 00:48         450
```

Shows information about current logged in users in your system along with other useful details, and this is a part of `w` output

**Command:** `last -n 5`

```sh
dm_lin   pts/1                         Fri Jun 27 12:27   still logged in
reboot   system boot  6.6.87.2-microso Fri Jun 27 12:27   still running
dm_lin   pts/1                         Mon Jun  2 17:39 - crash (24+18:47)
reboot   system boot  6.6.87.1-microso Mon Jun  2 17:39   still running
dm_lin   pts/1                         Mon Apr 28 01:20 - crash (35+16:19)

wtmp begins Thu Sep 12 23:48:09 2024
```

We get last 5 users logged in system since file `/var/log/wtmp` was created

### 1.5 Memory Analysis

#### 1 Inspect Memory Allocation

**Command:** `free -h`

```sh
               total        used        free      shared  buff/cache   available
Mem:           7.7Gi       904Mi       6.5Gi       3.0Mi       275Mi       6.6Gi
Swap:          2.0Gi          0B       2.0Gi
```

Allows to user check for memory on system, total/used/free and other

**Command:** `cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable`

```sh
MemTotal:        8047828 kB
MemAvailable:    6946088 kB
SwapTotal:       2097152 kB
```

Shows total volume of memory and available part of it

## Task 2: Networking Analysis

### 2.1 Network Path Tracing

#### 1 Traceoute Execution

**Command:** `traceroute github.com`

```sh
traceroute to github.com (140.82.121.3), 64 hops max
  1   172.24.0.1  0.203ms  0.414ms  0.203ms 
  2   192.168.1.XXX  2.099ms  1.807ms  1.699ms 
  3   10.XXX.XXX.XXX  5.958ms  4.155ms  4.107ms 
  4   89.17.35.249  4.456ms  3.416ms  3.567ms 
  5   188.234.79.90  9.120ms  5.868ms  4.977ms 
  6   62.115.11.10  4.489ms  3.556ms  3.752ms 
  7   62.115.143.24  23.752ms  23.914ms  24.067ms 
  8   62.115.143.29  48.013ms  47.862ms  48.870ms 
  9   *  *  * 
 10   62.115.182.171  49.256ms  47.473ms  47.892ms 
 11   *  *  * 
```

This command in Linux is a network diagnostic tool used to trace the path a packet takes from your computer to a destination. And some packets was blocked

#### 2 DNS Resolution Check

**Command:** `dig github.com`

```sh
; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 18828
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             60      IN      A       140.82.121.3

;; Query time: 59 msec
;; SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
;; WHEN: Fri Jun 27 13:41:00 MSK 2025
;; MSG SIZE  rcvd: 44
```

This is a powerful tool for querying Domain Name System (DNS) servers.

### 2.2 Packet Capture

#### 1 Capture DNS Traffic

**Command:** `sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn`

```sh
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes

0 packets captured
0 packets received by filter
0 packets dropped by kernel
```

This is command-line packet analyzer used to capture and display network traffic. There are no any DNS traffics by default in WSL, that's why 0 packets, if traffic was existed, we will see something like this:

```sh
13:45:01.123456 IP 192.168.1.XXX.12345 > 8.8.8.8.53: A? google.com
```

### 2.3 Reverse DNS 

#### 1 Perform PTR Lookups

**Command:** `dig -x 8.8.4.4`

```sh
; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 57405
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   1390    IN      PTR     dns.google.

;; Query time: 24 msec
;; SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
;; WHEN: Fri Jun 27 13:48:50 MSK 2025
;; MSG SIZE  rcvd: 73
```

This method to perform a reverse DNS lookup. 8.8.4.4 is a public Google DNS-server and all is correct

**Command:** `dig -x 1.1.2.2`

```sh
; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 6698
;; flags: qr rd ra ad; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.          IN      PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.         1750    IN      SOA     ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22230 7200 1800 604800 3600

;; Query time: 27 msec
;; SERVER: 10.255.255.254#53(10.255.255.254) (UDP)
;; WHEN: Fri Jun 27 13:52:07 MSK 2025
;; MSG SIZE  rcvd: 137
```

The same, but use another IP, but 1.1.2.2 is not a public domain, that's why we get NXDOMAIN
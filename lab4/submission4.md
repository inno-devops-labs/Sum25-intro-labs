# Operating Systems & Networking Lab

## Task 1: Operating System Analysis

### 1.1 Boot Performance

**Command:** `systemd-analyze`  
**Output:**
```
Startup finished in 1.128s (userspace)
graphical.target reached after 1.100s in userspace.
```

**Command:** `systemd-analyze blame`  
**Output:**
```
512ms landscape-client.service
257ms dev-sdd.device
215ms snapd.seeded.service
152ms snapd.service
127ms wsl-pro.service
97ms systemd-resolved.service
```
**Command:** `uptime`  
**Output:**
```
21:27:35 up 11 min, 1 user, load average: 0.00, 0.00, 0.00
```
**Command:** `w`  
**Output:**
```
21:28:05 up 12 min, 1 user, load average: 0.00, 0.00, 0.00
USER TTY FROM LOGIN@ IDLE JCPU PCPU WHAT
anntorko pts/1 - 21:15 12:42 0.00s ? -bash
```
### 1.2: Process Forensics
Identify Resource-Intensive Processes:
**Top 6 processes by memory usage:** 
```
PID PPID CMD %MEM %CPU
211 1 /usr/bin/python3 /usr/share 0.2 0.0
52 1 /usr/lib/systemd/systemd-jo 0.1 0.0
1 0 /sbin/init 0.1 0.0
108 1 /usr/lib/systemd/systemd-re 0.1 0.0
183 1 /usr/libexec/wsl-pro-servic 0.1 0.0
```

**Top 6 processes by CPU usage:**  
```
PID PPID CMD %MEM %CPU
1 0 /sbin/init 0.1 0.0
52 1 /usr/lib/systemd/systemd-jo 0.1 0.0
171 1 @dbus-daemon --system --add 0.0 0.0
270 269 /init 0.0 0.0
275 270 -bash 0.0 0.0
```

### 1.3 Service Dependencies

**Command:** `systemctl list-dependencies | head -n 10`  
**Output:**  
```
default.target
○ ├─display-manager.service
○ ├─systemd-update-utmp-runlevel.service
○ ├─wslg.service
● └─multi-user.target
○ ├─apport.service
● ├─console-setup.service
● ├─cron.service
● ├─dbus.service
○ ├─dmesg.service
```

**Command:** `systemctl list-dependencies multi-user.target | head -n 10`  
**Output:** 
```multi-user.target
○ ├─apport.service
● ├─console-setup.service
● ├─cron.service
● ├─dbus.service
○ ├─dmesg.service
○ ├─e2scrub_reap.service
○ ├─landscape-client.service
○ ├─networkd-dispatcher.service
● ├─rsyslog.service
```
### 1.4 User Sessions

**Command:** `who -a`  
**Output:**  
```
   system boot  2025-06-26 21:15
    run-level 5  2025-06-26 21:15
```
```
LOGIN console 2025-06-26 21:15 189 id=cons
LOGIN tty1 2025-06-26 21:15 205 id=tty1
anntorkot - pts/1 2025-06-26 21:15 00:32 355
```

**Command:** `last -n 5`  
**Output:** 
```
reboot system boot 6.6.87.2-microso Thu Jun 26 21:15 still running
reboot system boot 6.6.87.2-microso Thu Jun 26 21:05 still running
reboot system boot 6.6.87.2-microso Thu Jun 26 21:02 still running
reboot system boot 6.6.87.2-microso Thu Jun 26 20:59 still running
wtmp begins Thu Jun 26 20:59:18 2025
```
### 1.5 Memory Analysis

**Command:** `free -h`  
**Output:**  
```
  total        used        free      shared  buff/cache   available
```
```
Mem: 7.6Gi 494Mi 7.1Gi 3.4Mi 147Mi 7.1Gi
Swap: 2.0Gi 0B 2.0Gi
```

**Command:** `cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable`  
**Output:**  
```
MemTotal: 7990464 kB
MemAvailable: 7478368 kB
SwapTotal: 2097152 kB
```
## Task 2: Networking Analysis

### 2.1 Network Path Tracing

**Command:** `traceroute github.com`  
**Output:**  
```
traceroute to github.com (140.82.114.3), 30 hops max, 60 byte packets
1 kazan-ntb006.mshome.net (172.21.32.1) 1.173 ms 1.207 ms 1.293 ms
2 192.168.0.1 (192.168.0.1) 1.908 ms 1.885 ms 2.941 ms
3 * * *
4 lag-4-435.bbr01.nn.ertelecom.ru (109.194.184.18) 3.153 ms 3.750 ms 3.730 ms
5 ertelekom-ic-389478.ip.twelve99-cust.net (62.115.145.221) 13.379 ms 13.459 ms 13.859 ms
6 mow-b2-link.ip.twelve99.net (62.115.145.220) 12.709 ms 12.220 ms 12.164 ms
7 mow-b5-link.ip.twelve99.net (62.115.135.108) 14.151 ms 14.097 ms 14.042 ms
8 sto-bb2-link.ip.twelve99.net (62.115.141.22) 31.677 ms 31.658 ms 31.639 ms
```
### 2.1 DNS Resolution Check

**Command:** `dig github.com`  
**Output:*
```
; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47216
;; flags: qr rd ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
```
### 2.2 Packet Capture

**Command:** `sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn`  
**Example DNS query/response:**  
```
22:30:05.916964 eth0 Out IP 172.21.38.33.54496 > 172.21.32.1.53: 47057+ [1au] A? github.com. (51)
22:30:05.920217 eth0 In IP 172.21.32.1.53 > 172.21.38.33.54496: 47057-$ 1/0/0 A 140.82.113.4 (54)
```

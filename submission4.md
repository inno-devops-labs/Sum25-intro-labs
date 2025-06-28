# Lab 4 Submission

## Task 1: Operating System Analysis

### 1.1 Boot Performance

**Command**: `systemd-analyze`

```
Startup finished in 13.465s (firmware) + 3.679s (loader) + 1.649s (kernel) + 13.975s (userspace) = 32.769s 
graphical.target reached after 13.950s in userspace.
```

**Observation**: System booted in approximately 33 seconds, with userspace initialization taking \~14s.

**Command**: `systemd-analyze blame`

```
Top services:
- plymouth-quit-wait.service: 11.173s
- gpu-manager.service: 10.205s
- NetworkManager-wait-online.service: 5.721s
```

**Observation**: The Plymouth quit wait and GPU manager caused noticeable delays.

**Command**: `uptime`

```
18:50:02 up 3 min, 1 user, load average: 0.63, 0.60, 0.27
```

**Command**: `w`

```
zhalil is logged in on tty2.
```

**Observation**: System recently booted, low load average.

### 1.2 Process Forensics

**Command**: `ps --sort=-%mem`

```
Top memory consumers:
1. /snap/firefox/...: 3.0%
2. /usr/bin/gnome-shell: 2.4%
3. Google Chrome: ~2.3%
```

**Command**: `ps --sort=-%cpu`

```
Top CPU consumers:
1. Google Chrome: 22%
2. gnome-shell: 12.4%
3. Firefox: 12.2%
```

**Observation**: Browser processes are the most resource-intensive.

### 1.3 Service Dependencies

**Command**: `systemctl list-dependencies multi-user.target`

```
Includes docker, NetworkManager, ModemManager, etc.
Some inactive services marked with ○ (e.g., grub-common.service).
```

**Observation**: The multi-user target depends on core services like networking, logging, and containers.

### 1.4 User Sessions

**Command**: `who -a`

```
zhalil is logged in on tty2.
```

**Command**: `last -n 5`

```
Recent logins and a reboot observed at 21:46.
```

**Observation**: System was rebooted recently; user zhalil is active.

### 1.5 Memory Analysis

**Command**: `free -h`

```
Total RAM: 15GiB, Used: 5.0GiB, Available: 10GiB
Swap: 4.0GiB, 0B used
```

**Command**: `cat /proc/meminfo`

```
MemTotal: 15981844 kB
MemAvailable: 10782936 kB
SwapTotal: 4194300 kB
```

**Observation**: System has ample free memory and swap.

---

## Task 2: Networking Analysis

### 2.1 Network Path Tracing

**Note**: `traceroute` not installed.

**Command**: `dig github.com`

```
github.com. 28 IN A 140.82.121.4
Query time: 4 msec
```

**Observation**: DNS resolution successful; GitHub resolves to 140.82.121.4.

### 2.2 Packet Capture

**Command**: `sudo tcpdump -c 5 -i any 'port 53' -nn`

```
Example DNS query/response:
IP 10.91.2.XXX.43316 > 10.90.137.XXX.53: A? connectivity-check.ubuntu.com
IP 10.90.137.XXX.53 > 10.91.2.XXX.43316: A 185.125.190.98, A 91.189.91.48, ...
IP 127.0.0.1.36512 > 127.0.0.53.53: A? api.snapcraft.io
```

**Observation**: DNS responses returned multiple A records. IPs sanitized as requested.

### 2.3 Reverse DNS

**Command**: `dig -x 8.8.4.4`

```
PTR record: dns.google.
```

**Command**: `dig -x 1.1.2.2`

```
Result: NXDOMAIN (no reverse DNS entry)
```

**Observation**: 8.8.4.4 resolves to Google DNS; 1.1.2.2 has no PTR record.



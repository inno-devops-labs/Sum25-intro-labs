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

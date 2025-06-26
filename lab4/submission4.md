# OS & Networking Lab

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

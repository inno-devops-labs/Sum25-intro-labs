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

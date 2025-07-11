# Lab 8: Site reliability engineering (SRE)
## Task 1: Key Metric for SRE and SLAs
### Monitor system resource

└─# ps aux --sort=-%cpu | head -n 5
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
kali       84935  3.7  3.9 3596492 652636 ?      Sl   10:21   8:14 /usr/lib/firefox-esr/firefox-esr
kali       85238  2.9  0.7 2440904 125892 ?      Sl   10:21   6:35 /usr/lib/firefox-esr/firefox-esr -contentproc -childID 7 -isForBrowser -prefsLen 30639 -prefMapSize 247092 -jsInitLen 234912 -parentBuildID 20250519114620 -greomni /usr/lib/firefox-esr/omni.ja -appomni /usr/lib/firefox-esr/browser/omni.ja -appDir /usr/lib/firefox-esr/browser {422f33ac-db40-402d-9431-631d99b905fc} 84935 true tab
root        1034  2.7  1.4 569172 231612 tty7    Rsl+ 08:14   9:33 /usr/lib/xorg/Xorg :0 -seat seat0 -auth /var/run/lightdm/root/:0 -nolisten tcp vt7 -novtswitch
kali        1324  0.8  0.7 1190324 125668 ?      Sl   08:14   2:48 xfwm4

**Top 3 processes by CPU usage:**
1. **firefox-esr (PID: 84935)** - 3.7% CPU - Main Firefox ESR browser process, consuming significant CPU resources for web page rendering, JavaScript execution, and user interface handling
2. **firefox-esr -contentproc (PID: 85238)** - 2.9% CPU - Firefox child content process for web page content processing, running in isolated mode to enhance browser security and stability
3. **Xorg (PID: 1034)** - 2.7% CPU - X Window System server responsible for graphical interface display, keyboard and mouse event handling, window management, and graphics operations


└─# ps aux --sort=-%mem | head -n 5
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
kali       84935  3.6  3.9 3596396 652520 ?      Sl   10:21   8:15 /usr/lib/firefox-esr/firefox-esr
root        1034  2.7  1.4 569172 231352 tty7    Rsl+ 08:14   9:43 /usr/lib/xorg/Xorg :0 -seat seat0 -auth /var/run/lightdm/root/:0 -nolisten tcp vt7 -novtswitch
kali       85203  0.0  1.1 2583652 196464 ?      Sl   10:21   0:07 /usr/lib/firefox-esr/firefox-esr -contentproc -childID 6 -isForBrowser -prefsLen 28876 -prefMapSize 247092 -jsInitLen 234912 -parentBuildID 20250519114620 -greomni /usr/lib/firefox-esr/omni.ja -appomni /usr/lib/firefox-esr/browser/omni.ja -appDir /usr/lib/firefox-esr/browser {1519517e-7246-4828-9262-b861e6bafde9} 84935 true tab
kali       85238  2.9  0.7 2440904 125892 ?      Sl   10:21   6:35 /usr/lib/firefox-esr/firefox-esr -contentproc -childID 7 -isForBrowser -prefsLen 30639 -prefMapSize 247092 -jsInitLen 234912 -parentBuildID 20250519114620 -greomni /usr/lib/firefox-esr/omni.ja -appomni /usr/lib/firefox-esr/browser/omni.ja -appDir /usr/lib/firefox-esr/browser {422f33ac-db40-402d-9431-631d99b905fc} 84935 true tab

**Top 3 processes by memory usage:**
1. **firefox-esr (PID: 84935)** - 3.9% MEM (652,520 KB RSS) - Main Firefox ESR browser process, consuming significant memory for DOM structures, cached web content, browser extensions, and user interface components
2. **Xorg (PID: 1034)** - 1.4% MEM (231,352 KB RSS) - X Window System server holding graphics buffers, font caches, window pixmaps, and other graphical resources in memory for efficient display rendering
3. **firefox-esr -contentproc (PID: 85203)** - 1.1% MEM (196,464 KB RSS) - Firefox content process handling specific web page content, maintaining separate memory space for security isolation and crash protection

└─# iostat       
Linux 6.12.25-amd64 (kali)      07/11/2025      _x86_64_        (4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           2.10    0.00    1.36    0.04    0.00   96.49

Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd
sda              13.37        80.97       598.83         0.00    1723729   12748365          0

### I/O Analysis:
Primary storage device: sda (likely main system disk)
Transactions per second (tps): 13.37 - moderate disk activity
Read performance: 80.97 kB/s average read rate
Write performance: 598.83 kB/s average write rate (7.4x higher than reads)
Total data transferred:

Read: 1,723,729 kB (~1.68 GB)
Written: 12,748,365 kB (~12.46 GB)

### CPU I/O Wait Analysis:
%iowait: 0.04% - very low I/O wait time, indicating efficient disk operations
%idle: 96.49% - system is mostly idle, good performance headroom
%system: 1.36% - low system overhead for I/O operations

### Disk space management

└─# df -h   
Filesystem      Size  Used Avail Use% Mounted on
udev            7.8G     0  7.8G   0% /dev
tmpfs           1.6G  1.3M  1.6G   1% /run
/dev/sda1        79G   36G   39G  49% /
tmpfs           7.9G   88K  7.9G   1% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           7.9G  1.8M  7.9G   1% /tmp

### 3 big file in var

└─# find /var -type f -exec ls -la {} \; 2>/dev/null | sort -k 5 -nr | head -n 3

-rw-rw---- 1 mysql mysql 100663296 Apr 23 13:17 /var/lib/mysql/ib_logfile0
-rw-r--r-- 1 root root 94128568 Dec 23  2024 /var/cache/apt/archives/libwine_9.0~repack-7_i386.deb
-rw-r--r-- 1 root root 85621046 Jul  1 23:04 /var/lib/apt/lists/http.kali.org_kali_dists_kali-rolling_main_Contents-amd64.lz4

-- 2>/dev/null: suppresses errors
-- grep -v '/$': excludes directories (which end with / in `du` output)
-- sort -rh: sorts by size in descending order
-- head -n 3: limits to top 3 files

## Task 2:
### Choose your web site
https://beeline.kz (screen api-1.png)

Run request (screen api-2.png)

### Browser check Setup
screen (brwser-cneck.png)
run check (scren run-check.png)

### Alert Config
screen (alert.png)

- add email (screen add-email.png)

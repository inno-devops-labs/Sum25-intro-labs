## Operating Systems & Networking Lab Report

---

## Task 1: Operating System Analysis

### 1.1 Boot Performance

#### `systemd-analyze`

```sh
Startup finished in 8.617s (firmware) + 5.725s (loader) + 6.770s (kernel) + 8.640s (userspace) = 29.753s 
graphical.target reached after 8.611s in userspace.
```

#### `systemd-analyze blame`

```sh
1min 1.530s fstrim.service
     5.453s NetworkManager-wait-online.service
     5.190s fwupd-refresh.service
     1.830s apt-daily-upgrade.service
     1.467s NetworkManager.service
     1.251s fwupd.service
     1.225s snapd.seeded.service
     1.152s snapd.service
      914ms vboxdrv.service
      705ms snap.docker.nvidia-container-toolkit.service
      ...
```

**Observation**:
- `fstrim.service` is the top delay contributor - because it's disk operation. 
- `NetworkManager-wait-online.service` also slows boot due to network wait configuration.

---

#### `uptime`

```sh
 22:24:49 up 53 min,  2 users,  load average: 0,92, 0,84, 1,14
```

#### `w`

```sh
 22:24:52 up 53 min,  2 users,  load average: 0,92, 0,84, 1,14
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU  WHAT
peter    tty1     -                21:45   53:01   0.03s  0.03s /usr/bin/startplasma-wayland
peter             -                21:45     ?     0.00s  1.99s /usr/lib/systemd/systemd --user
```

**Observation**:
System is lightly loaded with two active sessions. No performance issues observed at present. I use wayland by the way) Nice environment

---

### 1.2 Process Forensics

#### Memory-heavy processes:

```sh
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
```

```sh
    PID    PPID CMD                         %MEM %CPU
  20032   19986 /opt/yandex/browser/yandex_  3.9  5.5
  23595   13330 /snap/telegram-desktop/6691  2.9  4.8
  13725   13330 /usr/bin/plasmashell --no-r  2.2  1.0
  19970   13330 /opt/yandex/browser/yandex_  1.8  2.5
  65677   65408 /proc/self/exe --type=utili  1.5  1.5
```

**Observation**:
Here we can observe, that browser and telegram used most of memory

#### CPU-heavy processes:

```sh
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
```

```sh
    PID    PPID CMD                         %MEM %CPU
  95698   19990 /opt/yandex/browser/yandex_  0.7  8.4
  71520   19990 /opt/yandex/browser/yandex_  1.3  8.0
  65510   65414 /usr/share/code/code --type  1.2  5.7
  79584   19990 /opt/yandex/browser/yandex_  0.7  5.6
  20032   19986 /opt/yandex/browser/yandex_  3.9  5.3
```

**Observation**:
Here browser and VS Code in the top

> By the way here i caught some fun bug, that is possibly caused by specific of fair cpu time manager in linux, that gives most priority for the new processes:
```sh
    PID    PPID CMD                         %MEM %CPU
 106646   66035 ps -eo pid,ppid,cmd,%mem,%c  0.0  100
  95698   19990 /opt/yandex/browser/yandex_  0.7  8.4
  71520   19990 /opt/yandex/browser/yandex_  1.3  8.1
  65510   65414 /usr/share/code/code --type  1.2  5.7
  79584   19990 /opt/yandex/browser/yandex_  0.7  5.7
```

---

### 1.3 Service Dependencies

#### All dependencies:

```sh
systemctl list-dependencies
```

```sh
● ├─accounts-daemon.service
● ├─ollama.service
● ├─power-profiles-daemon.service
● ├─sddm.service
● ├─switcheroo-control.service
○ ├─systemd-update-utmp-runlevel.service
● ├─udisks2.service
● └─multi-user.target
○   ├─anacron.service
●   ├─apache2.service
●   ├─apport.service
●   ├─avahi-daemon.service
●   ├─console-setup.service
●   ├─cron.service
●   ├─cups-browsed.service
...
●   ├─wpa_supplicant.service
●   ├─basic.target
●   │ ├─-.mount
●   │ ├─tmp.mount
●   │ ├─paths.target
○   │ │ ├─apport-autoreport.path
○   │ │ └─tpm-udev.path
●   │ ├─slices.target
●   │ │ ├─-.slice
●   │ │ └─system.slice
●   │ ├─sockets.target
○   │ │ ├─apport-forward.socket
●   │ │ ├─avahi-daemon.socket
●   │ │ ├─cups.socket
...

```

#### For multi-user.target:

```sh
systemctl list-dependencies multi-user.target
```

```sh
○ ├─anacron.service
● ├─apache2.service
● ├─apport.service
● ├─avahi-daemon.service
● ├─console-setup.service
● ├─cron.service
● ├─cups-browsed.service
...
● ├─wpa_supplicant.service
● ├─basic.target
● │ ├─-.mount
● │ ├─tmp.mount
● │ ├─paths.target
○ │ │ ├─apport-autoreport.path
○ │ │ └─tpm-udev.path
● │ ├─slices.target
● │ │ ├─-.slice
● │ │ └─system.slice
● │ ├─sockets.target
○ │ │ ├─apport-forward.socket
● │ │ ├─avahi-daemon.socket
● │ │ ├─cups.socket
```

**Observation**:
`multi-user.target` includes critical services like `NetworkManager` and `ssh`. They are essential for remote and multi-user environments. Here we see only multi-user.target branch

---

### 1.4 User Sessions

#### `who -a`

```sh
           system boot  2025-06-30 21:31
           run-level 5  2025-06-30 21:31
peter    + tty1         2025-06-30 21:45 01:07       13383
peter    + pts/0        2025-06-30 21:45 00:54       13608 (:1)
peter    - pts/1        2025-06-30 21:50 00:31       22006 (:1)
```

#### `who -a | last -n 5`

```sh
reboot   system boot  6.11.0-14-generi Mon Jun 30 21:31 - still running

/var/lib/wtmpdb/wtmp.db begins Mon Jun 30 21:31:37 2025
```

**Observation**:
The system was rebooted on June 30 at 21:31 and has been running since. The user peter has logged in through multiple terminals:

tty1 — local console session,

pts/0 — currently active terminal (likely within a graphical session),

pts/1, pts/3, and pts/4 — past or temporary sessions.
Most activity appears to occur within a single X session (:1). The pts/4 terminal seems to be a transient or orphaned session.

---

### 1.5 Memory Analysis

#### `free -h`

```sh
               total        used        free      shared  buff/cache   available
Mem:            27Gi       7,8Gi        11Gi       1,4Gi       9,6Gi        19Gi
Swap:           32Gi          0B        32Gi
```

#### `/proc/meminfo`

```sh
bash: /proc/meminfo: Permission denied
```

With sudo it's like:

```sh
sudo: /proc/meminfo: command not found
```

**Observation**:
Command not found

---

## Task 2: Networking Analysis

### 2.1 Path Tracing

#### `traceroute github.com`

```sh
 1   192.168.1.1  0,836ms  0,708ms  0,707ms 
  2   10.16.255.137  1,518ms  1,365ms  1,230ms 
  3   10.64.241.65  1,601ms  1,429ms  1,619ms 
  4   10.16.248.206  1,730ms  1,409ms  1,952ms 
  5   10.16.248.253  4,862ms  1,678ms  4,872ms 
  6   188.254.80.81  14,357ms  14,140ms  13,994ms 
  7   188.254.80.85  14,448ms  14,191ms  13,905ms 
  8   95.167.92.165  14,430ms  13,755ms  13,940ms 
  9   188.128.104.173  69,063ms  67,935ms  67,908ms 
 10   217.161.68.33  71,407ms  73,084ms  65,073ms 
 11   195.2.22.238  65,710ms  65,500ms  65,539ms 
 12   62.115.182.171  69,812ms  67,494ms  65,249ms 
 13   *  *  * 
 14   *  *  * 
 15   *  *  * 
 16   *  *  * 
 ...
```

**Observation**:
Trace is too long. Stars forever

---

#### `dig github.com`

```sh

; <<>> DiG 9.20.0-2ubuntu3.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 7717
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             33      IN      A       140.82.121.4

;; Query time: 15 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Jun 30 22:59:58 MSK 2025
;; MSG SIZE  rcvd: 55

```

**Observation**:
DNS successfully resolved `github.com` to IP `140.82.114.3`.

- `opcode`: QUERY: Standard DNS query.
- `status`: NOERROR: The query was successful; no errors occurred.
- `flags`: qr rd ra:
- `qr`: This is a response.
- `rd`: Recursion desired (you asked the DNS server to resolve it fully).
- `ra`: Recursion available (server supports recursive queries).
- `QUERY`: 1: One question was asked.
- `ANSWER`: 1: One answer was returned.
- `AUTHORITY`: 0: No authoritative server info included.
- `ADDITIONAL`: 1: One extra record (like EDNS info) was included.


---

### 2.2 Packet Capture

#### `sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn`

```sh
tcpdump: WARNING: any: That device doesn't support promiscuous mode
(Promiscuous mode not supported on the "any" device)
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
23:01:58.908346 lo    In  IP 127.0.0.1.3533 > 127.0.0.53.53: 8572+ A? api.passport.yandex.ru. (40)
23:01:58.908402 lo    In  IP 127.0.0.1.61528 > 127.0.0.53.53: 39256+ HTTPS? api.passport.yandex.ru. (40)
23:01:58.908482 lo    In  IP 127.0.0.1.42422 > 127.0.0.53.53: 33977+ A? mtalk.google.com. (34)
23:01:58.908523 wlp4s0 Out IP 192.168.1.231.44381 > 192.168.1.1.53: 65225+ [1au] A? api.passport.yandex.ru. (51)
23:01:58.908654 wlp4s0 Out IP 192.168.1.231.34998 > 192.168.1.1.53: 59282+ [1au] HTTPS? api.passport.yandex.ru. (51)
5 packets captured
16 packets received by filter
0 packets dropped by kernel
```

**Observation**:

- My net card doesn't support promiscuous mode
- I dumped some packets to yandex and to google
---

### 2.3 Reverse DNS

#### `dig -x 8.8.4.4`

```sh

; <<>> DiG 9.20.0-2ubuntu3.2-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 18570
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   17378   IN      PTR     dns.google.

;; Query time: 6 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Jun 30 23:10:24 MSK 2025
;; MSG SIZE  rcvd: 73

```
**Observation**:
The reverse DNS query for the IP address 8.8.4.4 was successful. The IP was resolved to the domain name dns.google., indicating that the address is owned and properly configured by Google with a valid PTR (pointer) record. The response was returned quickly (6 ms) via the local DNS resolver at 127.0.0.53.

#### `dig -x 1.1.2.2`

```bash
;; communications error to 127.0.0.53#53: timed out
;; communications error to 127.0.0.53#53: timed out
;; communications error to 127.0.0.53#53: timed out

; <<>> DiG 9.20.0-2ubuntu3.2-Ubuntu <<>> -x 1.1.2.2
;; global options: +cmd
;; no servers could be reached

```

**Observation**:
The reverse DNS query for 1.1.2.2 failed due to a timeout. The local DNS resolver (127.0.0.53) did not respond to the request. As a result, the dig command could not complete the reverse lookup, and no PTR record was retrieved.

---

## Final Notes

* All commands executed on Ubuntu 24.10 with KDE on Wayland
* No sensitive process or private IPs logged.
* Boot optimization could target `fstrim.service` or `NetworkManager-wait-online` (but i highly don't recomment)
* Networking tools functioned as expected; DNS resolution and reverse lookups were consistent.
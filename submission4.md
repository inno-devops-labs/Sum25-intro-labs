# Operating Systems & Networking Lab

## Task 1: Operating System Analysis

**Objective**: Analyze key OS components including boot performance, resource usage, services, sessions, and memory management.

### 1.1: Boot Performance

1. **Analyze System Boot Time**:

    **Command:**
    ```bash
    systemd-analyze
    ```

    **Output:**
    ```
    Startup finished in 8.245s (firmware) + 5.511s (loader) + 2.644s (kernel) + 13.476s (userspace) = 29.876s 
    graphical.target reached after 13.445s in userspace
    ```

    **Command:**
    ```bash
    systemd-analyze blame
    ```

    **Output (top 10 lines):**
    ```
    8.116s plymouth-quit-wait.service
    6.061s NetworkManager-wait-online.service
    3.399s snapd.apparmor.service
    3.243s binfmt-support.service
    3.000s systemd-binfmt.service
    2.961s proc-sys-fs-binfmt_misc.mount
    2.746s apt-daily-upgrade.service
    2.577s snapd.seeded.service
    2.411s snapd.service
    1.368s docker.service
    ```

    **Observation:**
    - The total boot time is approximately 30 seconds
    - The `plymouth-quit-wait.service` is the slowest individual unit (8.1s)

    ---

2. **Check System Load**:

    **Command:**
    ```bash
    uptime
    ```

    **Output:**
    ```
    12:57:37 up  2:33,  1 user,  load average: 0,93, 1,23, 1,20
    ```

    **Command:**
    ```bash
    w
    ```

    **Output:**
    ```
     12:57:38 up  2:33,  1 user,  load average: 0,85, 1,21, 1,20
    USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
    gleb     :1       :1               10:24   ?xdm?  57:52   0.00s /usr/libexec/gd
    ```

    **Observation:**

    - The system has been running for 2 hours and 33 minutes.
    - There is currently **1 active user** logged in: `gleb`, working in graphical session `:1`.
    - The load average over the last 1, 5, and 15 minutes is `0.93`, `1.23`, and `1.20` respectively, which indicates low to moderate system load — the system is not overloaded.

---

### 1.2: Process Forensics

1. **Identify Resource-Intensive Processes**:

    **Command:**
    ```bash
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    ```

    **Output:**
    ```
        PID    PPID CMD                         %MEM %CPU
    3752    3636 /opt/yandex/browser/yandex_  2.6  9.1
    23777   23625 /proc/self/exe --type=utili  1.9  3.2
    23184    3636 /opt/yandex/browser/yandex_  1.8 29.3
    23727   23628 /snap/code/198/usr/share/co  1.7 12.2
    3614    2253 /opt/yandex/browser/yandex_  1.5  4.3
    ```

    **Command:**
    ```bash
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    ```

    **Output:**
    ```
        PID    PPID CMD                         %MEM %CPU
    23184    3636 /opt/yandex/browser/yandex_  1.8 28.8
    23727   23628 /snap/code/198/usr/share/co  1.7 12.5
    3752    3636 /opt/yandex/browser/yandex_  2.6  9.0
    23743   23625 /proc/self/exe --type=gpu-p  0.6  8.1
    23354    2874 ./hiddify                    1.1  7.3
    ```

    **Observation:**
    - The most memory-hungry process is `yandex_browser` (`/opt/yandex/browser/yandex_`)
    - The highest CPU usage also comes from a `yandex_browser`

---

### 1.3: Service Dependencies

1. **Map Service Relationships**:

    **Command:**
    ```bash
    systemctl list-dependencies
    ```

    **Output (a few top lines):**
    ```
    default.target
    ● ├─accounts-daemon.service
    ● ├─apport.service
    ● ├─gdm.service
    ● ├─power-profiles-daemon.service
    ● ├─switcheroo-control.service
    ○ ├─systemd-update-utmp-runlevel.service
    ● ├─udisks2.service
    ● └─multi-user.target
    ○   ├─anacron.service
    ●   ├─apport.service
    ●   ├─avahi-daemon.service
    ```

    **Command:**
    ```bash
    systemctl list-dependencies multi-user.target
    ```

    **Output (a few top lines):**
    ```
    multi-user.target
    ○ ├─anacron.service
    ● ├─apport.service
    ● ├─avahi-daemon.service
    ● ├─binfmt-support.service
    ● ├─console-setup.service
    ● ├─containerd.service
    ● ├─cron.service
    ● ├─cups-browsed.service
    ```

    **Observation:**
    - The default systemd target (`default.target`) depends on multiple services such as `gdm.service` (GNOME Display Manager), `accounts-daemon.service`, `udisks2.service`, and indirectly on `multi-user.target`
    - `multi-user.target` in turn includes a wide set of core services like `cron.service`, `containerd.service`, `apport.service`, and `cups-browsed.service`
    - Services marked with `●` are active and enabled; those marked with `○` are available but not required by default.

---

### 1.4: User Sessions

1. **Audit Login Activity**:

    **Command:**
    ```bash
    who -a
    ```

    **Output:**
    ```
                system boot  2025-06-28 10:24
                run-level 5  2025-06-28 10:24
    gleb     ? :1           2025-06-28 10:24   ?          1957 (:1)
    ```

    **Command:**
    ```bash
    last -n 5
    ```

    **Output:**
    ```
    gleb     :1           :1               Sat Jun 28 10:24   still logged in
    reboot   system boot  6.8.0-60-generic Sat Jun 28 10:24   still running
    gleb     :1           :1               Fri Jun 27 21:40 - down   (01:09)
    reboot   system boot  6.8.0-60-generic Fri Jun 27 21:01 - 22:49  (01:47)
    gleb     :1           :1               Fri Jun 27 11:17 - down   (05:08)

    wtmp begins Thu May  1 16:03:28 2025
    ```

    **Observation:**
    - According to `who -a`, the system booted on **2025-06-28 at 10:24**
    - The only currently logged-in user is `gleb`
    - The `last` command confirms that `gleb` is still logged in from the current session
    - Previous sessions show that the same user (`gleb`) had multiple login sessions
    - All sessions are via the graphical environment (`:1`)

---

### 1.5: Memory Analysis

1. **Inspect Memory Allocation**:

    **Command:**
    ```bash
    free -h
    ```

    **Output:**
    ```
                    total        used        free      shared  buff/cache   available
    Mem:            22Gi       4,1Gi        14Gi       149Mi       4,2Gi        18Gi
    Swap:          2,0Gi          0B       2,0Gi
    ```

    **Command:**
    ```bash
    cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
    ```

    **Output:**
    ```
    MemTotal:       24020404 kB
    MemAvailable:   19149360 kB
    SwapTotal:       2097148 kB
    ```

    **Observation:**
    - The system has a total of **22 GiB of RAM**, with only **4.1 GiB currently used** and **18 GiB available**
    - An additional **4.2 GiB** is used by buffers and cache
    - The swap partition is **2.0 GiB** in size

---

## Task 2: Networking Analysis

**Objective**: Perform network diagnostics including path tracing, DNS inspection, packet capture, and reverse lookups.

### 2.1: Network Path Tracing

1. **Traceroute Execution**:

    **Command:**
    ```bash
    traceroute github.com
    ```

    **Output:**
    ```
    traceroute to github.com (140.82.121.3), 64 hops max
    1   10.241.1.1  0,251ms  0,195ms  0,209ms 
    2   10.250.0.2  0,132ms  0,125ms  0,142ms 
    3   10.252.5.1  0,410ms  0,434ms  0,558ms 
    4   10.252.6.1  0,833ms  0,747ms  0,594ms 
    5   188.170.164.34  3,769ms  3,241ms  3,381ms 
    ```

2. **DNS Resolution Check**:

    **Command:**
    ```bash
    dig github.com
    ```

    **Output:**
    ```
    ; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> github.com
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 31547
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 65494
    ;; QUESTION SECTION:
    ;github.com.			IN	A

    ;; ANSWER SECTION:
    github.com.		12	IN	A	140.82.121.3

    ;; Query time: 1 msec
    ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
    ;; WHEN: Sat Jun 28 13:21:54 MSK 2025
    ;; MSG SIZE  rcvd: 55
    ```

**Observation:**
- The `traceroute` command shows the path taken by packets to reach `github.com` (IP `140.82.121.3`)
- The first few hops (`10.x.x.x`) are private IP addresses, indicating internal provider or NAT infrastructure
- The public IP `188.170.164.34` likely belongs to the ISP or an upstream backbone router
- The `dig` command confirms successful DNS resolution of `github.com` to `140.82.121.3`, with a **query time of 1 ms** and a `NOERROR` status.

---

### 2.2: Packet Capture

1. **Capture DNS Traffic**:

    **Command:**
    ```bash
    sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
    ```

    **Output:**
    ```
    tcpdump: data link type LINUX_SLL2
    tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
    listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
    13:27:29.260994 lo    In  IP 127.0.0.1.38349 > 127.0.0.53.53: 9993+ A? alive.github.com. (34)
    13:27:29.261109 lo    In  IP 127.0.0.1.55560 > 127.0.0.53.53: 35680+ Type65? alive.github.com. (34)
    13:27:29.261446 enp2s0 Out IP 10.241.1.242.44344 > 10.90.137.30.53: 42029+ [1au] A? alive.github.com. (45)
    13:27:29.261542 wlp4s0 Out IP 192.168.50.165.35869 > 192.168.50.1.53: 60816+ [1au] A? alive.github.com. (45)
    13:27:29.261757 enp2s0 Out IP 10.241.1.242.51202 > 10.90.137.30.53: 46657+ [1au] Type65? alive.github.com. (45)
    5 packets captured
    20 packets received by filter
    0 packets dropped by kernel
    ```

    **Observation:**
    - During the 10-second `tcpdump` capture, 5 DNS packets were successfully captured on various interfaces (`lo`, `enp2s0`, `wlp4s0`).

---

### 2.3: Reverse DNS Lookup

1. **Perform PTR Lookups**:

    **Command:**
    ```bash
    dig -x 8.8.4.4
    ```

    **Output:**
    ```
    ; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 8.8.4.4
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 41786
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 65494
    ;; QUESTION SECTION:
    ;4.4.8.8.in-addr.arpa.		IN	PTR

    ;; ANSWER SECTION:
    4.4.8.8.in-addr.arpa.	60493	IN	PTR	dns.google.

    ;; Query time: 161 msec
    ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
    ;; WHEN: Sat Jun 28 13:29:47 MSK 2025
    ;; MSG SIZE  rcvd: 73
    ```

    **Command:**
    ```bash
    dig -x 1.1.2.2
    ```

    **Output:**
    ```
    ; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 1.1.2.2
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 39278
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 65494
    ;; QUESTION SECTION:
    ;2.2.1.1.in-addr.arpa.		IN	PTR

    ;; AUTHORITY SECTION:
    1.in-addr.arpa.		900	IN	SOA	ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22230 7200 1800 604800 3600

    ;; Query time: 496 msec
    ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
    ;; WHEN: Sat Jun 28 13:30:36 MSK 2025
    ;; MSG SIZE  rcvd: 137
    ```

    **Observation:**
    - The `dig -x 8.8.4.4` command successfully resolved the reverse DNS (PTR) record:
        - IP `8.8.4.4` maps to the domain `dns.google.`
        - This confirms that Google's public DNS server has a valid PTR record.

    - The `dig -x 1.1.2.2` command returned **NXDOMAIN**, meaning:
        - There is **no PTR (reverse) record** for this IP address.
        - The authoritative answer came from `ns.apnic.net`, and the response indicated the zone does not exist.

---
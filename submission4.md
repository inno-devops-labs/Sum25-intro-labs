## Task 1: Operating System Analysis

### 1.1: Boot Performance

1. **Analyze System Boot Time**:

   ```sh
   systemd-analyze
   ```

    #### Output 

        Startup finished in 4.721s (firmware) + 8.680s (loader) + 2.600s (kernel) + 11.132s (userspace) = 27.135s 
        graphical.target reached after 11.116s in userspace

    #### What does it mean?

    The `systemd-analyze` command in Linux is used to analyze system boot time and diagnose processes and dependencies in the initialization system, which manages services and other processes during boot.

    1. 4.721s (firmware) is the time taken by the BIOS or UEFI before the bootloader starts.

    2. 8.680s (loader) is the loader's job.

    3. 2.600s (kernel) - The time spent by the Linux kernel on initialization

    4. 11.132s (userspace) - The time spent by systemd to start services and switch to graphical.target.

    5. graphical.target reached after 11.116s in userspace - This means that the graphical user interface (GNOME) was fully ready 11.116 seconds after systemd started.


    ```sh
    systemd-analyze blame
    ```

    #### Output 

    ```sh
    20.467s fstrim.service
    6.761s plymouth-quit-wait.service
    6.686s NetworkManager-wait-online.service
    3.291s snapd.seeded.service
    3.183s snapd.service
    1.664s logrotate.service
    1.492s e2scrub_reap.service
    1.423s networkd-dispatcher.service
    1.392s dev-loop2.device
    1.358s dev-loop7.device
    1.337s dev-loop4.device
    1.324s udisks2.service
    1.304s dev-loop0.device
    1.196s dev-loop6.device
    1.148s dev-loop5.device
    1.006s dev-sda2.device
    995ms accounts-daemon.service
    994ms snapd.apparmor.service
    836ms cups.service
    826ms dev-loop1.device
    774ms bluetooth.service
    767ms avahi-daemon.service
    758ms NetworkManager.service
    lines 1-24/124 16%
    ```

    #### What does it mean?

    Shows a list of services (unit files) sorted by their launch time.

2. **Check System Load**:

   ```sh
   uptime
   ```

    #### Output 

    ```sh
    19:16:59 up  1:21,  1 user,  load average: 0,37, 0,40, 0,40
    ```

    #### What does it mean?

    It shows the continuous operation time of the system since the last boot, as well as brief information about processor usage and users.

    `19:16:59` - Current system time

    `up  1:21` - 1 hour 21 minutes

    `1 user`- Number of logged-in users

    `0,37, 0,40, 0,40` - Average CPU usage over the last 1, 5, and 15 minutes


    ```sh
    w
    ```

    #### Output 

    ```sh
    19:48:59 up  1:53,  1 user,  load average: 0,42, 0,46, 0,53
    USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
    alik     :1       :1               17:55   ?xdm?  28:45   0.00s /usr/libexec/gd
    ```

    #### What does it mean?

    - `USER` - User name
    - `TTY` - Terminal session (for example, pts/0 is a pseudo terminal)
    - `FROM` - Where the user connected (locally or over the network)
    - `LOGIN@` - Login time
    - `IDLE` - How long has the user been idle
    - `JCPU` - is the CPU time used by all processes associated with this terminal
    - `PCPU` - CPU time spent by the current active process
    - `WHAT` - is the user's current running command

### 1.2: Process Forensics

1. **Identify Resource-Intensive Processes**:

   ```sh
   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
   ```

    #### Output 

    ```sh
    PID     PPID CMD                         %MEM %CPU
    2089    1796 /usr/bin/anydesk --tray      2.1  0.8
    1819    1571 /usr/bin/gnome-shell         1.2  3.2
    4183    4130 /usr/share/code/code --type  1.1  3.7
    3141    1819 /opt/yandex/browser/yandex_  1.0  3.3
    3189    3158 /opt/yandex/browser/yandex_  0.9  3.2
    ```

    #### What does it mean?

    Shows the top 5 processes consuming the most RAM on the system

    The process that spends the most memory - anydesk

    ```sh
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    ```

    #### Output 

    ```sh
    PID    PPID CMD                         %MEM %CPU
    8975    1819 /snap/telegram-desktop/6691  1.4 17.3
    4183    4130 /usr/share/code/code --type  1.1  3.8
    1819    1571 /usr/bin/gnome-shell         1.2  3.3
    3141    1819 /opt/yandex/browser/yandex_  1.0  3.2
    3189    3158 /opt/yandex/browser/yandex_  1.0  3.0
    ```

    #### What does it mean?

    Shows the top 5 processes consuming the most CPU on the system

    The process that spends the most CPU - telegram

### 1.3: Service Dependencies

1. **Map Service Relationships**:

    ```sh
    systemctl list-dependencies
    systemctl list-dependencies multi-user.target
    ```
    #### Output 

    ```sh
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
    ●   ├─anydesk.service
    ●   ├─apport.service
    ●   ├─avahi-daemon.service
    ●   ├─binfmt-support.service
    ●   ├─console-setup.service
    ●   ├─cron.service
    ●   ├─cups-browsed.service
    ●   ├─cups.path
    ●   ├─cups.service
    ●   ├─dbus.service
    ○   ├─dmesg.service
    ○   ├─e2scrub_reap.service
    ○   ├─grub-common.service
    lines 1-23/156 
    ```

    #### What does it mean?

    It shows the dependency tree of systemd units - which services depend on each other.

    Dependencies for `default.target` are all units that run during normal system boot.

    Next, the tree shows what dependencies other processes have.

    ● - active process, ○ - non active process

    ```sh
    systemctl list-dependencies multi-user.target
    ```

    #### Output 

    ```sh
    multi-user.target
    ○ ├─anacron.service
    ● ├─anydesk.service
    ● ├─apport.service
    ● ├─avahi-daemon.service
    ● ├─binfmt-support.service
    ● ├─console-setup.service
    ● ├─cron.service
    ● ├─cups-browsed.service
    ● ├─cups.path
    ● ├─cups.service
    ● ├─dbus.service
    ○ ├─dmesg.service
    ○ ├─e2scrub_reap.service
    ○ ├─grub-common.service
    ○ ├─grub-initrd-fallback.service
    ● ├─irqbalance.service
    ● ├─kerneloops.service
    ● ├─ModemManager.service
    ● ├─networkd-dispatcher.service
    ● ├─NetworkManager.service
    ● ├─openvpn.service
    ● ├─plymouth-quit-wait.service
    ```

    #### What does it mean?

    Shows all systemd units that are required to run only multi-user.target, as well as their recursive dependencies


### 1.4: User Sessions

1. **Audit Login Activity**:

   ```sh
   who -a
   ```

   #### Output 

    ```sh
            system boot  2025-06-26 17:55
            run-level 5  2025-06-26 17:55
    alik  ? :1           2025-06-26 17:55   ?          1669 (:1)
    ```

    #### What does it mean?

    Shows advanced information about users and login processes.

    ```sh
    last -n 5
    ```

    #### Output 

    ```sh
    alik     :1           :1               Thu Jun 26 17:55   still logged in
    reboot   system boot  6.8.0-60-generic Thu Jun 26 17:55   still running
    alik     :1           :1               Thu Jun 19 17:13 - down   (04:51)
    reboot   system boot  6.8.0-60-generic Thu Jun 19 17:13 - 22:05  (04:52)
    alik     :1           :1               Wed Jun 18 17:04 - down   (08:46)
    

    wtmp begins Sun Apr 20 22:52:30 2025
    ```

    #### What does it mean?

    Shows the last 5 logins (and reboots) based on the /var/log/wtmp log

### 1.5: Memory Analysis

1. **Inspect Memory Allocation**:

   ```sh
   free -h
   ```

   #### Output 

    ```sh
                   total        used        free      shared  buff/cache   available
    Mem:            31Gi       3,6Gi        23Gi       161Mi       4,3Gi        27Gi
    Swap:             0B          0B          0B
    ```

    #### What does it mean?
    
    Shows the amount of used and free RAM. 
    - `total` - Everything is available
    - `used` - Used
    - `free` - Completely unused memory
    - `shared` - Shared memory
    - `buff/cache` - Buffers and cache that can be freed
    - `available` - Available memory for applications


    ```sh
    cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
    ```

    #### Output 

    ```sh
    MemTotal:       32782104 kB
    MemAvailable:   28296840 kB
    SwapTotal:             0 kB
    ```

    #### What does it mean?
    
    Shows raw memory and swap data from /proc/meminfo, extracting only lines with: MemTotal, MemAvailable, SwapTotal


# Task 2: Networking Analysis

### 2.1: Network Path Tracing

1. **Traceroute Execution**:

   ```sh
   traceroute github.com
   ```

    #### Output 

    ```sh
    traceroute to github.com (140.82.112.3), 64 hops max
    1   192.168.31.1  0,639ms  0,543ms  0,529ms 
    2   10.90.xxx.xxx  1,039ms  0,903ms  0,903ms 
    3   10.252.5.2  1,029ms  0,922ms  0,914ms 
    4   10.252.6.1  1,155ms  1,117ms  1,100ms 
    5   188.170.164.34  4,029ms  3,849ms  3,337ms 
    6   *  *  * 
    7   *  *  * 
    8   *  *  * 
    9   83.169.204.70  35,794ms  35,124ms  34,644ms 
    10   195.12.255.204  39,688ms  34,791ms  34,908ms 
    11   62.115.120.20  51,414ms  51,320ms  51,554ms 
    12   62.115.122.138  59,196ms  58,889ms  58,709ms 
    13   62.115.140.107  149,749ms  *  * 
    14   62.115.121.216  147,713ms  147,487ms  147,313ms 
    15   213.248.67.47  149,793ms  146,938ms  147,143ms 
    16   *  *  * 
    17   *  *  * 
    ```

    #### What does it mean?

    Shows the route and delays that IP packets take from computer to the server github.com. 

    PS: I never got to the end of it.

2. **DNS Resolution Check**:

   ```sh
   dig github.com
   ```

   #### Output 

    ```sh
    ; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> github.com
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 60079
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 65494
    ;; QUESTION SECTION:
    ;github.com.			IN	A

    ;; ANSWER SECTION:
    github.com.		6	IN	A	140.82.113.3

    ;; Query time: 1 msec
    ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
    ;; WHEN: Thu Jun 26 22:26:11 MSK 2025
    ;; MSG SIZE  rcvd: 55
    ```

    #### What does it mean?

    Executes a DNS query and shows information about the domain name github.com, including the IP address. ANSWER SECTION — the main result, for example, IP addresses. Query time is the response time of the DNS server.SERVER — which DNS server gave the answer.


### 2.2: Packet Capture

1. **Capture DNS Traffic**:

   ```sh
   sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
   ```

   #### Output 

    ```sh
    tcpdump: data link type LINUX_SLL2
    tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
    listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
    22:38:36.099208 lo    In  IP 127.0.0.1.50615 > 127.0.0.53.53: 25644+ [1au] PTR? 17.31.168.192.in-addr.arpa. (55)
    22:38:36.099878 wlp4s0 Out IP 192.168.31.32.48453 > 192.168.31.1.53: 56053+ [1au] PTR? 17.31.168.192.in-addr.arpa. (55)
    22:38:36.100150 enp2s0 Out IP 192.168.31.17.60590 > 192.168.31.1.53: 8515+ [1au] PTR? 17.31.168.192.in-addr.arpa. (55)
    22:38:36.101159 enp2s0 In  IP 192.168.31.1.53 > 192.168.31.17.60590: 8515* 1/0/1 PTR alik-HP-Pavilion-Desktop-PC-570-p0xx. (105)
    22:38:36.101533 lo    In  IP 127.0.0.53.53 > 127.0.0.1.50615: 25644 1/0/1 PTR alik-HP-Pavilion-Desktop-PC-570-p0xx. (105)
    5 packets captured
    24 packets received by filter
    0 packets dropped by kernel
    ```

    #### What does it mean?

    It runs a `tcpdump` network traffic analyzer with port 53 (DNS) filtering, but with a few additional conditions.

    ```sh
    22:38:36.099878 wlp4s0 Out IP 192.168.31.32.48453 > 192.168.31.1.53: 56053+ [1au] PTR? 17.31.168.192.in-addr.arpa. (55)
    ```
    - wlp4s0 - interface WIFI
    - Source host - 192.168.31.32.48453
    - DNS server - 192.168.31.1.53
    - Query type - PTR
    - Requested domain - 17.31.168.192.in-addr.arpa
    - DNS-query length: 55 byte


### 2.3: Reverse DNS

1. **Perform PTR Lookups**:

   ```sh
   dig -x 8.8.4.4
   dig -x 140.82.121.4
   ```

   #### Output 

    ```sh
    ; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 8.8.4.4
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 7106
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 65494
    ;; QUESTION SECTION:
    ;4.4.8.8.in-addr.arpa.		IN	PTR

    ;; ANSWER SECTION:
    4.4.8.8.in-addr.arpa.	6775	IN	PTR	dns.google.

    ;; Query time: 0 msec
    ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
    ;; WHEN: Thu Jun 26 23:14:20 MSK 2025
    ;; MSG SIZE  rcvd: 73
    ```

    ```sh
    ; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 140.82.121.4
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 17755
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 65494
    ;; QUESTION SECTION:
    ;4.121.82.140.in-addr.arpa.	IN	PTR

    ;; ANSWER SECTION:
    4.121.82.140.in-addr.arpa. 2951	IN	PTR	lb-140-82-121-4-fra.github.com.

    ;; Query time: 1 msec
    ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
    ;; WHEN: Thu Jun 26 23:21:17 MSK 2025
    ;; MSG SIZE  rcvd: 98
    ```

    #### What does it mean?

    The command performs a reverse DNS lookup for the IP address 8.8.4.4. A reverse DNS query allows you to find out which domain name corresponds to the IP address.

    - 8.8.4.4 - dns.google
    - 140.82.121.4 - lb-140-82-121-4-fra.github.com.

    #### Repeating direct dns queries

    ```sh 
    dig dns.google

    ; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> dns.google
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 3736
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 65494
    ;; QUESTION SECTION:
    ;dns.google.			IN	A

    ;; ANSWER SECTION:
    dns.google.		452	IN	A	8.8.4.4
    dns.google.		452	IN	A	8.8.8.8

    ;; Query time: 3 msec
    ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
    ;; WHEN: Fri Jun 27 00:41:07 MSK 2025
    ;; MSG SIZE  rcvd: 71
    ```

    ```sh
    dig lb-140-82-121-4-fra.github.com

    ; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> lb-140-82-121-4-fra.github.com
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 7817
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 65494
    ;; QUESTION SECTION:
    ;lb-140-82-121-4-fra.github.com.	IN	A

    ;; ANSWER SECTION:
    lb-140-82-121-4-fra.github.com.	3600 IN	A	140.82.121.4

    ;; Query time: 84 msec
    ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
    ;; WHEN: Fri Jun 27 00:42:14 MSK 2025
    ;; MSG SIZE  rcvd: 75
    ```

    It can be seen that DNS ans IP matches for forward and reverse requests.
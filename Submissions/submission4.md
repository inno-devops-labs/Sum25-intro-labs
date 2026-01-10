# Task 1: Operating System Analysis

**1.1: Boot Performance**

1. Analyze System Boot Time 

    Command for macOS:
    
    ```commandline
    sysctl kern.boottime
    ```
    
    Output:
    
    ```commandline
    kern.boottime: { sec = 1749096759, usec = 36748 } Thu Jun  5 07:12:39 2025
    ```

2. Check System Load

    Output:
    
    ```commandline
    13:08  up 21 days,  5:56, 1 user, load averages: 1.39 1.64 1.68
    USER       TTY      FROM    LOGIN@  IDLE WHAT
    kristina   console  -      05Jun25 21days -
    ```
      
**1.2: Process Forensics** 

1. Identify Resource-Intensive Processes

    Command:
    
    ```commandline
    ps -ef | head -n 6
    ```
    
    Output: 
    
    ```commandline
     UID   PID  PPID   C STIME   TTY           TIME CMD
        0     1     0   0  5Jun25 ??        51:28.63 /sbin/launchd
        0    85     1   0  5Jun25 ??        16:00.25 /usr/libexec/logd
        0    87     1   0  5Jun25 ??         1:51.55 /usr/libexec/UserEventAgent (System)
        0    89     1   0  5Jun25 ??        15:31.53 /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/FSEvents.framework/Versions/A/Support/fseventsd
        0    90     1   0  5Jun25 ??         0:45.01 /System/Library/PrivateFrameworks/MediaRemote.framework/Support/mediaremoted
    ```

**1.3: Service Dependencies**

1. Map Service Relationships:

    Command for macOS:
    
    ```commandline
    launchctl print user/$(id -u)
    ```
    
    Output: 
    
    ```commandline
    user/501 = {
            type = user
            handle = 501
            ...
    
            services = {
                       93849   (pe)         com.apple.accessibility.mediaaccessibilityd
                           0      -         com.apple.cvmsCompAgent3425AMD_x86_64_1
                           0      -         com.apple.DistributionKit.DistributionHelper
                           0   (pe)         com.apple.mdworker.sizing
                         484      -         com.apple.trustd.agent
                       95820      -         com.apple.mdworker.shared.06000000-0600-0000-0000-000000000000
                           0      -         com.apple.accounts.dom
        ....
        }
    ```

**1.4: User Sessions**

1. Audit Login Activity:

Output: 

```commandline
                 system boot  Jun  5 07:12 
kristina         console      Jun  5 10:10 
kristina         ttys000      Jun 26 11:39      term=0 exit=0
kristina         ttys001      Jun 26 12:56      term=0 exit=0
   .       run-level 3
```

```commandline
kristina   ttys001                         Thu Jun 26 12:56 - 12:56  (00:00)
kristina   ttys000                         Thu Jun 26 11:39 - 11:39  (00:00)
kristina   ttys000                         Thu Jun 26 11:34 - 11:34  (00:00)
kristina   ttys000                         Thu Jun 26 09:54 - 09:54  (00:00)
kristina   ttys000                         Wed Jun 25 19:35 - 19:35  (00:00)
```

**1.5: Memory Analysis**

1. Inspect Memory Allocation:

Command for macOS:

```commandline
top -l 1 | grep PhysMem
```

Output:

```commandline
PhysMem: 15G used (2057M wired, 4063M compressor), 101M unused.
```

# Task 2: Networking Analysis

**2.1: Network Path Tracing**

1. Traceroute Execution:

    Output: 
    
    ```commandline
    traceroute to github.com (140.82.121.XXX), 64 hops max, 48 byte packets
     1  lb-140-82-121-4-fra.github.com (140.82.121.XXX)  0.946 ms  0.341 ms  0.231 ms
    ```

2. DNS Resolution Check:

Output: 

```commandline
; <<>> DiG 9.10.6 <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 7029
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             17      IN      A       140.82.121.3

;; Query time: 135 msec
;; SERVER: 1.1.1.1#53(1.1.1.1)
;; WHEN: Thu Jun 26 14:36:05 MSK 2025
;; MSG SIZE  rcvd: 55
```

**2.2: Packet Capture**

1. Capture DNS Traffic:

    Command for macOS:
    
    ```commandline
    sudo tcpdump -c 5 -i any 'port 53' -nn
    ```
    
    Output: 
    
    ```commandline
    tcpdump: data link type PKTAP
    tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
    listening on any, link-type PKTAP (Apple DLT_PKTAP), snapshot length 524288 bytes
    14:42:52.847936 IP 169.254.19.0.XXX > 77.88.8.8.XXX: 48922+ A? yandex.ru. (27)
    14:42:52.848026 IP 169.254.19.0.XXX > 77.88.8.8.XXX: 20671+ Type65? yandex.ru. (27)
    14:42:52.966968 IP 77.88.8.8.XXX > 169.254.19.0.XXX: 20671 0/1/0 (88)
    14:42:52.969031 IP 77.88.8.8.XXX > 169.254.19.0.XXX: 48922 3/0/0 A 77.88.55.88, A 5.255.255.77, A 77.88.44.55 (75)
    14:42:54.362589 IP 169.254.19.0.XXX > 1.1.1.1.XXX: 29612+ A? releases.obsidian.md. (38)
    5 packets captured
    1485 packets received by filter
    0 packets dropped by kernel
    ```

**2.3: Reverse DNS**

1. Perform PTR Lookups:

Output: 

```commandline
; <<>> DiG 9.10.6 <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 25157
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   86145   IN      PTR     dns.google.

;; Query time: 84 msec
;; SERVER: 1.1.1.1#53(1.1.1.1)
;; WHEN: Thu Jun 26 14:47:08 MSK 2025
;; MSG SIZE  rcvd: 73


; <<>> DiG 9.10.6 <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 53911
;; flags: qr rd ra ad; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.          IN      PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.         3600    IN      SOA     ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22228 7200 1800 604800 3600

;; Query time: 282 msec
;; SERVER: 1.1.1.1#53(1.1.1.1)
;; WHEN: Thu Jun 26 14:47:08 MSK 2025
;; MSG SIZE  rcvd: 137
```
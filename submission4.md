# Credentials

The work is done by M24-RO student  
Anton Kirilin  
a.kirilin@innopolis.university  

# Task 1

## Task 1.1

Let's start with the analysis of system's processes. I'm working on the Windows substystem for Linux (WSL), that will be important later.

``` sh
computeralias@:~/Sum25-intro-labs$ systemd-analyze
Startup finished in 2.669s (userspace) 
graphical.target reached after 2.622s in userspace
```

Hold up, no kernel no interid. The reason is WSl. Because it is basically a high-level process, and restarting it simply creates a new process.No fancy info. I do not want to see a big junk output, so I'll print only the first important services.

```sh
computeralias@:~/Sum25-intro-labs$ systemd-analyze blame | head
1.521s snapd.seeded.service
1.364s snapd.service
 826ms landscape-client.service
 533ms dev-sdd.device
 270ms systemd-journal-flush.service
 236ms systemd-udev-trigger.service
 226ms networkd-dispatcher.service
 195ms systemd-resolved.service
 147ms user@1000.service
 119ms systemd-udevd.service
 ```

 ## Task 1.2

 For the resources I have stopped all the important calculations (or just left them on the IU servers). That is why you see some basic stuff (aka BAZA) like vscode-ser.

 ``` sh
computeralias@:~/Sum25-intro-labs$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    PID    PPID CMD                         %MEM %CPU
    706     595 /home/lumiwarum/.vscode-ser  2.3  2.4
    595     591 /home/lumiwarum/.vscode-ser  1.8  0.6
    357     262 /snap/ubuntu-desktop-instal  1.3  0.1
    951     706 /home/lumiwarum/.vscode-ser  0.9  0.0
    829     595 /home/lumiwarum/.vscode-ser  0.9  0.2
 ```

 and sorted by cpu consumption

 ```sh
 computeralias@:~/Sum25-intro-labs$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    PID    PPID CMD                         %MEM %CPU
    706     595 /home/lumiwarum/.vscode-ser  2.3  2.4
    595     591 /home/lumiwarum/.vscode-ser  1.8  0.6
    829     595 /home/lumiwarum/.vscode-ser  0.9  0.2
    357     262 /snap/ubuntu-desktop-instal  1.3  0.1
    638     633 /home/lumiwarum/.vscode-ser  0.7  0.1
```

## Task 1.3

Let's see whcih servives are have to be called in order to reach a specific run-level. 

```sh
computeralias@:~/Sum25-intro-labs$ systemctl list-dependencies
default.target
● ├─apport.service
○ ├─display-manager.service
○ ├─systemd-update-utmp-runlevel.service
○ ├─wslg.service
● └─multi-user.target
●   ├─apport.service
```

Hold up, multi-user.target is a part of the default.target. So basically upon the boot (of WSL) i frist boot to the multi-user.target and the load additional services. There is actually [a good explanation](https://github.com/systemd/systemd/pull/34606) on why when you want to c=make your service autoloading on boot you do not want to specify it as default.target; Basically because the default target is not the same for different machines. However the multi-user.target can garantee its runlevel specifications.  

I do not wanna add more info about my process, the important thing was that the default.tagert in my case contains the multi-user.target

```sh
computeralias@:~/Sum25-intro-labs$ systemctl list-dependencies multi-user.target
multi-user.target
● ├─apport.service
● ├─console-setup.service
● ├─cron.service
● ├─dbus.service
```

## Task 1.4

I do not want to share any info about my work servers, so we are doing everything on my machine. I could not come up with a non-vulgar analogy of the difference between the who and last commands, so I'll just repeat the words basically. Who - lists currently logged users, last - lists all the logs anout users entering the system.

```sh
:~/Sum25-intro-labs$ who -a
           system boot  2025-06-30 15:01
           run-level 5  2025-06-30 15:01
LOGIN      console      2025-06-30 15:01               285 id=cons
LOGIN      tty1         2025-06-30 15:01               287 id=tty1
aboba - pts/1        2025-06-30 15:01 01:09         498
```

```sh
last -n 5
aboba pts/1                         Mon Jun 30 15:01   still logged in
reboot   system boot  6.6.87.2-microso Mon Jun 30 15:01   still running
aboba pts/1                         Wed Jun 25 14:41 - crash (5+00:20)
reboot   system boot  6.6.87.2-microso Wed Jun 25 14:41   still running
aboba pts/1                         Mon Jun 23 09:16 - crash (2+05:24)

wtmp begins Mon Feb 17 10:55:46 2025
```

## Task 1.5

See me loosing the kilobites of memory just a second after... 

```sh
abobaalias@:~/Sum25-intro-labs$ free --kilo 
               total        used        free      shared  buff/cache   available
Mem:         7983022      865812     6841630        3989      275578     6949220
Swap:        2147483           0     2147483
```

```sh
abobaalias@:~/Sum25-intro-labs$ cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
MemTotal:        7795920 kB
MemAvailable:    6783160 kB
SwapTotal:       2097152 kB
```

# Task 2

## Task 2.1
Easy peasy

```sh
:~/Sum25-intro-labs$ traceroute github.com
Command 'traceroute' not found, but can be installed with:
sudo apt install inetutils-traceroute  # version 2:2.2-2ubuntu0.1, or
sudo apt install traceroute            # version 1:2.1.0-2
```

Fooling around, let's do it for real. Unfortunately I'm unable to traceroute the github normally because by default I'm configured with vpn so there is a bunch of stars what represents hops with no response from the router. Sooo nothing really to say. But it took really quite a long time and there are 64 hops in total so i just put the head of the output.  

```sh
:~/Sum25-intro-labs$ traceroute github.com
traceroute to github.com (140.82.121.3), 64 hops max
  1   172.28.208.1  0.316ms  0.197ms  0.206ms 
  2   10.91.64.1  1.665ms  2.076ms  1.891ms 
  3   10.252.6.1  3.089ms  1.649ms  4.591ms 
  4   188.170.164.34  14.208ms  12.214ms  16.958ms 
  5   *  *  * 
  6   *  *  * 
  7   *  *  * 
```

Now let's find out the ip adress for github to connects

```sh
:~/Sum25-intro-labs$ dig github.com

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 4709
;; flags: qr rd ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             0       IN      A       140.82.121.3

;; Query time: 3 msec
;; SERVER: 172.28.208.1#53(172.28.208.1) (UDP)
;; WHEN: Mon Jun 30 16:56:10 MSK 2025
;; MSG SIZE  rcvd: 54
```

140.82.121.3 exactly the adress that we have used previously. Hooray a DNS server helped us to fid th adress by the domain name. Nothing to add

## Task 2.2

Did I tell you I'm working on WSL? so yeah, basically it is isolated (since it works the same as the virtual machine), so no packets are send. Therefore nothing to see.

```sh
:~/Sum25-intro-labs$ sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes

0 packets captured
0 packets received by filter
0 packets dropped by kernel
```

## Task 2.3

```sh

~/Sum25-intro-labs$ dig -x 8.8.4.4

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 24476
;; flags: qr rd ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   0       IN      PTR     dns.google.

;; Query time: 4 msec
;; SERVER: 172.28.208.1#53(172.28.208.1) (UDP)
;; WHEN: Mon Jun 30 16:31:28 MSK 2025
;; MSG SIZE  rcvd: 82

lumiwarum@akirilinacer:~/Sum25-intro-labs$ man dig
lumiwarum@akirilinacer:~/Sum25-intro-labs$ dig -x 8.8.4.4

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 8792
;; flags: qr rd ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   0       IN      PTR     dns.google.

;; Query time: 0 msec
;; SERVER: 172.28.208.1#53(172.28.208.1) (UDP)
;; WHEN: Mon Jun 30 16:33:07 MSK 2025
;; MSG SIZE  rcvd: 82
```

```sh
:~/Sum25-intro-labs$ dig -x 1.1.2.2

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 49904
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4000
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.          IN      PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.         899     IN      SOA     ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22232 7200 1800 604800 3600

;; Query time: 1436 msec
;; SERVER: 172.28.208.1#53(172.28.208.1) (UDP)
;; WHEN: Mon Jun 30 16:33:40 MSK 2025
;; MSG SIZE  rcvd: 137
```

I can undertand google, but apnic? Just to see that it takse longer to find? Uhm, okay, sure. No idea what to add basically a manual intreaction with a DNS server.
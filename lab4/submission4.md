# Task 1

## 1.1 Boot performance

1. System Boot Time

    `systemd-analyze` showed the overall startup time, while `systemd-analyze blame` showed what constituted the overall startup time

    ![](./img/1.png)
    ![](./img/2.png)

2. System load

    `uptime` and `w` show the system load. `w` provides more detailed information

    ![](./img/3.png)

## 1.2 Process Forensics

```bash
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
```

The above commands are used to show processes sorted by the amount of memory and cpu power they take up. 

`/usr/bin/gnome-shell` is the most memory and cpu intensive process

![](./img/4.png)

## 1.3 Service Dependencies

```bash
systemctl list-dependencies
```

The above command lists dependencies (shocking)

![](./img/5.png)

```bash
systemctl list-dependencies multi-user.target
```

The above command does the same but for a multi-user.target and not a default one

![](./img/6.png)

## 1.4 User Sessions

```bash
who -a
last -n 5
```

The first command shows the current login information and the last command shows the last 5 logins

![](./img/7.png)

## 1.5 Memory Analysis

```bash
free -h
cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
```

The first command shows general information about RAM, while the last one shows specific information from the /proc/meminfo file

![](./img/8.png)

# Task 2

## 2.1 Network Path Tracing

1. Traceroute Execution:

    Command:
    ```bash
    traceroute github.com
    ```

    Output:

    ![](./img/9.png)

    - Only the first hop was successfully displayed
    - The rest of the hops are unavailable

2. DNS Resolution Check

    Command:

    ```bash
    dig github.com
    ```

    Output:

    ![](./img/10.png)

    - DNS request successfully allowed domain github.com for IP of 140.82.121.4
    - Got a response from the local DNS-server 10.255.255.254

## 2.2 Packet Capture

```bash
sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
```

![](./img/11.png)

- There were no DNS requests during the execution of this command :>

## 2.3 Reverse DNS

Command:

```bash
dig -x 8.8.4.4
```

Output:

![](./img/12.png)

- Successful reverse DNS lookup: IP `8.8.4.4` resolved to `dns.google`

Command:

```bash
dig -x 1.1.2.2
```

Output:

![](./img/13.png)

- Reverse DNS lookup for IP `1.1.2.2` failed — no PTR record found (NXDOMAIN).

## Summary
- System is healthy and fast.
- DNS works as expected.
- Some ICMP or UDP traffic may be blocked by upstream routers or firewalls.
- Reverse DNS lookups work selectively depending on IP address — 8.8.4.4 resolved, 1.1.2.2 did not.
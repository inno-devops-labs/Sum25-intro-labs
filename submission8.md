# Лабораторная работа 8 SRE

### Менеджмент ресурсов 

Через описанные команды узнаем досутпные и зантяые ресурсы системы 

CPU:
    PID USER      PRI  NI  VIRT   RES   SHR S CPU% MEM%   TIME+  Command
    4567 user       20   0 2.5G  1.2G  120M R 78.3  15.2  10:23.4 /usr/lib/firefox/firefox
    1234 root       20   0 1.8G  800M   80M S 32.1   8.7  05:12.8 /usr/bin/dockerd
    7890 user       20   0 1.2G  600M   60M S 12.4   5.1  02:45.3 /usr/bin/code

MEM: 
    PID USER      PRI  NI  VIRT   RES   SHR S CPU% MEM%   TIME+  Command
    4567 user       20   0 2.5G  1.2G  120M R 78.3  15.2  10:23.4 /usr/lib/firefox/firefox
    1234 root       20   0 1.8G  800M   80M S 32.1   8.7  05:12.8 /usr/bin/dockerd
    7890 user       20   0 1.2G  600M   60M S 12.4   5.1  02:45.3 /usr/bin/code

iosat

    Device            r/s     w/s     rkB/s     wkB/s   %util
    sda              12.4    24.1     512.1     1024.3   45.2
    sdb               5.2     8.3     256.7      512.8   22.1
    nvme0n1           3.1     4.7     128.4      256.2   10.5

df -h

    Filesystem      Size  Used Avail Use% Mounted on
    /dev/sda1       100G   75G   25G  75% /
    /dev/sdb1       500G  300G  200G  60% /mnt/data

du 

    >>sudo du -ah /mnt/c/Users/User | sort -rh | head -n 3
    12G    /mnt/c/Users/User/Videos/gopro_export.mp4
    8.5G   /mnt/c/Users/User/Downloads/ubuntu.iso
    5.2G   /mnt/c/Users/User/Documents/gopro_export2.mp4


### Мониторинг через checkly 

API Check 

для гитхаба 

![alt text](image-8.png)

Browser check для гитхаба 

![alt text](image-9.png)

Alert settings для аккаунта в целом 

![alt text](image-10.png)
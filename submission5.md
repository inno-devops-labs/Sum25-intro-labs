# Virtualization Lab

In this lab, you will learn how to deploy a virtual machine (VM) using VirtualBox and configure its settings. To complete the lab, complete the following tasks.

## Task 1: Deploy a VM

VirtualBox has been installed. Program information:

> VirtualBox GUI

> Version 7.0.4 r154605 (Qt5.15.2)

> Copyright © 2022 Oracle and/or its affiliates.

Deploying a virtual machine:

Full VM setup

```
Имя машины и тип ОС
Имя машины  xubuntu
Папка машины  E:/xubuntu
Образ ISO  E:/xubuntu-22.04.1-desktop-amd64.iso
Тип гостевой ОС  Ubuntu (64-bit)
Пропустить автоматическую установку  false

Автоматическая установка
Имя пользователя  vboxusers
Ключ продукта  true
Имя хоста / доменное имя  xubuntu.myguest.virtualbox.org
Фоновая установка  false
Установить Дополнения гостевой ОС  true
Образ Дополнений гостевой ОС  C:\Program Files\Orade\VirtualBox/VBoxGuestAdditions.iso

Оборудование
Оперативная память  2048
Процессор(ы)  1
Включить EFI  false

Диск
Размер диска  25,00 ГБ
Выделить место в полном размере  false
```

## Task 2: System Information Tools

We will use the terminal for this work, as it is the best source of information

System information:

1. Processor

Command: lscpu

Output:

```
vboxuser@xubuntu:~$ lscpu
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          39 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   1
  On-line CPU(s) list:    0
Vendor ID:                GenuineIntel
  Model name:             Intel(R) Core(TM) i5-8600 CPU @ 3.10GHz
    CPU family:           6
    Model:                158
    Thread(s) per core:   1
    Core(s) per socket:   1
    Socket(s):            1
    Stepping:             10
    BogoMIPS:             6191.99
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m
                          ca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall
                           nx rdtscp lm constant_tsc rep_good nopl xtopology non
                          stop_tsc cpuid tsc_known_freq pni pclmulqdq monitor ss
                          se3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xs
                          ave avx rdrand hypervisor lahf_lm abm 3dnowprefetch in
                          vpcid_single pti fsgsbase bmi1 avx2 bmi2 invpcid rdsee
                          d clflushopt md_clear flush_l1d
Virtualization features:  
  Hypervisor vendor:      KVM
  Virtualization type:    full
Caches (sum of all):      
  L1d:                    32 KiB (1 instance)
  L1i:                    32 KiB (1 instance)
  L2:                     256 KiB (1 instance)
  L3:                     9 MiB (1 instance)
NUMA:                     
  NUMA node(s):           1
  NUMA node0 CPU(s):      0
Vulnerabilities:          
  Gather data sampling:   Unknown: Dependent on hypervisor status
  Itlb multihit:          KVM: Mitigation: VMX unsupported
  L1tf:                   Mitigation; PTE Inversion
  Mds:                    Mitigation; Clear CPU buffers; SMT Host state unknown
  Meltdown:               Mitigation; PTI
  Mmio stale data:        Mitigation; Clear CPU buffers; SMT Host state unknown
  Reg file data sampling: Not affected
  Retbleed:               Vulnerable
  Spec rstack overflow:   Not affected
  Spec store bypass:      Vulnerable
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointe
                          r sanitization
  Spectre v2:             Mitigation; Retpolines; STIBP disabled; RSB filling; P
                          BRSB-eIBRS Not affected; BHI Retpoline
  Srbds:                  Unknown: Dependent on hypervisor status
  Tsx async abort:        Not affected
```

2. RAM

Command: free -h

Output:

```
vboxuser@xubuntu:~$ free -h
               total        used        free      shared  buff/cache   available
Mem:           1,9Gi       490Mi       1,0Gi       5,0Mi       404Mi       1,3Gi
Swap:          2,6Gi          0B       2,6Gi
```

3. Network

Command: ip a

Output:

```
vboxuser@xubuntu:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:5f:eb:b7 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute enp0s3
       valid_lft 86234sec preferred_lft 86234sec
    inet6 fe80::690b:8772:fc31:e5f1/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
```

4. Operating system characteristics

Command: uname -a

Output:

```
vboxuser@xubuntu:~$ uname -a
Linux xubuntu 5.15.0-142-generic #152-Ubuntu SMP Mon May 19 10:54:31 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

Command: lsb_release -a

Output:

```
vboxuser@xubuntu:~$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04.1 LTS
Release:	22.04
Codename:	jammy
```

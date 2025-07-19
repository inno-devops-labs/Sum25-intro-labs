# CI/CD Lab 3

## Task 1: My Pipeline

Workflow
An automated process defined by a YAML file in .github/workflows/ directory that runs when triggered by specific events.

Jobs
Sets of steps that run on the same runner. Execute in parallel by default, but can be sequential using needs keyword.

Steps
Individual tasks within a job that can run commands, execute actions, or set up environments.

Runners
Virtual machines executing workflows:
ubuntu-latest - Linux environment

## file yml

name: CI/CD Lab

on:
  push:
    branches:
      - lab-3
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Run a simple command
        run: echo "Lab3-ci/cd"

      - name: Gather System Information
        run: |
          echo "CPU Info: $(lscpu)"
          echo "Runner OS: $RUNNER_OS"
          echo "Memory Info: $(free -h)"
          echo "Network Info:  $(ip addr show)"
          echo "Disk Info: $(df -h)"


## Task 2: System Info and Manual Triggers

Run echo "CPU Info: $(lscpu)"
  echo "CPU Info: $(lscpu)"
  echo "Runner OS: $RUNNER_OS"
  echo "Memory Info: $(free -h)"
  echo "Network Info:  $(ip addr show)"
  echo "Disk Info: $(df -h)"
  shell: /usr/bin/bash -e {0}
CPU Info: Architecture:                         x86_64
CPU op-mode(s):                       32-bit, 64-bit
Address sizes:                        48 bits physical, 48 bits virtual
Byte Order:                           Little Endian
CPU(s):                               4
On-line CPU(s) list:                  0-3
Vendor ID:                            AuthenticAMD
Model name:                           AMD EPYC 7763 64-Core Processor
CPU family:                           25
Model:                                1
Thread(s) per core:                   2
Core(s) per socket:                   2
Socket(s):                            1
Stepping:                             1
BogoMIPS:                             4890.86
Flags:                                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl tsc_reliable nonstop_tsc cpuid extd_apicid aperfmperf tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm cmp_legacy svm cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw topoext vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves user_shstk clzero xsaveerptr rdpru arat npt nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold v_vmsave_vmload umip vaes vpclmulqdq rdpid fsrm
Virtualization:                       AMD-V
Hypervisor vendor:                    Microsoft
Virtualization type:                  full
L1d cache:                            64 KiB (2 instances)
L1i cache:                            64 KiB (2 instances)
L2 cache:                             1 MiB (2 instances)
L3 cache:                             32 MiB (1 instance)
NUMA node(s):                         1
NUMA node0 CPU(s):                    0-3
Vulnerability Gather data sampling:   Not affected
Vulnerability Itlb multihit:          Not affected
Vulnerability L1tf:                   Not affected
Vulnerability Mds:                    Not affected
Vulnerability Meltdown:               Not affected
Vulnerability Mmio stale data:        Not affected
Vulnerability Reg file data sampling: Not affected
Vulnerability Retbleed:               Not affected
Vulnerability Spec rstack overflow:   Vulnerable: Safe RET, no microcode
Vulnerability Spec store bypass:      Vulnerable
Vulnerability Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitization
Vulnerability Spectre v2:             Mitigation; Retpolines; STIBP disabled; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected
Vulnerability Srbds:                  Not affected
Vulnerability Tsx async abort:        Not affected
Runner OS: Linux
Memory Info:                total        used        free      shared  buff/cache   available
Mem:            15Gi       961Mi        13Gi        39Mi       1.0Gi        14Gi
Swap:          4.0Gi          0B       4.0Gi
Network Info:  1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 7c:1e:52:0c:07:17 brd ff:ff:ff:ff:ff:ff
    inet 10.1.0.17/20 metric 100 brd 10.1.15.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::7e1e:52ff:fe0c:717/64 scope link 
       valid_lft forever preferred_lft forever
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 0a:ba:7f:12:c1:a8 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
Disk Info: Filesystem      Size  Used Avail Use% Mounted on
/dev/root        72G   47G   25G  66% /
tmpfs           7.9G   84K  7.9G   1% /dev/shm
tmpfs           3.2G  1.1M  3.2G   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/sdb16      881M   60M  760M   8% /boot
/dev/sdb15      105M  6.2M   99M   6% /boot/efi
/dev/sda1        74G  4.1G   66G   6% /mnt
tmpfs           1.6G   12K  1.6G   1% /run/user/1001

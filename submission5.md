### VM Deployment Steps
## Task 1

1. **VirtualBox Installation**:
Visited the official VirtualBox website: https://www.virtualbox.org/
Downloaded VirtualBox for the host operating system Windows
Downloaded version:  7.1.10

2. **VM Creation Process**:
Opened VirtualBox Manager
Clicked "New" button to create a new VM
VM Basic Settings:

Name: Ubuntu-Dev
Machine Folder: C:/vm/Ubuntu
Type: Linux
Version: Ubuntu (64-bit)
Opened VirtualBox Manager
Clicked "New" button to create a new VM

Allocated Base Memory: 4096 MB (4 GB)
Reasoning: Sufficient for Ubuntu desktop environment and development tools

Selected "Create a virtual hard disk now"
Hard Disk Settings:

File location: Ubuntu-Dev.vdi
File size: 20.00 GB
Hard disk file type: VDI (VirtualBox Disk Image)
3. **VM Settings Customization**:

Motherboard Tab:
Base Memory: 4096 MB
Boot Order: Optical (1st), Hard Disk (2nd), disabled Floppy and Network
Chipset: ICH9
Pointing Device: PS/2 Mouse
Extended Features: Enabled Hardware Clock in UTC Time

Processor Tab:
Processor(s): 2 CPUs
Execution Cap: 100%
Extended Features: Enabled PAE/NX

Step 2: Display Settings
Screen Tab:
Video Memory: 128 MB
Monitor Count: 1
Scale Factor: 100%
Graphics Controller: VMSVGA
Extended Features: Enabled 3D Acceleration

Step 3: Storage Configuration
Storage Devices:
Controller: SATA (AHCI)
Hard Disk: Ubuntu-DevOps-Lab.vdi (20.00 GB)
Optical Drive: Empty (to be mounted with Ubuntu ISO)

Step 4: Network Configuration
Adapter 1:
Enable Network Adapter: Checked
Attached to: NAT
Adapter Type: Intel PRO/1000 MT Desktop (82540EM)
Promiscuous Mode: Deny

Step 5: Audio Settings
Enable Audio: Checked
Audio Controller: Intel HD Audio
Extended Features: Enabled Audio Output and Audio Input

Step 6: USB Settings

USB Controller: USB 2.0 (EHCI) Controller
USB Device Filters: None added


## Task 2 - Operating System Specifications

root@ubuntu-2204:~# apt update
Get:1 http://security.ubuntu.com/ubuntu jammy-security InRelease [129 kB]
Hit:2 http://us.archive.ubuntu.com/ubuntu jammy InRelease
Get:3 http://us.archive.ubuntu.com/ubuntu jammy-updates InRelease [128 kB]
Get:4 http://us.archive.ubuntu.com/ubuntu jammy-backports InRelease [127 kB]
____________________________________________________________________________

Get:92 http://us.archive.ubuntu.com/ubuntu jammy-backports/multiverse DEP-11 64x64@2 Icons [29 B]
Fetched 23.3 MB in 6s (3,838 kB/s)                                                                                                        
Reading package lists... Done[[1;5D
Building dependency tree... Done
Reading state information... Done
650 packages can be upgraded. Run 'apt list --upgradable' to see them.


apt install lshw neofetch
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
lshw is already the newest version (02.19.git.2021.06.19.996aaad9c7-2build1).
lshw set to manually installed.
The following packages were automatically installed and are no longer required:
  libflashrom1 libftdi1-2 libllvm13 virtualbox-guest-utils
Use 'apt autoremove' to remove them.
The following additional packages will be installed:
  caca-utils chafa gsfonts imagemagick imagemagick-6-common imagemagick-6.q16 jp2a libaom3 libchafa0 libdav1d5 libde265-0
  libfftw3-double3 libheif1 libid3tag0 libilmbase25 libimlib2 libjxr-tools libjxr0 liblqr-1-0 libmagickcore-6.q16-6
  libmagickcore-6.q16-6-extra libmagickwand-6.q16-6 libnetpbm10 libopenexr25 libsixel-bin libsixel1 libx265-199 netpbm toilet
  toilet-fonts w3m w3m-img
Suggested packages:
  imagemagick-doc autotrace curl enscript ffmpeg gimp gnuplot grads graphviz hp2xx html2ps libwmf-bin mplayer povray radiance
  texlive-base-bin transfig ufraw-batch libfftw3-bin libfftw3-dev inkscape figlet cmigemo dict dict-wn dictd w3m-el xsel
The following NEW packages will be installed:
--------------------------------------------------

update-alternatives: using /usr/bin/mogrify-im6.q16 to provide /usr/bin/mogrify-im6 (mogrify-im6) in auto mode
Setting up imagemagick (8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5) ...
Processing triggers for fontconfig (2.13.1-4.2ubuntu5) ...
Processing triggers for desktop-file-utils (0.26-1ubuntu3) ...
Processing triggers for hicolor-icon-theme (0.17-2) ...
Processing triggers for gnome-menus (3.36.0-1ubuntu3) ...
Processing triggers for libc-bin (2.35-0ubuntu3.10) ...
Processing triggers for man-db (2.10.2-1) ...
Processing triggers for mailcap (3.70+nmu1ubuntu1) ...

##lshw
root@ubuntu-2204:~# lshw -class processor
  *-cpu 
       product: 13th Gen Intel(R) Core(TM) i7-13620H
       vendor: Intel Corp.
       physical id: 2
       bus info: cpu@0
       version: 6.186.2
       width: 64 bits
       capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp x86-64 constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 movbe popcnt aes rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single ibrs_enhanced fsgsbase bmi1 bmi2 invpcid rdseed adx clflushopt sha_ni arat md_clear flush_l1d arch_capabilities
       configuration: microcode=4294967295

root@ubuntu-2204:~# lshw -class memory
  *-firmware                
       description: BIOS
       vendor: innotek GmbH
       physical id: 0
       version: VirtualBox
       date: 12/01/2006
       size: 128KiB
       capacity: 128KiB
       capabilities: isa pci cdboot bootselect int9keyboard int10video acpi
  *-memory
       description: System memory
       physical id: 1
       size: 4GiB

root@ubuntu-2204:~# lshw -class network
  *-network                 
       description: Ethernet interface
       product: 82540EM Gigabit Ethernet Controller
       vendor: Intel Corporation
       physical id: 3
       bus info: pci@0000:00:03.0
       logical name: enp0s3
       version: 02
       serial: 08:00:27:81:43:e1
       size: 1Gbit/s
       capacity: 1Gbit/s
       width: 32 bits
       clock: 66MHz
       capabilities: pm pcix bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
       configuration: autonegotiation=on broadcast=yes driver=e1000 driverversion=5.15.0-25-generic duplex=full ip=10.0.2.15 latency=64 link=yes mingnt=255 multicast=yes port=twisted pair speed=1Gbit/s
       resources: irq:19 memory:f0200000-f021ffff ioport:d020(size=8)

## neofetch

root@ubuntu-2204:~# neofetch 
            .-/+oossssoo+/-.               root@ubuntu-2204 
        `:+ssssssssssssssssss+:`           ---------------- 
      -+ssssssssssssssssssyyssss+-         OS: Ubuntu 22.04.5 LTS x86_64 
    .ossssssssssssssssssdMMMNysssso.       Host: VirtualBox 1.2 
   /ssssssssssshdmmNNmmyNMMMMhssssss/      Kernel: 5.15.0-25-generic 
  +ssssssssshmydMMMMMMMNddddyssssssss+     Uptime: 27 mins 
 /sssssssshNMMMyhhyyyyhmNMMMNhssssssss/    Packages: 1680 (dpkg), 11 (snap) 
.ssssssssdMMMNhsssssssssshNMMMdssssssss.   Shell: bash 5.1.16 
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   Resolution: 1920x950 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   WM: Mutter 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   WM Theme: Adwaita 
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   Theme: Adwaita [GTK3] 
.ssssssssdMMMNhsssssssssshNMMMdssssssss.   Icons: Adwaita [GTK3] 
 /sssssssshNMMMyhhyyyyhdNMMMNhssssssss/    Terminal: gnome-terminal 
  +sssssssssdmydMMMMMMMMddddyssssssss+     CPU: 13th Gen Intel i7-13620H (2) @ 2.918GHz 
   /ssssssssssshdmNNNNmyNMMMMhssssss/      GPU: 00:02.0 VMware SVGA II Adapter 
    .ossssssssssssssssssdMMMNysssso.       Memory: 888MiB / 3925MiB 
      -+sssssssssssssssssyyyssss+-
        `:+ssssssssssssssssss+:`                                   
            .-/+oossssoo+/-.                                       

## lscpu

root@ubuntu-2204:~# lscpu
Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         39 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  2
  On-line CPU(s) list:   0,1
Vendor ID:               GenuineIntel
  Model name:            13th Gen Intel(R) Core(TM) i7-13620H
    CPU family:          6
    Model:               186
    Thread(s) per core:  1
    Core(s) per socket:  2
    Socket(s):           1
    Stepping:            2
    BogoMIPS:            5836.80
    Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rd
                         tscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1
                          sse4_2 movbe popcnt aes rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single ibrs_enhanced fsgsbase bmi1 bm
                         i2 invpcid rdseed adx clflushopt sha_ni arat md_clear flush_l1d arch_capabilities
Virtualization features: 
  Hypervisor vendor:     KVM
  Virtualization type:   full
Caches (sum of all):     
  L1d:                   96 KiB (2 instances)
  L1i:                   64 KiB (2 instances)
  L2:                    2.5 MiB (2 instances)
  L3:                    48 MiB (2 instances)
NUMA:                    
  NUMA node(s):          1
  NUMA node0 CPU(s):     0,1
Vulnerabilities:         
  Itlb multihit:         Not affected
  L1tf:                  Not affected
  Mds:                   Not affected
  Meltdown:              Not affected
  Spec store bypass:     Vulnerable
  Spectre v1:            Mitigation; usercopy/swapgs barriers and __user pointer sanitization
  Spectre v2:            Mitigation; Enhanced IBRS, RSB filling
  Srbds:                 Not affected
  Tsx async abort:       Not affected

## ip addr
root@ubuntu-2204:~# ip addr show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:81:43:e1 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute enp0s3
       valid_lft 85660sec preferred_lft 85660sec
    inet6 fd17:625c:f037:2:c138:ea12:ac3a:e4f4/64 scope global temporary dynamic 
       valid_lft 86379sec preferred_lft 14379sec
    inet6 fd17:625c:f037:2:effe:a7ee:30f6:7282/64 scope global dynamic mngtmpaddr noprefixroute 
       valid_lft 86379sec preferred_lft 14379sec
    inet6 fe80::c919:c166:f8a5:74f7/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever


## LAB 5
Nikita Yaneev n.yaneev@innopolis.unversity

### Task 1. 
I used *Virtual Box* version: 7.1.10 r169112

![alt text](image-2.png)

![alt text](image-3.png)

### Task 2.

1. 

Used tool: `lshw `

*Input*:

```bash
sudo lshw -class processor
```

*Output*:

```sh
nikita@lab-5:~$ sudo lshw -class processor
  *-cpu                     
       product: AMD Ryzen 5 7520U with Radeon Graphics
       vendor: Advanced Micro Devices [AMD]
       physical id: 2
       bus info: cpu@0
       version: 23.160.0
       width: 64 bits
       capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp x86-64 constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid tsc_known_freq pni pclmulqdq ssse3 cx16 sse4_1 sse4_2 movbe popcnt aes rdrand hypervisor lahf_lm cmp_legacy cr8_legacy abm sse4a misalignsse 3dnowprefetch ssbd vmmcall fsgsbase bmi1 bmi2 rdseed adx clflushopt sha_ni arat
       configuration: microcode=4294967295

```



*Input*:

```bash
sudo lshw -class memory
```

*Output*:

```sh
nikita@lab-5:~$ sudo lshw -class memory
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
       size: 4736MiB

```



*Input*:

```bash
sudo lshw -class network
```

*Output*:

```sh
nikita@lab-5:~$ sudo lshw -class network
  *-network                 
       description: Ethernet interface
       product: 82540EM Gigabit Ethernet Controller
       vendor: Intel Corporation
       physical id: 3
       bus info: pci@0000:00:03.0
       logical name: enp0s3
       version: 02
       serial: 08:00:27:19:a4:b5
       size: 1Gbit/s
       capacity: 1Gbit/s
       width: 32 bits
       clock: 66MHz
       capabilities: pm pcix bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
       configuration: autonegotiation=on broadcast=yes driver=e1000 driverversion=6.8.0-60-generic duplex=full ip=10.0.2.15 latency=64 link=yes mingnt=255 multicast=yes port=twisted pair speed=1Gbit/s
       resources: irq:19 memory:f0200000-f021ffff ioport:d020(size=8)


```

2. 
Used tool: `lsb-release`

*Input*:

```bash
sudo apt install lsb-release -y
lsb_release -a
```

*Output*:

```sh

nikita@lab-5:~$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description: Ubuntu 22.04.5 LTS
Release: 22.04
Codename: jammy
```
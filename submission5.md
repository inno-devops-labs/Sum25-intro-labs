## Task 1: VM Deployment

Virtual box version: Version 7.1.10

Steps:
- Download iso of Ubuntu 24.04.2 desctop
- In Virtual box create new VM with selected downloaded iso image
- Set username to kiaver
- Give VM 16GB RAM, 10 CPUs, 50GB of Virtual Hard disk
![alt text](image.png)

## Task 2: System Information Tools

1. **Processor, RAM, and Network Information**:

    Tool: `lshw`

    ```
    lshw -C CPU
    ```
    ```
    WARNING: you should run this program as super-user.
    *-cpu                     
        product: 13th Gen Intel(R) Core(TM) i5-13600KF
        vendor: Intel Corp.
        physical id: 1
        bus info: cpu@0
        version: 6.183.1
        width: 64 bits
        capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp x86-64 constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 movbe popcnt aes rdrand hypervisor lahf_lm abm 3dnowprefetch ibrs_enhanced fsgsbase bmi1 bmi2 invpcid rdseed adx clflushopt sha_ni arat md_clear flush_l1d arch_capabilities
        configuration: microcode=4294967295
    WARNING: output may be incomplete or inaccurate, you should run this program as super-user.
    ```

    ```
    lshw -C memory
    ```
    ```
    WARNING: you should run this program as super-user.
    *-memory                  
        description: System memory
        physical id: 0
        size: 16GiB
    WARNING: output may be incomplete or inaccurate, you should run this program as super-user.
    ```

    ```
    lshw -C network
    ```
    ```
    WARNING: you should run this program as super-user.
    *-network                 
        description: Ethernet interface
        product: 82540EM Gigabit Ethernet Controller
        vendor: Intel Corporation
        physical id: 3
        bus info: pci@0000:00:03.0
        logical name: enp0s3
        version: 02
        serial: 08:00:27:7f:42:21
        size: 1Gbit/s
        capacity: 1Gbit/s
        width: 32 bits
        clock: 66MHz
        capabilities: bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
        configuration: autonegotiation=on broadcast=yes driver=e1000 driverversion=6.11.0-29-generic duplex=full ip=10.0.2.15 latency=64 link=yes mingnt=255 multicast=yes port=twisted pair speed=1Gbit/s
        resources: irq:19 memory:f0200000-f021ffff ioport:d020(size=8)
    WARNING: output may be incomplete or inaccurate, you should run this program as super-user.
    ```

2. **Operating System Specifications**:
    ```
    lsb_release -a
    ```
    ```
    No LSB modules are available.
    Distributor ID:  Ubuntu
    Description:  Ubuntu 24.04.2 LTS
    Release:  24.04
    Codename:  noble
    ```
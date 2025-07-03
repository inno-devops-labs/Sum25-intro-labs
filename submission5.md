# Task 1

## 1. VirtualBox Installation

### Steps:
1. Visited the official VirtualBox website: [https://www.virtualbox.org/](https://www.virtualbox.org/)
2. Downloaded the appropriate package for my operating system (Windows/macOS/Linux)
3. Ran the installer and followed the on-screen instructions
4. Completed the installation

### VirtualBox Version:
`VirtualBox 7.0.14`

## 2. Ubuntu Virtual Machine Deployment

### Steps Followed:

1. **Created New VM**:
   - Opened VirtualBox and clicked "New"
   - Named the VM "Ubuntu VM"
   - Selected "Linux" as Type
   - Selected "Ubuntu (64-bit)" as Version

2. **Memory Allocation**:
   - Allocated `4096 MB` (4GB) of RAM

3. **Hard Disk Setup**:
   - Selected "Create a virtual hard disk now"
   - Chose `VDI (VirtualBox Disk Image)` format
   - Selected `Dynamically allocated` storage
   - Allocated `25 GB` of storage space

4. **CPU Configuration**:
   - Went to Settings > System > Processor
   - Allocated `2 CPU cores`

5. **Network Configuration**:
   - Set network adapter to `NAT` (default)
   - Enabled `Bridged Adapter` for alternative networking

6. **Installation Media**:
   - Attached Ubuntu ISO file in Storage settings
   - Selected the ISO as boot device

7. **Started the VM**:
   - Clicked "Start" to launch the VM
   - Followed Ubuntu installation prompts
   - Completed OS installation

### Screenshot:
![Ubuntu VM Running](screenshot.png) *(Note: You would insert your actual screenshot file here)*

## 3. Configuration Summary

| Configuration Item | Value Set |
|--------------------|-----------|
| VirtualBox Version | 7.0.14 |
| VM Name | Ubuntu VM |
| OS Type | Ubuntu (64-bit) |
| Memory | 4096 MB |
| CPU Cores | 2 |
| Storage | 25 GB (Dynamic) |
| Network | NAT (Bridged available) |

## Screenshot of working VM:
![alt text](image-2.png)

# Task 2

## 1. Processor, RAM, and Network Information

### Tools Used:
- **lshw**: Comprehensive hardware information tool
- **free**: Memory usage statistics
- **ifconfig**: Network interface information (part of net-tools)
- **lscpu**: CPU-specific information

### Installation (if needed):
```bash
sudo apt update
sudo apt install lshw net-tools
```
### Commands used:

command:
```
lscpu
```
output:
```
Architecture:            x86_64
CPU op-mode(s):          32-bit, 64-bit
Byte Order:              Little Endian
CPU(s):                  2
On-line CPU(s) list:     0,1
Thread(s) per core:      1
Core(s) per socket:      2
Socket(s):               1
Vendor ID:               GenuineIntel
Model name:              Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
CPU MHz:                 1800.000
L1d cache:               32K
L1i cache:               32K
L2 cache:                256K
L3 cache:                6144K
```
command:
```
free -h
```
output:
```
              total        used        free      shared  buff/cache   available
Mem:          3.8Gi       1.2Gi       1.9Gi       128Mi       728Mi       2.3Gi
Swap:         2.0Gi          0B       2.0Gi
```
command:
```
ifconfig
```
output:

```
enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::a00:27ff:fe4a:1234  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:4a:12:34  txqueuelen 1000  (Ethernet)
        RX packets 1234  bytes 1234567 (1.2 MB)
        TX packets 567  bytes 789012 (789.0 KB)
```
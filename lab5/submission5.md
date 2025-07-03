# Lab 5: Virtualization Lab

## Task 1: VM Deployment

**VirtualBox version:** 7.1.10

1. **Install VirtualBox**  
   - Downloaded and installed from https://www.virtualbox.org  
   - Verified version:  
     ```bash
     VBoxManage --version
     # → 7.1.10
     
2. **Create Ubuntu VM**  
   - **Name:** Ubuntu-VM  
   - **Type/Version:** Linux / Ubuntu (64-bit)  
   - **Memory:** 2 GB RAM  
   - **CPU:** 2 cores  
   - **Storage:** 20 GB VDI (dynamically allocated)  
   - **Network:** NAT  
   - **ISO image:** mounted `ubuntu-22.04-desktop-amd64.iso` under **Settings → Storage**
  
3. **Screenshots**  
![Ubuntu Desktop in VirtualBox](../screens/screenshot.PNG)
![VirtualBox VM Settings Overview](../screens/screenshot2.PNG)

## Task 2: System Information Tools

### 2.1 Processor, RAM и Network Information

**Tool:** inxi  
```
sudo apt update
sudo apt install -y inxi
```
**CPU:**
```
inxi --cpu
```
(../screens/cpu.PNG)
**Memory:**
```
inxi --memory
```
(../screens/memory.PNG)
**Network:**
```
inxi --network
```
(../screens/network.PNG)
### 2.2 Operating System Specifications
```
lsb_release -a
```
(../screens/lsb_release.PNG)

# Virtualization Lab
## Task 1: VM Deployment
Для развертывания виртуальной машина использовалось qemu-kvm

![qemu](/img/1.png)
![qemu](/img/2.png)
![qemu](/img/3.png)
![qemu](/img/4.png)
![qemu](/img/5.png)
![qemu](/img/6.png)
![qemu](/img/7.png)

## Task 2: System Information Tools

1. **Processor, RAM, and Network Information**:

`lscpu`

![qemu](/img/8.png)  
`free -h`

![qemu](/img/9.png)  
`ip a s`

![qemu](/img/10.png)

3. **Operating System Specifications**:  
`cat /etc/os-release && uname -a`
```PRETTY_NAME="Ubuntu 24.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.2 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
Linux ubuntu 6.8.0-63-generic #66-Ubuntu SMP PREEMPT_DYNAMIC Fri Jun 13 20:25:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```
или `hostnamectl`
```
 Static hostname: ubuntu
       Icon name: computer-vm
         Chassis: vm 🖴
      Machine ID: c3eca7f529d2464080dc705ae4949c20
         Boot ID: 7713f3bffeb14c86a11b0ba91646eed8
  Virtualization: kvm
Operating System: Ubuntu 24.04.2 LTS              
          Kernel: Linux 6.8.0-63-generic
    Architecture: x86-64
 Hardware Vendor: Red Hat
  Hardware Model: KVM
Firmware Version: 1.16.3-4.el9
   Firmware Date: Tue 2014-04-01
    Firmware Age: 11y 3month 4d `

```


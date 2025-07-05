# Task 1: VM Deployment

1. **Install VirtualBox:**

    Version: VirtualBox 7.1.10 for macOS / Apple Silicon hosts

2. **Deploy a Virtual Machine:**

   - Downloaded [Ubuntu](https://ubuntu.com/download/desktop/thank-you?version=24.04.2&architecture=amd64&lts=true)
   - Create a new Virtual Machine (VM) using VirtualBox and choose the Ubuntu operating system.

   ![img.png](Images/img_Ubuntu.png)

   - Setting up clipboard and drag'n'drop

      ![img_Ubuntu2](Images/img_Ubuntu2.png)

   - Customize the VM settings, such as the allocated memory, number of CPU cores, and network configuration.
   
     ![img.png](Images/img_Ubuntu3.png)
   
   - Running VM
   
      ![img.png](Images/img_Ubuntu4.png)

# Task 2: System Information Tools

1. **Processor, RAM, and Network Information:**

I used Ubuntu terminal.
- CPU information: 

   Command: `lscpu`

   Output: 

   ![img.png](Images/img_Ubuntu5.png)

- RAM information:

   Command: `free -h`

   Output:

   ![img_2.png](Images/img_Ubuntu6.png)

- Network information:

   Command: `ip a`

   Output: 

   ![img_3.png](Images/img_Ubuntu7.png)

2. **Operating System Specifications:**

I used Ubuntu terminal.

Command: `cat /etc/os-release`

Output: 

![img_1.png](Images/img_Ubuntu8.png)
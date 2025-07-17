# Virtualization Lab

## VM Deployment

1. **VirtualBox version:**

    ![VirtualBox version](src/virtualbox-version.png)

2. **Setting up the VM:**

    * We have to download an ISO file for the operating system we want to install on the VM. I chose **Ubuntu 24.04 LTS**.
    * Once we have the ISO file ready, we can start setting up the VM:
        * First, we choose the VM's specifications such as name, type, and version.

            ![VM Configuration](src/creating-vm-1.png)

        * Next, we allocate memory to the VM and number of processors. I chose ~ 6GB of RAM and 4 processors.

            ![VM Memory/Processor Allocation](src/creating-vm-2.png)

        * Then, we create a virtual hard disk. I chose a dynamically allocated disk with a size of 25GB. *(This will be used incase we want to install the OS on the VM)*

            ![VM Processor Allocation](src/creating-vm-3.png)

        * Once we are done we will see the summary of the VM configuration.

            ![VM Summary](src/creating-vm-summary.png)

        * Finally, we start the VM and select the downloaded ISO file as the boot disk.

            ![mount the image](src/mount-image.png)

    * Once we restart, we can start using it, first we will see the boot screen (I am using Ubuntu so it's `grub`)

        ![Boot Screen](src/grub.png)

    * Finally, after booting into the VM, we can start using the operating system, either by installing it into the hard disk or running it live from the ISO. *(Installing it is recommended in case of long-term use)*

        ![Ubuntu Desktop](src/running-vm.png)

## System Information Tools

### Processor, RAM, and Network Information

#### `neofetch`

* **Installation:**

    ```bash
    sudo apt update
    sudo apt install neofetch
    ```

* **Command:**

    ```bash
    neofetch
    ```

* **Output:**

    ![neofetch output](src/neofetch.png)

#### Alternative Built-in Commands for Specific Information

* **Processor Information:**
  * Command: `lscpu`
  * Output:

    ![lscpu output](src/lscpu.png)

* **RAM Information:**
  * Command: `free -h`
  * Output:

    ![free -h output](src/free.png)

* **Network Information:**
  * Command: `ip addr show`
  * Output:

    ![ip addr show output](src/ip.png)

### Operating System Specifications

#### `hostnamectl`

* **Command:**

    ```bash
    hostnamectl
    ```

* **Output:**

    ![hostnamectl output](src/hostnamectl.png)

#### `uname`

* **Command:**

    ```bash
    uname -a
    ```

* **Output:**

    ![uname -a output](src/uname.png)

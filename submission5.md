# Virtualization Lab

## Task 1: VM Deployment

**Objective**: Install VirtualBox and deploy a new VM using Ubuntu.

1. **Install VirtualBox**:
   **VirtualBox Version:**
    ```
    7.1.10 r169112 (Qt6.5.3)
    ```

2. **Deploy a Virtual Machine**:

   **Operating System Selected:** Ubuntu 24.04

    **VM Configuration:**

    - Memory: 4096 MB
    - CPU Cores: 2
    - Storage: 25 GB

    **Deployment Steps:**

    1. Downloaded and installed VirtualBox.
    2. Created a new VM and named it `Ubuntu24.04`.
    3. Attached the Ubuntu ISO image.
    4. Allocated memory and CPU cores.
    5. Created a new virtual hard disk.
    6. Completed Ubuntu installation and booted into the desktop.

    **Screenshot of Running VM:![alt text](image.png)**

## Task 2: System Information Tools

**Objective**: Discover and use command-line tools to display system information of the VM.

1. **Processor, RAM, and Network Information**:

    **Tool Used:** `lshw`

    **Command:**
    ```bash
    sudo lshw -short -C processor
    ```

    **Output:**
    ```
    H/W path              Device          Class          Description
    ================================================================
    /0/2                                  processor      AMD Ryzen 5 3550H with Rade
    ```

    **Command:**
    ```bash
    sudo lshw -short -C memory
    ```

    **Output:**
    ```
    H/W path              Device          Class          Description
    ================================================================
    /0/0                                  memory         128KiB BIOS
    /0/1                                  memory         4GiB System Memory
    ```

    **Command:**
    ```bash
    sudo lshw -short -C network
    ```

    **Output:**
    ```
    H/W path              Device          Class          Description
    ================================================================
    /0/100/3              enp0s3          network        82540EM Gigabit Ethernet Controller
    ```

2. **Operating System Specifications**:

   **Tool Used:** `lsb_release` and `uname`

    **Command:**
    ```bash
    lsb_release -a
    ```

    **Output:**
    ```
    No LSB modules are available.
    Distributor ID:	Ubuntu
    Description:	Ubuntu 24.04.2 LTS
    Release:	    24.04
    Codename:	    noble
    ```

    **Command:**
    ```bash
    uname -a
    ```

    **Output:**
    ```
    Linux Ubuntu24 6.11.0-29-generic #29~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Jun 26 14:16:59 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
    ```
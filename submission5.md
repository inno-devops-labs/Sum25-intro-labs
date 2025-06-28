# Lab 5: Virtualization

## Task 1: VM Deployment

### Install VirtualBox

Installed version:

![](screenshots/virtualbox_about.png)

### Deploy a Virtual Machine

1. Download ISO Image of Ubuntu. I had Ubuntu 18 already downloaded.
2. Create a new virtual machine.

Select ISO file and set the name to `Ubuntu18.04.6`:

![](screenshots/virtualbox_create_general.png)

Keep suggested user configuration:

![](screenshots/virtualbox_create_install.png)

Set RAM to 4 GB and CPU to 4:

![](screenshots/virtualbox_create_hardware.png)

Keep suggested disk configuration:

![](screenshots/virtualbox_create_disk.png)

Finish:

![](screenshots/virtualbox_create_result.png)

## Task 2: System Information Tools

### Processor, RAM, and Network Information

For displaying CPU, RAM, and network information I decided to use `lshw` which was pre-installed:

![](screenshots/lshw_version.png)

Login as root for `lshw` to display complete information:

![](screenshots/login_as_root.png)

Display CPU info:

![](screenshots/lshw_cpu.png)

Display RAM info:

![](screenshots/lshw_memory.png)

Display network info:

![](screenshots/lshw_netrwork.png)

### Operating System Specifications

For OS specifications I decided to use `neofetch` which has very appealing output formatting.

Install `neofetch`:

![](screenshots/neofetch_install.png)

Display OS info:

![](screenshots/neofetch.png)

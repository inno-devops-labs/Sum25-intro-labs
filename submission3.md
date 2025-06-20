## Task 1: First GitHub Actions Pipeline

### Workflow Content:
```yaml
name: CI Pipeline

on: [push]  

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Run a simple command
      run: echo "Hello, GitHub Actions!"
```

## Task 2: System Info and Manual Trigger

### Changes to Workflow:
1. Added trigger `workflow_dispatch`
2. Added step with collecting system info

### Gathered System Info:
### System Information ###
OS: Linux fv-az788-215 6.11.0-1015-azure #15~24.04.1-Ubuntu SMP

Thu May  1 02:52:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux

CPU: Model name:                           AMD EPYC 7763 64-Core Processor

Memory:                total        used        free      shared  buff/cache   available

Mem:            15Gi       1.0Gi       9.9Gi        55Mi       5.2Gi        14Gi

Swap:          4.0Gi          0B       4.0Gi

Disk: Filesystem      Size  Used Avail Use% Mounted on

/dev/root        72G   48G   25G  66% /

tmpfs           7.9G   84K  7.9G   1% /dev/shm

tmpfs           3.2G  1.1M  3.2G   1% /run

tmpfs           5.0M     0  5.0M   0% /run/lock

/dev/sda16      881M   60M  760M   8% /boot

/dev/sda15      105M  6.2M   99M   6% /boot/efi

/dev/sdb1        74G  4.1G   66G   6% /mnt

tmpfs           1.6G   12K  1.6G   1% /run/user/1001
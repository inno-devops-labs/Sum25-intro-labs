# CI/CD Lab - GitHub Actions

In this lab, you will explore continuous integration and continuous deployment (CI/CD) practices using GitHub Actions. GitHub Actions provides a powerful workflow automation tool to streamline your development and deployment processes. You will perform various tasks related to setting up CI/CD pipelines and gathering system information using GitHub Actions. Follow the tasks below to complete the lab assignment.

## Task 1: Create Your First GitHub Actions Pipeline

**Objective**: Set up a basic GitHub Actions workflow and observe its execution.

### Key Concepts and What I Learned

- GitHub Actions is a CI/CD platform built into GitHub that allows automating workflows, such as testing, building, and deploying code.
- A workflow is defined in a YAML file stored under `.github/workflows/`.
- A workflow is made up of jobs, which run on runners provided by GitHub (for example, `ubuntu-latest`).
- Each job contains steps, which can run shell commands or use prebuilt actions.

### Workflow File

I created a file named `.github/workflows/.github/workflows/github-actions-demo.yml` with the following contents:

```yaml
name: GitHub Actions Demo
run-name: ${{ github.actor }} is testing out GitHub Actions 🚀
on: [push]
jobs:
  Explore-GitHub-Actions:
    runs-on: ubuntu-latest
    steps:
      - run: echo "🎉 The job was automatically triggered by a ${{ github.event_name }} event."
      - run: echo "🐧 This job is now running on a ${{ runner.os }} server hosted by GitHub!"
      - run: echo "🔎 The name of your branch is ${{ github.ref }} and your repository is ${{ github.repository }}."
      - name: Check out repository code
        uses: actions/checkout@v4
      - run: echo "💡 The ${{ github.repository }} repository has been cloned to the runner."
      - run: echo "🖥️ The workflow is now ready to test your code on the runner."
      - name: List files in the repository
        run: |
          ls ${{ github.workspace }}
      - run: echo "🍏 This job's status is ${{ job.status }}."
```

### Execution and Observations
After pushing the workflow file to my branch (lab3-solution), I visited the Actions tab on GitHub. The workflow was automatically triggered as expected.

### Output observed in the Actions UI:
- The job ran successfully on an `ubuntu-latest` runner.

- All echo statements printed expected values, such as:

    - The event type (`push`)

    - The operating system (`Linux`)

    - The branch name and repository

    - A list of files in the repository

### Conclusion
This task helped me understand the structure of GitHub Actions workflows, including how events trigger jobs and how to configure steps within those jobs. Now I know more about setting up automated CI pipelines using GitHub Actions.


## Task 2: Gathering System Information and Manual Triggering

**Objective**: Extend your workflow to include manual triggering and system information gathering.

### Configure a Manual Trigger:
To support manual triggering of the workflow, I added the following line to the `on` block:

```yaml
on:
  push:
  workflow_dispatch:
```

This allows me to run the workflow directly from the GitHub UI by clicking "Run workflow".

### Gather System Information:
I added a new step to the workflow to display system information about the GitHub-hosted runner:

```yaml
- name: Show system information 🧠
    run: |
        echo "=== UNAME ==="
        uname -a

        echo "=== CPU ==="
        lscpu

        echo "=== MEMORY ==="
        free -h

        echo "=== DISK ==="
        df -h
```

This step prints the OS name, CPU architecture, available memory, and disk space. It helps us understand the environment where the workflow is executed.

### Output Example:
Here’s a sample output captured from the Actions run about System:

```yaml
=== UNAME ===
Linux pkrvmxyh4eaekms 6.11.0-1015-azure #15~24.04.1-Ubuntu SMP Thu May  1 02:52:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
=== CPU ===
Architecture:                         x86_64
CPU op-mode(s):                       32-bit, 64-bit
Address sizes:                        48 bits physical, 48 bits virtual
Byte Order:                           Little Endian
CPU(s):                               4
On-line CPU(s) list:                  0-3
Vendor ID:                            AuthenticAMD
Model name:                           AMD EPYC 7763 64-Core Processor
CPU family:                           25
Model:                                1
Thread(s) per core:                   2
Core(s) per socket:                   2
Socket(s):                            1
Stepping:                             1
BogoMIPS:                             4890.86
Flags:                                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl tsc_reliable nonstop_tsc cpuid extd_apicid aperfmperf tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm cmp_legacy svm cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw topoext vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves user_shstk clzero xsaveerptr rdpru arat npt nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold v_vmsave_vmload umip vaes vpclmulqdq rdpid fsrm
Virtualization:                       AMD-V
Hypervisor vendor:                    Microsoft
Virtualization type:                  full
L1d cache:                            64 KiB (2 instances)
L1i cache:                            64 KiB (2 instances)
L2 cache:                             1 MiB (2 instances)
L3 cache:                             32 MiB (1 instance)
NUMA node(s):                         1
NUMA node0 CPU(s):                    0-3
Vulnerability Gather data sampling:   Not affected
Vulnerability Itlb multihit:          Not affected
Vulnerability L1tf:                   Not affected
Vulnerability Mds:                    Not affected
Vulnerability Meltdown:               Not affected
Vulnerability Mmio stale data:        Not affected
Vulnerability Reg file data sampling: Not affected
Vulnerability Retbleed:               Not affected
Vulnerability Spec rstack overflow:   Vulnerable: Safe RET, no microcode
Vulnerability Spec store bypass:      Vulnerable
Vulnerability Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitization
Vulnerability Spectre v2:             Mitigation; Retpolines; STIBP disabled; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected
Vulnerability Srbds:                  Not affected
Vulnerability Tsx async abort:        Not affected
=== MEMORY ===
               total        used        free      shared  buff/cache   available
Mem:            15Gi       851Mi        14Gi        37Mi       1.0Gi        14Gi
Swap:          4.0Gi          0B       4.0Gi
=== DISK ===
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        72G   47G   25G  66% /
tmpfs           7.9G   84K  7.9G   1% /dev/shm
tmpfs           3.2G  1.1M  3.2G   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/sda16      881M   60M  760M   8% /boot
/dev/sda15      105M  6.2M   99M   6% /boot/efi
/dev/sdb1        74G  4.1G   66G   6% /mnt
tmpfs           1.6G   12K  1.6G   1% /run/user/1001
```

### Conclusion
This task helped me learn how to manually trigger workflows and inspect the GitHub-hosted runner environment. Now I understand how to extend GitHub Actions pipelines with useful debug or system-related information.
# Lab 3
### Task 1: Create Your First GitHub Actions Pipeline

GitHub Actions is a CI/CD pipeline which can be used for many various processes: CI, deployment, automation, code scanning, etc., depending on the configuration.

To create my own GitHub Actions pipeline I performed the following steps:

1. Checked the settings of the repository and ensured that none of the features of GitHub Actions were disabled for it. I enabled the followed option:
> Allow all actions and reusable workflows.
2. I created the .github folder and the file github-actions-demo.yml through the VS Code Explorer interface, as neither the folder, nor the file appeared in my repository previously.
3. As instructed, I copy pasted 
```
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
into the newly-created file.
> At this stage you don't need to understand the details of this workflow.

Thank you, GitHub, very cool.
4. I commited the changes to the local lab3 branch and pushed the changes to origin.
5. After searching and failing to find my workflow in the GitHub Actions interface, I retraced my steps and found the issue - I forgot to put the workflows directory between .github and .yml file. I fixed that and once again pushed to origin.
6. The bugfix worked and I was able to visit the [GitHub Actions tab in my repository](https://github.com/Daru1914/Sum25-intro-labs/actions), where I found Explore-GitHub-Actions tab.
7. There I could observe the workflow execution for my last push:
  - Set up job: The job was set up successfully on a GitHub-hosted Ubuntu 24.04 runner using actions/checkout@v4, with all necessary permissions and environment components initialized.
  - The workflow confirmed it was automatically triggered by a push event.
  - The workflow confirmed that the job is executing on a GitHub-hosted Linux (Ubuntu) server.
  - The workflow is running on the lab3 branch of the Daru1914/Sum25-intro-labs repository.
  - Checkout the repository code: The workflow successfully checked out the lab3 branch of the Daru1914/Sum25-intro-labs repository using actions/checkout@v4, with a shallow fetch of the latest commit (63c83b35). It initialized a fresh Git environment, set up authentication, and ensured a clean working directory.
  - The repository Daru1914/Sum25-intro-labs was successfully cloned to the GitHub Actions runner.
  - The workflow setup is complete, and the environment is ready to run and test my code.
  - The repository contains five files: README.md, lab1.md, lab2.md, lab3.md, and submission3.md.
  - The workflow completed successfully with no errors.
  - The workflow performed standard post-job cleanup: it confirmed the Git version, marked the repo as a safe directory, and removed temporary authentication headers and SSH settings.
  - The runner cleaned up any leftover (orphaned) processes to ensure a clean and isolated environment for future jobs.

### Task 2: Gathering System Information and Manual Triggering
To complete this task, I extended my existing GitHub Actions workflow in two ways:
1. I added a manual trigger.
2. I appended steps to gather system information from the runner.

#### Part 1: Manual Trigger Configuration:
- I modified the beginning of my existing `github-actions-demo.yml` file to include the `workflow_dispatch` trigger in addition to `push`. This enables me to trigger the workflow manually via the GitHub Actions UI.
```
on: 
  push:
  workflow_dispatch:
```
I did not define any inputs since they were not required for this task.
- After pushing the change to the lab3 branch, I wasn't able to manually run the workflow as the button did not appear in the GitHub interface.
- Rewriting the yaml file to
```
on: [push, workflow_dispatch]
```
also did not fix the issue.
- Then I tried merging `lab3` with workflow features into `master`, as I found this advice on a similar Stackoverflow question.
- After merging my `lab3` branch, and removing the unnecessary `submission3.md` from `main`, I was able to manually run the workflow on `lab3` by navigating to the Actions tab -> selecting the workflow -> clicking "Run workflow".

#### Part 2: Gathering System Information:
To gather runner system information, I added a new step in the `steps:` section of the workflow:
```
- name: Gather system information
  run: |
    echo "System Information:"
    uname -a
    lscpu
    free -h
    df -h /
```
These commands collect:
- `uname -a`: Kernel version and OS architecture
- `lscpu`: Detailed CPU info (model, cores, threads)
- `free -h`: RAM size and usage
- `df -h /`: Disk usage on the root filesystem

The included commands worked imemdiately, as in the workflow triggered by the commit that included those changes I was able to receive the following information:
```
Run echo "System Information:"
  echo "System Information:"
  uname -a
  lscpu
  free -h
  df -h /
  shell: /usr/bin/bash -e {0}
System Information:
Linux pkrvmxyh4eaekms 6.11.0-1015-azure #15~24.04.1-Ubuntu SMP Thu May  1 02:52:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
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
BogoMIPS:                             4890.85
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
               total        used        free      shared  buff/cache   available
Mem:            15Gi       807Mi        14Gi        39Mi       1.0Gi        14Gi
Swap:          4.0Gi          0B       4.0Gi
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        72G   47G   25G  66% /
```
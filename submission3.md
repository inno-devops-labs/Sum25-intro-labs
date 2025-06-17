# Solution to Lab 3

by Dmitry Beresnev <d.beresnev@innopolis.university>

## Task 1

**Key Concepts Observed:**

- **Workflows** are the automated processes defined in YAML files inside `.github/workflows` directory, triggered by specific events
- **Events** are activities that trigger a workflow, such as a `push` and `pull_request`
- **Jobs** are a set of steps that execute on the same runner. Several jobs can run sequentially or in parallel. Job consists of individual tasks - **steps**
- **Workflow File Location:** Workflow files must be stored in the `.github/workflows` directory in your repository.

**Followed steps:**

1. Created `github/workflows/github-actions-demo.yml` file
2. Put the content of template described [in this link](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/triggering-a-workflow#defining-inputs-for-manually-triggered-workflows) in the created file
3. Pushed the changes

**Observations:**

- After pushing to `lab3` branch, the workflow triggered automatically
- The workflows are listed in the actions tab
- From the logs it is seen that all the github variables are correctly substituted (like `github.event_name` and `github.actor`)

- Upon pushing a commit to the `main` branch, the workflow triggered automatically as expected.
- In the "Actions" tab of the repository, I could see the workflow run listed.
- Clicking on the workflow run showed the job(s) defined.
- Expanding the job showed the individual steps and their logs.

**Output of workflow:**

```bash
Current runner version: '2.325.0'
Runner Image Provisioner
Operating System
Runner Image
GITHUB_TOKEN Permissions
Secret source: Actions
Prepare workflow directory
Prepare all required actions
Getting action download info
Download immutable action package 'actions/checkout@v4'
Complete job name: Explore-GitHub-Actions
Run echo "🎉 The job was automatically triggered by a push event."
🎉 The job was automatically triggered by a push event.
Run echo "🐧 This job is now running on a Linux server hosted by GitHub!"
🐧 This job is now running on a Linux server hosted by GitHub!
Run echo "🔎 The name of your branch is refs/heads/lab3 and your repository is dsomni/Sum25-intro-labs."
🔎 The name of your branch is refs/heads/lab3 and your repository is dsomni/Sum25-intro-labs.
Run actions/checkout@v4
Syncing repository: dsomni/Sum25-intro-labs
Getting Git version info
Temporarily overriding HOME='/home/runner/work/_temp/d7edffa2-4599-4949-a124-8f4c717fbd2b' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
Deleting the contents of '/home/runner/work/Sum25-intro-labs/Sum25-intro-labs'
Initializing the repository
Disabling automatic garbage collection
Setting up auth
Fetching the repository
Determining the checkout info
/usr/bin/git sparse-checkout disable
/usr/bin/git config --local --unset-all extensions.worktreeConfig
Checking out the ref
/usr/bin/git log -1 --format=%H
459f95c5b98deb0e6f2d3cb59339a9ac3ad70e50
0s
Run echo "💡 The dsomni/Sum25-intro-labs repository has been cloned to the runner."
💡 The dsomni/Sum25-intro-labs repository has been cloned to the runner.
Run echo "🖥️ The workflow is now ready to test your code on the runner."
🖥️ The workflow is now ready to test your code on the runner.
Run ls /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
README.md
lab1.md
lab2.md
lab3.md
submission3.md
Run echo '🍏 This job's status is success.'
🍏 This job's status is success.
Post job cleanup.
/usr/bin/git version
git version 2.49.0
Temporarily overriding HOME='/home/runner/work/_temp/5590be19-2108-4a3e-b6be-59d5075360bf' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
http.https://github.com/.extraheader
/usr/bin/git config --local --unset-all http.https://github.com/.extraheader
/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
Cleaning up orphan processes
```

## Task 2

### 1. Configure a Manual Trigger

I enabled manual triggering of the workflow by adding the `workflow_dispatch` event to the `on:` section.

**Changes of `github-actions-demo.yml`:**

```diff
- on: [push]
+ on:
+  push:
+  workflow_dispatch:
```

However, the "Run workflow" button did not appear. To fix it, I added this workflow in the `master` branch and then merge it to the `lab3` branch (according to [this answer](https://github.com/orgs/community/discussions/58022#discussioncomment-8716372)).

### 2. Gather System Information

To gather system information I have added the new job to `github-actions-demo.yml` file:

```yaml
jobs:
  Explore-GitHub-Actions: ...

  Gather-Runner-Information:
    runs-on: ubuntu-latest
    steps:
      - name: Runner OS information
        run: uname -a
      - name: Hardware specification
        run: |
          echo "CPU info:"
          lscpu
          echo ""
          echo "Memory info:"
          free -m
          echo ""
          echo "Disk info:"
          df -h
      - name: Other runner details
        run: |
          echo "Runner Name: $RUNNER_NAME"
          echo "Runner OS: $RUNNER_OS"
          echo "Runner Arch: $RUNNER_ARCH"
          echo "Workflow: $GITHUB_WORKFLOW"
          echo "Actor: $GITHUB_ACTOR"
      - run: echo "🍏 This job's status is ${{ job.status }}."
```

After the push, the workflow job `Gather-Runner-Information` outputs the following:

```bash
Current runner version: '2.325.0'
Runner Image Provisioner
Operating System
Runner Image
GITHUB_TOKEN Permissions
Secret source: Actions
Prepare workflow directory
Prepare all required actions
Complete job name: Gather-Runner-Information
Run uname -a
Linux pkrvmxyh4eaekms 6.11.0-1015-azure \#15~24.04.1-Ubuntu SMP Thu May  1 02:52:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
Run echo "CPU info:"
CPU info:
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

Memory info:
               total        used        free      shared  buff/cache   available
Mem:           15995         736       14549          35        1033       15259
Swap:           4095           0        4095

Disk info:
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        72G   47G   25G  66% /
tmpfs           7.9G   84K  7.9G   1% /dev/shm
tmpfs           3.2G  1.1M  3.2G   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/sdb16      881M   60M  760M   8% /boot
/dev/sdb15      105M  6.2M   99M   6% /boot/efi
/dev/sda1        74G  4.1G   66G   6% /mnt
tmpfs           1.6G   12K  1.6G   1% /run/user/1001
Run echo "Runner Name: $RUNNER_NAME"
Runner Name: GitHub Actions 1000000262
Runner OS: Linux
Runner Arch: X64
Workflow: GitHub Actions Demo
Actor: dsomni
Run echo '🍏 This job's status is success.'
🍏 This job's status is success.
Cleaning up orphan processes
```

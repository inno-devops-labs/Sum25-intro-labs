# CI/CD Lab Submission: GitHub Actions

## Task 1: Create Your First GitHub Actions Pipeline

### Following the Quickstart Guide

I began by following the official GitHub Actions quickstart guide. The process was straightforward and provided a solid introduction to the core concepts of GitHub Actions.

**Steps Followed:**

1.  I created the `.github/workflows/` directory structure in the root of my repository. This is the required location for GitHub to discover workflow files.
2.  Inside this directory, I created a new YAML file named `test.yml`.
3.  I populated the file with the basic workflow configuration provided in the guide. This included defining a name, an `on` trigger for `push` events, and a single `job` with several `steps`.
4.  I committed the new workflow file and pushed it to the `lab3` branch of my repository, and then, merge to master branch.

**Key Concepts Learned:**

*   **Workflow:** the top-level automated process defined in a YAML file.
*   **Event:** a trigger that starts a workflow, such as a `push` to a branch or a `pull_request`.
*   **Job:** a set of steps that execute on the same runner. Jobs run in parallel by default.
*   **Step:** an individual task within a job. It can be a shell command (`run`) or a pre-built, reusable command (`uses`).
*   **Action:** a reusable unit of code that can be included in a workflow. `actions/checkout@v4` is a common example that checks out the repository's code.
*   **Runner:** a server (virtual machine) hosted by GitHub that runs the workflow jobs. You can choose between different operating systems like Linux, Windows, or macOS.

### Workflow Execution Observations

Upon pushing the commit, the workflow was triggered automatically. The following are my key observations from the execution log:

*   `Current runner version: '2.325.0'`: shows the specific version of the runner software that is executing the job.
*   `Operating System: Ubuntu 24.04.2 LTS`: confirms that my job is running on a Linux machine, specifically the latest Long-Term Support version of Ubuntu.
*   `Runner Image: image: ubuntu-24.04`: details the virtual environment image being used, with a link to the software included on it. This is very useful for debugging.
*   `GITHUB_TOKEN Permissions`: this section is critical. It lists all the permissions that the temporary `GITHUB_TOKEN` has for this job. For example, `Contents: write` means the job can push code back to the repository.
*   `Download immutable action package 'actions/checkout@v4'`: before my code runs, the workflow prepares its environment by downloading any required actions, like `checkout`.
*   `Run echo "🎉 The job was automatically triggered by a push event."`: this is the direct output from the first `run` command in my workflow file. It executes successfully.
*   `Run echo "🐧 This job is now running on a Linux server hosted by GitHub!"`: the output of the second `run` command, confirming the script's execution.

No errors were encountered during this initial run. The process was smooth and provided clear, step-by-step logging.

## Task 2: Gathering System Information and Manual Triggering

### Configuring a Manual Trigger

To enable manual execution of the workflow, I added the `workflow_dispatch` event trigger. This allows the workflow to be started directly from the "Actions" tab in the GitHub UI without needing a code push.

**Changes to `test.yml`:**

I modified the `on:` block in my workflow file as follows:

```diff
- on: [push]
+ on: [push, workflow_dispatch]
```

This simple addition enabled the "Run workflow" button in the repository's Actions tab. No inputs were required, as per the lab instructions.

### Gathering System Information

I then added a new step to the existing job to collect and display information about the runner's system.

**Changes to `test.yml`:**

I added the following step to my job's configuration:

```yaml
      - name: Gather system information
        run: |
          echo "--- KERNEL INFO ---"
          uname -a
          echo -e "\n--- CPU INFO ---"
          lscpu
          echo -e "\n--- MEMORY INFO ---"
          free -h
```

I manually launched the final version of the workflow, using the interface of Github Actions and it gathered the system information of the deploy server.

**Gathered System Information:**

This step produced the following details about the GitHub-hosted runner environment:

```
--- KERNEL INFO ---
Linux fv-az1914-629 6.11.0-1015-azure #15~24.04.1-Ubuntu SMP Thu May  1 02:52:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux

--- CPU INFO ---
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

--- MEMORY INFO ---
               total        used        free      shared  buff/cache   available
Mem:            15Gi       993Mi       9.9Gi        55Mi       5.2Gi        14Gi
Swap:          4.0Gi          0B       4.0Gi
```
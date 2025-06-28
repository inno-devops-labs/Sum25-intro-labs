# CI/CD Lab - GitHub Actions

## Task 1: My Pipeline

### Key Concepts

* **Workflows:** Scripts that run automatically. You put them in `.github/workflows`.
* **Events:** What triggers a workflow, like a `push` or a manual click.
* **Jobs:** A set of steps that run on a server.
* **Runners:** The servers that run your jobs (like Ubuntu, Windows, etc.).
* **Steps:** The actual commands or actions inside a job.



1. Made the `.github/workflows` folders.
2. Created the `main.yml` file inside.
3. Wrote the basic workflow to run on a push to `main`.
4. Pushed the file to my repo. It didn't run at first because I was on a different branch, which makes sense.

No errors.



## Task 2: System Info and Manual Triggers

### Workflow Changes

I updated the `main.yml` file to do two new things:

1. Added `workflow_dispatch:` so I could start it manually with a button on the Actions page.
2. Added a new step to print out the runner's system details using commands like `uname` and `lscpu`.

### Gathered System Information

Here is the info I got from the runner when I ran the workflow manually.



```
--- Operating System ---
Linux pkrvmxyh4eaekms 6.11.0-1015-azure #15~24.04.1-Ubuntu SMP Thu May  1 02:52:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux

--- CPU Information ---
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

--- Memory Information ---
               total        used        free      shared  buff/cache   available
Mem:            15Gi       759Mi        14Gi        39Mi       1.0Gi        14Gi
Swap:          4.0Gi          0B       4.0Gi
```

--- 

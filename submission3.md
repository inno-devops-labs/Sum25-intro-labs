# Lab 3

## Task 1: Create Your First GitHub Actions Pipeline

### GitHub Actions Quickstart Summary

- created work flow
  - added .github/workflows/demo.yml
  - used template with push trigger and basic steps
- triggered workflow
  - pushed changes → auto-run on GH
- viewed results
  - checked actions tab -> saw logs andf outputs

key concepts:
- workflows: .yaml files in .github/workflows/
- triggers: Events like push, pull_request
- runners: GitHub-hosted (e.g., ubuntu-latest)
- steps: commands or premade actions

### main.yml

```
name: First CI Workflow

on:
  push:
    branches: [master]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v3

      - name: Say Hello
        run: echo "Hello, GitHub Actions!"

```

### Output of main.yml

```
1s
Current runner version: '2.325.0'
Operating System
Runner Image
Runner Image Provisioner
GITHUB_TOKEN Permissions
Secret source: Actions
Prepare workflow directory
Prepare all required actions
Getting action download info
Download immutable action package 'actions/checkout@v3'
Complete job name: build
0s
Run actions/checkout@v3
Syncing repository: beleet/Sum25-intro-labs
Getting Git version info
Temporarily overriding HOME='/home/runner/work/_temp/7d9c98d4-aacc-4201-9f83-a7ad31f58e8e' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
Deleting the contents of '/home/runner/work/Sum25-intro-labs/Sum25-intro-labs'
Initializing the repository
Disabling automatic garbage collection
Setting up auth
Fetching the repository
Determining the checkout info
Checking out the ref
/usr/bin/git log -1 --format='%H'
'34b2c3adc351a64ffa1eed99ef48dfced427ce0b'
0s
Run echo "Hello, GitHub Actions!"
Hello, GitHub Actions!
0s
Post job cleanup.
/usr/bin/git version
git version 2.49.0
Temporarily overriding HOME='/home/runner/work/_temp/6cbcb79e-4afe-4531-8585-39e3af7e6fe5' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
http.https://github.com/.extraheader
/usr/bin/git config --local --unset-all http.https://github.com/.extraheader
/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
0s
Cleaning up orphan processes
```


## Task 2: Gathering System Information and Manual Triggering



```
name: Enhanced CI Workflow

on:
  push:
    branches: [master]
  workflow_dispatch:  # This enables manual triggering

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v3

      - name: Say Hello
        run: echo "Hello, GitHub Actions!"

      - name: Gather system information
        run: |
          echo "### System Information ###"
          echo "Runner OS: $(uname -a)"
          echo "CPU Info:"
          lscpu
          echo "Memory Info:"
          free -h
          echo "Disk Usage:"
          df -h
          echo "Environment Variables:"
          printenv
```

Here you can find the output of system information output

```

0s
Run echo "### System Information ###"
  echo "### System Information ###"
  echo "Runner OS: $(uname -a)"
  echo "CPU Info:"
  lscpu
  echo "Memory Info:"
  free -h
  echo "Disk Usage:"
  df -h
  echo "Environment Variables:"
  printenv
  shell: /usr/bin/bash -e {0}
### System Information ###
Runner OS: Linux pkrvmpptgkbjq6m 6.11.0-1018-azure #18~24.04.1-Ubuntu SMP Sat Jun 28 04:46:03 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
CPU Info:
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
Memory Info:
               total        used        free      shared  buff/cache   available
Mem:            15Gi       777Mi        14Gi        39Mi       1.0Gi        14Gi
Swap:          4.0Gi          0B       4.0Gi
Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        72G   45G   28G  62% /
tmpfs           7.9G   84K  7.9G   1% /dev/shm
tmpfs           3.2G  1.1M  3.2G   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/sda16      881M   60M  760M   8% /boot
/dev/sda15      105M  6.2M   99M   6% /boot/efi
/dev/sdb1        74G  4.1G   66G   6% /mnt
tmpfs           1.6G   12K  1.6G   1% /run/user/1001
Environment Variables:
SHELL=/bin/bash
SELENIUM_JAR_PATH=/usr/share/java/selenium-server.jar
CONDA=/usr/share/miniconda
GITHUB_WORKSPACE=/home/runner/work/Sum25-intro-labs/Sum25-intro-labs
JAVA_HOME_11_X64=/usr/lib/jvm/temurin-11-jdk-amd64
GITHUB_PATH=/home/runner/work/_temp/_runner_file_commands/add_path_f06d93f5-2a3c-4653-acc9-c88f7f6b6ead
GITHUB_ACTION=__run_2
JAVA_HOME=/usr/lib/jvm/temurin-17-jdk-amd64
GITHUB_RUN_NUMBER=1
RUNNER_NAME=GitHub Actions 1000000004
GRADLE_HOME=/usr/share/gradle-8.14.3
GITHUB_REPOSITORY_OWNER_ID=105719971
ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE=/opt/actionarchivecache
XDG_CONFIG_HOME=/home/runner/.config
MEMORY_PRESSURE_WRITE=c29tZSAyMDAwMDAgMjAwMDAwMAA=
DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
ANT_HOME=/usr/share/ant
JAVA_HOME_8_X64=/usr/lib/jvm/temurin-8-jdk-amd64
GITHUB_TRIGGERING_ACTOR=beleet
GITHUB_REF_TYPE=branch
HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS=3650
ANDROID_NDK=/usr/local/lib/android/sdk/ndk/27.3.13750724
BOOTSTRAP_HASKELL_NONINTERACTIVE=1
***
PIPX_BIN_DIR=/opt/pipx_bin
LOGNAME=runner
GITHUB_REPOSITORY_ID=996999866
GITHUB_ACTIONS=true
ANDROID_NDK_LATEST_HOME=/usr/local/lib/android/sdk/ndk/28.2.13676358
SYSTEMD_EXEC_PID=1890
GITHUB_SHA=e3657d6a44a74de4caebc6149304aa32ef1c715d
GITHUB_WORKFLOW_REF=beleet/Sum25-intro-labs/.github/workflows/manual.yml@refs/heads/master
POWERSHELL_DISTRIBUTION_CHANNEL=GitHub-Actions-ubuntu24
RUNNER_ENVIRONMENT=github-hosted
DOTNET_MULTILEVEL_LOOKUP=0
GITHUB_REF=refs/heads/master
RUNNER_OS=Linux
GITHUB_REF_PROTECTED=false
HOME=/home/runner
GITHUB_API_URL=https://api.github.com
LANG=C.UTF-8
RUNNER_TRACKING_ID=github_2e618a6b-b527-4540-becb-f81ce81ebd2e
RUNNER_ARCH=X64
MEMORY_PRESSURE_WATCH=/sys/fs/cgroup/system.slice/hosted-compute-agent.service/memory.pressure
RUNNER_TEMP=/home/runner/work/_temp
GITHUB_STATE=/home/runner/work/_temp/_runner_file_commands/save_state_f06d93f5-2a3c-4653-acc9-c88f7f6b6ead
EDGEWEBDRIVER=/usr/local/share/edge_driver
JAVA_HOME_21_X64=/usr/lib/jvm/temurin-21-jdk-amd64
GITHUB_ENV=/home/runner/work/_temp/_runner_file_commands/set_env_f06d93f5-2a3c-4653-acc9-c88f7f6b6ead
GITHUB_EVENT_PATH=/home/runner/work/_temp/_github_workflow/event.json
INVOCATION_ID=08e23e56da6f4a8b90e233c3446dd05e
GITHUB_EVENT_NAME=push
GITHUB_RUN_ID=16579029340
JAVA_HOME_17_X64=/usr/lib/jvm/temurin-17-jdk-amd64
ANDROID_NDK_HOME=/usr/local/lib/android/sdk/ndk/27.3.13750724
GITHUB_STEP_SUMMARY=/home/runner/work/_temp/_runner_file_commands/step_summary_f06d93f5-2a3c-4653-acc9-c88f7f6b6ead
HOMEBREW_NO_AUTO_UPDATE=1
GITHUB_ACTOR=beleet
NVM_DIR=/home/runner/.nvm
SGX_AESM_ADDR=1
GITHUB_RUN_ATTEMPT=1
ANDROID_HOME=/usr/local/lib/android/sdk
GITHUB_GRAPHQL_URL=https://api.github.com/graphql
ACCEPT_EULA=Y
USER=runner
GITHUB_SERVER_URL=https://github.com
PIPX_HOME=/opt/pipx
GECKOWEBDRIVER=/usr/local/share/gecko_driver
CHROMEWEBDRIVER=/usr/local/share/chromedriver-linux64
SHLVL=1
ANDROID_SDK_ROOT=/usr/local/lib/android/sdk
VCPKG_INSTALLATION_ROOT=/usr/local/share/vcpkg
GITHUB_ACTOR_ID=105719971
RUNNER_TOOL_CACHE=/opt/hostedtoolcache
ImageVersion=20250720.1.0
DOTNET_NOLOGO=1
GOROOT_1_23_X64=/opt/hostedtoolcache/go/1.23.11/x64
GITHUB_WORKFLOW_SHA=e3657d6a44a74de4caebc6149304aa32ef1c715d
GOROOT_1_24_X64=/opt/hostedtoolcache/go/1.24.5/x64
GITHUB_REF_NAME=master
GITHUB_JOB=build
XDG_RUNTIME_DIR=/run/user/1001
AZURE_EXTENSION_DIR=/opt/az/azcliextensions
GITHUB_REPOSITORY=beleet/Sum25-intro-labs
GOROOT_1_22_X64=/opt/hostedtoolcache/go/1.22.12/x64
CHROME_BIN=/usr/bin/google-chrome
ANDROID_NDK_ROOT=/usr/local/lib/android/sdk/ndk/27.3.13750724
GITHUB_RETENTION_DAYS=90
JOURNAL_STREAM=9:10721
RUNNER_WORKSPACE=/home/runner/work/Sum25-intro-labs
GITHUB_ACTION_REPOSITORY=
PATH=/snap/bin:/home/runner/.local/bin:/opt/pipx_bin:/home/runner/.cargo/bin:/home/runner/.config/composer/vendor/bin:/usr/local/.ghcup/bin:/home/runner/.dotnet/tools:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
GITHUB_BASE_REF=
GHCUP_INSTALL_BASE_PREFIX=/usr/local
CI=true
SWIFT_PATH=/usr/share/swift/usr/bin
ImageOS=ubuntu24
GITHUB_REPOSITORY_OWNER=beleet
GITHUB_HEAD_REF=
GITHUB_ACTION_REF=
ENABLE_RUNNER_TRACING=true
GITHUB_WORKFLOW=Enhanced CI Workflow
DEBIAN_FRONTEND=noninteractive
GITHUB_OUTPUT=/home/runner/work/_temp/_runner_file_commands/set_output_f06d93f5-2a3c-4653-acc9-c88f7f6b6ead
AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache
_=/usr/bin/printenv
```

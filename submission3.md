# Лабораторная работа: CI/CD – GitHub Actions

## Задание 1: Создание первого конвейера GitHub Actions

### Изучение официального руководства

Для выполнения задания я изучил официальное руководство GitHub Actions Quickstart. Из него я узнал:

- Файлы workflow'ов должны располагаться в каталоге `.github/workflows`.
- Расширение файлов должно быть `.yml` или `.yaml`.
- Workflow запускается автоматически при определённых событиях, например `push`.
- Внутри `jobs` описываются задачи, которые включают шаги (`steps`), выполняемые на GitHub Runner'е.

### Выполненные шаги

1. В репозитории создал файл `.github/workflows/github-actions-demo.yml`.
2. Добавил в файл следующий код:

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
      - run: echo "🍏 This job's status is ${{ job.status }}.
```



## Наблюдение за выполнением рабочего процесса

### Что я сделал

1. Внёс небольшое изменение в `README.md` (добавил тестовую строку).
2. Сделал commit и push в основную ветку:
   ```bash
   git add README.md
   git commit -m "Изменение для теста workflow2"
   git push
   ```

## Перешёл на вкладку Actions в GitHub и увидел, что workflow был автоматически запущен.

- Workflow сработал мгновенно после push-события.
- Все шаги были выполнены успешно.
- Все шаги отработали без сбоев.
- Среда ubuntu-latest автоматически была предоставлена GitHub Runner'ом.
- actions/checkout@v4 корректно клонировал репозиторий.

```
2025-06-20T16:26:59.2459147Z Current runner version: '2.325.0'
2025-06-20T16:26:59.2495438Z ##[group]Operating System
2025-06-20T16:26:59.2496681Z Ubuntu
2025-06-20T16:26:59.2497408Z 24.04.2
2025-06-20T16:26:59.2498256Z LTS
2025-06-20T16:26:59.2498973Z ##[endgroup]
2025-06-20T16:26:59.2499810Z ##[group]Runner Image
2025-06-20T16:26:59.2500917Z Image: ubuntu-24.04
2025-06-20T16:26:59.2501703Z Version: 20250615.1.0
2025-06-20T16:26:59.2503428Z Included Software: https://github.com/actions/runner-images/blob/ubuntu24/20250615.1/images/ubuntu/Ubuntu2404-Readme.md
2025-06-20T16:26:59.2506131Z Image Release: https://github.com/actions/runner-images/releases/tag/ubuntu24%2F20250615.1
2025-06-20T16:26:59.2507653Z ##[endgroup]
2025-06-20T16:26:59.2508427Z ##[group]Runner Image Provisioner
2025-06-20T16:26:59.2509645Z 2.0.437.1
2025-06-20T16:26:59.2510355Z ##[endgroup]
2025-06-20T16:26:59.2514940Z ##[group]GITHUB_TOKEN Permissions
2025-06-20T16:26:59.2517804Z Actions: write
2025-06-20T16:26:59.2519160Z Attestations: write
2025-06-20T16:26:59.2520112Z Checks: write
2025-06-20T16:26:59.2520957Z Contents: write
2025-06-20T16:26:59.2521757Z Deployments: write
2025-06-20T16:26:59.2522609Z Discussions: write
2025-06-20T16:26:59.2523356Z Issues: write
2025-06-20T16:26:59.2524538Z Metadata: read
2025-06-20T16:26:59.2525320Z Models: read
2025-06-20T16:26:59.2526236Z Packages: write
2025-06-20T16:26:59.2527017Z Pages: write
2025-06-20T16:26:59.2527795Z PullRequests: write
2025-06-20T16:26:59.2528845Z RepositoryProjects: write
2025-06-20T16:26:59.2529750Z SecurityEvents: write
2025-06-20T16:26:59.2530592Z Statuses: write
2025-06-20T16:26:59.2531304Z ##[endgroup]
2025-06-20T16:26:59.2534820Z Secret source: Actions
2025-06-20T16:26:59.2536031Z Prepare workflow directory
2025-06-20T16:26:59.3015374Z Prepare all required actions
2025-06-20T16:26:59.3074011Z Getting action download info
2025-06-20T16:26:59.5457146Z ##[group]Download immutable action package 'actions/checkout@v4'
2025-06-20T16:26:59.5458165Z Version: 4.2.2
2025-06-20T16:26:59.5459130Z Digest: sha256:ccb2698953eaebd21c7bf6268a94f9c26518a7e38e27e0b83c1fe1ad049819b1
2025-06-20T16:26:59.5460445Z Source commit SHA: 11bd71901bbe5b1630ceea73d27597364c9af683
2025-06-20T16:26:59.5461174Z ##[endgroup]
2025-06-20T16:26:59.7300406Z Complete job name: Explore-GitHub-Actions
2025-06-20T16:26:59.8012277Z ##[group]Run echo "🎉 The job was automatically triggered by a push event."
2025-06-20T16:26:59.8013230Z [36;1mecho "🎉 The job was automatically triggered by a push event."[0m
2025-06-20T16:26:59.8120484Z shell: /usr/bin/bash -e {0}
2025-06-20T16:26:59.8121290Z ##[endgroup]
2025-06-20T16:26:59.8284364Z 🎉 The job was automatically triggered by a push event.
2025-06-20T16:26:59.8368583Z ##[group]Run echo "🐧 This job is now running on a Linux server hosted by GitHub!"
2025-06-20T16:26:59.8369526Z [36;1mecho "🐧 This job is now running on a Linux server hosted by GitHub!"[0m
2025-06-20T16:26:59.8428543Z shell: /usr/bin/bash -e {0}
2025-06-20T16:26:59.8428998Z ##[endgroup]
2025-06-20T16:26:59.8509733Z 🐧 This job is now running on a Linux server hosted by GitHub!
2025-06-20T16:26:59.8545475Z ##[group]Run echo "🔎 The name of your branch is refs/heads/master and your repository is Valeriitsoy/Sum25-intro-labs."
2025-06-20T16:26:59.8546797Z [36;1mecho "🔎 The name of your branch is refs/heads/master and your repository is Valeriitsoy/Sum25-intro-labs."[0m
2025-06-20T16:26:59.8603871Z shell: /usr/bin/bash -e {0}
2025-06-20T16:26:59.8604336Z ##[endgroup]
2025-06-20T16:26:59.8685053Z 🔎 The name of your branch is refs/heads/master and your repository is Valeriitsoy/Sum25-intro-labs.
2025-06-20T16:26:59.8796141Z ##[group]Run actions/checkout@v4
2025-06-20T16:26:59.8796662Z with:
2025-06-20T16:26:59.8797068Z   repository: Valeriitsoy/Sum25-intro-labs
2025-06-20T16:26:59.8797758Z   token: ***
2025-06-20T16:26:59.8798131Z   ssh-strict: true
2025-06-20T16:26:59.8798518Z   ssh-user: git
2025-06-20T16:26:59.8798911Z   persist-credentials: true
2025-06-20T16:26:59.8799348Z   clean: true
2025-06-20T16:26:59.8799736Z   sparse-checkout-cone-mode: true
2025-06-20T16:26:59.8800448Z   fetch-depth: 1
2025-06-20T16:26:59.8800819Z   fetch-tags: false
2025-06-20T16:26:59.8801214Z   show-progress: true
2025-06-20T16:26:59.8801595Z   lfs: false
2025-06-20T16:26:59.8801950Z   submodules: false
2025-06-20T16:26:59.8802334Z   set-safe-directory: true
2025-06-20T16:26:59.8802752Z ##[endgroup]
2025-06-20T16:27:00.1227298Z Syncing repository: Valeriitsoy/Sum25-intro-labs
2025-06-20T16:27:00.1229097Z ##[group]Getting Git version info
2025-06-20T16:27:00.1229998Z Working directory is '/home/runner/work/Sum25-intro-labs/Sum25-intro-labs'
2025-06-20T16:27:00.1231802Z [command]/usr/bin/git version
2025-06-20T16:27:00.1278465Z git version 2.49.0
2025-06-20T16:27:00.1310724Z ##[endgroup]
2025-06-20T16:27:00.1327545Z Temporarily overriding HOME='/home/runner/work/_temp/66e47c90-26be-4a08-9266-624df78ef484' before making global git config changes
2025-06-20T16:27:00.1329873Z Adding repository directory to the temporary git global config as a safe directory
2025-06-20T16:27:00.1342666Z [command]/usr/bin/git config --global --add safe.directory /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
2025-06-20T16:27:00.1381416Z Deleting the contents of '/home/runner/work/Sum25-intro-labs/Sum25-intro-labs'
2025-06-20T16:27:00.1385306Z ##[group]Initializing the repository
2025-06-20T16:27:00.1390336Z [command]/usr/bin/git init /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
2025-06-20T16:27:00.1454886Z hint: Using 'master' as the name for the initial branch. This default branch name
2025-06-20T16:27:00.1456277Z hint: is subject to change. To configure the initial branch name to use in all
2025-06-20T16:27:00.1457138Z hint: of your new repositories, which will suppress this warning, call:
2025-06-20T16:27:00.1457894Z hint:
2025-06-20T16:27:00.1458716Z hint: 	git config --global init.defaultBranch <name>
2025-06-20T16:27:00.1459428Z hint:
2025-06-20T16:27:00.1460004Z hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
2025-06-20T16:27:00.1461568Z hint: 'development'. The just-created branch can be renamed via this command:
2025-06-20T16:27:00.1462865Z hint:
2025-06-20T16:27:00.1463510Z hint: 	git branch -m <name>
2025-06-20T16:27:00.1465128Z Initialized empty Git repository in /home/runner/work/Sum25-intro-labs/Sum25-intro-labs/.git/
2025-06-20T16:27:00.1472935Z [command]/usr/bin/git remote add origin https://github.com/Valeriitsoy/Sum25-intro-labs
2025-06-20T16:27:00.1507889Z ##[endgroup]
2025-06-20T16:27:00.1509021Z ##[group]Disabling automatic garbage collection
2025-06-20T16:27:00.1513034Z [command]/usr/bin/git config --local gc.auto 0
2025-06-20T16:27:00.1541564Z ##[endgroup]
2025-06-20T16:27:00.1542729Z ##[group]Setting up auth
2025-06-20T16:27:00.1549583Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2025-06-20T16:27:00.1580523Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
2025-06-20T16:27:00.1888297Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2025-06-20T16:27:00.1920116Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
2025-06-20T16:27:00.2152010Z [command]/usr/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ***
2025-06-20T16:27:00.2189359Z ##[endgroup]
2025-06-20T16:27:00.2190495Z ##[group]Fetching the repository
2025-06-20T16:27:00.2198104Z [command]/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --no-recurse-submodules --depth=1 origin +b6133c19c0eefe1eb0901712e6babb1578079f15:refs/remotes/origin/master
2025-06-20T16:27:01.5332019Z From https://github.com/Valeriitsoy/Sum25-intro-labs
2025-06-20T16:27:01.5332884Z  * [new ref]         b6133c19c0eefe1eb0901712e6babb1578079f15 -> origin/master
2025-06-20T16:27:01.5357360Z ##[endgroup]
2025-06-20T16:27:01.5357971Z ##[group]Determining the checkout info
2025-06-20T16:27:01.5359842Z ##[endgroup]
2025-06-20T16:27:01.5365270Z [command]/usr/bin/git sparse-checkout disable
2025-06-20T16:27:01.5406099Z [command]/usr/bin/git config --local --unset-all extensions.worktreeConfig
2025-06-20T16:27:01.5434038Z ##[group]Checking out the ref
2025-06-20T16:27:01.5438061Z [command]/usr/bin/git checkout --progress --force -B master refs/remotes/origin/master
2025-06-20T16:27:01.5484796Z Reset branch 'master'
2025-06-20T16:27:01.5487670Z branch 'master' set up to track 'origin/master'.
2025-06-20T16:27:01.5493412Z ##[endgroup]
2025-06-20T16:27:01.5530349Z [command]/usr/bin/git log -1 --format=%H
2025-06-20T16:27:01.5553753Z b6133c19c0eefe1eb0901712e6babb1578079f15
2025-06-20T16:27:01.5678227Z ##[group]Run echo "💡 The Valeriitsoy/Sum25-intro-labs repository has been cloned to the runner."
2025-06-20T16:27:01.5679046Z [36;1mecho "💡 The Valeriitsoy/Sum25-intro-labs repository has been cloned to the runner."[0m
2025-06-20T16:27:01.5738794Z shell: /usr/bin/bash -e {0}
2025-06-20T16:27:01.5739126Z ##[endgroup]
2025-06-20T16:27:01.5817646Z 💡 The Valeriitsoy/Sum25-intro-labs repository has been cloned to the runner.
2025-06-20T16:27:01.5850867Z ##[group]Run echo "🖥️ The workflow is now ready to test your code on the runner."
2025-06-20T16:27:01.5851523Z [36;1mecho "🖥️ The workflow is now ready to test your code on the runner."[0m
2025-06-20T16:27:01.5910394Z shell: /usr/bin/bash -e {0}
2025-06-20T16:27:01.5910728Z ##[endgroup]
2025-06-20T16:27:01.5996261Z 🖥️ The workflow is now ready to test your code on the runner.
2025-06-20T16:27:01.6026011Z ##[group]Run ls /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
2025-06-20T16:27:01.6026618Z [36;1mls /home/runner/work/Sum25-intro-labs/Sum25-intro-labs[0m
2025-06-20T16:27:01.6085934Z shell: /usr/bin/bash -e {0}
2025-06-20T16:27:01.6086261Z ##[endgroup]
2025-06-20T16:27:01.6180306Z README.md
2025-06-20T16:27:01.6180854Z lab1.md
2025-06-20T16:27:01.6181251Z lab2.md
2025-06-20T16:27:01.6181499Z lab3.md
2025-06-20T16:27:01.6181737Z submission1.md
2025-06-20T16:27:01.6181988Z submission2.md
2025-06-20T16:27:01.6215705Z ##[group]Run echo "🍏 This job's status is success."
2025-06-20T16:27:01.6216172Z [36;1mecho "🍏 This job's status is success."[0m
2025-06-20T16:27:01.6275570Z shell: /usr/bin/bash -e {0}
2025-06-20T16:27:01.6275893Z ##[endgroup]
2025-06-20T16:27:01.6357679Z 🍏 This job's status is success.
2025-06-20T16:27:01.6507430Z Post job cleanup.
2025-06-20T16:27:01.7466908Z [command]/usr/bin/git version
2025-06-20T16:27:01.7504667Z git version 2.49.0
2025-06-20T16:27:01.7552869Z Temporarily overriding HOME='/home/runner/work/_temp/cebd071e-56a8-4c0a-8d10-6a4b40b0a8fc' before making global git config changes
2025-06-20T16:27:01.7554139Z Adding repository directory to the temporary git global config as a safe directory
2025-06-20T16:27:01.7558655Z [command]/usr/bin/git config --global --add safe.directory /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
2025-06-20T16:27:01.7596353Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2025-06-20T16:27:01.7630150Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
2025-06-20T16:27:01.7865991Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2025-06-20T16:27:01.7888353Z http.https://github.com/.extraheader
2025-06-20T16:27:01.7901758Z [command]/usr/bin/git config --local --unset-all http.https://github.com/.extraheader
2025-06-20T16:27:01.7934801Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
2025-06-20T16:27:01.8270487Z Cleaning up orphan processes
```



## Задание 2: Сбор системной информации и ручной запуск

### Расширение рабочего процесса: ручной запуск и сбор информации

### Внесённые изменения в файл workflow

- Добавлен новый способ запуска:
  ```yaml
  on:
    push:
    workflow_dispatch:
  ```

- Добавлены шаги для сбора системной информации:

  ```yaml
    - name: Gather system information
    run: |
    echo "OS Version:" && uname -a
    echo "CPU Info:" && lscpu
    echo "Memory Info:" && free -h
    echo "Disk Info:" && df -h /
  ```

- После добавления workflow_dispatch на GitHub появилась кнопка "Run workflow".
- Workflow можно запускать как вручную, так и по push.
- При ручном запуске в логах видна информация об ОС, CPU, памяти и диске.

```
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
 Memory Info:
               total        used        free      shared  buff/cache   available
Mem:            15Gi       991Mi       9.9Gi        55Mi       5.2Gi        14Gi
Swap:          4.0Gi          0B       4.0Gi
 Disk Info:
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        72G   48G   25G  66% /
```

## Теперь workflow можно запускать вручную через вкладку Actions → Run workflow на GitHub.


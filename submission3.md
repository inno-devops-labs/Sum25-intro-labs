### Основные компоненты GitHub Actions:
1. **Workflow** - автоматизированный процесс, описываемый YAML-файлом;
2. **Job** - набор шагов, выполняемых на одном runner;
3. **Step** - отдельная задача (может быть командой или action);
4. **Action** - переиспользуемый компонент для упрощения workflow;
5. **Runner** - сервер, на котором выполняются jobs (GitHub-hosted или self-hosted).

### Порядок действий:
- создана папка .github/workflows в репозитории;
- добавлен файл workflow github-actions-demo.yml, использован пример из гайда;
- сохранен файл и создана новая ветка lab3.

### Результаты выполнения workflow:
- Set up job
- Run echo The job was automatically triggered by a push event."
- Run echo This job is now running on a Linux server hosted by GitHub!"
- Run echo The name of your branch is refs/heads/lab3 and your repository is kotosham/Sum25-intro-labs."
- Check out repository code
- Run echo The kotosham/Sum25-intro-labs repository has been cloned to the runner."
- Run echo The workflow is now ready to test your code on the runner."
- List files in the repository
- Run echo This job's status is success."
- Post Check out repository code
- Complete job
  
Ошибок не возникло, workflow занял 7 секунд, для каждого шага можно посмотреть логи.

#### Добавлен manual trigger (`workflow_dispatch`)
```yaml
on:
  push:
  workflow_dispatch:
```
Это позволяет запускать workflow вручную при необходимости.  
Также теперь в workflow собирается информация о системе:
```yaml
- name: Gather system information
        run: |
          echo "### SYSTEM INFO ###"
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
Вывод системной информации:
```
### SYSTEM INFO ###
Runner OS: Linux fv-az1074-531 6.11.0-1015-azure #15~24.04.1-Ubuntu SMP Thu May  1 02:52:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
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
Mem:            15Gi       1.0Gi       9.9Gi        55Mi       5.2Gi        14Gi
Swap:          4.0Gi          0B       4.0Gi
Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        72G   48G   25G  66% /
tmpfs           7.9G   84K  7.9G   1% /dev/shm
tmpfs           3.2G  1.1M  3.2G   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/sdb16      881M   60M  760M   8% /boot
/dev/sdb15      105M  6.2M   99M   6% /boot/efi
/dev/sda1        74G  4.1G   66G   6% /mnt
tmpfs           1.6G   12K  1.6G   1% /run/user/1001
Environment Variables:
SELENIUM_JAR_PATH=/usr/share/java/selenium-server.jar
CONDA=/usr/share/miniconda
GITHUB_WORKSPACE=/home/runner/work/Sum25-intro-labs/Sum25-intro-labs
JAVA_HOME_11_X64=/usr/lib/jvm/temurin-11-jdk-amd64
GITHUB_PATH=/home/runner/work/_temp/_runner_file_commands/add_path_583de771-6f3c-4c0a-8327-c750b12bfb38
...
```
Кнопка "Run workflow" появляется в интерфейсе GitHub Actions. Для запуска требуется перейти в Actions → выбрать workflow → "Run workflow"  
Преимущества ручного запуска:  
- тестирование workflow без внесения изменений в код;
- возможность запуска в любое время;
- полезно для отладки и демонстрации.
# Task 1
What I did:
- Created a `.github/workflows/github-actions-demo.yml`
- Used an example demo workflow from the quickstart
- Pushed the changes
- The workflow [ran](https://github.com/JustSomeDude2001/Sum25-intro-labs/actions/runs/15763560942/job/44435360621) as expected

Source code of the workflow:
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

Output:
```
2025-06-19T17:42:26.8504652Z Current runner version: '2.325.0'
2025-06-19T17:42:26.8546132Z ##[group]Operating System
2025-06-19T17:42:26.8547398Z Ubuntu
2025-06-19T17:42:26.8548195Z 24.04.2
2025-06-19T17:42:26.8548931Z LTS
2025-06-19T17:42:26.8549826Z ##[endgroup]
2025-06-19T17:42:26.8550701Z ##[group]Runner Image
2025-06-19T17:42:26.8551681Z Image: ubuntu-24.04
2025-06-19T17:42:26.8552675Z Version: 20250615.1.0
2025-06-19T17:42:26.8554436Z Included Software: https://github.com/actions/runner-images/blob/ubuntu24/20250615.1/images/ubuntu/Ubuntu2404-Readme.md
2025-06-19T17:42:26.8556977Z Image Release: https://github.com/actions/runner-images/releases/tag/ubuntu24%2F20250615.1
2025-06-19T17:42:26.8558713Z ##[endgroup]
2025-06-19T17:42:26.8559665Z ##[group]Runner Image Provisioner
2025-06-19T17:42:26.8560651Z 2.0.437.1
2025-06-19T17:42:26.8561508Z ##[endgroup]
2025-06-19T17:42:26.8565614Z ##[group]GITHUB_TOKEN Permissions
2025-06-19T17:42:26.8568779Z Actions: write
2025-06-19T17:42:26.8569939Z Attestations: write
2025-06-19T17:42:26.8571121Z Checks: write
2025-06-19T17:42:26.8572061Z Contents: write
2025-06-19T17:42:26.8572877Z Deployments: write
2025-06-19T17:42:26.8573980Z Discussions: write
2025-06-19T17:42:26.8574737Z Issues: write
2025-06-19T17:42:26.8575771Z Metadata: read
2025-06-19T17:42:26.8576670Z Models: read
2025-06-19T17:42:26.8577437Z Packages: write
2025-06-19T17:42:26.8578266Z Pages: write
2025-06-19T17:42:26.8579116Z PullRequests: write
2025-06-19T17:42:26.8579933Z RepositoryProjects: write
2025-06-19T17:42:26.8580796Z SecurityEvents: write
2025-06-19T17:42:26.8581776Z Statuses: write
2025-06-19T17:42:26.8582539Z ##[endgroup]
2025-06-19T17:42:26.8586208Z Secret source: Actions
2025-06-19T17:42:26.8587512Z Prepare workflow directory
2025-06-19T17:42:26.9045423Z Prepare all required actions
2025-06-19T17:42:26.9101879Z Getting action download info
2025-06-19T17:42:27.1503232Z ##[group]Download immutable action package 'actions/checkout@v4'
2025-06-19T17:42:27.1504190Z Version: 4.2.2
2025-06-19T17:42:27.1505331Z Digest: sha256:ccb2698953eaebd21c7bf6268a94f9c26518a7e38e27e0b83c1fe1ad049819b1
2025-06-19T17:42:27.1506702Z Source commit SHA: 11bd71901bbe5b1630ceea73d27597364c9af683
2025-06-19T17:42:27.1507384Z ##[endgroup]
2025-06-19T17:42:27.3275718Z Complete job name: Explore-GitHub-Actions
2025-06-19T17:42:27.3942138Z ##[group]Run echo "🎉 The job was automatically triggered by a push event."
2025-06-19T17:42:27.3943055Z [36;1mecho "🎉 The job was automatically triggered by a push event."[0m
2025-06-19T17:42:27.4040752Z shell: /usr/bin/bash -e {0}
2025-06-19T17:42:27.4041522Z ##[endgroup]
2025-06-19T17:42:27.4192319Z 🎉 The job was automatically triggered by a push event.
2025-06-19T17:42:27.4277536Z ##[group]Run echo "🐧 This job is now running on a Linux server hosted by GitHub!"
2025-06-19T17:42:27.4278458Z [36;1mecho "🐧 This job is now running on a Linux server hosted by GitHub!"[0m
2025-06-19T17:42:27.4334903Z shell: /usr/bin/bash -e {0}
2025-06-19T17:42:27.4335511Z ##[endgroup]
2025-06-19T17:42:27.4414734Z 🐧 This job is now running on a Linux server hosted by GitHub!
2025-06-19T17:42:27.4449648Z ##[group]Run echo "🔎 The name of your branch is refs/heads/master and your repository is JustSomeDude2001/Sum25-intro-labs."
2025-06-19T17:42:27.4451043Z [36;1mecho "🔎 The name of your branch is refs/heads/master and your repository is JustSomeDude2001/Sum25-intro-labs."[0m
2025-06-19T17:42:27.4504173Z shell: /usr/bin/bash -e {0}
2025-06-19T17:42:27.4504649Z ##[endgroup]
2025-06-19T17:42:27.4581877Z 🔎 The name of your branch is refs/heads/master and your repository is JustSomeDude2001/Sum25-intro-labs.
2025-06-19T17:42:27.4693195Z ##[group]Run actions/checkout@v4
2025-06-19T17:42:27.4693719Z with:
2025-06-19T17:42:27.4694148Z   repository: JustSomeDude2001/Sum25-intro-labs
2025-06-19T17:42:27.4694829Z   token: ***
2025-06-19T17:42:27.4695371Z   ssh-strict: true
2025-06-19T17:42:27.4695751Z   ssh-user: git
2025-06-19T17:42:27.4696154Z   persist-credentials: true
2025-06-19T17:42:27.4696602Z   clean: true
2025-06-19T17:42:27.4697233Z   sparse-checkout-cone-mode: true
2025-06-19T17:42:27.4697699Z   fetch-depth: 1
2025-06-19T17:42:27.4698086Z   fetch-tags: false
2025-06-19T17:42:27.4698485Z   show-progress: true
2025-06-19T17:42:27.4698887Z   lfs: false
2025-06-19T17:42:27.4699246Z   submodules: false
2025-06-19T17:42:27.4699641Z   set-safe-directory: true
2025-06-19T17:42:27.4700062Z ##[endgroup]
2025-06-19T17:42:27.7353155Z Syncing repository: JustSomeDude2001/Sum25-intro-labs
2025-06-19T17:42:27.7355814Z ##[group]Getting Git version info
2025-06-19T17:42:27.7357163Z Working directory is '/home/runner/work/Sum25-intro-labs/Sum25-intro-labs'
2025-06-19T17:42:27.7359015Z [command]/usr/bin/git version
2025-06-19T17:42:27.7426748Z git version 2.49.0
2025-06-19T17:42:27.7457796Z ##[endgroup]
2025-06-19T17:42:27.7476947Z Temporarily overriding HOME='/home/runner/work/_temp/5434c69d-8285-46d9-aa41-48b229e8f53d' before making global git config changes
2025-06-19T17:42:27.7478301Z Adding repository directory to the temporary git global config as a safe directory
2025-06-19T17:42:27.7481709Z [command]/usr/bin/git config --global --add safe.directory /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
2025-06-19T17:42:27.7516872Z Deleting the contents of '/home/runner/work/Sum25-intro-labs/Sum25-intro-labs'
2025-06-19T17:42:27.7520292Z ##[group]Initializing the repository
2025-06-19T17:42:27.7524345Z [command]/usr/bin/git init /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
2025-06-19T17:42:27.7617152Z hint: Using 'master' as the name for the initial branch. This default branch name
2025-06-19T17:42:27.7618256Z hint: is subject to change. To configure the initial branch name to use in all
2025-06-19T17:42:27.7619116Z hint: of your new repositories, which will suppress this warning, call:
2025-06-19T17:42:27.7619767Z hint:
2025-06-19T17:42:27.7620222Z hint: 	git config --global init.defaultBranch <name>
2025-06-19T17:42:27.7620813Z hint:
2025-06-19T17:42:27.7621687Z hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
2025-06-19T17:42:27.7622591Z hint: 'development'. The just-created branch can be renamed via this command:
2025-06-19T17:42:27.7623259Z hint:
2025-06-19T17:42:27.7623618Z hint: 	git branch -m <name>
2025-06-19T17:42:27.7630407Z Initialized empty Git repository in /home/runner/work/Sum25-intro-labs/Sum25-intro-labs/.git/
2025-06-19T17:42:27.7640793Z [command]/usr/bin/git remote add origin https://github.com/JustSomeDude2001/Sum25-intro-labs
2025-06-19T17:42:27.7674511Z ##[endgroup]
2025-06-19T17:42:27.7675424Z ##[group]Disabling automatic garbage collection
2025-06-19T17:42:27.7678666Z [command]/usr/bin/git config --local gc.auto 0
2025-06-19T17:42:27.7706468Z ##[endgroup]
2025-06-19T17:42:27.7707116Z ##[group]Setting up auth
2025-06-19T17:42:27.7713124Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2025-06-19T17:42:27.7742359Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
2025-06-19T17:42:27.8125231Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2025-06-19T17:42:27.8153382Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
2025-06-19T17:42:27.8387893Z [command]/usr/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ***
2025-06-19T17:42:27.8435191Z ##[endgroup]
2025-06-19T17:42:27.8436263Z ##[group]Fetching the repository
2025-06-19T17:42:27.8447221Z [command]/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --no-recurse-submodules --depth=1 origin +30edfc321ed91d09f166a7ab634d1cf7844b6913:refs/remotes/origin/master
2025-06-19T17:42:28.2118393Z From https://github.com/JustSomeDude2001/Sum25-intro-labs
2025-06-19T17:42:28.2121214Z  * [new ref]         30edfc321ed91d09f166a7ab634d1cf7844b6913 -> origin/master
2025-06-19T17:42:28.2153399Z ##[endgroup]
2025-06-19T17:42:28.2154624Z ##[group]Determining the checkout info
2025-06-19T17:42:28.2156764Z ##[endgroup]
2025-06-19T17:42:28.2162514Z [command]/usr/bin/git sparse-checkout disable
2025-06-19T17:42:28.2212170Z [command]/usr/bin/git config --local --unset-all extensions.worktreeConfig
2025-06-19T17:42:28.2241660Z ##[group]Checking out the ref
2025-06-19T17:42:28.2246482Z [command]/usr/bin/git checkout --progress --force -B master refs/remotes/origin/master
2025-06-19T17:42:28.2300131Z Reset branch 'master'
2025-06-19T17:42:28.2303070Z branch 'master' set up to track 'origin/master'.
2025-06-19T17:42:28.2309385Z ##[endgroup]
2025-06-19T17:42:28.2344274Z [command]/usr/bin/git log -1 --format=%H
2025-06-19T17:42:28.2370311Z 30edfc321ed91d09f166a7ab634d1cf7844b6913
2025-06-19T17:42:28.2515685Z ##[group]Run echo "💡 The JustSomeDude2001/Sum25-intro-labs repository has been cloned to the runner."
2025-06-19T17:42:28.2516989Z [36;1mecho "💡 The JustSomeDude2001/Sum25-intro-labs repository has been cloned to the runner."[0m
2025-06-19T17:42:28.2577530Z shell: /usr/bin/bash -e {0}
2025-06-19T17:42:28.2578008Z ##[endgroup]
2025-06-19T17:42:28.2662822Z 💡 The JustSomeDude2001/Sum25-intro-labs repository has been cloned to the runner.
2025-06-19T17:42:28.2701556Z ##[group]Run echo "🖥️ The workflow is now ready to test your code on the runner."
2025-06-19T17:42:28.2702515Z [36;1mecho "🖥️ The workflow is now ready to test your code on the runner."[0m
2025-06-19T17:42:28.2760582Z shell: /usr/bin/bash -e {0}
2025-06-19T17:42:28.2761054Z ##[endgroup]
2025-06-19T17:42:28.2838862Z 🖥️ The workflow is now ready to test your code on the runner.
2025-06-19T17:42:28.2877624Z ##[group]Run ls /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
2025-06-19T17:42:28.2878477Z [36;1mls /home/runner/work/Sum25-intro-labs/Sum25-intro-labs[0m
2025-06-19T17:42:28.2932434Z shell: /usr/bin/bash -e {0}
2025-06-19T17:42:28.2932905Z ##[endgroup]
2025-06-19T17:42:28.3023545Z README.md
2025-06-19T17:42:28.3024115Z history.txt
2025-06-19T17:42:28.3024713Z lab1.md
2025-06-19T17:42:28.3025455Z lab2.md
2025-06-19T17:42:28.3025996Z lab3.md
2025-06-19T17:42:28.3026539Z submission1.md
2025-06-19T17:42:28.3027211Z submission1task2picture.PNG
2025-06-19T17:42:28.3028196Z submission2.md
2025-06-19T17:42:28.3066333Z ##[group]Run echo "🍏 This job's status is success."
2025-06-19T17:42:28.3067019Z [36;1mecho "🍏 This job's status is success."[0m
2025-06-19T17:42:28.3121118Z shell: /usr/bin/bash -e {0}
2025-06-19T17:42:28.3121590Z ##[endgroup]
2025-06-19T17:42:28.3196402Z 🍏 This job's status is success.
2025-06-19T17:42:28.3358199Z Post job cleanup.
2025-06-19T17:42:28.4312588Z [command]/usr/bin/git version
2025-06-19T17:42:28.4349690Z git version 2.49.0
2025-06-19T17:42:28.4393767Z Temporarily overriding HOME='/home/runner/work/_temp/7a75eaad-a96b-4dee-b9df-c9992c15739a' before making global git config changes
2025-06-19T17:42:28.4395363Z Adding repository directory to the temporary git global config as a safe directory
2025-06-19T17:42:28.4406962Z [command]/usr/bin/git config --global --add safe.directory /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
2025-06-19T17:42:28.4440686Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2025-06-19T17:42:28.4472449Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
2025-06-19T17:42:28.4704102Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2025-06-19T17:42:28.4726031Z http.https://github.com/.extraheader
2025-06-19T17:42:28.4739770Z [command]/usr/bin/git config --local --unset-all http.https://github.com/.extraheader
2025-06-19T17:42:28.4774595Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
2025-06-19T17:42:28.5113127Z Cleaning up orphan processes
```

Key concepts:
- GitHub actions allows running things on GitHub servers on specific triggers (such as push)
- The things you could run may include:
    - linters
    - tests
    - deployment
    - and other tests
- All things in a workflow are executed in a sequenctial order, until some item in a workflow fails
- This way workflows can be used to facilitate some degree of quality on the master branch, so that only items with workflows passing are pushed on the main branch.
# Task 2
- Updated [existing workflow](https://github.com/JustSomeDude2001/Sum25-intro-labs/blob/master/.github/workflows/github-actions-demo.yml) to also run on `workflow_dispatch`
- Added 3 more steps:
    - Get Runner Details
    - Get OS Details
    - Get Hardware Details

Source code of the added steps:
```
# These steps have been appended to the workflow
      - name: Get Runner Details
        run: |
          echo "Runner OS: ${{ runner.os }}"
          echo "Runner Name: ${{ runner.name }}"
          echo "Runner Architecture: ${{ runner.arch }}"
          echo "GitHub Workspace: ${{ github.workspace }}"
      - name: Get OS Details
        run: |
          lsb_release -a
          uname -a
      - name: Get Hardware Details
        run: |
          echo "CPU Cores: $(nproc)"
          echo "Memory:"
          free -h
          echo "Storage:"
          df -h
          # Detailed Hardware (if available)
          echo -e "\n### CPU DETAILS ###"
          lscpu || echo "lscpu not available"
          echo -e "\n### MEMORY DETAILS ###"
          grep MemTotal /proc/meminfo || echo "/proc/meminfo not accessible"
```

[Relevant log output](https://github.com/JustSomeDude2001/Sum25-intro-labs/actions/runs/15764284124/job/44437504787):
```
2025-06-19T18:33:05.9526126Z ##[group]Run echo "Runner OS: Linux"
2025-06-19T18:33:05.9527221Z [36;1mecho "Runner OS: Linux"[0m
2025-06-19T18:33:05.9528348Z [36;1mecho "Runner Name: GitHub Actions 1000000302"[0m
2025-06-19T18:33:05.9529586Z [36;1mecho "Runner Architecture: X64"[0m
2025-06-19T18:33:05.9531195Z [36;1mecho "GitHub Workspace: /home/runner/work/Sum25-intro-labs/Sum25-intro-labs"[0m
2025-06-19T18:33:05.9587210Z shell: /usr/bin/bash -e {0}
2025-06-19T18:33:05.9588113Z ##[endgroup]
2025-06-19T18:33:05.9669051Z Runner OS: Linux
2025-06-19T18:33:05.9670212Z Runner Name: GitHub Actions 1000000302
2025-06-19T18:33:05.9672109Z Runner Architecture: X64
2025-06-19T18:33:05.9673757Z GitHub Workspace: /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
2025-06-19T18:33:05.9724074Z ##[group]Run lsb_release -a
2025-06-19T18:33:05.9725051Z [36;1mlsb_release -a[0m
2025-06-19T18:33:05.9725884Z [36;1muname -a[0m
2025-06-19T18:33:05.9779252Z shell: /usr/bin/bash -e {0}
2025-06-19T18:33:05.9780135Z ##[endgroup]
2025-06-19T18:33:05.9929231Z Distributor ID:	Ubuntu
2025-06-19T18:33:05.9930259Z Description:	Ubuntu 24.04.2 LTS
2025-06-19T18:33:05.9931223Z Release:	24.04
2025-06-19T18:33:05.9932130Z Codename:	noble
2025-06-19T18:33:05.9940484Z Linux fv-az1048-749 6.11.0-1015-azure #15~24.04.1-Ubuntu SMP Thu May  1 02:52:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
2025-06-19T18:33:05.9992598Z ##[group]Run echo "CPU Cores: $(nproc)"
2025-06-19T18:33:05.9993969Z [36;1mecho "CPU Cores: $(nproc)"[0m
2025-06-19T18:33:05.9994967Z [36;1mecho "Memory:"[0m
2025-06-19T18:33:05.9995788Z [36;1mfree -h[0m
2025-06-19T18:33:05.9996548Z [36;1mecho "Storage:"[0m
2025-06-19T18:33:05.9997370Z [36;1mdf -h[0m
2025-06-19T18:33:05.9998193Z [36;1m# Detailed Hardware (if available)[0m
2025-06-19T18:33:05.9999296Z [36;1mecho -e "\n### CPU DETAILS ###"[0m
2025-06-19T18:33:06.0000377Z [36;1mlscpu || echo "lscpu not available"[0m
2025-06-19T18:33:06.0001562Z [36;1mecho -e "\n### MEMORY DETAILS ###"[0m
2025-06-19T18:33:06.0003003Z [36;1mgrep MemTotal /proc/meminfo || echo "/proc/meminfo not accessible"[0m
2025-06-19T18:33:06.0058592Z shell: /usr/bin/bash -e {0}
2025-06-19T18:33:06.0059479Z ##[endgroup]
2025-06-19T18:33:06.0162083Z CPU Cores: 4
2025-06-19T18:33:06.0162997Z Memory:
2025-06-19T18:33:06.0178053Z                total        used        free      shared  buff/cache   available
2025-06-19T18:33:06.0179516Z Mem:            15Gi       994Mi       9.9Gi        55Mi       5.2Gi        14Gi
2025-06-19T18:33:06.0181163Z Swap:          4.0Gi          0B       4.0Gi
2025-06-19T18:33:06.0182312Z Storage:
2025-06-19T18:33:06.0196127Z Filesystem      Size  Used Avail Use% Mounted on
2025-06-19T18:33:06.0197883Z /dev/root        72G   48G   25G  66% /
2025-06-19T18:33:06.0199635Z tmpfs           7.9G   84K  7.9G   1% /dev/shm
2025-06-19T18:33:06.0200874Z tmpfs           3.2G  1.1M  3.2G   1% /run
2025-06-19T18:33:06.0201925Z tmpfs           5.0M     0  5.0M   0% /run/lock
2025-06-19T18:33:06.0202979Z /dev/sdb16      881M   60M  760M   8% /boot
2025-06-19T18:33:06.0204219Z /dev/sdb15      105M  6.2M   99M   6% /boot/efi
2025-06-19T18:33:06.0205278Z /dev/sda1        74G  4.1G   66G   6% /mnt
2025-06-19T18:33:06.0206340Z tmpfs           1.6G   12K  1.6G   1% /run/user/1001
2025-06-19T18:33:06.0207114Z 
2025-06-19T18:33:06.0207425Z ### CPU DETAILS ###
2025-06-19T18:33:06.0235297Z Architecture:                         x86_64
2025-06-19T18:33:06.0236764Z CPU op-mode(s):                       32-bit, 64-bit
2025-06-19T18:33:06.0238578Z Address sizes:                        48 bits physical, 48 bits virtual
2025-06-19T18:33:06.0240156Z Byte Order:                           Little Endian
2025-06-19T18:33:06.0241223Z CPU(s):                               4
2025-06-19T18:33:06.0242218Z On-line CPU(s) list:                  0-3
2025-06-19T18:33:06.0243455Z Vendor ID:                            AuthenticAMD
2025-06-19T18:33:06.0244721Z Model name:                           AMD EPYC 7763 64-Core Processor
2025-06-19T18:33:06.0245900Z CPU family:                           25
2025-06-19T18:33:06.0246870Z Model:                                1
2025-06-19T18:33:06.0247834Z Thread(s) per core:                   2
2025-06-19T18:33:06.0249047Z Core(s) per socket:                   2
2025-06-19T18:33:06.0250041Z Socket(s):                            1
2025-06-19T18:33:06.0251020Z Stepping:                             1
2025-06-19T18:33:06.0252595Z BogoMIPS:                             4890.86
2025-06-19T18:33:06.0263138Z Flags:                                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl tsc_reliable nonstop_tsc cpuid extd_apicid aperfmperf tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm cmp_legacy svm cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw topoext vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves user_shstk clzero xsaveerptr rdpru arat npt nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold v_vmsave_vmload umip vaes vpclmulqdq rdpid fsrm
2025-06-19T18:33:06.0272088Z Virtualization:                       AMD-V
2025-06-19T18:33:06.0273177Z Hypervisor vendor:                    Microsoft
2025-06-19T18:33:06.0274833Z Virtualization type:                  full
2025-06-19T18:33:06.0275983Z L1d cache:                            64 KiB (2 instances)
2025-06-19T18:33:06.0277206Z L1i cache:                            64 KiB (2 instances)
2025-06-19T18:33:06.0278443Z L2 cache:                             1 MiB (2 instances)
2025-06-19T18:33:06.0279598Z L3 cache:                             32 MiB (1 instance)
2025-06-19T18:33:06.0280676Z NUMA node(s):                         1
2025-06-19T18:33:06.0281664Z NUMA node0 CPU(s):                    0-3
2025-06-19T18:33:06.0282784Z Vulnerability Gather data sampling:   Not affected
2025-06-19T18:33:06.0284218Z Vulnerability Itlb multihit:          Not affected
2025-06-19T18:33:06.0285420Z Vulnerability L1tf:                   Not affected
2025-06-19T18:33:06.0286590Z Vulnerability Mds:                    Not affected
2025-06-19T18:33:06.0287825Z Vulnerability Meltdown:               Not affected
2025-06-19T18:33:06.0289043Z Vulnerability Mmio stale data:        Not affected
2025-06-19T18:33:06.0290306Z Vulnerability Reg file data sampling: Not affected
2025-06-19T18:33:06.0291538Z Vulnerability Retbleed:               Not affected
2025-06-19T18:33:06.0293012Z Vulnerability Spec rstack overflow:   Vulnerable: Safe RET, no microcode
2025-06-19T18:33:06.0294713Z Vulnerability Spec store bypass:      Vulnerable
2025-06-19T18:33:06.0296471Z Vulnerability Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitization
2025-06-19T18:33:06.0299119Z Vulnerability Spectre v2:             Mitigation; Retpolines; STIBP disabled; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected
2025-06-19T18:33:06.0301187Z Vulnerability Srbds:                  Not affected
2025-06-19T18:33:06.0302393Z Vulnerability Tsx async abort:        Not affected
2025-06-19T18:33:06.0303170Z 
2025-06-19T18:33:06.0303642Z ### MEMORY DETAILS ###
2025-06-19T18:33:06.0304432Z MemTotal:       16379564 kB
```

- The workflow ran manually on push and workflow was ran manually from the website, as can be seen in [GitHub Actions](https://github.com/JustSomeDude2001/Sum25-intro-labs/actions/workflows/github-actions-demo.yml)
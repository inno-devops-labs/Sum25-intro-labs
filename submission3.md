# Task 1: Create Your First GitHub Actions Pipeline

1. By following Quickstart I created proposed demo GitHub action: `.github/workflows/github-actions-demo.yml` that triggers on every push to the repository.
2. Key concepts learned:

- Workflows: Automated processes defined in YAML files
- Events: Triggers like push or pull_request
- Jobs: Sets of steps that run on the same runner
- Runners: Machines that execute jobs (GitHub-hosted or self-hosted)
- Actions: Reusable units of code for common tasks

# Task 2: Gathering System Information and Manual Triggering

1. Added manual trigger to the workflow by adding `workflow_dispatch`. Now, we can trigger the action manually or on push. Indicator of manual trigger was also added as a step in the job.
```yml
...
on: 
  push:
  workflow_dispatch:

jobs:
  Explore-GitHub-Actions:
    runs-on: ubuntu-latest
    steps:
      ...
      - name: Manual Trigger Check
        if: ${{ github.event_name == 'workflow_dispatch' }}
        run: |
          echo "🚀 This workflow was manually triggered by ${{ github.actor }}"
          echo "⏱️ Triggered at: ${{ github.event.workflow_dispatch.created_at }}"
```

Only after pushing the workflow onto default branch (in my case it is `master`), the "Run workflow" button appeared in the GitHub UI. This measure is used to prevent unauthorized workflow execution.

I also corrected context path to get the time of event creation to becuase previously it printed nothing:
```yml
    echo "⏱️ Triggered at: $(date -d '${{ github.event.created_at }}' '+%Y-%m-%d %H:%M:%S %Z')"
```

2. Added gathering system info as additional step in workflow. Now it prints OS, CPU, Memory, and Disk info.

```yml
...
jobs:
  Explore-GitHub-Actions:
    runs-on: ubuntu-latest
    steps:
      ...
      - name: Gather system info
        run: |
          echo "Runner OS: $(uname -a)"
          echo "CPU Info: $(lscpu | grep 'Model name')"
          echo "Memory: $(free -h | grep Mem)"
          echo "Disk Space: $(df -h / | grep -v Filesystem)"
```

3. Final manual workflow execution logs:
```
2025-06-19T18:53:39.0341734Z Current runner version: '2.325.0'
2025-06-19T18:53:39.0366444Z ##[group]Operating System
2025-06-19T18:53:39.0367267Z Ubuntu
2025-06-19T18:53:39.0367735Z 24.04.2
2025-06-19T18:53:39.0368345Z LTS
2025-06-19T18:53:39.0368816Z ##[endgroup]
2025-06-19T18:53:39.0369369Z ##[group]Runner Image
2025-06-19T18:53:39.0370161Z Image: ubuntu-24.04
2025-06-19T18:53:39.0370681Z Version: 20250615.1.0
2025-06-19T18:53:39.0371715Z Included Software: https://github.com/actions/runner-images/blob/ubuntu24/20250615.1/images/ubuntu/Ubuntu2404-Readme.md
2025-06-19T18:53:39.0373100Z Image Release: https://github.com/actions/runner-images/releases/tag/ubuntu24%2F20250615.1
2025-06-19T18:53:39.0373983Z ##[endgroup]
2025-06-19T18:53:39.0374461Z ##[group]Runner Image Provisioner
2025-06-19T18:53:39.0375283Z 2.0.437.1
2025-06-19T18:53:39.0375764Z ##[endgroup]
2025-06-19T18:53:39.0378079Z ##[group]GITHUB_TOKEN Permissions
2025-06-19T18:53:39.0380085Z Actions: write
2025-06-19T18:53:39.0380799Z Attestations: write
2025-06-19T18:53:39.0381548Z Checks: write
2025-06-19T18:53:39.0382092Z Contents: write
2025-06-19T18:53:39.0382607Z Deployments: write
2025-06-19T18:53:39.0383146Z Discussions: write
2025-06-19T18:53:39.0383604Z Issues: write
2025-06-19T18:53:39.0384177Z Metadata: read
2025-06-19T18:53:39.0384671Z Models: read
2025-06-19T18:53:39.0385331Z Packages: write
2025-06-19T18:53:39.0385882Z Pages: write
2025-06-19T18:53:39.0386388Z PullRequests: write
2025-06-19T18:53:39.0386919Z RepositoryProjects: write
2025-06-19T18:53:39.0387454Z SecurityEvents: write
2025-06-19T18:53:39.0388166Z Statuses: write
2025-06-19T18:53:39.0388618Z ##[endgroup]
2025-06-19T18:53:39.0390553Z Secret source: Actions
2025-06-19T18:53:39.0391433Z Prepare workflow directory
2025-06-19T18:53:39.0716108Z Prepare all required actions
2025-06-19T18:53:39.0753422Z Getting action download info
2025-06-19T18:53:39.6696597Z ##[group]Download immutable action package 'actions/checkout@v4'
2025-06-19T18:53:39.6697591Z Version: 4.2.2
2025-06-19T18:53:39.6698743Z Digest: sha256:ccb2698953eaebd21c7bf6268a94f9c26518a7e38e27e0b83c1fe1ad049819b1
2025-06-19T18:53:39.6699897Z Source commit SHA: 11bd71901bbe5b1630ceea73d27597364c9af683
2025-06-19T18:53:39.6700596Z ##[endgroup]
2025-06-19T18:53:40.7953595Z Complete job name: Explore-GitHub-Actions
2025-06-19T18:53:40.8649967Z ##[group]Run echo "🎉 The job was automatically triggered by a workflow_dispatch event."
2025-06-19T18:53:40.8651168Z [36;1mecho "🎉 The job was automatically triggered by a workflow_dispatch event."[0m
2025-06-19T18:53:40.9328282Z shell: /usr/bin/bash -e {0}
2025-06-19T18:53:40.9329240Z ##[endgroup]
2025-06-19T18:53:40.9487828Z 🎉 The job was automatically triggered by a workflow_dispatch event.
2025-06-19T18:53:40.9573267Z ##[group]Run echo "🐧 This job is now running on a Linux server hosted by GitHub!"
2025-06-19T18:53:40.9574266Z [36;1mecho "🐧 This job is now running on a Linux server hosted by GitHub!"[0m
2025-06-19T18:53:40.9630638Z shell: /usr/bin/bash -e {0}
2025-06-19T18:53:40.9631140Z ##[endgroup]
2025-06-19T18:53:40.9706254Z 🐧 This job is now running on a Linux server hosted by GitHub!
2025-06-19T18:53:40.9742386Z ##[group]Run echo "🔎 The name of your branch is refs/heads/master and your repository is kilimanj4r0/DevOpsFundamentals."
2025-06-19T18:53:40.9743852Z [36;1mecho "🔎 The name of your branch is refs/heads/master and your repository is kilimanj4r0/DevOpsFundamentals."[0m
2025-06-19T18:53:40.9796337Z shell: /usr/bin/bash -e {0}
2025-06-19T18:53:40.9796872Z ##[endgroup]
2025-06-19T18:53:40.9870176Z 🔎 The name of your branch is refs/heads/master and your repository is kilimanj4r0/DevOpsFundamentals.
2025-06-19T18:53:40.9986795Z ##[group]Run actions/checkout@v4
2025-06-19T18:53:40.9987361Z with:
2025-06-19T18:53:40.9987815Z   repository: kilimanj4r0/DevOpsFundamentals
2025-06-19T18:53:40.9988569Z   token: ***
2025-06-19T18:53:40.9988991Z   ssh-strict: true
2025-06-19T18:53:40.9989409Z   ssh-user: git
2025-06-19T18:53:40.9989827Z   persist-credentials: true
2025-06-19T18:53:40.9990301Z   clean: true
2025-06-19T18:53:40.9990979Z   sparse-checkout-cone-mode: true
2025-06-19T18:53:40.9991496Z   fetch-depth: 1
2025-06-19T18:53:40.9991905Z   fetch-tags: false
2025-06-19T18:53:40.9992328Z   show-progress: true
2025-06-19T18:53:40.9992755Z   lfs: false
2025-06-19T18:53:40.9993155Z   submodules: false
2025-06-19T18:53:40.9993600Z   set-safe-directory: true
2025-06-19T18:53:40.9994070Z ##[endgroup]
2025-06-19T18:53:43.3967208Z Syncing repository: kilimanj4r0/DevOpsFundamentals
2025-06-19T18:53:43.3968691Z ##[group]Getting Git version info
2025-06-19T18:53:43.3969275Z Working directory is '/home/runner/work/DevOpsFundamentals/DevOpsFundamentals'
2025-06-19T18:53:43.3969944Z [command]/usr/bin/git version
2025-06-19T18:53:43.6522099Z git version 2.49.0
2025-06-19T18:53:43.6602852Z ##[endgroup]
2025-06-19T18:53:43.6624146Z Temporarily overriding HOME='/home/runner/work/_temp/2d451e3f-05e5-4a56-9cb6-18ddf1a57365' before making global git config changes
2025-06-19T18:53:43.6625420Z Adding repository directory to the temporary git global config as a safe directory
2025-06-19T18:53:43.6630090Z [command]/usr/bin/git config --global --add safe.directory /home/runner/work/DevOpsFundamentals/DevOpsFundamentals
2025-06-19T18:53:43.6710782Z Deleting the contents of '/home/runner/work/DevOpsFundamentals/DevOpsFundamentals'
2025-06-19T18:53:43.6714314Z ##[group]Initializing the repository
2025-06-19T18:53:43.6718831Z [command]/usr/bin/git init /home/runner/work/DevOpsFundamentals/DevOpsFundamentals
2025-06-19T18:53:43.7861485Z hint: Using 'master' as the name for the initial branch. This default branch name
2025-06-19T18:53:43.7862405Z hint: is subject to change. To configure the initial branch name to use in all
2025-06-19T18:53:43.7863074Z hint: of your new repositories, which will suppress this warning, call:
2025-06-19T18:53:43.7863645Z hint:
2025-06-19T18:53:43.7863999Z hint: 	git config --global init.defaultBranch <name>
2025-06-19T18:53:43.7864407Z hint:
2025-06-19T18:53:43.7864800Z hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
2025-06-19T18:53:43.7865642Z hint: 'development'. The just-created branch can be renamed via this command:
2025-06-19T18:53:43.7866156Z hint:
2025-06-19T18:53:43.7866423Z hint: 	git branch -m <name>
2025-06-19T18:53:43.7967085Z Initialized empty Git repository in /home/runner/work/DevOpsFundamentals/DevOpsFundamentals/.git/
2025-06-19T18:53:43.7981467Z [command]/usr/bin/git remote add origin https://github.com/kilimanj4r0/DevOpsFundamentals
2025-06-19T18:53:43.8075888Z ##[endgroup]
2025-06-19T18:53:43.8076989Z ##[group]Disabling automatic garbage collection
2025-06-19T18:53:43.8081219Z [command]/usr/bin/git config --local gc.auto 0
2025-06-19T18:53:43.8110418Z ##[endgroup]
2025-06-19T18:53:43.8111136Z ##[group]Setting up auth
2025-06-19T18:53:43.8118562Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2025-06-19T18:53:43.8148712Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
2025-06-19T18:53:44.0837112Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2025-06-19T18:53:44.0867058Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
2025-06-19T18:53:44.1092893Z [command]/usr/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ***
2025-06-19T18:53:44.1139077Z ##[endgroup]
2025-06-19T18:53:44.1139783Z ##[group]Fetching the repository
2025-06-19T18:53:44.1147162Z [command]/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --no-recurse-submodules --depth=1 origin +574a7c97ba1a3228d043e165e69298f7e1c57435:refs/remotes/origin/master
2025-06-19T18:53:44.7783509Z From https://github.com/kilimanj4r0/DevOpsFundamentals
2025-06-19T18:53:44.7784451Z  * [new ref]         574a7c97ba1a3228d043e165e69298f7e1c57435 -> origin/master
2025-06-19T18:53:44.7871940Z ##[endgroup]
2025-06-19T18:53:44.7872523Z ##[group]Determining the checkout info
2025-06-19T18:53:44.7873231Z ##[endgroup]
2025-06-19T18:53:44.7878520Z [command]/usr/bin/git sparse-checkout disable
2025-06-19T18:53:44.7964418Z [command]/usr/bin/git config --local --unset-all extensions.worktreeConfig
2025-06-19T18:53:44.7991012Z ##[group]Checking out the ref
2025-06-19T18:53:44.7995713Z [command]/usr/bin/git checkout --progress --force -B master refs/remotes/origin/master
2025-06-19T18:53:44.8084606Z Reset branch 'master'
2025-06-19T18:53:44.8087937Z branch 'master' set up to track 'origin/master'.
2025-06-19T18:53:44.8093641Z ##[endgroup]
2025-06-19T18:53:44.8130571Z [command]/usr/bin/git log -1 --format=%H
2025-06-19T18:53:44.8153941Z 574a7c97ba1a3228d043e165e69298f7e1c57435
2025-06-19T18:53:44.8319355Z ##[group]Run echo "💡 The kilimanj4r0/DevOpsFundamentals repository has been cloned to the runner."
2025-06-19T18:53:44.8320056Z [36;1mecho "💡 The kilimanj4r0/DevOpsFundamentals repository has been cloned to the runner."[0m
2025-06-19T18:53:44.8379231Z shell: /usr/bin/bash -e {0}
2025-06-19T18:53:44.8379459Z ##[endgroup]
2025-06-19T18:53:44.8455505Z 💡 The kilimanj4r0/DevOpsFundamentals repository has been cloned to the runner.
2025-06-19T18:53:44.8480960Z ##[group]Run echo "🖥️ The workflow is now ready to test your code on the runner."
2025-06-19T18:53:44.8481455Z [36;1mecho "🖥️ The workflow is now ready to test your code on the runner."[0m
2025-06-19T18:53:44.8533130Z shell: /usr/bin/bash -e {0}
2025-06-19T18:53:44.8533351Z ##[endgroup]
2025-06-19T18:53:44.8603340Z 🖥️ The workflow is now ready to test your code on the runner.
2025-06-19T18:53:44.8626661Z ##[group]Run ls /home/runner/work/DevOpsFundamentals/DevOpsFundamentals
2025-06-19T18:53:44.8627153Z [36;1mls /home/runner/work/DevOpsFundamentals/DevOpsFundamentals[0m
2025-06-19T18:53:44.8679984Z shell: /usr/bin/bash -e {0}
2025-06-19T18:53:44.8680219Z ##[endgroup]
2025-06-19T18:53:44.8763920Z README.md
2025-06-19T18:53:44.8764221Z lab1.md
2025-06-19T18:53:44.8764438Z lab2.md
2025-06-19T18:53:44.8764597Z lab3.md
2025-06-19T18:53:44.8790995Z ##[group]Run echo "Runner OS: $(uname -a)"
2025-06-19T18:53:44.8791313Z [36;1mecho "Runner OS: $(uname -a)"[0m
2025-06-19T18:53:44.8791598Z [36;1mecho "CPU Info: $(lscpu | grep 'Model name')"[0m
2025-06-19T18:53:44.8791899Z [36;1mecho "Memory: $(free -h | grep Mem)"[0m
2025-06-19T18:53:44.8792219Z [36;1mecho "Disk Space: $(df -h / | grep -v Filesystem)"[0m
2025-06-19T18:53:44.8845412Z shell: /usr/bin/bash -e {0}
2025-06-19T18:53:44.8845645Z ##[endgroup]
2025-06-19T18:53:44.8929991Z Runner OS: Linux fv-az1915-651 6.11.0-1015-azure #15~24.04.1-Ubuntu SMP Thu May  1 02:52:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
2025-06-19T18:53:44.8970868Z CPU Info: Model name:                           AMD EPYC 7763 64-Core Processor
2025-06-19T18:53:44.8994522Z Memory: Mem:            15Gi       1.0Gi       9.8Gi        60Mi       5.2Gi        14Gi
2025-06-19T18:53:44.9250750Z Disk Space: /dev/root        72G   48G   25G  66% /
2025-06-19T18:53:44.9346863Z ##[group]Run echo "🍏 This job's status is success."
2025-06-19T18:53:44.9347217Z [36;1mecho "🍏 This job's status is success."[0m
2025-06-19T18:53:44.9405347Z shell: /usr/bin/bash -e {0}
2025-06-19T18:53:44.9405577Z ##[endgroup]
2025-06-19T18:53:44.9477735Z 🍏 This job's status is success.
2025-06-19T18:53:44.9519494Z ##[group]Run echo "🚀 This workflow was manually triggered by kilimanj4r0"
2025-06-19T18:53:44.9519954Z [36;1mecho "🚀 This workflow was manually triggered by kilimanj4r0"[0m
2025-06-19T18:53:44.9520362Z [36;1mecho "⏱️ Triggered at: $(date -d '' '+%Y-%m-%d %H:%M:%S %Z')"[0m
2025-06-19T18:53:44.9572972Z shell: /usr/bin/bash -e {0}
2025-06-19T18:53:44.9573196Z ##[endgroup]
2025-06-19T18:53:44.9645197Z 🚀 This workflow was manually triggered by kilimanj4r0
2025-06-19T18:53:44.9658134Z ⏱️ Triggered at: 2025-06-19 00:00:00 UTC
2025-06-19T18:53:44.9727228Z Post job cleanup.
2025-06-19T18:53:45.0637468Z [command]/usr/bin/git version
2025-06-19T18:53:45.0677229Z git version 2.49.0
2025-06-19T18:53:45.0721331Z Temporarily overriding HOME='/home/runner/work/_temp/55a3aae2-eac2-474e-98c2-9af25bdc8459' before making global git config changes
2025-06-19T18:53:45.0722620Z Adding repository directory to the temporary git global config as a safe directory
2025-06-19T18:53:45.0728096Z [command]/usr/bin/git config --global --add safe.directory /home/runner/work/DevOpsFundamentals/DevOpsFundamentals
2025-06-19T18:53:45.0763858Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2025-06-19T18:53:45.0795944Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
2025-06-19T18:53:45.1066393Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2025-06-19T18:53:45.1086937Z http.https://github.com/.extraheader
2025-06-19T18:53:45.1099220Z [command]/usr/bin/git config --local --unset-all http.https://github.com/.extraheader
2025-06-19T18:53:45.1129371Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
2025-06-19T18:53:45.1470896Z Cleaning up orphan processes
```
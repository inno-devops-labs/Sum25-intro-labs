## main.yml

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

## Output of main.yml

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

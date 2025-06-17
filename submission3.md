## LAB 3
Nikita Yaneev n.yaneev@innopolis.unversity


### TASK 1.1


#### Key steps

1. Creating yaml file

2. Write in the file 
```name: GitHub Actions Demo
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
3. push on the git

#### Key Concepts

- **GitHub Actions**: A CI/CD tool integrated into GitHub that automates workflows like testing, building, and deploying code.
- **Workflow**: Defined in `.github/workflows/` using YAML. It's a set of steps that GitHub executes.
- **Runners**: Virtual machines or containers that run workflows.
- **Triggers**: Events that start workflows (e.g., `push`, `pull_request`).

#### Results

![alt text](image.png)

#### TASK 1.2
![alt text](image-1.png)

As a result we can see, changed yaml file, which tell us a information about task 1.2 

### TASK 2
![alt text](image-3.png)
![alt text](image-2.png)

The latest yaml version is
```
name: GitHub Actions Demo
run-name: ${{ github.actor }} is testing out GitHub Actions 🚀
on: 
  push:
  workflow_dispatch:
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4

    - name: Run a one-line script
      run: echo "Hello, GitHub Actions!"

    - name: Gather Basic System Info
      run: |
        echo "=== UNAME ==="
        uname -a
        echo "=== DISK SPACE ==="
        df -h
        echo "=== MEMORY USAGE ==="
        free -h
        echo "=== UPTIME ==="
        uptime

    - name: Gather Detailed Runner Info
      run: |
        echo "=== CPU Info ==="
        lscpu || cat /proc/cpuinfo
        echo "=== Memory Info ==="
        cat /proc/meminfo | head -n 10
        echo "=== OS Release Info ==="
        cat /etc/os-release
        echo "=== Runner Environment ==="
        echo "Runner OS: $RUNNER_OS"
        echo "Runner Arch: $RUNNER_ARCH"
        echo "Runner Temp: $RUNNER_TEMP"
        echo "Runner Workspace: $GITHUB_WORKSPACE"

```
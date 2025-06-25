# Lab: GitHub Actions CI/CD

## Task 1: Creating Your First GitHub Actions Pipeline

### Steps:
1. Created a workflow file: `.github/workflows/github-actions-demo.yml`
2. Used the YAML configuration from the guide:
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
          - run: echo "🍏 This job's status is ${{ job.status }}."
    ```

### Observations:
- Workflow automatically triggered after push
- All steps executed successfully
- Output:
🎉 The job was automatically triggered by a push event.
🐧 This job is now running on a Linux server hosted by GitHub!
🔎 The name of your branch is refs/heads/main and your repository is Gh0stCasper/lab3.
💡 The Gh0stCasper/lab3 repository has been cloned to the runner.
🖥️ The workflow is now ready to test your code on the runner.
lab3
README.md
🍏 This job's status is success.

text

## Task 2: Manual Trigger and System Information Collection

### Changes to Workflow:
1. Added manual trigger:
  ```yaml
  on: 
    push:
    workflow_dispatch:  # Manual trigger
  ```

2. Added system information collection:
  ```yaml
  - name: Collect system information
    run: |
      echo "### 🖥️ System Info ###"
      echo "OS: $(uname -a)"
      echo "CPU: $(lscpu | grep 'Model name' | sed 's/Model name://')"
      echo "Memory: $(free -h | grep Mem | awk '{print $2}')"
      echo "Disk: $(df -h / | grep -v Filesystem)"
  ```

### Full Workflow File:
```yaml
name: GitHub Actions Demo
run-name: ${{ github.actor }} is testing out GitHub Actions 🚀
on: 
push:
workflow_dispatch:  # Manual trigger
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
    - name: Collect system information
      run: |
        echo "### 🖥️ System Info ###"
        echo "OS: $(uname -a)"
        echo "CPU: $(lscpu | grep 'Model name' | sed 's/Model name://')"
        echo "Memory: $(free -h | grep Mem | awk '{print $2}')"
        echo "Disk: $(df -h / | grep -v Filesystem)"
Manual Execution Results:
How to run:

Go to Actions → GitHub Actions Demo

Click "Run workflow"

System information output:

text
### 🖥️ System Info ###
OS: Linux fv-az1276-708 6.11.0-1015-azure #15~24.04.1-Ubuntu SMP Thu May  1 02:52:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
CPU: AMD EPYC 7763 64-Core Processor
Memory: 15Gi
Disk: /dev/root        72G   48G   25G  66% /
System analysis:

OS: Ubuntu 24.04 (kernel 6.11.0-1015-azure)

CPU: AMD EPYC 7763 (64 cores)

Memory: 15 GB RAM

Disk: 72 GB total (25 GB free)

Conclusions
GitHub Actions simplifies CI/CD automation

Manual triggers (workflow_dispatch) are useful for debugging

System information helps analyze execution environment:

Modern runners use powerful AMD EPYC processors

Standard disk size: 72-84 GB

Memory size: 7-15 GB depending on load

GitHub Actions significantly speeds up development processes

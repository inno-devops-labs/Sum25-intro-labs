# CI/CD Lab – GitHub Actions

## Task 1: Create Your First GitHub Actions Pipeline

**quickstart guide:**  
https://docs.github.com/en/actions/quickstart

### Observations
1. When I pushed the new branch `lab3`, the GitHub Actions workflow started automatically on an Ubuntu-hosted runner.
2. The workflow logs show built-in variables `${{ github.actor }}` (my GitHub username) and `${{ runner.os }}` (the runner operating system, here “Ubuntu”).

### Key Concepts
1. A GitHub Actions workflow is defined in a YAML file with `on`, `jobs` and `steps` sections.
2. The `actions/checkout@v4` action checks out your repository code into the runner workspace.

### Steps Followed
1. Created the file `.github/workflows/github-actions-demo.yml`, pasted the example workflow from the quickstart guide, and committed it to branch `lab3`.
2. Pushed branch `lab3` to GitHub, then opened the Actions tab to confirm the workflow ran and viewed the step-by-step logs.

<!-- Triggering CI/CD workflow for Task 1 -->

### Execution Results
- **Workflow run status:** Success  
- **Output snippet:**  
Operating System: Linux pkrvmxyh4eaekms 6.11.0-1015-azure #15~24.04.1-Ubuntu SMP Thu May 1 02:52:08 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
CPU info:
Architecture: x86_64
CPU op-mode(s): 32-bit, 64-bit
Address sizes: 48 bits physical, 48 bits virtual
Byte Order: Little Endian
CPU(s): 4
Memory info:
total used free shared buff/cache available
Mem: 15Gi 870Mi 14Gi 39Mi 1.0Gi 14Gi

- **Errors encountered:** none
- **Run a one-line script**
- **Run a multi-line script**

Run echo Hello, world!
Hello, world!
Run echo Add other actions to build,
Add other actions to build,
test, and deploy your project.

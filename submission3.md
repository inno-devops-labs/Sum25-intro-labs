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

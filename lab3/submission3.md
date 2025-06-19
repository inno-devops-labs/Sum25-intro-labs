# CI/CD Lab - GitHub Actions Submission

## Task 1: Create Your First GitHub Actions Pipeline

### Key Concepts
- **GitHub Actions**: A CI/CD platform to automate workflows.
- **Workflow**: A YAML file defining triggers, jobs, and steps.
- **Runner**: A virtual machine (e.g., `ubuntu-latest`) to execute jobs.
- **Triggers**: Events like `push` or `pull_request` that start the workflow.

### Steps Followed
1. Read the [GitHub Actions Quickstart Guide](https://docs.github.com/en/actions/quickstart).
2. Created a workflow file at `.github/workflows/basic-ci.yml`.
3. Configured the workflow to trigger on `push` to the `lab3` branch.
4. Added a job to check out code and run a simple `echo` command.
5. Pushed changes to the `lab3` branch and observed execution in the GitHub Actions tab.

### Workflow Execution Output
- The workflow ran successfully.
- Output: `Hello, GitHub Actions!`
- No errors encountered.

### Observations
- The workflow executed automatically on push.
- The `ubuntu-latest` runner was fast and reliable.
- The Actions tab provided clear logs for debugging.

## Task 2: Gathering System Information and Manual Triggering

### Manual Trigger Configuration
- Added `workflow_dispatch` to the `on` section in `.github/workflows/basic-ci.yml`.
- This allows manual triggering via the GitHub Actions UI.
- No inputs were configured as per the lab requirements.

### System Information Gathering
- Added a step to run system information commands:
  ```bash
  echo "Runner OS: $RUNNER_OS"
  echo "CPU Info: $(lscpu)"
  echo "Memory Info: $(free -h)"
  echo "Disk Info: $(df -h)"
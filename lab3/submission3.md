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

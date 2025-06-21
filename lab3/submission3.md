# Task 1

## Setup

- A new branch for lab 3 was created
- A workflow file `main.yaml` was added to `.github/workflows/`
- Workflow runs upon being pushed into a lab3 branch

## Terminology

- **Workflow** is an automated process, described by a YAML file
- **Job** — a task in the workflow
- **Step** — a step in the task
- **runs-on** — determines the runner OS

## Results

- Workflow launched upon being pushed
- Step output looked like "Hello, GitHub Actions!"
- No errors occured

# Task 2

## Changes

- `workflow_dispatch` was added for manual startup
- `Show system info` step was added to display runner information
- Workflow file was uploaded into the master branch in order for Workflow Dispatch to work

## Observations

- Manual lauch works
- System information was gathered and displayed
- No runtime errors in the final version (errors due to incorrect commands for the runner were encountered in one of the iterations) 
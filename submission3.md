# CI/CD Lab - GitHub Actions

## Introduction

GitHub Actions allows you to automate workflows for your project. With Actions, you can create CI/CD (Continuous Integration and Continuous delivery) and other automated processes.

sources:

-  https://docs.github.com/en/actions/writing-workflows/quickstart
-  https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/triggering-a-workflow#defining-inputs-for-manually-triggered-workflows

## Steps to get started

### 1. Creating a repository

- Go to GitHub and create a new repository.
- Give it a name and select the visibility options (public or private).

### 2. Workflow Setup

- Create a folder in your repository.github/workflows.
- In this folder, create a YAML file for the workflow, for example main.yml.

### 3. Writing the Workflow

An example of a workflow for Node.js applications:

```
yaml
name: Node.js CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:

      • name: Checking the source code
        uses: actions/checkout@v2

      • name: Installation Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '14'

      • name: Installing Dependencies
        run: npm install

      • name: Running tests
        run: npm test
```

### 4. Starting the workflow

- After adding the workflow file, each time you push to the main branch or create a pull request, the specified process will be started.

### 5. Checking the results

- Go to the "Actions" tab in your repository to see the progress status of the workflows.
- You can view the logs for each step to debug possible errors.

## Key concepts

- **Workflow**: A set of steps that are performed in response to certain events.
- **Steps (Steps)**: Separate tasks within a workflow that can run commands or use actions.
- **Actions**: Reusable modules that perform certain tasks.

# CI/CD Lab - GitHub Actions

In this lab, you will explore continuous integration and continuous deployment (CI/CD) practices using GitHub Actions. GitHub Actions provides a powerful workflow automation tool to streamline your development and deployment processes. You will perform various tasks related to setting up CI/CD pipelines and gathering system information using GitHub Actions. Follow the tasks below to complete the lab assignment.

## Task 1: Create Your First GitHub Actions Pipeline

**Objective**: Set up a basic GitHub Actions workflow and observe its execution.

### Key Concepts and What I Learned

- GitHub Actions is a CI/CD platform built into GitHub that allows automating workflows, such as testing, building, and deploying code.
- A workflow is defined in a YAML file stored under `.github/workflows/`.
- A workflow is made up of jobs, which run on runners provided by GitHub (for example, `ubuntu-latest`).
- Each job contains steps, which can run shell commands or use prebuilt actions.

### Workflow File

I created a file named `.github/workflows/.github/workflows/github-actions-demo.yml` with the following contents:

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

### Execution and Observations
After pushing the workflow file to my branch (lab3-solution), I visited the Actions tab on GitHub. The workflow was automatically triggered as expected.

### Output observed in the Actions UI:
- The job ran successfully on an `ubuntu-latest` runner.

- All echo statements printed expected values, such as:

    - The event type (`push`)

    - The operating system (`Linux`)

    - The branch name and repository

    - A list of files in the repository

### Conclusion
This task helped me understand the structure of GitHub Actions workflows, including how events trigger jobs and how to configure steps within those jobs. Now I know more about setting up automated CI pipelines using GitHub Actions.
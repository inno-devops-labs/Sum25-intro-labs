# Lab 3
### Task 1: Create Your First GitHub Actions Pipeline

GitHub Actions is a CI/CD pipeline which can be used for many various processes: CI, deployment, automation, code scanning, etc., depending on the configuration.

To create my own GitHub Actions pipeline I performed the following steps:

1. Checked the settings of the repository and ensured that none of the features of GitHub Actions were disabled for it. I enabled the followed option:
> Allow all actions and reusable workflows.
2. I created the .github folder and the file github-actions-demo.yml through the VS Code Explorer interface, as neither the folder, nor the file appeared in my repository previously.
3. As instructed, I copy pasted 
```
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
into the newly-created file.
> At this stage you don't need to understand the details of this workflow.

Thank you, GitHub, very cool.
4. I commited the changes to the local lab3 branch and pushed the changes to origin.
5. After searching and failing to find my workflow in the GitHub Actions interface, I retraced my steps and found the issue - I forgot to put the workflows directory between .github and .yml file. I fixed that and once again pushed to origin.
6. The bugfix worked and I was able to visit the [GitHub Actions tab in my repository](https://github.com/Daru1914/Sum25-intro-labs/actions), where I found Explore-GitHub-Actions tab.
7. There I could observe the workflow execution for my last push:
  - Set up job: The job was set up successfully on a GitHub-hosted Ubuntu 24.04 runner using actions/checkout@v4, with all necessary permissions and environment components initialized.
  - The workflow confirmed it was automatically triggered by a push event.
  - The workflow confirmed that the job is executing on a GitHub-hosted Linux (Ubuntu) server.
  - The workflow is running on the lab3 branch of the Daru1914/Sum25-intro-labs repository.
  - Checkout the repository code: The workflow successfully checked out the lab3 branch of the Daru1914/Sum25-intro-labs repository using actions/checkout@v4, with a shallow fetch of the latest commit (63c83b35). It initialized a fresh Git environment, set up authentication, and ensured a clean working directory.
  - The repository Daru1914/Sum25-intro-labs was successfully cloned to the GitHub Actions runner.
  - The workflow setup is complete, and the environment is ready to run and test my code.
  - The repository contains five files: README.md, lab1.md, lab2.md, lab3.md, and submission3.md.
  - The workflow completed successfully with no errors.
  - The workflow performed standard post-job cleanup: it confirmed the Git version, marked the repo as a safe directory, and removed temporary authentication headers and SSH settings.
  - The runner cleaned up any leftover (orphaned) processes to ensure a clean and isolated environment for future jobs.

### Task 2: Gathering System Information and Manual Triggering
To complete this task, I extended my existing GitHub Actions workflow in two ways:
1. I added a manual trigger.
2. I appended steps to gather system information from the runner.

#### Part 1: Manual Trigger Configuration:
- I modified the beginning of my existing `github-actions-demo.yml` file to include the `workflow_dispatch` trigger in addition to `push`. This enables me to trigger the workflow manually via the GitHub Actions UI.
```
on: 
  push:
  workflow_dispatch:
```
I did not define any inputs since they were not required for this task.
After pushing the change to the lab3 branch, I was able to manually run the workflow by navigating to the Actions tab -> selecting the workflow -> clicking "Run workflow".
# Lab 3
## Task 2
### Part 1: Basic GitHub Actions Workflow

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

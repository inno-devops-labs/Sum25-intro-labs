# CI/CD Lab Submission: GitHub Actions

## Task 1: Create Your First GitHub Actions Pipeline

### Following the Quickstart Guide

I began by following the official GitHub Actions quickstart guide. The process was straightforward and provided a solid introduction to the core concepts of GitHub Actions.

**Steps Followed:**

1.  I created the `.github/workflows/` directory structure in the root of my repository. This is the required location for GitHub to discover workflow files.
2.  Inside this directory, I created a new YAML file named `test.yml`.
3.  I populated the file with the basic workflow configuration provided in the guide. This included defining a name, an `on` trigger for `push` events, and a single `job` with several `steps`.
4.  I committed the new workflow file and pushed it to the `lab3` branch of my repository, and then, merge to master branch.

**Key Concepts Learned:**

*   **Workflow:** the top-level automated process defined in a YAML file.
*   **Event:** a trigger that starts a workflow, such as a `push` to a branch or a `pull_request`.
*   **Job:** a set of steps that execute on the same runner. Jobs run in parallel by default.
*   **Step:** an individual task within a job. It can be a shell command (`run`) or a pre-built, reusable command (`uses`).
*   **Action:** a reusable unit of code that can be included in a workflow. `actions/checkout@v4` is a common example that checks out the repository's code.
*   **Runner:** a server (virtual machine) hosted by GitHub that runs the workflow jobs. You can choose between different operating systems like Linux, Windows, or macOS.

### Workflow Execution Observations

Upon pushing the commit, the workflow was triggered automatically. The following are my key observations from the execution log:

*   `Current runner version: '2.325.0'`: shows the specific version of the runner software that is executing the job.
*   `Operating System: Ubuntu 24.04.2 LTS`: confirms that my job is running on a Linux machine, specifically the latest Long-Term Support version of Ubuntu.
*   `Runner Image: image: ubuntu-24.04`: details the virtual environment image being used, with a link to the software included on it. This is very useful for debugging.
*   `GITHUB_TOKEN Permissions`: this section is critical. It lists all the permissions that the temporary `GITHUB_TOKEN` has for this job. For example, `Contents: write` means the job can push code back to the repository.
*   `Download immutable action package 'actions/checkout@v4'`: before my code runs, the workflow prepares its environment by downloading any required actions, like `checkout`.
*   `Run echo "🎉 The job was automatically triggered by a push event."`: this is the direct output from the first `run` command in my workflow file. It executes successfully.
*   `Run echo "🐧 This job is now running on a Linux server hosted by GitHub!"`: the output of the second `run` command, confirming the script's execution.

No errors were encountered during this initial run. The process was smooth and provided clear, step-by-step logging.

## Task 2: Gathering System Information and Manual Triggering

### Configuring a Manual Trigger

To enable manual execution of the workflow, I added the `workflow_dispatch` event trigger. This allows the workflow to be started directly from the "Actions" tab in the GitHub UI without needing a code push.

**Changes to `test.yml`:**

I modified the `on:` block in my workflow file as follows:

```diff
- on: [push]
+ on: [push, workflow_dispatch]
```

This simple addition enabled the "Run workflow" button in the repository's Actions tab. No inputs were required, as per the lab instructions.

### Gathering System Information

I then added a new step to the existing job to collect and display information about the runner's system.

**Changes to `test.yml`:**

I added the following step to my job's configuration:

```yaml
      - name: Gather system information
        run: |
          echo "--- KERNEL INFO ---"
          uname -a
          echo -e "\n--- CPU INFO ---"
          lscpu
          echo -e "\n--- MEMORY INFO ---"
          free -h
```

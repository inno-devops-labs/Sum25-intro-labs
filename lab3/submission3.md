# CI/CD Lab - GitHub Actions

## Task 1: Create Your First GitHub Actions Pipeline

**Objective**: Set up a basic GitHub Actions workflow and observe its execution.

- [x] [Read the Official Guide](https://docs.github.com/en/actions/quickstart)
- [x] Observe the Workflow Execution

## 🔄 Trigger

This workflow is **automatically triggered** on every `push` event to the repository.

```yaml
on: [push]
```

---

## 🧱 Jobs

### 🛠️ Job: `Explore-GitHub-Actions`

- **Runner:** `ubuntu-latest`
- **Environment:** GitHub-hosted Ubuntu Linux virtual machine

#### 🔡 Step-by-step Execution

1. **Log Trigger Info**

   ```bash
   echo "🎉 The job was automatically triggered by a ${{ github.event_name }} event."
   ```

   ✅ Outputs the type of event that triggered the workflow, e.g.:

   ```text
   🎉 The job was automatically triggered by a push event.
   ```

2. **Log Runner Info**

   ```bash
   echo "🐧 This job is now running on a ${{ runner.os }} server hosted by GitHub!"
   ```

   ✅ Outputs the OS the job is running on:

   ```text
   🐧 This job is now running on a Linux server hosted by GitHub!
   ```

3. **Log Branch and Repo Info**

   ```bash
   echo "🔎 The name of your branch is ${{ github.ref }} and your repository is ${{ github.repository }}."
   ```

   ✅ Displays full branch ref and repository name, for example:

   ```text
   🔎 The name of your branch is refs/heads/lab3 and your repository is Samatgator/Sum25-intro-labs.
   ```

4. **Checkout Repository**

   ```yaml
   - name: Check out repository code
     uses: actions/checkout@v4
   ```

   ✅ Clones the repository content into the GitHub runner's workspace directory.

5. **Confirm Cloning**

   ```bash
   echo "💡 The ${{ github.repository }} repository has been cloned to the runner."
   ```

   ✅ Confirms that code is now accessible in the runner:

   ```text
   💡 The Samatgator/Sum25-intro-labs repository has been cloned to the runner.
   ```

6. **Start Testing**

   ```bash
   echo "🖥️ The workflow is now ready to test your code on the runner."
   ```

   ✅ General notification that the environment is prepared.

7. **List Files**

   ```bash
   ls ${{ github.workspace }}
   ```

   ✅ Lists the files in the root of the cloned repository.

   Example output:

   ```text
   Run ls /home/runner/work/Sum25-intro-labs/Sum25-intro-labs
   README.md
   lab1
   lab1.md
   lab2
   lab2.md
   lab3
   lab3.md
   lab4.md
   lab5.md
   lab6.md
   ```

8. **Job Status Output**

   ```bash
   echo "🍏 This job's status is ${{ job.status }}."
   ```

   ✅ Displays the status at that point:

   ```text
   🍏 This job's status is success.
   ```

---

## ✅ Summary

| Step          | Purpose                   | Output                                  |
| ------------- | ------------------------- | --------------------------------------- |
| Event trigger | Confirm source of trigger | `push`                                  |
| Runner info   | Display OS                | `Linux`                                 |
| Branch info   | Show branch and repo      | `refs/heads/lab3`, `Samatgator/Sum25-intro-labs` |
| Checkout      | Clone repo                | Uses `actions/checkout@v4`              |
| File list     | List repo contents        | Output of `ls`                          |
| Job status    | Report final status       | `success`                               |

---

## 📎 Notes

- `${{ github.* }}` and `${{ runner.* }}` are GitHub Actions **context expressions** that interpolate live environment and event data.
- `${{ job.status }}` reflects the status **only at the moment of execution** of that step — not the final job result unless it's the last step.

---

## Task 2: Gathering System Information and Manual Triggering

**Objective**: Extend your workflow to include manual triggering and system information gathering.

- [x] Configure a Manual Trigger
- [x] Gather System Information


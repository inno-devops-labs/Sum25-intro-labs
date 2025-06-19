# CI/CD Lab – GitHub Actions

## Task 1: Create Your First GitHub Actions Pipeline

### 1.1 Set Up the Workflow

1. Copy CI from GitHub (the example)

```bash
mkdir -p .github/workflows
cat > .github/workflows/ci.yml << 'EOF'
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
EOF
```

2. Commit & push

```bash
git add .github/workflows/ci.yml
git commit -m "add CI from example from github"
git push origin main
```

### 1.2 Observe the Workflow Execution

When I pushed to master, GH ran the CI job automatically.

![alt text](image.png)

As it's an example CI, it worked fine, without errors.

![alt text](image2.png)

Here's the jobs it did in ~ under 8 second:

![alt text](image3.png)

The outputs that we expect in the jobs execution log:

![alt text](image4.png)

I hope this reflects the core concepts and steps I followed

---

## Task 2: Gathering System Information and Manual Triggering

### 2.1 Add a Manual Trigger

1. Put on workflow_dispatch in the `ci.yml` file
2. Commit, push
3. In GitHub Actions / CI, see Run workflow button.

![alt text](image5.png)

We can run it manually now, too.

![alt text](image6.png)

^^^
This one's been run on workflow_dispatch.

### 2.2 Gather System Information

1. Added the gather system info step into the workflow .ci file:

![alt text](image7.png)

2. Commit, push

3. Log output

![alt text](image8.png)

4. Observations

The runner is an Ubuntu 24.04.1 LTS server, kernel 6.11.0-1015-azure. It has 15 GiB of RAM and a 4 GiB for swap. The main disk `/dev/root` is 72 GiB with about 25 GiB free. The CPU model is an AMD EPYC 7763 "64-Core Processor" with 4 vCPUs active in this VM. All vulnerability checks reported as Not affected.


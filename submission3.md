### Task 1

Comparing with the other tool's for `CI/CD` processes like Jenkins (The most popular) or gitlab solutions, github provide us the full complect of integration for differ project architectures. Also it provides the public lib community of actions.

We do not need to lose a lot of time to learn and create the workflow, then the tools like jenkins, and it can be have the one file to configure all project tasks from testing to building to docker image and send it to the server.

To self try, I will be create the simple project on `python3.12` with pytesting of unit components.

From the docs about github workflows, I have set the demo action, and it has bean complete [Actions](https://github.com/Slauva/devops-course/actions/runs/15782411482)

And added the python workflow for testing [Actions](https://github.com/Slauva/devops-course/actions/runs/15782578937)

### Task 2

Added the manual trigger with system information parts:

~~~yaml
      - name: Manual Trigger Check
        if: ${{ github.event_name == 'workflow_dispatch' }}
        run: |
          echo "🚀 This workflow was manually triggered by ${{ github.actor }}"
          echo "⏱️ Triggered at: ${{ github.event.workflow_dispatch.created_at }}"
      - name: Gather system info
        run: |
          echo "Runner OS: $(uname -a)"
          echo "CPU Info: $(lscpu | grep 'Model name')"
          echo "Memory: $(free -h | grep Mem)"
          echo "Disk Space: $(df -h / | grep -v Filesystem)"
~~~
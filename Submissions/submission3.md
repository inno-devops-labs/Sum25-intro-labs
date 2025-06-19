# Task 1: Create Your First GitHub Actions Pipeline

- GitHub Actions allow to automate workflows (CI/CD) directly from the repository. 
- Workflow - an automated process triggered by an event.
- Workflows are defined in YAML files in  `.github/workflows/`

I wrote a CI script that checks that only files that have the word “submission” in their name are in the `Submissions/` directory.

Code:

```yml
name: Check Submission Filenames

on:
  push:
    paths:
      - 'Submissions/**'
  pull_request:
    paths:
      - 'Submissions/**'

jobs:
  check-submissions:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Check filenames in Submissions directory
        run: |
          invalid_files=$(find Submissions/ -maxdepth 1 -type f ! -name '*submission*')

          if [ -n "$invalid_files" ]; then
            echo "❌ Found invalid files:"
            echo "$invalid_files"
            exit 1
          else
            echo "✅ All files are correctly named."
          fi
```

First output:
```commandline
❌ Found invalid files:
Submissions/img.png
Submissions/img_1.png
Error: Process completed with exit code 1.
```

After checking, it was discovered that there were images in the `/Submissions` directory. I created a separate directory for the images and moved the files. Let's test the script after the changes.

Second output:

```commandline
✅ All files are correctly named.
```

# Task 2: Gathering System Information and Manual Triggering

1. Configure a Manual Trigger:

    Add `workflow_dispatch`. It allows you to run workflow manually from the Actions tab on GitHub.
    
    ```yml
    name: Check Submission Filenames
    
    on:
      push:         
      workflow_dispatch:  # manual trigger
    
    jobs:
      check-submissions:
        runs-on: ubuntu-latest
        steps:
          - name: Checkout code
            uses: actions/checkout@v3
    
          - name: Check filenames in Submissions directory
            run: |
              echo "🔍 Checking files in Submissions/..."
              invalid_files=$(find Submissions/ -type f ! -name '*Submission*')
    
              if [ -n "$invalid_files" ]; then
                echo "❌ Found invalid files:"
                echo "$invalid_files"
                exit 1
              else
                echo "✅ All filenames are valid."
              fi
    ```
   
2. Gather System Information
    
    Added Gather system information `.yml` file, which executes commands:

    `uname -a` - OS and kernel 

    `lscpu` - information about CPU
    
    `free -h` - memory information
    
    `df -h` - disk information
    
    `env` - runner environment variables
        

```yml
name: Gather System Information

on:
  workflow_dispatch:  # Ручной запуск

jobs:
  system-info:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Display system information
        run: |
          echo "🖥️ System Information:"
          echo "---- uname -a ----"
          uname -a
          
          echo ""
          echo "---- CPU Info ----"
          lscpu
          
          echo ""
          echo "---- Memory Info ----"
          free -h
          
          echo ""
          echo "---- Disk Info ----"
          df -h
          
          echo ""
          echo "---- Environment Variables ----"
          env | sort
```
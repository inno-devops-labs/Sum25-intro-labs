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


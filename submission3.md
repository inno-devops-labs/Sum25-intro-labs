## Task 1: First GitHub Actions Pipeline

### Workflow Content:
```yaml
name: CI Pipeline

on: [push]  

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Run a simple command
      run: echo "Hello, GitHub Actions!"
```

## Task 2: System Info and Manual Trigger

### Changes to Workflow:
1. Added trigger `workflow_dispatch`
2. Added step with collecting system info

### Gathered System Info:
# Lab 3 Submission

## Task 1: Create Your First GitHub Actions Pipeline

### 1.1 Workflow Configuration

File: `.github/workflows/ci.yml`

```yaml
name: CI Pipeline

on:
  push:
    branches: [ master ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Gather system info
        run: |
          uname -a
          lsb_release -a || echo 'No lsb_release'
          df -h

      - name: Initialize npm project
        run: |
          npm init -y
          npm set-script test "echo \"No tests specified\""

      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '16'

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test

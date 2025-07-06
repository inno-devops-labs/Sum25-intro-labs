# Lab on Operating Systems and Networks

## Task 1: Operating System Analysis

For the task, system_analysis.yml was created (https://github.com/Kulikova-A18/Sum25-intro-labs/blob/master/.github/workflows/system_analysis.yml)

```
name: System Analysis

on:
  # Triggers the workflow on push or pull request events but only for the "master" branch
  push:
    branches: [ "master" ]
  pull_request:
    branches: [ "master" ]

jobs:
  boot_performance:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Analyze Boot Performance
        run: |
          echo "=== Boot Performance ==="
          echo "Systemd Analyze:"
          systemd-analyze
          echo "Blame:"
          systemd-analyze blame
          echo "Uptime:"
          uptime
          echo "Current Users:"
          w

  resource_intensive_processes:
    runs-on: ubuntu-latest
    needs: boot_performance
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Process Expertise
        run: |
          echo "=== Resource-Intensive Processes ==="
          echo "Top Memory Consumers:"
          ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
          echo "Top CPU Consumers:"
          ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

  service_dependencies:
    runs-on: ubuntu-latest
    needs: resource_intensive_processes
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Service Dependencies
        run: |
          echo "=== Service Dependencies ==="
          systemctl list-dependencies
          systemctl list-dependencies multi-user.target

  user_sessions_audit:
    runs-on: ubuntu-latest
    needs: service_dependencies
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: User Sessions Audit
        run: |
          echo "=== User Sessions ==="
          who -a
          last -n 5

  memory_analysis:
    runs-on: ubuntu-latest
    needs: user_sessions_audit
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Memory Analysis
        run: |
          echo "=== Memory Allocation ==="
          free -h
          echo "Memory Info:"
          cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
```

![image](https://github.com/user-attachments/assets/4b3ac868-877a-4602-bcd0-59e701cdd14b)

Submission4.md will describe the key observations, answer the question "Identify the process consuming the most memory", and note the resource usage patterns

## Task 2: Network Analysis

A network_analysis.yml was created for the task (https://github.com/Kulikova-A18/Sum25-intro-labs/blob/master/.github/workflows/network_analysis.yml)

```
name: Network Analysis

on:
  # Triggers the workflow on push or pull request events but only for the "master" branch
  push:
    branches: [ "master" ]
  pull_request:
    branches: [ "master" ]

jobs:
  traceroute_and_dns:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install traceroute
        run: |
          sudo apt-get update
          sudo apt-get install -y traceroute

      - name: Traceroute to github.com
        run: |
          echo "=== Traceroute ==="
          traceroute github.com || echo "Error occurred during Traceroute step"

      - name: DNS Resolution for github.com
        run: |
          echo "=== DNS Resolution ==="
          dig github.com || echo "Error occurred during DNS Resolution step"

  packet_capture:
    runs-on: ubuntu-latest
    needs: traceroute_and_dns
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Capture DNS Traffic
        run: |
          echo "=== Generating DNS Traffic ==="
          dig github.com || echo "Error occurred during DNS Traffic Generation step"
          
          echo "=== Packet Capture ==="
          sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn || echo "Error occurred during Packet Capture step"
          
  reverse_dns_lookup:
    runs-on: ubuntu-latest
    needs: packet_capture
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install dnsutils
        run: |
          sudo apt-get update
          sudo apt-get install -y dnsutils

      - name: Reverse DNS Lookup for 8.8.4.4
        run: |
          echo "=== Reverse DNS Lookup ==="
          dig -x 8.8.4.4 || echo "Error occurred during Reverse DNS Lookup for 8.8.4.4 step"

      - name: Reverse DNS Lookup for 1.1.1.1
        run: |
          dig -x 1.1.1.1 || echo "Error occurred during Reverse DNS Lookup for 1.1.1.1 step"
```

![image](https://github.com/user-attachments/assets/a6cdcb2c-90d3-47c9-b26d-7fd323dcfdb7)

Submission4.md will cover network path information, DNS query/response patterns, comparing reverse lookup results, IP address sanitization in packet captures (replace last octet with XXX) when documenting sensitive networks.
## Information about the author

The report was made by Kulikova Alyona specifically for "Integration and automation of the software development process (advanced course)".

If you have any questions or suggestions for improvement, do not hesitate to contact us!

Link to git: https://github.com/Kulikova-A18

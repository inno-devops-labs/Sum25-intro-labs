
# Operating Systems & Networking Lab

In this lab, you'll analyze operating system fundamentals including boot performance, resource utilization, and service dependencies, while conducting network diagnostics through path tracing, DNS inspection, and packet capture to develop core DevOps infrastructure skills.

## Task 1: Operating System Analysis

**Objective**: Analyze key OS components including boot performance, resource usage, services, sessions, and memory management.

### 1.1: Boot Performance

1. **Analyze System Boot Time**:

   ```sh
   systemd-analyze
   systemd-analyze blame
   ```

2. **Check System Load**:

   ```sh
   uptime
   w
   ```

### 1.2: Process Forensics

1. **Identify Resource-Intensive Processes**:

   ```sh
   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
   ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
   ```

### 1.3: Service Dependencies

1. **Map Service Relationships**:

   ```sh
   systemctl list-dependencies
   systemctl list-dependencies multi-user.target
   ```

### 1.4: User Sessions

1. **Audit Login Activity**:

   ```sh
   who -a
   last -n 5
   ```

### 1.5: Memory Analysis

1. **Inspect Memory Allocation**:

   ```sh
   free -h
   cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
   ```

### Documentation for OS Analysis

- Create `submission4.md` with all command outputs
- For each
  - Include key observations
  - Answer specific questions (e.g., "Identify top memory-consuming process")
  - Note resource utilization patterns

## Task 2: Networking Analysis

**Objective**: Perform network diagnostics including path tracing, DNS inspection, packet capture, and reverse lookups.

### 2.1: Network Path Tracing

1. **Traceroute Execution**:

   ```sh
   traceroute github.com
   ```

2. **DNS Resolution Check**:

   ```sh
   dig github.com
   ```

### 2.2: Packet Capture

1. **Capture DNS Traffic**:

   ```sh
   sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
   ```

### 2.3: Reverse DNS

1. **Perform PTR Lookups**:

   ```sh
   dig -x 8.8.4.4
   dig -x 1.1.2.2
   ```

### Documentation for Networking Analysis

- Add outputs to `submission4.md`
- For each
  - Include insights on network paths
  - Analyze DNS query/response patterns
  - Compare reverse lookup results
  - Sanitize IPs in packet captures (replace last octet with XXX) if documenting sensitive networks

## Guidelines

- Use Markdown headers to organize  in `submission4.md`
- Include both command outputs and written analysis
- For packet capture (2.2), document 1 DNS query example
- Create PR to main branch when complete

> **Security Notes**
>
> 1. Sanitize IPs in packet capture outputs
> 2. Avoid including sensitive process names in documentation

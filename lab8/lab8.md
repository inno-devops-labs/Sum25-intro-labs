# SRE Lab

In this lab, you will explore the principles of Site Reliability Engineering (SRE). Follow the tasks below to complete the lab assignment.

## Task 1: Key Metrics for SRE and SLAs

**Objective**: Monitor system resources and manage disk space.

1. **Monitor System Resources**:
   - Use commands like `htop` and `iostat` to monitor CPU, memory, and I/O usage.
   - Identify and document the top 3 most consuming applications for CPU, memory, and I/O usage in a `submission8.md` file.

2. **Disk Space Management**:
   - Use `du` and `df` to manage disk space.
   - Identify and log the top 3 largest files in the `/var` directory in the `submission8.md` file.

3. **Documentation**:
   - Create a `submission8.md` file.
   - Provide the output and analysis of the monitored metrics and disk space management.

## Task 2: Practical Website Monitoring Setup

**Objective**: Set up real-time monitoring for any website using Checkly. You'll create checks for:

   1. Basic availability (is the site loading?)
   2. Content validation (is a key element visible?)
   3. Interaction performance (how long does a button click take?)
   4. Alerting (get notified when something breaks)

### Step 1: Choose Your Website

Pick ANY public website you want to monitor (e.g., your favorite store, news site, or portfolio)

### Step 2: Create Checks in Checkly

1. **Sign up at [Checkly](https://checklyhq.com/)** (free account)
2. Create **API Check** for basic availability:
   - URL: Your chosen website
   - Assertion: Status code is 200
3. Create **Browser Check** for content & interactions:
   - URL: Same website

### Step 3: Set Up Alerts

Configure **alert rules** of YOUR choice:

- What to alert on? (e.g., failed checks, slow latency)
- How to be notified? (email, telegram, etc.)
- Set thresholds that make sense for your site

### Step 4: Capture Proof & Documentation

1. Run checks manually to verify they work
2. Take screenshots and add them to `submission8.md` showing:
   - Your browser check configuration
   - A successful check result
   - Your alert settings

### Guidelines

- Use proper Markdown formatting and structure for the documentation files.
- Organize the files within the lab folder using appropriate naming conventions.
- Create a Pull Request to the main branch of the repository with your completed lab assignment.

> Note: Actively explore SRE metrics and SLAs to understand their importance in measuring system reliability.

# SRE Lab

In this lab, you will learn the principles of Site Reliability Engineering (SRE). To complete the lab, complete the following tasks.

## Task 1: Key Metrics for SRE and SLAs

**Objective**: Monitor system resources and manage disk space.

1. **Monitor system resources**:
- Use commands such as `htop` and `iostat` to monitor CPU, memory, and I/O usage.
- Identify and document the top 3 CPU, memory, and I/O consuming applications in `submission8.md`.

2. **Manage disk space**:
- Use `du` and `df` to manage disk space.
- Identify and document the top 3 files in the `/var` directory in `submission8.md`.

3. **Documentation**:
- Create a `submission8.md` file.

- Provide output and analysis of monitored metrics and disk space management.

### Solution

A script was made for this task that creates a submission8.md template.

The script itself:

```
#!/bin/bash

OUTPUT_FILE="submission8.md"

echo "# System resource monitoring and disk space management report" > $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

if command -v ps > /dev/null; then
echo "## System resource monitoring" >> $OUTPUT_FILE
echo "### CPU and memory usage" >> $OUTPUT_FILE
echo "Current CPU usage:" >> $OUTPUT_FILE
mpstat 1 1 | tail -n +4 | awk '{print "CPU usage: " $3 "%"}' >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "Top 3 CPU consuming apps:" >> $OUTPUT_FILE
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 4 >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "Current memory usage:" >> $OUTPUT_FILE
free -h | awk 'NR==2{printf "Memory usage: %s of %s\n", $3, $2}' >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "The top three memory hogs are:" >> $OUTPUT_FILE
ps -eo pid,comm,%mem --sort=-%mem | head -n 4 >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
else
echo "The ps command was not found." >> $OUTPUT_FILE
fi

if command -v iostat > /dev/null; then
echo "### I/O Usage" >> $OUTPUT_FILE
echo "The top three I/O-consuming applications are:" >> $OUTPUT_FILE
iostat -xz 1 3 | awk 'NR>3 {print $1, $2, $3, $4, $5, $6}' | sort -k4 -nr | head -n 3 >> $OUTPUT_FILE
echo "I/O-consuming applications are:" >> $OUTPUT_FILE
ps all >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
else
echo "The iostat command was not found." >> $OUTPUT_FILE
fi

echo "## Disk Space Management" >> $OUTPUT_FILE

if command -v df > /dev/null; then
echo "Current disk space status:" >> $OUTPUT_FILE
df -h >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
else
echo "The df command could not be found." >> $OUTPUT_FILE
fi

if command -v du > /dev/null; then
echo "### The three largest files in /var" >> $OUTPUT_FILE
echo "the largest directories" >> $OUTPUT_FILE
du -ah /var 2>/dev/null | sort -rh | head -n 4 >> $OUTPUT_FILE
echo "the largest files" >> $OUTPUT_FILE
find /var -type f -exec du -ah {} + 2>/dev/null | sort -rh | head -n 3 >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
else
echo "The du command could not be found." >> $OUTPUT_FILE
fi

echo "Report complete. Results written to file $OUTPUT_FILE."
```

The final file is a template:

```
# System resource monitoring and disk space management report

## System resource monitoring
### CPU and memory usage
Current CPU usage:
CPU usage: 0,51%
CPU usage: 0,51%

Top 3 CPU consuming apps:
    PID COMMAND         %CPU
 180568 cpptools        16.0
 180485 code             6.6
 180453 code             2.7

Current memory usage:
Memory usage: 2,5Gi of 7,8Gi

The top three memory hogs are:
    PID COMMAND         %MEM
 180568 cpptools         8.0
 180689 dart             6.8
 180485 code             5.1

### I/O Usage
The top three I/O-consuming applications are:
sda 10,36 271,77 2,79 21,23 9,67
31,20 0,00 2,16 1,48 0,00 65,16
sr0 0,00 0,00 0,00 0,00 0,50
I/O-consuming applications are:
F   UID     PID    PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
4     0    1370    1337  20   0 363360 109800 -     Ssl+ tty7       3:14 /usr/lib/xorg/Xorg -core :0 -seat seat0 -auth /var/run/lightdm/root/:0 -nolisten tcp vt7 -novtswitch
4     0    1376       1  20   0  12296  1060 -      Ss+  tty1       0:00 /sbin/agetty -o -p -- \u --noclear tty1 linux
0  1000    2494    2475  20   0  15184  3712 do_sel Ss+  pts/0      0:00 bash
0  1000  180376    2475  20   0  14928  5180 do_wai Ss   pts/1      0:00 bash
0  1000  187390  180376  20   0  13624  3940 do_wai S+   pts/1      0:00 bash submission8.sh
0  1000  187404  187390  20   0  16192  1632 -      R+   pts/1      0:00 ps all

## Disk Space Management
Current disk space status:
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           794M  1,3M  793M   1% /run
/dev/sda3        78G   55G   20G  74% /
tmpfs           3,9G   19M  3,9G   1% /dev/shm
tmpfs           5,0M  4,0K  5,0M   1% /run/lock
/dev/sda2       512M  6,1M  506M   2% /boot/efi
tmpfs           794M  112K  794M   1% /run/user/1000

### The three largest files in /var
the largest directories
6,6G	/var
4,4G	/var/lib
4,0G	/var/lib/snapd
3,2G	/var/lib/snapd/snaps
the largest files
517M	/var/lib/snapd/snaps/gnome-42-2204_202.snap
506M	/var/lib/snapd/snaps/gnome-42-2204_176.snap
401M	/var/lib/snapd/snaps/gnome-3-38-2004_112.snap
```

## Task 2: Hands-on Website Monitoring Setup

**Goal**: Set up real-time monitoring for any website using Checkly. You'll create checks for:

1. Basic availability (does the site load?)
2. Content checks (is a key element visible?)
3. Interaction efficiency (how long does it take to click a button?)
4. Alerts (get notified when something breaks)

### Step 1: Select your website

Select ANY public website you want to monitor (like your favorite store, news site, or portfolio site)

http://www.vbstreets.ru/VB/Articles/66484.aspx was selected

### Step 2: Create Checks in Checkly

1. **Sign up for [Checkly](https://checklyhq.com/)** (free account entry)

![image](https://github.com/user-attachments/assets/a7766186-dd9e-45c2-aafd-1cb8e8488deb)

2. Create an **API Check** for basic accessibility:
- URL: your chosen website
- Assertion: status code 200

![image](https://github.com/user-attachments/assets/7ad9a265-536c-45f8-a9bc-6d4a419e0c55)

![image](https://github.com/user-attachments/assets/f9380bf0-750b-4d0a-9ced-3fdb94207b1d)

3. Create a **Browser Check** for content and interaction:
- URL: same website

![image](https://github.com/user-attachments/assets/722326f7-8672-44c3-acb8-38b39d14d036)

![image](https://github.com/user-attachments/assets/528c408e-8b7b-42d1-ae9c-a8108af6a095)

### Step 3: Set up alerts

Set up **alert rules** YOUR choice:

- What to alert on? (e.g. failed checks, slow latency)
- How to get notified? (email, telegram, etc.)
- Set thresholds that make sense for your site

failed to do

### Step 4: Capture evidence and documentation

1. Run checks manually to make sure they work
2. Take screenshots and add them to `submission8.md` showing:
- Your browser check configuration
- A successful check result
- Your alert settings

Exported code:

```
/**
* This is a Checkly CLI ApiCheck construct. To learn more, visit:
* - https://www.checklyhq.com/docs/cli/
* - https://www.checklyhq.com/docs/cli/constructs-reference/#apicheck
*/

import { ApiCheck, Frequency, AssertionBuilder, RetryStrategyBuilder } from 'checkly/constructs'

new ApiCheck('http-www-vbstreets-ru-vb-articles-66484-aspx', {
  name: 'http://www.vbstreets.ru/VB/Articles/66484.aspx',
  activated: true,
  muted: false,
  shouldFail: false,
  runParallel: true,
  locations: ['eu-north-1', 'eu-central-1', 'us-east-1', 'eu-west-1', 'us-east-2', 'ca-central-1', 'us-west-1', 'us-west-2', 'eu-west-2', 'eu-west-3', 'eu-south-1', 'me-south-1', 'af-south-1', 'ap-southeast-1', 'ap-northeast-1', 'ap-northeast-3', 'ap-east-1', 'ap-southeast-3', 'ap-southeast-2', 'ap-northeast-2', 'ap-south-1'],
  tags: [],
  frequency: Frequency.EVERY_10S,
  environmentVariables: [],
  maxResponseTime: 20000,
  degradedResponseTime: 5000,
  request: {
    url: 'http://www.vbstreets.ru/VB/Articles/66484.aspx',
    method: 'GET',
    followRedirects: true,
    skipSSL: true,
    assertions: [
      AssertionBuilder.statusCode().equals(1),
    ],
    body: ``,
    bodyType: 'NONE',
    headers: [],
    queryParameters: [],
    basicAuth: {
      username: 'test-user',
      password: '',
    },
  },
  retryStrategy: RetryStrategyBuilder.linearStrategy({
    baseBackoffSeconds: 60,
    maxRetries: 2,
    maxDurationSeconds: 600,
    sameRegion: true,
  }),
})
```

### Recommendations

- Use proper Markdown formatting and structure for documentation files.
- Organize files in the lab folder using appropriate naming conventions.
- Create a pull request to the master branch of the repository with your completed lab.

> Note: Actively study SRE and SLA metrics to understand their importance in measuring system reliability.

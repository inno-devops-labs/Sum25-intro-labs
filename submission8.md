# SRE Lab

1. **Monitor System Resources**:

![htop](/img/13.png)
Top 3 CPU: htop(0.7%), /sbin/init, journald

![htop](/img/14.png)
Top 3 memory: containerd(1.3%), multipathd(0.7), journald(0.6)

![htop](/img/15.png)
Top 3 I/O usage: bash, htop, /sbin/init

2. **Disk Space Management**:
![find](/img/16.png)

## Task 2: Practical Website Monitoring Setup

### Step 1: Choose Your Website

https://ya.ru

### Step 2: Create Checks in Checkly

1. **Sign up at [Checkly](https://checklyhq.com/)** (free account)

![checkly](/img/17.png)

2. Create **API Check** for basic availability:
![checkly](/img/18.png)
3. Create **Browser Check** for content & interactions:
![checkly](/img/19.png)

### Step 3: Set Up Alerts

![checkly](/img/20.png)

### Step 4: Capture Proof & Documentation

![checkly](/img/21.png)
![checkly](/img/22.png)

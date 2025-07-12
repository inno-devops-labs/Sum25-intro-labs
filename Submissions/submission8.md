# Task 1: Key Metrics for SRE and SLAs

1. **Monitor System Resources:**

    Top-3 CPU:
    ![img.png](Images/img_lab8.png)
    
    Top-3 memory:
    ![img_1.png](Images/img1_lab8.png)
    
    I/O usage:
    ![img_2.png](Images/img2_lab8.png)

2. **Disk Space Management:**

    Checking the available space: 
    ![img_3.png](Images/img3_lab8.png)

    Files in the `/var` directory 

    Command: 
    ```commandline
    sudo du -ah /var | sort -rh | head -n 4 > /Users/kristina/Documents/Kristina/large_files.txt
    ```
   
    Result:
    ![img_4.png](Images/img4_lab8.png)

# Task 2: Practical Website Monitoring Setup

1. Choose Your Website

    https://www.postcrossing.com/

2. Create Checks in Checkly

    Create API Check for basic availability

    ![img_5.png](Images/img5_lab8.png)

    Create Browser Check for content & interactions

    ![img_6.png](Images/img6_lab8.png)


3. Set Up Alerts

    ![img_7.png](Images/img7_lab8.png)
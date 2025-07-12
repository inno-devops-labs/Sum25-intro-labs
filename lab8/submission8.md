# Lab 8: SRE 

## Task 1: Key Metrics for SRE and SLAs

#### Disk Space Management

1. Check disk usage for `/var`  
   ```bash
   df -h /var
   ```
   **Output:**  
   ```bash
   Filesystem      Size  Used Avail Use% Mounted on
   /dev/sdd       1007G  2.5G  954G   1% /var
   ```

2. Identify top-3 largest items under `/var`  
   ```bash
   sudo du -ah /var | sort -rh | head -n 4
   ```
   **Output:**  
   ```bash
   1.4G    /var
   605M    /var/lib
   405M    /var/log
   398M    /var/log/journal/ec74d31f02584090a2331f53c474d2ec
   ```

**Analysis:**  
- `/var/log` and its journal directory consume the most space.  
- Regular log rotation or cleanup is needed to manage disk usage.
<img width="1600" height="370" alt="image" src="https://github.com/user-attachments/assets/52d09e05-6c61-4a39-87b9-d3a35325bcc7" />

<img width="1045" height="196" alt="image" src="https://github.com/user-attachments/assets/f45e81fe-3327-4b23-86db-8004f2033982" />




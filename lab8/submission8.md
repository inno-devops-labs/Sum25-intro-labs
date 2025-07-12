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


## Task 2: Website Monitoring with Checkly

### API Check configuration
<img width="1310" height="638" alt="image" src="https://github.com/user-attachments/assets/b20ec589-e5b2-48ea-a9b7-dc99cbeb8641" />


### Browser Check code & assertion
```js
test('visit Apple homepage', async ({ page }) => {
  const response = await page.goto(process.env.ENVIRONMENT_URL || 'https://www.apple.com/');
  expect(response.status(), 'status should be 200').toBe(200);
  await expect(page).toHaveTitle(/Apple/);
  await page.screenshot({ path: 'screenshots/browser_ok.png' });
});
<img width="1783" height="619" alt="image" src="https://github.com/user-attachments/assets/26da430b-9073-4635-af47-ac97fd9f4793" />

### Alert setting
<img width="1645" height="853" alt="image" src="https://github.com/user-attachments/assets/7ba0249c-04dc-448b-a2a8-20fcbbe6b5db" />


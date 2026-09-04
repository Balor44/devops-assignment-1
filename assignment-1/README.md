# System Diagnostic Toolkit


This toolkit is a collection of Bash scripts designed to report on the local system. It includes utilities to gather live system specifications, monitor disk space against usage thresholds, and verify network connectivity and port status.


## How to Run the Scripts
Before executing any script, ensure it has runnable permissions by using `chmod +x filename.sh`. 


*   **System Information (`system-info.sh`):** Gathers and prints live data about the operating system, user, memory, and CPU.
    ```bash
    ./system-info.sh
    ```
*   **Disk Check (`disk-check.sh`):** Checks if disk usage exceeds a defined limit. It requires a numeric threshold as the first argument and accepts an optional directory path as the second argument[cite: 1].
    ```bash
    ./disk-check.sh 80 /home
    ```
*   **Network Check (`network-check.sh`):** Resolves a hostname to an IP address, runs a connectivity ping test, and optionally checks an open port[cite: 1].
    ```bash
    ./network-check.sh google.com 443
    ```


## Running the Tests
To verify the scripts against the assignment criteria, execute the provided grader script[cite: 1]:
```bash
chmod +x grade.sh
./grade.sh


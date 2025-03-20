# Beginner DevOps Projects

## Project 1: Server Performance Statistics Script
(https://roadmap.sh/projects/server-stats)

### Overview
The `server-stats.sh` script is a comprehensive server monitoring tool that provides real-time information about various system metrics. This script is designed to work on any Linux server and provides detailed insights into system performance, resource usage, and system status.

### Features
The script provides the following information:

1. **System Information**
   - Operating System Version
   - Kernel Version
   - Hostname
   - System Uptime
   - Load Average
   - Number of Logged-in Users
   - Failed Login Attempts

2. **CPU Information**
   - Total CPU Usage (percentage)
   - Number of CPU Cores
   - CPU Model Details

3. **Memory Usage**
   - Total Memory
   - Used Memory
   - Free Memory
   - Memory Usage Percentage

4. **Disk Usage**
   - Total Disk Space
   - Used Disk Space
   - Free Disk Space
   - Disk Usage Percentage

5. **Process Information**
   - Top 5 CPU-consuming Processes
   - Top 5 Memory-consuming Processes

6. **Network Information**
   - System IP Addresses (excluding localhost)

7. **System Load**
   - 1-minute Load Average
   - 5-minute Load Average
   - 15-minute Load Average

8. **Swap Usage**
   - Total Swap Space
   - Used Swap Space
   - Free Swap Space

### Prerequisites
- Linux Operating System
- Basic system utilities (top, free, df, ps, etc.)
- Bash shell

### Installation
1. Clone or download the repository
2. Navigate to the Beginner directory
3. Make the script executable:
   ```bash
   chmod +x server-stats.sh
   ```

### Usage
Run the script using:
```bash
./server-stats.sh
```

### Output Format
The script uses color-coded output for better readability:
- 🟢 Green: Main header
- 🟡 Yellow: Section headers
- ⚪ White: Data values

### Technical Details
The script uses various Linux commands and utilities:
- `top`: For CPU usage information
- `free`: For memory and swap usage
- `df`: For disk usage information
- `ps`: For process information
- `ip`: For network information
- `cat /proc/loadavg`: For system load information
- `uname`: For system information
- `who`: For user information
- `lastb`: For failed login attempts

### Notes
- The script requires root privileges for some information (like failed login attempts)
- Some information might vary depending on the Linux distribution
- The script is designed to be lightweight and can be run frequently without significant system impact

### Future Enhancements
Potential improvements could include:
- Historical data tracking
- Alert thresholds for critical metrics
- Export functionality for data analysis
- Web interface for remote monitoring
- Custom metric collection based on user needs 
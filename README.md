# DevOps Projects Collection

## Projects Overview

| Project Name | Difficulty | Description | Link |
|-------------|------------|-------------|------|
| Server Stats | Beginner | A comprehensive server monitoring tool that provides real-time information about various system metrics. | [Details](#server-performance-statistics-script) |
| Log Archive | Beginner | A tool to archive logs on a set schedule by compressing them and storing them in a new directory. | [Details](#log-archive-tool) |
| Nginx Log Analyzer | Beginner | A tool to analyze Nginx access logs and provide various statistics about requests, IPs, and response codes. | [Details](#nginx-log-analyzer) |
| GitHub Pages Deployment | Beginner | A GitHub Actions workflow to automatically deploy a static website to GitHub Pages. | [Details](#github-pages-deployment) |
| SSH Remote Server Setup | Beginner | A guide for setting up SSH access to a remote server with multiple SSH keys for secure authentication. | [Details](#ssh-remote-server-setup) |

## Project Details

### Server Performance Statistics Script
[Project Link](https://roadmap.sh/projects/server-stats)

#### Overview
The `server-stats.sh` script is a comprehensive server monitoring tool that provides real-time information about various system metrics. This script is designed to work on any Linux server and provides detailed insights into system performance, resource usage, and system status.

#### Features
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

#### Prerequisites
- Linux Operating System
- Basic system utilities (top, free, df, ps, etc.)
- Bash shell

#### Installation
1. Clone or download the repository
2. Make the script executable:
   ```bash
   chmod +x server-stats.sh
   ```

#### Usage
Run the script using:
```bash
./server-stats.sh
```

### Log Archive Tool
[Project Link](https://roadmap.sh/projects/log-archive-tool)

#### Overview
A command-line tool designed to archive logs by compressing them and storing them in a new directory. This tool helps maintain system cleanliness while preserving logs in a compressed format for future reference.

#### Features
- Compress logs into tar.gz format
- Timestamp-based archive naming
- Archive history logging
- Directory existence validation
- Archive size reporting

#### Prerequisites
- Linux/Unix-based system
- Bash shell
- Basic system utilities (tar, date, du)

#### Installation
1. Clone or download the repository
2. Make the script executable:
   ```bash
   chmod +x log-archive.sh
   ```

#### Usage
Run the script with a log directory as an argument:
```bash
./log-archive.sh <log-directory>
```

Example:
```bash
./log-archive.sh /var/log
```

#### Output
- Creates a `logs_archive` directory
- Generates timestamped archives (e.g., `logs_archive_20240816_100648.tar.gz`)
- Maintains an `archive_history.log` file with archive creation records
- Displays archive size and status

#### Notes
- The script requires read permissions for the log directory
- Archives are stored in a `logs_archive` directory in the current working directory
- Each archive operation is logged in `archive_history.log`

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

### Nginx Log Analyzer
[Project Link](https://roadmap.sh/projects/nginx-log-analyser)

#### Overview
A command-line tool designed to analyze Nginx access logs and provide various statistics about requests, IPs, and response codes. This tool helps in understanding web server traffic patterns and identifying potential issues.

#### Features
- Top 5 IP addresses with the most requests
- Top 5 most requested paths
- Top 5 response status codes
- Top 5 user agents
- Additional statistics:
  - Total number of requests
  - Total unique IPs
  - Total unique paths
  - Total unique user agents
- Response code distribution

#### Prerequisites
- Linux/Unix-based system
- Bash shell
- Basic system utilities (awk, sort, uniq, head)

#### Installation
1. Clone or download the repository
2. Make the script executable:
   ```bash
   chmod +x nginx-log-analyzer.sh
   ```

#### Usage
Run the script with a log file as an argument:
```bash
./nginx-log-analyzer.sh <log-file>
```

Example:
```bash
./nginx-log-analyzer.sh /var/log/nginx/access.log
```

#### Output Format
The script provides color-coded output:
- 🟡 Yellow: Section headers
- 🟢 Green: Statistics and results
- 🔴 Red: Error messages

#### Technical Details
The script uses various Unix commands:
- `awk`: For text processing and field extraction
- `sort`: For sorting data
- `uniq`: For counting unique occurrences
- `head`: For limiting output to top 5
- `wc`: For counting lines and unique entries

### GitHub Pages Deployment
[Project Link](https://roadmap.sh/projects/github-actions-deployment-workflow)

#### Overview
A GitHub Actions workflow that automatically deploys a static website to GitHub Pages whenever changes are made to the index.html file. This project demonstrates continuous deployment using GitHub's built-in CI/CD capabilities.

#### Features
- Automated deployment to GitHub Pages
- Path-specific triggering (only deploys when index.html changes)
- Simple static website showcase
- Demonstration of GitHub Actions workflow

#### Prerequisites
- GitHub account
- Repository with GitHub Pages enabled
- Basic understanding of YAML and GitHub Actions

#### Implementation Details
The project consists of three main components:

1. **Static Website (index.html)**
   - A simple HTML page that displays information about the DevOps projects
   - Styled with CSS for better presentation
   - Contains a list of the projects in this repository

2. **GitHub Actions Workflow (.github/workflows/static.yml)**
   - Triggered only when changes to index.html are pushed to the main branch
   - Sets up the necessary environment for deployment
   - Builds the site by copying files to the _site directory
   - Deploys the built site to GitHub Pages

3. **Repository Configuration**
   - GitHub repository needs to have Pages enabled
   - Permissions for GitHub Actions to deploy Pages

#### How It Works
1. When a change is pushed to the index.html file in the main branch, the workflow is triggered
2. The workflow checks out the repository contents
3. It sets up Node.js and other dependencies
4. It prepares the site by copying files to a build directory
5. Finally, it deploys the built site to GitHub Pages

#### Viewing the Deployed Site
Once deployed, the site can be viewed at: https://[username].github.io/[repository-name]/

#### Notes
- The first deployment may take a few minutes to become available
- GitHub Pages deployment requires the repository to have GitHub Pages enabled in the settings
- The workflow requires appropriate permissions to deploy to GitHub Pages

#### Future Enhancements
- Add a custom domain
- Implement a static site generator like Jekyll or Hugo
- Add more interactive features to the website
- Implement testing before deployment

### SSH Remote Server Setup
[Project Link](https://roadmap.sh/projects/ssh-remote-server-setup)

#### Overview
This project provides a guide for setting up SSH access to a remote Linux server with multiple SSH keys. It demonstrates how to configure both the server and client sides for secure SSH authentication.

#### Features
- Generation of multiple SSH key pairs
- Server-side SSH configuration
- Client-side SSH configuration
- Security hardening with Fail2Ban (stretch goal)
- Convenient SSH access using aliases

#### Prerequisites
- A Linux server (uses LinuxZoo.net for practice)
- SSH client (built into Linux/macOS, or use PuTTY/Windows Terminal on Windows)
- Basic command line knowledge

#### Implementation Details
The project includes:

1. **SSH Key Generation**
   - RSA key pair (4096-bit)
   - ED25519 key pair (more modern and secure)

2. **Server Configuration**
   - Setting up the `.ssh` directory with proper permissions
   - Adding public keys to `authorized_keys`
   - Configuring SSH daemon settings

3. **Client Configuration**
   - Setting up the SSH config file for convenient access
   - Creating aliases for different keys

4. **Fail2Ban Setup (Stretch Goal)**
   - Installation and configuration of Fail2Ban
   - Protection against brute force attacks

#### Usage
Detailed step-by-step instructions are provided in the [ssh-remote-server-setup.md](ssh-remote-server-setup.md) file, covering:

1. How to generate SSH keys
2. How to connect to a remote server
3. How to add keys to the server
4. How to configure the SSH client
5. How to test connections with different keys

#### Security Considerations
- Proper file permissions for SSH files
- Using strong encryption algorithms
- Implementing Fail2Ban for additional security
- Best practices for SSH configuration

#### Notes
- This implementation uses LinuxZoo.net as a safe environment for practice
- The approach works for any Linux/Unix server
- The guide includes troubleshooting tips for common issues 
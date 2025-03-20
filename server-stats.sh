#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print header
echo -e "${GREEN}=== Server Performance Statistics ===${NC}\n"

# System Information
echo -e "${YELLOW}=== System Information ===${NC}"
echo "OS Version: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
echo "Kernel Version: $(uname -r)"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(cat /proc/loadavg | awk '{print $1", "$2", "$3}')"
echo "Logged in Users: $(who | wc -l)"
echo "Failed Login Attempts: $(lastb | wc -l)"
echo

# CPU Usage
echo -e "${YELLOW}=== CPU Usage ===${NC}"
echo "Total CPU Usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')%"
echo "CPU Cores: $(nproc)"
echo "CPU Model: $(lscpu | grep "Model name" | cut -f 2 -d ":" | sed 's/^[ \t]*//')"
echo

# Memory Usage
echo -e "${YELLOW}=== Memory Usage ===${NC}"
total_mem=$(free -h | grep Mem | awk '{print $2}')
used_mem=$(free -h | grep Mem | awk '{print $3}')
free_mem=$(free -h | grep Mem | awk '{print $4}')
mem_percent=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

echo "Total Memory: $total_mem"
echo "Used Memory: $used_mem"
echo "Free Memory: $free_mem"
echo "Memory Usage: ${mem_percent%.2f}%"
echo

# Disk Usage
echo -e "${YELLOW}=== Disk Usage ===${NC}"
df -h / | tail -1 | awk '{print "Total Space: " $2 "\nUsed Space: " $3 "\nFree Space: " $4 "\nUsage: " $5}'
echo

# Top 5 CPU Processes
echo -e "${YELLOW}=== Top 5 CPU Processes ===${NC}"
ps aux --sort=-%cpu | head -n 6 | awk '{print $1"\t"$2"\t"$3"%\t"$11}'
echo

# Top 5 Memory Processes
echo -e "${YELLOW}=== Top 5 Memory Processes ===${NC}"
ps aux --sort=-%mem | head -n 6 | awk '{print $1"\t"$2"\t"$4"%\t"$11}'
echo

# Network Information
echo -e "${YELLOW}=== Network Information ===${NC}"
echo "IP Addresses:"
ip addr show | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}'
echo

# System Load
echo -e "${YELLOW}=== System Load ===${NC}"
echo "1 minute: $(cat /proc/loadavg | awk '{print $1}')"
echo "5 minutes: $(cat /proc/loadavg | awk '{print $2}')"
echo "15 minutes: $(cat /proc/loadavg | awk '{print $3}')"
echo

# Swap Usage
echo -e "${YELLOW}=== Swap Usage ===${NC}"
free -h | grep Swap | awk '{print "Total Swap: " $2 "\nUsed Swap: " $3 "\nFree Swap: " $4}' 
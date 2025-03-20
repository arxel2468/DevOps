#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if log file is provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: Please provide a log file path${NC}"
    echo "Usage: $0 <log-file>"
    exit 1
fi

LOG_FILE="$1"

# Check if file exists
if [ ! -f "$LOG_FILE" ]; then
    echo -e "${RED}Error: File '$LOG_FILE' does not exist${NC}"
    exit 1
fi

# Function to print section header
print_header() {
    echo -e "\n${YELLOW}=== $1 ===${NC}"
}

# Function to analyze and print top 5
analyze_and_print() {
    local title="$1"
    local awk_pattern="$2"
    
    print_header "$title"
    awk "$awk_pattern" "$LOG_FILE" | \
    sort -rn | \
    head -n 5 | \
    while read -r count item; do
        echo -e "${GREEN}$item - $count requests${NC}"
    done
}

# Analyze IP addresses
analyze_and_print "Top 5 IP addresses with the most requests" \
    '{print $1}' | \
    sort | uniq -c | \
    awk '{print $1, $2}'

# Analyze requested paths
analyze_and_print "Top 5 most requested paths" \
    '{print $7}' | \
    sort | uniq -c | \
    awk '{print $1, $2}'

# Analyze response status codes
analyze_and_print "Top 5 response status codes" \
    '{print $9}' | \
    sort | uniq -c | \
    awk '{print $1, $2}'

# Analyze user agents
analyze_and_print "Top 5 user agents" \
    '{print $12}' | \
    sort | uniq -c | \
    awk '{print $1, $2}'

# Additional statistics
print_header "Additional Statistics"
echo -e "${GREEN}Total number of requests:${NC} $(wc -l < "$LOG_FILE")"
echo -e "${GREEN}Total unique IPs:${NC} $(awk '{print $1}' "$LOG_FILE" | sort -u | wc -l)"
echo -e "${GREEN}Total unique paths:${NC} $(awk '{print $7}' "$LOG_FILE" | sort -u | wc -l)"
echo -e "${GREEN}Total unique user agents:${NC} $(awk '{print $12}' "$LOG_FILE" | sort -u | wc -l)"

# Response code distribution
print_header "Response Code Distribution"
awk '{print $9}' "$LOG_FILE" | \
    sort | uniq -c | \
    sort -rn | \
    while read -r count code; do
        echo -e "${GREEN}$code - $count requests${NC}"
    done 
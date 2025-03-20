#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if directory argument is provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: Please provide a log directory path${NC}"
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR="$1"

# Check if directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo -e "${RED}Error: Directory '$LOG_DIR' does not exist${NC}"
    exit 1
fi

# Create archive directory if it doesn't exist
ARCHIVE_DIR="logs_archive"
if [ ! -d "$ARCHIVE_DIR" ]; then
    mkdir -p "$ARCHIVE_DIR"
fi

# Generate timestamp for archive name
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="$ARCHIVE_DIR/$ARCHIVE_NAME"

# Create archive
echo -e "${YELLOW}Creating archive of logs from $LOG_DIR...${NC}"
tar -czf "$ARCHIVE_PATH" -C "$(dirname "$LOG_DIR")" "$(basename "$LOG_DIR")"

# Check if archive was created successfully
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Successfully created archive: $ARCHIVE_PATH${NC}"
    
    # Log the archive creation
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Created archive: $ARCHIVE_PATH" >> "$ARCHIVE_DIR/archive_history.log"
    
    # Display archive size
    ARCHIVE_SIZE=$(du -h "$ARCHIVE_PATH" | cut -f1)
    echo -e "${GREEN}Archive size: $ARCHIVE_SIZE${NC}"
else
    echo -e "${RED}Failed to create archive${NC}"
    exit 1
fi 
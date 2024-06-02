#!/bin/bash

CONFIG_FILE="RemoteRsync.conf"

# Function to load configuration from file
load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
    fi
}

# Function to ask user for input and save it to config file
ask_and_store() {
    read -p "Enter source directory: " SRC_DIR
    read -p "Enter destination username: " DEST_USER
    read -p "Enter destination host: " DEST_HOST
    read -p "Enter destination directory: " DEST_DIR
    read -p "Enter log file path: " LOG_FILE
    
    # Save configuration to file
    cat > "$CONFIG_FILE" <<EOL
SRC_DIR="${SRC_DIR}"
DEST_USER="${DEST_USER}"
DEST_HOST="${DEST_HOST}"
DEST_DIR="${DEST_DIR}"
LOG_FILE="${LOG_FILE}"
EOL
}

# Load existing configuration
load_config

# Check if any configuration variables are missing
if [ -z "$SRC_DIR" ] || [ -z "$DEST_USER" ] || [ -z "$DEST_HOST" ] || [ -z "$DEST_DIR" ] || [ -z "$LOG_FILE" ]; then
    # Ask for input and store it if any variable is missing
    ask_and_store
fi

# Function to sync with rsync and resume if needed
sync_rsync() {
    rsync -avz --partial --progress --log-file="$LOG_FILE" "$SRC_DIR" "${DEST_USER}@${DEST_HOST}:${DEST_DIR}"
}

# Start the sync process
sync_rsync

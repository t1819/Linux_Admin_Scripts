#!/bin/bash

# Initialize variables
ServerIP="IP"
email="Email Address"
nrpe_plugin="/usr/lib64/nagios/plugins/check_nrpe"
snapshot_dir="/tmp"
current_date=$(date +%F)  # Use ISO 8601 date format for better compatibility
current_time=$(date +%H:%M:%S)  # Use time format for better readability

# Validate email address (simple regex for demonstration; in real apps, consider more robust validation)
if ! [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Invalid email address: $email"
    exit 1
fi

# Function to take snapshot and send email
take_snapshot_and_send_email() {
    local severity="$1"
    local snapshot_file="$snapshot_dir/demo_$current_date.txt"

    # Run check_nrpe command and write output to the snapshot file
    if ! $nrpe_plugin -H "$ServerIP" -c processes_snapshot > "$snapshot_file"; then
        echo "Failed to capture process snapshot from $ServerIP"
        exit 1
    fi

    # Send email with the snapshot data
    if ! /usr/bin/mail -s "$severity - $ServerIP Server running process logs $current_date $current_time" "$email" < "$snapshot_file"; then
        echo "Failed to send email to $email"
        exit 1
    fi
}

# Get the service status from check_nrpe command
service_status=$($nrpe_plugin -H "$ServerIP" -c check_load 2>/dev/null | cut -d '-' -f1)

# Check if the service status retrieval was successful
if [ -z "$service_status" ]; then
    echo "Failed to retrieve service status from $ServerIP"
    exit 1
fi

# Handle different service statuses using a case statement
case "$service_status" in
    "OK ")
        echo "Service is running ok"
        ;;
    "WARNING ")
        take_snapshot_and_send_email "WARNING"
        ;;
    "CRITICAL ")
        take_snapshot_and_send_email "CRITICAL"
        ;;
    *)
        echo "Unknown service status: $service_status"
        ;;
esac

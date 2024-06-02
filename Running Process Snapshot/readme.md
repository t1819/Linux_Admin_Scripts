# RunningProcessSnapshot.sh

## Table of Contents

1. [Introduction](#introduction)
2. [Purpose](#purpose)
3. [Requirements](#requirements)
4. [Usage](#usage)
5. [Detailed Description](#detailed-description)
6. [Configuration](#configuration)
7. [Error Handling](#error-handling)
8. [License](#license)

## Introduction

`RunningProcessSnapshot.sh` is a Bash script designed to monitor server processes by interfacing with Nagios' NRPE (Nagios Remote Plugin Executor). It checks the load status of a server and, based on the severity of the status (OK, WARNING, CRITICAL), captures a snapshot of the running processes and sends it via email.

## Purpose

The script provides a mechanism for proactive server monitoring by:

- Checking the server's load status.
- Capturing process snapshots for servers facing load-related issues.
- Sending those snapshots to a specified email address for further analysis.

## Requirements

- A Linux-based server or workstation with Bash.
- Nagios NRPE installed on both the monitoring and target servers.
- Mail utility installed (`mail`) for sending email notifications.

## Usage

1. Clone or download the script to your local machine.
2. Update the script variables (e.g., `ServerIP`, `email`, etc.) as per your requirements.
3. Run the script:
   ```sh
   ./RunningProcessSnapshot.sh
   ```

## Detailed Description

### Initialization

The script initializes several variables:

- `ServerIP` - The IP address of the server to monitor.
- `email` - The email address to send alerts to.
- `nrpe_plugin` - Path to the NRPE plugin.
- `snapshot_dir` - Directory to store the snapshot files.
- `current_date` - The current date.
- `current_time` - The current time.

### Email Validation

A simple regex is used to validate the provided email address.

### Snapshot and Email Function

`take_snapshot_and_send_email`:

- Takes a snapshot using NRPE.
- Sends the snapshot via email.

### Service Status Check

- Retrieves the service status using the NRPE plugin.
- Checks the retrieved status and handles different statuses (`OK`, `WARNING`, `CRITICAL`).

### Example

Below is an example of how to update the script with your specific settings:

```sh
ServerIP="192.168.1.100"
email="admin@example.com"
nrpe_plugin="/usr/lib64/nagios/plugins/check_nrpe"
```

## Configuration

1. Define the server IP:
   ```sh
   ServerIP="YourServerIP"
   ```
2. Define the recipient email:
   ```sh
   email="YourEmailAddress"
   ```
3. Ensure the path to `check_nrpe` is correct:
   ```sh
   nrpe_plugin="/usr/lib64/nagios/plugins/check_nrpe"
   ```

## Error Handling

The script includes basic error handling:

- Validates email format.
- Checks the success of NRPE commands.
- Outputs corresponding error messages for failed operations.
- Handles unknown service statuses gracefully.

## License

This script is open-source and can be freely modified and distributed. No warranty is offered; use at your own risk.

# Server Status Check Script

## Overview

`ServerStatusCheck.sh` is a shell script used to monitor the status of specified servers by pinging them and sending an email alert if any server is down.

## Requirements

- Bash shell
- `ping` command
- `mail` command configured to send emails

## Configuration

### Hosts Configuration

The script uses an array named `HOSTS` to store the IP addresses of the servers you want to monitor. Replace `Server1_IP` and `Server2_IP` in the `HOSTS` array with the actual IP addresses of your servers.

```bash
# Array of host IP addresses
HOSTS=(
    "Server1_IP"
    "Server2_IP"
)
```

### Ping Attempt Count

The variable `COUNT` defines the number of ping attempts for each server. You can adjust the value as needed:

```bash
# Number of ping attempts
COUNT=4
```

### Email Configuration

The script uses the `mail` command to send an alert email if a server is detected as down. You need to replace `example@email.com` with your actual email address:

```bash
echo "Host: $myHost is down (ping failed) at $(date)" | mail -s "Alert: $myHost IP is not working" example@email.com
```

Ensure that your system is configured to send emails via the `mail` command.

## Usage

1. **Permission**: Ensure that the script has execution permissions. You can set it using:

   ```bash
   chmod +x ServerStatusCheck.sh
   ```

2. **Execution**: Run the script manually or set it up as a cron job for periodic checks:
   ```bash
   ./ServerStatusCheck.sh
   ```

### Example Cron Job

To run the script every hour, add the following line to your crontab (use `crontab -e` to edit):

```bash
0 * * * * /path/to/ServerStatusCheck.sh
```

## Notes

- Ensure the `mail` command is correctly installed and configured on your system.
- Adjust the ping count and email configurations according to your needs.

## Disclaimer

This script is provided as-is without any warranty or guarantee. Ensure to test it in a safe environment before deploying it on production systems.

---

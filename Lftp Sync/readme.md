# LftpSync.sh

## Overview

`LftpSync.sh` is a Bash script designed to synchronize directories between a local machine and a remote FTP server using `lftp`. The script provides easy-to-configure environment variables, logging capabilities, and error handling.

## Features

- Syncs local directories to remote FTP directories.
- Supports excluding specific files/directories using glob patterns.
- Automatically logs the sync process and errors.
- Can override default configuration using environment variables.

## Prerequisites

- `lftp` must be installed on the local machine.
- A valid FTP server with username and password.

## Environment Variables

The following environment variables can be used to override the default settings:

- `FTP_HOST`: FTP server IP or domain (default: `ServerIP`)
- `FTP_USER`: FTP username (default: `username`)
- `FTP_PASS`: FTP password (default: `password`)
- `LOCAL_DIR`: Local directory to sync (default: `/path/of/your/local/dir`)
- `REMOTE_DIR`: Remote directory to sync to (default: `/path/of/your/remote/dir`)
- `LOG_FILE`: Log file path (default: `lftp_sync.log`)
- `DELETE_OPTION`: Delete option for the mirror command (default: `--delete`)

## Usage

1. **Set the Environment Variables (Optional):**

```bash
export FTP_HOST="your.ftp.server"
export FTP_USER="yourusername"
export FTP_PASS="yourpassword"
export LOCAL_DIR="/your/local/dir"
export REMOTE_DIR="/your/remote/dir"
export LOG_FILE="/path/to/your/logfile.log"
export DELETE_OPTION="--delete"
```

2. **Run the Script:**

```bash
./LftpSync.sh
```

## Logging

- Logs are stored in the file specified by the `LOG_FILE` environment variable (default: `lftp_sync.log`).
- The script logs both the start and completion of the sync process, and any errors encountered.

## Exclusion Rules

The script allows excluding specific files and directories using `--exclude-glob` options in the `lftp mirror` command. Modify these options within the script as needed:

```bash
mirror --reverse \
       $DELETE \
       --verbose \
       --exclude-glob a-dir-to-exclude/ \
       --exclude-glob a-file-to-exclude \
       --exclude-glob a-file-group-to-exclude* \
       --exclude-glob other-files-to-exclude
```

## Error Handling

- The script checks for the presence of `lftp` and exits if it's not installed.
- Sync success or failure is logged, and the script exits with an error code on failure.

## URL Encoding Function

The script includes a `urlencode` function to percent-encode the FTP username and password to handle special characters.

```bash
urlencode() {
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
}
```

## Conclusion

`LftpSync.sh` provides a straightforward and configurable way to synchronize directories with a remote FTP server using `lftp`. Customize the environment variables and exclusion rules as needed for your specific use case.

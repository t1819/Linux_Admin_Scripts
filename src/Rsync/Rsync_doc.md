# RemoteRsync.sh

**RemoteRsync.sh** is a Bash script designed to facilitate the process of synchronizing directories to a remote server using `rsync`. The script offers a user-friendly way to input and store configuration details, making it easy to reuse the settings for future sync operations.

## Features

1. **Configuration Management**: Load configuration from a file (`RemoteRsync.conf`) or prompt the user for input if configuration details are missing.
2. **Seamless Resumption**: Utilizes `rsync` features to resume interrupted transfers, log details of the transaction, and show progress.
3. **Automated Sync**: Automatically initiates the sync process using the configured parameters.

## Installation

1. **Clone Repository**

   ```sh
   git clone <repository_url>
   ```

2. **Navigate to the Script Directory**
   ```sh
   cd <repository_directory>
   ```

## Usage

1. **Make Script Executable**

   ```sh
   chmod +x RemoteRsync.sh
   ```

2. **Run the Script**
   ```sh
   ./RemoteRsync.sh
   ```

## Configuration File

Upon first run, if the configuration details are missing, the script will prompt you to input the necessary details:

- **Source Directory**: The local directory you wish to sync.
- **Destination Username**: The username on the remote host.
- **Destination Host**: The remote host's address.
- **Destination Directory**: The directory on the remote host where the files will be synchronized.
- **Log File Path**: Path to the log file for capturing rsync operations.

These details are saved in the `RemoteRsync.conf` file for future use.

## Example Configuration (`RemoteRsync.conf`)

```sh
SRC_DIR="/path/to/source"
DEST_USER="username"
DEST_HOST="hostname"
DEST_DIR="/path/to/destination"
LOG_FILE="/path/to/logfile"
```

## Notes

- Ensure you have the necessary permissions and correct paths set up for both local and remote directories.
- Verify that `rsync` is installed on both the local and remote systems.
- You may need to configure SSH access to the remote server for this script to work without requiring password inputs each time.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

This readme provides a concise overview and instructions for using the `RemoteRsync.sh` script effectively. Feel free to reach out if you have any questions or need further assistance.

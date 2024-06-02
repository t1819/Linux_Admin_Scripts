# System Update Script

## Overview

This Go script is designed to automate the process of updating an Ubuntu system. It performs several steps to ensure that all installed packages are up-to-date and cleans up any unnecessary files.

## Features

- Updates the package list.
- Upgrades all installed packages.
- Performs a distribution upgrade.
- Removes unnecessary packages.
- Cleans up residual files.

## Prerequisites

- Go installed on your system.
- `sudo` privileges.

## Installation

1. **Clone the repository:**

   ```sh
   git clone <repo_link>
   cd <repo_directory>
   ```

2. **Build the script:**
   ```sh
   go build -o system_update_script system_update_script.go
   ```

## Usage

1. **Run the script:**

   ```sh
   sudo ./system_update_script
   ```

   Make sure to run the script with `sudo` as it requires administrative privileges to execute system updates.

## Configuration

No additional configuration is needed. The script is ready to use out-of-the-box.

## Troubleshooting

- Ensure you have the required permissions by running the script with `sudo`.
- Check the output logs for any specific errors that occur during the execution of the commands.

## License

This project is licensed under the MIT License. Feel free to use and modify it as per your needs.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.

---

Feel free to reach out if you have any questions or need further assistance. Happy updating!

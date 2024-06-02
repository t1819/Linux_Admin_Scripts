# Security Scanning Script

This script runs security audits using Lynis and OSSEC, saves the reports, and ensures the existence of directories for report storage.

## Prerequisites

Before running the script, ensure you have the following:

1. Python 3.x installed.
2. Lynis installed under `/usr/local/lynis/lynis`.
3. OSSEC installed under `/var/ossec/bin/ossec-control`.
4. Appropriate permissions to execute Lynis and OSSEC commands.

## Installation

1. Clone the repository or download the script to your local machine.
2. Ensure the Lynis and OSSEC commands defined in `LYNIS_CMD` and `OSSEC_CMD` are correct paths to your installed Lynis and OSSEC binaries.
3. Ensure you have read/write permissions on `/var/log/lynis-reports` and `/var/log/ossec-reports`.

## Usage

1. Open a terminal and navigate to the directory containing `main.py`.
2. Run the script using Python:

   ```bash
   python main.py
   ```

## Script Overview

- `run_command(command)`: Runs a shell command and captures its output.
- `ensure_dir(directory)`: Ensures that the specified directory exists.
- `save_report(report_content, tool_name, timestamp)`: Saves the report to the corresponding directory.
- `main()`: The main function that coordinates the execution of security scans and report generation.

## Features

1. **Lynis Audit**:

   - Executes a Lynis audit of the system.
   - Stores the output in `/var/log/lynis-reports` with a timestamped filename.

2. **OSSEC Integrity Check**:
   - Restarts OSSEC and checks its status.
   - Stores the output in `/var/log/ossec-reports` with a timestamped filename.

## Directory Structure

```plaintext
.
├── main.py
└── README.md
```

## Log File Structure

- Lynis Reports: `/var/log/lynis-reports/lynis-report-YYYYMMDDHHMMSS.txt`
- OSSEC Reports: `/var/log/ossec-reports/ossec-report-YYYYMMDDHHMMSS.txt`

## Troubleshooting

1. **Permission Denied**: Ensure you have the necessary permissions to execute Lynis and OSSEC commands and write to the log directories.
2. **Command Not Found**: Verify that Lynis and OSSEC paths in `LYNIS_CMD` and `OSSEC_CMD` are correct.
3. **Unknown tool name**: The tool name provided in the `save_report` function must be either "lynis" or "ossec".

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to contribute or open issues for any enhancements or bugs.

Happy Scanning!

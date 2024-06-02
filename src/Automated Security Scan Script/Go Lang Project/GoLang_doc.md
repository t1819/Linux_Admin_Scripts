# Automated Security Scan

## Overview

The `automated_security_scan.go` script is a Go program designed to execute security scans using Lynis and OSSEC, aggregate the output, and generate a security scan report. The report is saved to a file named `security_scan_report.txt`.

## Features

- Runs Lynis security audit.
- Checks the status of OSSEC.
- Generates a consolidated report including the outputs of Lynis and OSSEC.
- Saves the report to `security_scan_report.txt`.

## Prerequisites

- Go programming language installed.
- Lynis installed on the system.
- OSSEC installed and properly configured on the system.

## Usage

### 1. Clone the repository

```sh
git clone https://github.com/yourusername/automated_security_scan.git
cd automated_security_scan
```

### 2. Install Dependencies

Ensure that Lynis and OSSEC are installed on your system.

### 3. Build the Program

```sh
go build -o automated_security_scan
```

### 4. Run the Program

```sh
./automated_security_scan
```

Upon running, the program will:

- Execute a Lynis audit.
- Check the status of OSSEC.
- Combine the results into a report.
- Save the report to `security_scan_report.txt`.

### 5. Check the Report

Open `security_scan_report.txt` to review the security scan report.

## Error Handling

- Errors encountered while running Lynis or OSSEC commands are captured and included in the relevant sections of the report.
- Error while writing the report to a file will be printed to the console.

## Customization

- Modify `runLynis` and `runOSSEC` functions if your Lynis or OSSEC commands require additional or different arguments.
- Adjust the file path if you want to save the report to a different location or with a different name.

## License

This project is licensed under the [MIT License](LICENSE).

## Contributing

Feel free to submit issues and pull requests for improvements.

---

**Note:** This README assumes standard installation paths and configurations for Lynis and OSSEC. Adjust accordingly if your setup differs.

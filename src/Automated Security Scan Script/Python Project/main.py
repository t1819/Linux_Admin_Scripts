import subprocess
import datetime
import os

# Define paths for Lynis and OSSEC
LYNIS_CMD = "/usr/local/lynis/lynis audit system"
OSSEC_CMD = "/var/ossec/bin/ossec-control"

# Define the directories for the reports
LYNIS_REPORT_DIR = "/var/log/lynis-reports"
OSSEC_REPORT_DIR = "/var/log/ossec-reports"


def run_command(command):
    try:
        result = subprocess.run(command, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        return e.stderr


def ensure_dir(directory):
    if not os.path.exists(directory):
        os.makedirs(directory)


def save_report(report_content, tool_name, timestamp):
    if tool_name == "lynis":
        report_file = os.path.join(LYNIS_REPORT_DIR, f"lynis-report-{timestamp}.txt")
    elif tool_name == "ossec":
        report_file = os.path.join(OSSEC_REPORT_DIR, f"ossec-report-{timestamp}.txt")
    else:
        raise ValueError("Unknown tool name")

    with open(report_file, "w") as file:
        file.write(report_content)


def main():
    ensure_dir(LYNIS_REPORT_DIR)
    ensure_dir(OSSEC_REPORT_DIR)

    timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")

    # Run Lynis Scan
    print("Running Lynis Scan...")
    lynis_output = run_command(LYNIS_CMD)
    save_report(lynis_output, "lynis", timestamp)

    # Run OSSEC Scan
    print("Running OSSEC Integrity Check...")
    ossec_output = run_command(f"{OSSEC_CMD} restart")
    ossec_output += run_command(f"{OSSEC_CMD} status")
    save_report(ossec_output, "ossec", timestamp)

    print("Security scans completed. Reports generated.")


if __name__ == "__main__":
    main()

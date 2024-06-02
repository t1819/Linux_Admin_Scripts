import psutil
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError
from dotenv import load_dotenv, set_key
import os

# Load environment variables from .env file
load_dotenv()

# Configuration variables
DISK_PARTITION = '/'
THRESHOLD = 80  # Percentage
SLACK_CHANNEL = '#your-channel'

def get_or_set_slack_token():
    """Prompt for the Slack token if not already set in the .env file, and store it."""
    slack_token = os.getenv("SLACK_TOKEN")
    if not slack_token:
        slack_token = input("Enter your Slack token: ")
        set_key(".env", "SLACK_TOKEN", slack_token)
    return slack_token

# Get or set the Slack token
SLACK_TOKEN = get_or_set_slack_token()

# Initialize Slack client
client = WebClient(token=SLACK_TOKEN)

def check_disk_usage(partition):
    """Check the disk usage of the given partition."""
    usage = psutil.disk_usage(partition)
    return usage.percent

def send_alert_to_slack(usage):
    """Send an alert to Slack if disk usage exceeds the threshold."""
    message = f"Warning: Disk usage has exceeded {THRESHOLD}%. Current usage is {usage}%."
    try:
        response = client.chat_postMessage(channel=SLACK_CHANNEL, text=message)
    except SlackApiError as e:
        print(f"Error sending alert to Slack: {e.response['error']}")

def main():
    """Main function to check disk usage and send alert if necessary."""
    usage = check_disk_usage(DISK_PARTITION)
    if usage > THRESHOLD:
        send_alert_to_slack(usage)

if __name__ == "__main__":
    main()

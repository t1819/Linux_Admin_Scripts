# Disk Space Monitoring with Slack Alerts

This script monitors the disk space usage on a specified partition and sends an alert to a designated Slack channel when the usage exceeds a predefined threshold.

## Prerequisites

- Python 3.x
- Required Python packages: `psutil`, `slack_sdk`, `python-dotenv`
- Slack API Token and channel to receive alerts

## Installation

1. Clone the repository or download the script.

2. Install the required packages using pip:

   ```sh
   pip install psutil slack_sdk python-dotenv
   ```

3. Create a `.env` file in the root of your project directory:

   ```env
   SLACK_TOKEN=your-slack-bot-token
   ```

## Configuration

- `DISK_PARTITION`: The disk partition to monitor. Default is `/`.
- `THRESHOLD`: The disk usage percentage that triggers an alert. Default is `80`.
- `SLACK_CHANNEL`: The Slack channel where alerts will be sent.

Update these variables directly in the script as needed.

## Usage

Run the script:

```sh
python Disk_Space_Monitoring_Slack.py
```

## Functionality

- The script loads environment variables from the `.env` file.
- It checks the disk usage of the specified partition.
- If the disk usage exceeds the threshold, it sends an alert to the specified Slack channel.
- If the Slack token is not set in the `.env` file, it prompts the user to enter it and saves it in the `.env` file.

## Notes

- Ensure that the Slack app has the necessary permissions to post messages in the specified channel.
- If you encounter a `SlackApiError`, the script will print the error.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License.

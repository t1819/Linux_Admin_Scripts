#!/bin/bash    


# Set default variables and provide ability to override via environment variables
HOST="${FTP_HOST:-ServerIP}"
USER="${FTP_USER:-username}"
PASS="${FTP_PASS:-password}"
LCD="${LOCAL_DIR:-/path/of/your/local/dir}"
RCD="${REMOTE_DIR:-/path/of/your/remote/dir}"

# Define log file
LOG_FILE="${LOG_FILE:-lftp_sync.log}"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

DELETE="${DELETE_OPTION:---delete}"

# Function to log messages
log(){
  echo "$DATE - $1" >> $LOG_FILE
}

# Check for required commands
command -v lftp >/dev/null 2>&1 || { echo >&2 "lftp is required but it's not installed. Exiting."; exit 1; }

# Generate FTP URL securely when possible
FTPURL="ftp://$(urlencode "$USER"):$(urlencode "$PASS")@$HOST"

# Perform sync
log "Starting sync process"
{
  lftp -c "set ftp:list-options -a;
  open '$FTPURL';
  lcd $LCD;
  cd $RCD;
  mirror --reverse \
         $DELETE \
         --verbose \
         --exclude-glob a-dir-to-exclude/ \
         --exclude-glob a-file-to-exclude \
         --exclude-glob a-file-group-to-exclude* \
         --exclude-glob other-files-to-exclude"
} >> $LOG_FILE 2>&1

# Check if the lftp command succeeded
if [ $? -eq 0 ]; then
    log "Sync completed successfully"
else
    log "Sync failed"
    exit 1
fi

log "Script execution finished"

# Function to percent-encode URL components
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


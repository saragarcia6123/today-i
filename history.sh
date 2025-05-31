#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_PATH=$(jq -r '.config.path' "$SCRIPT_DIR/defaults.json")
CONFIG_PATH="${CONFIG_PATH/\$HOME/$HOME}"

LOG_FILE="$CONFIG_PATH/log.csv"

time_window=$(jq -r '.history.window' "$SCRIPT_DIR/defaults.json")
time_unit=$(jq -r '.history.units' "$SCRIPT_DIR/defaults.json")

HELP_FILE="$SCRIPT_DIR/help/history.txt"

while getopts ":t:f:" opt; do
    case $opt in
      t)
        time_window=$OPTARG
        ;;
      f)
        if [[ "$OPTARG" != "h" && "$OPTARG" != "d" ]]; then
            echo "Invalid time unit: $OPTARG"
            cat "$HELP_FILE"
            exit 1
        fi
        time_unit=$OPTARG
        ;;
      \?)
        echo "Invalid option: -$OPTARG"
        cat "$HELP_FILE"
        exit 1
        ;;
      :)
        echo "Option -$OPTARG requires an argument."
        cat "$HELP_FILE"
        exit 1
        ;;
    esac
done

now=$(date +%s)

if [ "$time_unit" == "d" ]; then
    cutoff=$(( now - time_window*24*3600 ))
else
    cutoff=$(( now - time_window*3600 ))
fi

echo "Showing logs since $(date -d @$cutoff):"
echo -e "\n"

# Filter LOG_FILE entries newer than cutoff timestamp
awk -F, -v cutoff="$cutoff" '
BEGIN {
  # Print header
  printf "%-19s | %-10s | %s\n", "TIMESTAMP", "REPOSITORY", "MESSAGE"
  print "--------------------|------------|----------------"
}
{
  # Convert $1 (epoch seconds) to YYYY/MM/DD format
  formatted_time = strftime("%Y/%m/%d %H:%M:%S", $1)

  # Check cutoff (assuming cutoff is defined in the shell environment or earlier in awk)
  if ($1 >= cutoff) {
    printf "%-19s | %-10s | %s\n", formatted_time, $2, $3
  }
}' "$LOG_FILE"

echo -e "\n"
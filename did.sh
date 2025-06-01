#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_PATH=$(jq -r '.config.path' "$SCRIPT_DIR/defaults.json")
CONFIG_PATH="${CONFIG_PATH/\$HOME/$HOME}"

HELP_FILE="$SCRIPT_DIR/help/did.txt"

LOG_FILE="$CONFIG_PATH/log.csv"

mkdir -p "$CONFIG_PATH"
touch "$LOG_FILE"

message=""
commit=$(jq -r '.did.commit' "$SCRIPT_DIR/defaults.json")
push=$(jq -r '.did.push' "$SCRIPT_DIR/defaults.json")

# Read arguments
while getopts ":m:r:c:p:" opt; do
  case $opt in
  m)
    message=$OPTARG
    ;;
  r)
    repo=$OPTARG
    ;;
  c)
    commit=$OPTARG
    ;;
  p)
    push=$OPTARG
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

if [ "$message" == "" ]; then
  echo "Message cannot be empty."
  exit 1
fi


timestamp=$(date +%s)

echo "$timestamp,$repo,$message" >> "$LOG_FILE"
echo "Logged: $message"

"$SCRIPT_DIR/cron.sh"

if [ "$commit" == "true" ]; then
    "$SCRIPT_DIR/commit.sh"
fi

if [ "$push" == "true" ]; then
    "$SCRIPT_DIR/push.sh"
fi
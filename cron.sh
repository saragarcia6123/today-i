#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CRON_SCHEDULE=$(jq -r '.cron.schedule' "$SCRIPT_DIR/defaults.json")

CRON_CMD="today-i commit && today-i push"

# Check if job exists
if crontab -l 2>/dev/null | grep -Fq -- "$CRON_CMD"; then
  exit 0
fi

# Add the job
(
  crontab -l 2>/dev/null
  echo "$CRON_SCHEDULE $CRON_CMD"
) | crontab - 2>/dev/null

echo "Cron job installed."


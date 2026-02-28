#!/bin/bash
set -e

echo "Setting up Agent Done Notifier..."

# List of available agent-done-tags for notifications
AGENT_DONE_TAGS=(
  "Done."
  "Action complete."
  "Task finished."
  "Complete."
  "Finished."
  "Work done."
  "Ready for review."
)

# Pick a random agent-done-tag
RANDOM_TAG=${AGENT_DONE_TAGS[$RANDOM % ${#AGENT_DONE_TAGS[@]}]}

# Default ntfy topic
DEFAULT_TOPIC="agent-done-k9x3mq"

# Check if NTFY_TOPIC is already set
if [ -z "$NTFY_TOPIC" ]; then
  NTFY_TOPIC="$DEFAULT_TOPIC"
fi

# Create .env file with configuration
cat > .env << EOF
# Agent Done Notifier Configuration
NTFY_TOPIC=$NTFY_TOPIC
NTFY_TITLE=Agent Update
NTFY_PRIORITY=high
NTFY_TAGS=white_check_mark,robot
AGENT_DONE_TAG="$RANDOM_TAG"
EOF

echo ""
echo "=== Setup Complete ==="
echo "Agent-done-tag: $RANDOM_TAG"
echo "Ntfy topic: $NTFY_TOPIC"
echo ""
echo "Next steps:"
echo "1. Subscribe to topic '$NTFY_TOPIC' in the ntfy app on your phone"
echo "2. Test with: bash scripts/message.sh 'test notification'"
echo ""

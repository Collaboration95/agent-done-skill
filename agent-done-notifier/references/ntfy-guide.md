# ntfy.sh Push Notification Implementation

This guide documents the complete implementation of the push notification system using ntfy.sh.

## Overview

The notification system provides a zero-infrastructure solution for sending push notifications when tasks are completed. Uses ntfy.sh, a free and open-source pub/sub notification service.

## Implementation Details

### Components

Two notification scripts are provided in the `scripts/` directory:

#### 1. message.sh (Bash)
- Native bash implementation
- Minimal dependencies
- POSTs message to ntfy.sh endpoint
- Fails silently on network errors

#### 2. message.py (Python)
- Python 3 with stdlib only
- No pip dependencies required
- Supports command-line flags
- POSTs message to ntfy.sh endpoint
- Fails silently on network errors

### Configuration

Both scripts support configuration via environment variables:

| Environment Variable | Default | Purpose |
|---------------------|---------|---------|
| `NTFY_TOPIC` | `agent-done-k9x3mq` | ntfy.sh topic identifier |
| `NTFY_TITLE` | `Agent Update` | Notification title |
| `NTFY_PRIORITY` | `high` | Priority level: min/low/default/high/urgent |
| `NTFY_TAGS` | `white_check_mark,robot` | Notification tags (emoji shortcodes) |

### Setup Instructions

1. Clone this repository
2. Run setup script: `bash scripts/setup.sh` (selects random agent-done-tag)
3. Subscribe to the ntfy topic on your phone:
   - Install ntfy app (iOS or Android)
   - Subscribe to the topic displayed by setup script
4. Test with: `bash scripts/message.sh "test notification"`

### Usage Examples

#### Bash Script
```bash
bash scripts/message.sh "Refactored auth module — tests pass"
bash scripts/message.sh "PR #42 opened — ready for review"
```

With custom environment variables:
```bash
NTFY_TOPIC=my-topic NTFY_PRIORITY=urgent bash scripts/message.sh "Critical fix deployed"
```

#### Python Script
```bash
python3 scripts/message.py "Task completed successfully"
python3 scripts/message.py "Custom message" --title "Build Done" --priority urgent --tags "warning,robot"
```

### Network Error Handling

Both scripts implement silent failure on network errors:
- Scripts will never block or interrupt workflow
- Error messages are suppressed from stdout
- Confirmation message printed only on successful send
- Timeout set to 10 seconds for network requests

### Integration with Agents

The notification system is designed to work seamlessly with AI agents:

1. Agent completes task
2. Agent executes notification script as final step
3. User receives push notification on phone
4. No user intervention required

## Architecture

```
User Task Completion
       ↓
   Agent executes scripts/message.sh or scripts/message.py
       ↓
   POST to https://ntfy.sh/<topic>
       ↓
   ntfy.sh delivers to all subscribers
       ↓
   User receives push notification on phone
```

## Notes

- Public topics on ntfy.sh are free and require no authentication
- For sensitive projects, consider using private topics with authentication
- Topic can be customized via NTFY_TOPIC environment variable
- Default topic is configured in scripts but should be changed for production use

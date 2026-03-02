## Overview

The notification system provides a zero-infrastructure solution for sending push notifications when tasks are completed. Uses ntfy.sh, a free and open-source pub/sub notification service.

## Implementation Details

### Components

A notification script is provided in the `scripts/` directory:

#### message.sh (Bash)

- Native bash implementation
- Minimal dependencies
- POSTs message to ntfy.sh endpoint
- Fails silently on network errors

### Configuration

The script supports configuration via environment variables:

| Environment Variable | Default                  | Purpose                                     |
| -------------------- | ------------------------ | ------------------------------------------- |
| `NTFY_TOPIC`         | `agent-done-k9x3mq`      | ntfy.sh topic identifier                    |
| `NTFY_TITLE`         | `Agent Update`           | Notification title                          |
| `NTFY_PRIORITY`      | `high`                   | Priority level: min/low/default/high/urgent |
| `NTFY_TAGS`          | `white_check_mark,robot` | Notification tags (emoji shortcodes)        |

```bash
bash scripts/message.sh "Refactored auth module — tests pass"
bash scripts/message.sh "PR #42 opened — ready for review"
```

With custom environment variables:

```bash
NTFY_TOPIC=my-topic NTFY_PRIORITY=urgent bash scripts/message.sh "Critical fix deployed"
```

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
    Agent executes scripts/message.sh
        ↓
   POST to https://ntfy.sh/<topic>
       ↓
   ntfy.sh delivers to all subscribers
       ↓
   User receives push notification on phone
```

## Notes

- Topic can be customized via NTFY_TOPIC environment variable

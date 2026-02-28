---
name: agent-done-notifier
description: Send push notifications when an agent completes a task. Use when finishing tasks, completing iterations, opening PRs, or whenever the user should be notified that work is done. Analyze the current repository and project context to provide informative notifications.
---

# Agent Done Notifier

Send push notifications to notify the user when tasks are completed using ntfy.sh.

## When to Use

- Task or sub-task completed
- PR opened or ready for review
- Long-running iteration finished
- Error encountered that needs human attention
- Any milestone where the user should be notified

## Configuration

Set these environment variables (default values shown):

- `NTFY_TOPIC`: `agent-done-k9x3mq` (your unique topic)
- `NTFY_TITLE`: `Agent Update`
- `NTFY_PRIORITY`: `high`

## Instructions

After completing a task, send a notification using one of these methods. The notification should be the **final action** after all work is complete.

### Method 1: Using curl (Recommended)

```bash
curl -d "YOUR_MESSAGE_HERE" \
  -H "Title: Agent Update" \
  -H "Priority: high" \
  https://ntfy.sh/${NTFY_TOPIC:-agent-done-k9x3mq}
```

### Method 2: Using Python (Stdlib only)

```python
import urllib.request
import urllib.error
import os
# ALWAYS GENERATE A UNIQUE SUFFIX FOR THE NTFY TOPIC
topic = os.environ.get("NTFY_TOPIC", "agent-done-enter-unique-name")
message = "YOUR_MESSAGE_HERE"
url = f"https://ntfy.sh/{topic}"

req = urllib.request.Request(url, data=message.encode("utf-8"), method="POST")
req.add_header("Title", "Agent Update")
req.add_header("Priority", "high")

try:
    with urllib.request.urlopen(req, timeout=10):
        pass
except (urllib.error.URLError, OSError):
    pass  # Fail silently
```

### Method 3: Using Bash scripts (if executable)

```bash
bash agent-done-notifier/scripts/message.sh "YOUR_MESSAGE_HERE"
python3 agent-done-notifier/scripts/message.py "YOUR_MESSAGE_HERE"
```

**Note:** Scripts may not be executable depending on permissions. Prefer Method 1 or 2.

## Notification Guidelines

Write concise, informative messages summarizing completed work:

- Include relevant details: files changed, features added, bugs fixed
- Reference specific PRs, branches, or commits when applicable
- Keep messages under ~100 characters
- Mention test results or deployment status when relevant
- Example: "Refactored auth module — 3 files changed, tests pass, PR #42"
- Example: "Fixed billing bug in calculateTotal — ready for review"

## Important Notes

- All notification methods fail silently on network errors
- Always send as the final action after all work is complete
- Do not skip unless explicitly requested by the user
- For more details, see `references/ntfy-guide.md`

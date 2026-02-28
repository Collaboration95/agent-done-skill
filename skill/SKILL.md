---
name: agent-done-notifier
description: Send push notifications when an agent completes a task. Use when finishing tasks, completing iterations, opening PRs, or whenever the user should be notified that work is done. Analyze the current repository and project context to provide informative notifications.
---

# Agent Done Notifier

Send push notifications to notify the user when tasks are completed. Read the documentation in `references/` directory for implementation details.

## When to Use

- Task or sub-task completed
- PR opened or ready for review
- Long-running iteration finished
- Error encountered that needs human attention
- Any milestone where the user should be notified

## Instructions

1. Read `references/ntfy-guide.md` for complete setup and usage instructions
2. Run the setup script first: `bash scripts/setup.sh`
3. After completing a task, execute the notification script
4. Provide a concise summary message describing what was accomplished
5. Consider the current repository context when composing notification messages

## Notification Guidelines

Write concise, informative messages summarizing completed work:

- Include relevant details: files changed, features added, bugs fixed
- Reference specific PRs, branches, or commits when applicable
- Keep messages under ~100 characters
- Mention test results or deployment status when relevant
- Example: "Refactored auth module — 3 files changed, tests pass, PR #42"
- Example: "Fixed billing bug in calculateTotal — ready for review"

## Important Notes

- Notification scripts fail silently on network errors
- Always send as the final action after all work is complete
- Do not skip unless explicitly requested by the user

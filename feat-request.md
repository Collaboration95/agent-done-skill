# Feature Request: Agent Completion Notifications via ntfy

## Overview

Build a lightweight notification script (`message.sh` and/or `message.py`) that sends push notifications to an iPhone via **ntfy.sh** when an AI agent (Cursor, opencode, etc.) completes a task or iteration.

---

## Goals

- Zero infrastructure — no server, no account required
- Single command the LLM agent can call at end of any task
- Notification appears on iPhone instantly via the ntfy app
- Dead simple to maintain or modify

---

## How ntfy Works (context for the agent)

ntfy.sh is a pub/sub notification service. You publish to a **topic** via HTTP POST, and any subscribed device receives a push notification.

- **Base URL:** `https://ntfy.sh`
- **Topic:** a unique string you choose (e.g. `my-agent-alerts-x7k2`) — treat it like a password, keep it random enough to avoid collisions
- **No auth needed** for public topics (good enough for local/personal use)
- **iPhone app:** already installed, user subscribes to their chosen topic inside the app

### Minimal curl call

```bash
curl -d "Your message here" ntfy.sh/YOUR_TOPIC
```

### Full curl call with title + priority + tags

```bash
curl \
  -H "Title: opencode — Task Done" \
  -H "Priority: high" \
  -H "Tags: white_check_mark" \
  -d "PR opened for feature/xyz" \
  ntfy.sh/YOUR_TOPIC
```

### ntfy HTTP headers available

| Header     | Purpose                         | Example                             |
| ---------- | ------------------------------- | ----------------------------------- |
| `Title`    | Notification title              | `Agent Done`                        |
| `Message`  | Body (also via `-d`)            | `PR #42 opened`                     |
| `Priority` | `low / default / high / urgent` | `high`                              |
| `Tags`     | Emoji shortcodes                | `white_check_mark, robot`           |
| `Click`    | URL to open on tap              | `https://github.com/org/repo/pulls` |

---

## Deliverables

### 1. `message.sh`

A bash script callable as: `./message.sh "opencode - dione finished xyz"`

Requirements:

- Read topic from an env var `NTFY_TOPIC` (set in `~/.zshrc` or `~/.bashrc`)
- Accept full message as `$*` (all arguments joined)
- Set a sensible default title like `Agent Update`
- Set priority to `high`
- Include a tag (`white_check_mark` on success by default)
- Gracefully fail silently if no network (don't block the agent)
- Print a confirmation line to stdout: `[ntfy] Notification sent: <message>`

### 2. `message.py`

A Python equivalent for agents/environments that prefer Python.

Requirements:

- Same behaviour as `message.sh`
- Use only stdlib (`urllib` — no requests dependency)
- Accept message via `sys.argv[1:]` or `--message` flag
- Optional `--title` and `--priority` flags
- Read `NTFY_TOPIC` from env

### 3. `.env.example`

```
NTFY_TOPIC=your-random-topic-here
```

---

## File Structure

```
~/scripts/notify/
├── message.sh
├── message.py
└── .env.example
```

Add `~/scripts/notify` to `$PATH` so the agent can call `message.sh` from anywhere.

---

## Usage Examples (what the LLM agent will run)

```bash
# Basic
message.sh "opencode - dione completed PR for auth refactor"

# With context
message.sh "cursor agent finished 3 iterations on billing bug - PR #88 opened"

# From python
python message.py "opencode done — tests passing, PR ready for review"
```

---

## Setup Steps (for the agent to also scaffold)

1. Create `~/scripts/notify/` directory
2. Write `message.sh` and `message.py`
3. `chmod +x message.sh`
4. Add `export NTFY_TOPIC=your-topic` to `~/.zshrc`
5. Add `~/scripts/notify` to `PATH` in `~/.zshrc`
6. Run `source ~/.zshrc`
7. Test: `message.sh "hello from terminal"`
8. Confirm notification appears on iPhone

---

## Out of Scope

- Authentication / private ntfy servers (future enhancement)
- Logging notifications to a file (can be added later)
- Two-way communication / approvals

---

## Notes for Agent

- `NTFY_TOPIC` should be something random like `agent-done-k9x3mq` to avoid public collisions
- ntfy.sh free tier is plenty for personal use (no rate limit issues at this scale)
- Both scripts should be idempotent and safe to call multiple times

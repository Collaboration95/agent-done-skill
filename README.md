# agent-done-notifier

Push notifications to your phone when AI agents finish tasks. Zero infrastructure, zero dependencies.

Uses [ntfy.sh](https://ntfy.sh) — a free, open-source pub/sub notification service.

## Quick Start

```bash
# 1. Clone
git clone https://github.com/YOUR_USER/agent-done-notifier.git
cd agent-done-notifier

# 2. Run setup
bash scripts/setup.sh

# 3. Subscribe on your phone
#    Install the ntfy app (iOS / Android), subscribe to the topic shown by setup

# 4. Send a test notification
bash scripts/message.sh "hello from terminal"
```

## Project Structure

```
agent-done-notifier/
├── SKILL.md               # Agent skill instructions (Cursor/OpenCode)
├── scripts/               # Notification scripts
│   ├── setup.sh           # Initial setup script
│   ├── message.sh         # Bash notification script
│   └── message.py         # Python notification script
├── references/            # Documentation
│   └── ntfy-guide.md      # Complete implementation guide
├── README.md              # This file
├── .env.example           # Environment variables template
└── .gitignore             # Git ignore rules
```

## Scripts

### `setup.sh`

Initial setup script that:
- Creates a random agent-done-tag
- Generates `.env` file with configuration
- Displays the ntfy topic to subscribe to

Run this once after cloning the repository.

### `message.sh` (Bash)

```bash
bash scripts/message.sh "Agent finished refactoring auth module"
```

### `message.py` (Python, stdlib only)

```bash
python3 scripts/message.py "PR #42 opened — ready for review"
python3 scripts/message.py "Custom title" --title "Build Done" --priority urgent
```

Both scripts:
- Read configuration from `.env` file
- Fail silently on network errors (never block your agent)
- Print a confirmation line to stdout

## Configuration

Configuration is managed via the `.env` file (created by setup.sh):

| Environment Variable | Default | Purpose |
|---------------------|---------|---------|
| `NTFY_TOPIC` | `agent-done-k9x3mq` | Your ntfy topic |
| `NTFY_TITLE` | `Agent Update` | Notification title |
| `NTFY_PRIORITY` | `high` | `min` / `low` / `default` / `high` / `urgent` |
| `NTFY_TAGS` | `white_check_mark,robot` | ntfy tags (emoji shortcodes) |

To change the default topic, either edit the `.env` file or set the env var.

## Install as a Cursor Skill

Copy the entire repository into your Cursor skills folder:

```bash
cp -r agent-done-notifier ~/.cursor/skills/agent-done-notifier
```

The agent will automatically send notifications at the end of tasks.

## Install as an OpenCode Skill

Copy the entire repository into your OpenCode skills folder:

```bash
cp -r agent-done-notifier ~/.config/opencode/skills/agent-done-notifier
```

The agent will automatically send notifications at the end of tasks.

## How It Works

1. You subscribe to a topic in the ntfy phone app
2. The setup script generates a `.env` file with configuration
3. The scripts POST a message to `ntfy.sh/<topic>`
4. ntfy pushes it to every subscribed device instantly

No server, no account, no API keys needed for public topics.

## Documentation

For complete implementation details, see `references/ntfy-guide.md`.

## License

MIT

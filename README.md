# agent-done-notifier

Push notifications to your phone when AI agents finish tasks. Zero infrastructure, zero dependencies.

Uses [ntfy.sh](https://ntfy.sh) — a free, open-source pub/sub notification service.

## Quick Start

```bash
# 1. Clone
git clone https://github.com/YOUR_USER/agent-done-notifier.git
cd agent-done-notifier

# 2. Install for your agent
# For Claude Code:
cp -r .claude/skills/agent-done-notifier ~/.claude/skills/agent-done-notifier

# For OpenCode:
cp -r .claude/skills/agent-done-notifier ~/.config/opencode/skills/agent-done-notifier

# 3. Subscribe on your phone
#    Install the ntfy app (iOS / Android), subscribe to topic: agent-done-k9x3mq

# 4. Test notification
bash ~/.claude/skills/agent-done-notifier/scripts/message.sh "hello from terminal"
```

## Project Structure

```
agent-done-notifier/                    # Repository root
├── .claude/skills/                    # Compatible with Claude Code and OpenCode
│   └── agent-done-notifier/
│       ├── SKILL.md                  # Agent skill instructions
│       ├── scripts/                  # Notification scripts
│       │   └── message.sh            # Bash notification script
│       └── references/               # Documentation
│           └── ntfy-guide.md         # Complete implementation guide
├── .agents/skills/                   # Compatible with OpenCode
│   └── agent-done-notifier/          # (same structure as .claude/skills/)
├── agent-done-notifier/              # Source directory (reference)
├── README.md                        # This file
├── AGENTS_DOCS.md                  # Agent compatibility documentation
├── .env.example                     # Environment variables template
└── .gitignore                       # Git ignore rules
```

## Scripts

### `message.sh` (Bash)

```bash
bash ~/.claude/skills/agent-done-notifier/scripts/message.sh "Agent finished refactoring auth module"
```

Both scripts:
- Read configuration from environment variables
- Fail silently on network errors (never block your agent)
- Print a confirmation line to stdout

## Configuration

Configuration is managed via environment variables:

| Environment Variable | Default | Purpose |
|---------------------|---------|---------|
| `NTFY_TOPIC` | `agent-done-k9x3mq` | Your ntfy topic |
| `NTFY_TITLE` | `Agent Update` | Notification title |
| `NTFY_PRIORITY` | `high` | `min` / `low` / `default` / `high` / `urgent` |
| `NTFY_TAGS` | `white_check_mark,robot` | ntfy tags (emoji shortcodes) |

To change the default topic, set the `NTFY_TOPIC` environment variable in your shell config.

## Installation

### Claude Code

Copy the skill folder into your Claude skills folder:

```bash
cp -r .claude/skills/agent-done-notifier ~/.claude/skills/agent-done-notifier
```

The agent will automatically send notifications at the end of tasks.

### OpenCode

Copy the skill folder into your OpenCode skills folder:

```bash
cp -r .claude/skills/agent-done-notifier ~/.config/opencode/skills/agent-done-notifier
```

The agent will automatically send notifications at the end of tasks.

### Other Agents

This skill follows the Agent Skills open standard (https://agentskills.io) and may work with other agents that support `.claude/skills/` or `.agents/skills/` formats.

See `AGENTS_DOCS.md` for compatibility details.

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

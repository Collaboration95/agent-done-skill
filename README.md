# agent-done-notifier

Push notifications to your phone when AI agents finish tasks. Zero infrastructure, zero dependencies.

Uses [ntfy.sh](https://ntfy.sh) — a free, open-source pub/sub notification service.

## Agent Compatibility

### Cursor
- **Docs**: https://cursor.com/docs/context/skills
- **Location**: `.cursor/skills/<name>/SKILL.md` (project), `~/.cursor/skills/<name>/SKILL.md` (user)
- **Also loads from**: `.claude/skills/`, `.agents/skills/`, `.codex/skills/` directories

### Claude Code
- **Docs**: https://code.claude.com/docs/en/skills.md
- **Location**: `.claude/skills/<name>/SKILL.md` (project), `~/.claude/skills/<name>/SKILL.md` (user)
- **Supports**: Additional files (scripts, references, templates)

### OpenCode
- **Docs**: https://opencode.ai/docs/skills/
- **Location**: `.opencode/skills/<name>/SKILL.md`, `.agents/skills/<name>/SKILL.md`, or `~/.config/opencode/skills/<name>/SKILL.md`
- **Also loads from**: `.claude/skills/` directories

## Quick Start

```bash
# 1. Clone
git clone https://github.com/Collaboration95/agent-done-skill.git
cd agent-done-skill

# 2. Install for your agent (pick one)

# Cursor
cp -r .cursor/skills/agent-done-notifier ~/.cursor/skills/agent-done-notifier

# Claude Code
cp -r .claude/skills/agent-done-notifier ~/.claude/skills/agent-done-notifier

# OpenCode
cp -r .agents/skills/agent-done-notifier ~/.config/opencode/skills/agent-done-notifier

# 3. Subscribe on your phone
#    Install the ntfy app (iOS / Android), subscribe to topic: agent-done-unique

# 4. Test notification
curl -d "hello from terminal" https://ntfy.sh/agent-done-unique
```

## Project Structure

```
agent-done-skill/                      # Repository root
├── .claude/skills/                    # Compatible with Claude Code, Cursor, and OpenCode
│   └── agent-done-notifier/
│       ├── SKILL.md                  # Agent skill instructions
│       ├── scripts/                  # Notification scripts
│       │   └── message.sh            # Bash notification script
│       └── references/               # Documentation
│           └── ntfy-guide.md         # Complete implementation guide
├── .agents/skills/                   # Compatible with OpenCode and Cursor
│   └── agent-done-notifier/          # (same structure as .claude/skills/)
├── .cursor/skills/                   # Compatible with Cursor
│   └── agent-done-notifier/          # (same structure as .claude/skills/)
├── agent-done-notifier/              # Source directory (reference)
├── README.md                        # This file
├── .env.example                     # Environment variables template
└── .gitignore                       # Git ignore rules
```

## Scripts

### `message.sh` (Bash)

```bash
bash scripts/message.sh "Agent finished refactoring auth module"
```

Or after installing globally:

```bash
bash ~/.cursor/skills/agent-done-notifier/scripts/message.sh "Agent finished refactoring auth module"
```

Behaviour:
- Reads configuration from environment variables
- Fails silently on network errors (never blocks your agent)
- Prints a confirmation line to stdout

## Configuration

Configuration is managed via environment variables:

| Environment Variable | Default | Purpose |
|---------------------|---------|---------|
| `NTFY_TOPIC` | `agent-done-unique` | Your ntfy topic (change this to something unique) |
| `NTFY_TITLE` | `Agent Update` | Notification title |
| `NTFY_PRIORITY` | `high` | `min` / `low` / `default` / `high` / `urgent` |
| `NTFY_TAGS` | `white_check_mark,robot` | ntfy tags (emoji shortcodes) |

To change the default topic, set the `NTFY_TOPIC` environment variable in your shell config.

## Installation

### Cursor

Copy the skill folder into your Cursor skills folder:

```bash
cp -r .cursor/skills/agent-done-notifier ~/.cursor/skills/agent-done-notifier
```

The agent will automatically send notifications at the end of tasks.

### Claude Code

Copy the skill folder into your Claude skills folder:

```bash
cp -r .claude/skills/agent-done-notifier ~/.claude/skills/agent-done-notifier
```

The agent will automatically send notifications at the end of tasks.

### OpenCode

Copy the skill folder into your OpenCode skills folder:

```bash
cp -r .agents/skills/agent-done-notifier ~/.config/opencode/skills/agent-done-notifier
```

The agent will automatically send notifications at the end of tasks.

### Other Agents

This skill follows the [Agent Skills open standard](https://agentskills.io) and may work with other agents that support `.claude/skills/` or `.agents/skills/` formats.

## How It Works

1. You subscribe to a topic in the ntfy phone app
2. The agent runs a curl command (or the bash script) to POST a message to `ntfy.sh/<topic>`
3. ntfy pushes it to every subscribed device instantly

No server, no account, no API keys needed for public topics.

## Documentation

For complete implementation details, see [`agent-done-notifier/references/ntfy-guide.md`](agent-done-notifier/references/ntfy-guide.md).

## License

MIT

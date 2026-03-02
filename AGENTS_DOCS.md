# Agent Documentation Summary

## OpenCode
- **Docs**: https://opencode.ai/docs/skills/
- **Location**: `.opencode/skills/<name>/SKILL.md` or `~/.config/opencode/skills/<name>/SKILL.md`
- **Structure**: SKILL.md with YAML frontmatter (name, description, license, compatibility, metadata)
- **Compatible with**: `.claude/skills/` and `.agents/skills/` formats

## Claude Code
- **Docs**: https://code.claude.com/docs/en/skills.md
- **Location**: `.claude/skills/<skill-name>/SKILL.md` (project), `~/.claude/skills/<skill-name>/SKILL.md` (personal)
- **Structure**: SKILL.md with YAML frontmatter (name, description, disable-model-invocation, user-invocable, allowed-tools, model, context, agent, hooks, argument-hint)
- **Supports**: Additional files (templates, examples, scripts)

## Cursor
- **Status**: Could not access documentation (certificate expired)
- **Note**: Compatible with `.claude/skills/` format based on OpenCode docs

## Gemini CLI
- **Status**: Could not access documentation
- **Note**: Unknown compatibility
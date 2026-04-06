# AI Skill: Quality Audit

An AI agent skill that runs automated quality audits on frontend projects. Works with Claude Code, and any CLI AI agent that supports skill/prompt loading.

## What It Does

When invoked, the skill:
1. Reads the project's `quality-checks/AGENT-GUIDE.md` for available audits
2. Runs the requested audit script(s)
3. Summarizes findings with severity levels (ERROR / WARNING / INFO)
4. Suggests fixes for each issue found

## Available Audits

| Topic | Check | What it detects |
|---|---|---|
| **UI/UX** | `zindex` | Z-index layering conflicts |
| | `design-tokens` | Hardcoded colors, font sizes, shadows |
| | `unused-css` | Dead CSS selectors |
| | `animation-performance` | Non-GPU animations, bad durations |
| | `reduced-motion` | Missing `prefers-reduced-motion` (WCAG 2.3.3) |
| | `focus-management` | Removed focus indicators (WCAG 2.4.7) |
| | `accessibility` | Missing alt, labels, ARIA (WCAG 1.1.1) |
| | `touch-targets` | Small interactive elements (WCAG 2.5.5) |
| | `responsive` | Inconsistent breakpoints, viewport issues |
| | `semantic-html` | Heading hierarchy, landmarks (WCAG 1.3.1) |
| **Performance** | `bundle-size` | Oversized build output files |

## Prerequisites

Your project must have the `quality-checks/` directory. Install it:

```bash
# Option A: Git submodule
git submodule add https://github.com/el-musleh/quality-checks.git quality-checks

# Option B: Direct clone
git clone https://github.com/el-musleh/quality-checks.git quality-checks

# Option C: Use the install script
curl -sL https://raw.githubusercontent.com/el-musleh/ai-skill-quality-audit/main/install.sh | bash
```

## Usage

### Claude Code

Add to your project's `.claude/settings.json` or invoke directly:

```
/audit              — run all audits
/audit ui-ux        — run all UI/UX audits
/audit zindex       — run a specific audit
/audit performance  — run all performance audits
```

### Any CLI AI Agent

Load `skill.md` as a system prompt or skill file, then ask:

```
Run a quality audit on this project
Run the accessibility audit
Check z-index layering
```

## Install as Claude Code Skill

```bash
# From your project root:
claude skill add --from https://github.com/el-musleh/ai-skill-quality-audit
```

Or manually copy `skill.md` to `.claude/skills/audit.md` in your project.

## License

MIT

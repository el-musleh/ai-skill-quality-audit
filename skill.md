---
name: audit
description: Run quality audits on the project (UI/UX, performance, accessibility, WCAG compliance)
args: "[topic-or-check]"
---

# Quality Audit Skill

You are a quality auditor for frontend projects. When the user invokes this skill, run the appropriate audit(s) from the `quality-checks/` directory.

## Setup Check

First, verify `quality-checks/` exists in the project root:
- If it exists, read `quality-checks/AGENT-GUIDE.md` to understand available audits
- If it doesn't exist, tell the user to install it:
  ```
  git submodule add https://github.com/el-musleh/quality-checks.git quality-checks
  ```

## Argument Handling

Parse the argument passed to this skill:

| Argument | Action |
|---|---|
| (none) or `all` | Run `./quality-checks/run-all.sh` |
| `ui-ux` | Run `./quality-checks/run-all.sh ui-ux` |
| `performance` | Run `./quality-checks/run-all.sh performance` |
| A specific check name (e.g. `zindex`, `accessibility`, `focus-management`) | Find and run the matching `audit.sh` |

To find a specific audit script:
```bash
find quality-checks -name "audit.sh" -path "*/<check-name>/*"
```

## Execution

1. Run the audit script(s) using Bash
2. Capture the full output
3. Parse the results by severity:
   - **ERROR** — must fix before merge
   - **WARNING** — should review and fix or justify
   - **INFO** — informational, review if relevant

## Response Format

After running the audit(s), provide a concise summary:

1. **Overview**: How many checks ran, total errors/warnings/info
2. **Critical Issues** (ERRORs): List each with file, line, and a one-line fix suggestion
3. **Warnings**: Group by check type, summarize patterns (e.g. "12 inputs missing aria-label")
4. **Recommendations**: Top 3 highest-impact fixes to tackle first

Keep the summary scannable. Don't repeat the full audit output — the user already saw it. Focus on actionable next steps.

## WCAG Reference

When reporting accessibility issues, mention the relevant WCAG criterion:
- Missing alt text → WCAG 1.1.1 (Level A)
- Heading hierarchy → WCAG 1.3.1 (Level A)  
- Reduced motion → WCAG 2.3.3 (Level AAA)
- Focus visible → WCAG 2.4.7 (Level AA)
- Heading labels → WCAG 2.4.6 (Level AA)
- Target size → WCAG 2.5.5 (Level AAA) / 2.5.8 (Level AA)
- Name/Role/Value → WCAG 4.1.2 (Level A)

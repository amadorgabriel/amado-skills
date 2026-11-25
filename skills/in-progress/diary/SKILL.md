---
name: diary
description: >-
  Records a daily work diary in ~/.diary/YYYY-MM-DD.md and .html from the
  current session: recap, achievements, challenges and solutions, changes per
  project, roles involved, STAR/XYZ career notes, and next steps. Anonymized
  (roles, no company names, no LGPD data). Re-runs on the same day merge into
  the same file. Explicit invocation only.
disable-model-invocation: true
argument-hint: "[notas extras do dia]"
---

# Diary

Write one diary per day that a future `/report` can filter by week and project, and that a job search can mine for STAR/XYZ evidence. Inspired by [rlancemartin/claude-diary](https://github.com/rlancemartin/claude-diary), keeping only the user-facing record (no preference learning, no `CLAUDE.md` updates).

Write the entry in PT-BR. Be factual and specific: real files, commits, PRs, errors. Every claim traces back to the session, git, or the user's answers; unknown numbers become `[MÉTRICA A CONFIRMAR]`.

The diary is anonymized. Apply the [`privacy-guardrail`](../privacy-guardrail/SKILL.md) skill throughout: people are roles, companies are descriptions, no LGPD data, alias map in `~/.diary/.aliases.md`.

## Steps

### 1. Stamp the run

Read date and time from the system clock (never from memory), plus the repo and branch:

```powershell
Get-Date -Format 'yyyy-MM-dd HH:mm'
git rev-parse --show-toplevel; git branch --show-current
```

On bash use `date '+%Y-%m-%d %H:%M'`. The project is the repo folder name, or its alias when it reveals a company; outside a repo, ask for it.

Targets: `~/.diary/<date>.md` and `~/.diary/<date>.html` (on Windows, `$HOME\.diary\`). Create the folder if missing.

Done when you have date, time, project, branch (or `sem-git`), and both target paths.

### 2. Load continuity

- Read `~/.diary/.aliases.md` if it exists.
- If today's `.md` exists, read it: this run merges into it (step 5).
- Read the most recent earlier `.md` in `~/.diary/` and collect its open `- [ ]` next steps.

Done when you know which open items from the previous entry this session resolved, which are still open, and whether today's file already exists.

### 3. Gather evidence

Primary source is the session in context: user requests, files edited, commands, errors, decisions and their reasons. Then, if in a git repo, add today's commits as support:

```bash
git log --since='<date> 00:00' --author="$(git config user.email)" --pretty=format:'%h|%ad|%s' --date=format:'%H:%M' --no-merges
```

Also collect PR numbers mentioned in the session. If the session was compacted and details are missing, say what is missing instead of guessing.

Done when every section of the template has material or is confirmed empty.

### 4. Ask once

Ask in a single message, then wait:

- **Papéis:** list the roles already known from the alias map and the session, and ask who else took part today and how (pairing, review, alinhamento, reunião). For every name without a known substitute, ask its role and team.
- **Empresas e projetos:** for every company, client, or revealing repo name without a known substitute, ask for its description or alias.
- **Métricas:** for the 1 to 3 strongest achievements, ask for the number that proves impact (tempo, %, volume, custo). Accept "não sei".

Treat the skill argument as notes already given. Save each new substitute to the alias map.

Done when every person, company, and project has a substitute, and each metric is answered or skipped.

### 5. Write or merge the Markdown

Follow [references/entry-template.md](references/entry-template.md) exactly: frontmatter keys and section headings are the contract `/report` parses.

- **New file:** write the full entry, recap and sumário included.
- **Existing file:** merge. Append the session to `sessions`, union `projects`, `roles`, `tags`. If the project section exists, add new bullets to its subsections; otherwise add a new project section. Append career items. Merge next steps without duplicates. Preserve every line the user already confirmed or edited. Rewrite the recap and sumário to cover the whole day.
- **Continuity:** an open item from the previous entry that was resolved today becomes an achievement bullet; one still open is carried into today's next steps with `(desde YYYY-MM-DD)`. Past diary files stay untouched.

Run the `privacy-guardrail` sweep on the Markdown, then save.

Done when the `.md` on disk matches the template, contains this session, and passes the sweep.

### 6. Render the HTML

Regenerate `~/.diary/<date>.html` in full from the saved `.md`, using [references/entry-template.html](references/entry-template.html). The `.md` is the source of truth; the HTML only mirrors it, with the sumário as anchor links.

Done when the HTML holds every section of the `.md` and nothing else.

### 7. Ask for anything else

Ask: "Quer adicionar mais alguma informação a este diário?" and wait for free text.

- If the user adds something, place it in the section where it fits (or under `## Notas adicionais`), apply the guardrail, update recap and sumário if needed, save the `.md`, and render the HTML again. Then ask again.
- Stop when the user declines.

### 8. Hand over

Print both file paths, a 3-line summary of what was recorded, and every `[MÉTRICA A CONFIRMAR]` left, so the user can fill them in.

## Checklist

- [ ] Date and time come from the system clock
- [ ] Recap and sumário right after the title, covering the whole day
- [ ] Frontmatter keys and headings match the template
- [ ] Changes grouped by project, with files, commits, `PR #n`
- [ ] Each challenge paired with its solution and the reason behind it
- [ ] Career section has XYZ plus STAR, metrics real or marked
- [ ] People appear only as roles; companies only as descriptions; sweep passed
- [ ] Next steps are checkboxes tagged with the project
- [ ] Merged, not overwritten, when today's file existed
- [ ] HTML regenerated from the final `.md`
- [ ] User was asked for anything else
- [ ] No em-dash (U+2014)

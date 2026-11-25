---
name: diary
description: >-
  Records a daily work diary entry in ~/.diary/YYYY-MM-DD.md from the current
  session: achievements, challenges and solutions, changes per project, people
  involved, STAR/XYZ career notes, and next steps. Re-runs on the same day merge
  into the same file. Explicit invocation only.
disable-model-invocation: true
argument-hint: "[notas extras do dia]"
---

# Diary

Write one diary file per day that a future `/report` can filter by week and project, and that a job search can mine for STAR/XYZ evidence. Inspired by [rlancemartin/claude-diary](https://github.com/rlancemartin/claude-diary), keeping only the user-facing record (no preference learning, no `CLAUDE.md` updates).

Write the entry in PT-BR. Be factual and specific: real file paths, commits, PRs, errors. Every claim traces back to the session, git, or the user's answers; unknown numbers become `[MÉTRICA A CONFIRMAR]`.

## Steps

### 1. Stamp the run

Read date and time from the system clock (never from memory), plus the project and branch:

```powershell
Get-Date -Format 'yyyy-MM-dd HH:mm'
git rev-parse --show-toplevel; git branch --show-current
```

On bash use `date '+%Y-%m-%d %H:%M'`. The project name is the repo folder name; outside a repo, ask for it.

Target file: `~/.diary/<date>.md` (on Windows, `$HOME\.diary\`). Create the folder if missing.

Done when you have date, time, project, branch (or `sem-git`), and the target path.

### 2. Load continuity

- If today's file exists, read it: this run merges into it (step 5).
- Read the most recent earlier file in `~/.diary/` and collect its open `- [ ]` next steps.

Done when you know which open items from the previous entry this session resolved, which are still open, and whether today's file already exists.

### 3. Gather evidence

Primary source is the session in context: user requests, files edited, commands, errors, decisions and their reasons. Then, if in a git repo, add today's commits as support:

```bash
git log --since='<date> 00:00' --author="$(git config user.email)" --pretty=format:'%h|%ad|%s' --date=format:'%H:%M' --no-merges
```

Also pull any open PR links mentioned in the session. If the session was compacted and details are missing, say what is missing instead of guessing.

Done when every section of the template has material or is confirmed empty.

### 4. Ask once

Ask in a single message, then wait:

- **Pessoas:** suggest names that appeared in the session or commits, and ask who else took part today and in what role (pairing, review, alinhamento, reunião).
- **Métricas:** for the 1 to 3 strongest achievements, ask for the number that proves impact (tempo, %, volume, custo). Accept "não sei".
- **Notas extras:** anything done outside this session (meetings, other repos) to include. Treat the skill argument as notes already given.

Done when the user answered or explicitly skipped each item.

### 5. Write or merge

Follow [references/entry-template.md](references/entry-template.md) exactly: frontmatter keys and section headings are the contract `/report` parses.

- **New file:** write the full entry.
- **Existing file:** merge. Append the session to `sessions`, union `projects`, `people`, `tags`. If the project section exists, add new bullets to its subsections; otherwise add a new project section. Append career items. Merge next steps without duplicates. Preserve every line the user already confirmed or edited.
- **Continuity:** an open item from the previous entry that was resolved today becomes an achievement bullet; one still open is carried into today's next steps with `(desde YYYY-MM-DD)`. Past diary files stay untouched.

Done when the file on disk matches the template and contains this session.

### 6. Hand over

Print the file path, a 3-line summary of what was recorded, and every `[MÉTRICA A CONFIRMAR]` left, so the user can fill them in.

## Checklist

- [ ] Date and time come from the system clock
- [ ] Frontmatter keys and headings match the template
- [ ] Changes grouped by project, with files, commits, PRs
- [ ] Each challenge paired with its solution and the reason behind it
- [ ] Career section has XYZ plus STAR, metrics real or marked
- [ ] People confirmed by the user
- [ ] Next steps are checkboxes tagged with the project
- [ ] Merged, not overwritten, when today's file existed
- [ ] No em-dash (U+2014)

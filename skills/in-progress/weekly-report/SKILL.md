---
name: weekly-report
description: >-
  Drafts a ready-to-send weekly email with this week's achievements (impact,
  not activity), blockers or risks, and next week's plan. Use when the user
  explicitly asks for a weekly report, status email, Friday update, or
  achievements-and-plan note. Optional git log intake. Language follows the
  request (pt-BR or en-US). Explicit invocation only. Never sends the email.
disable-model-invocation: true
argument-hint: "[week of YYYY-MM-DD] [repo path] [--lang pt-BR|en-US]"
---

# Weekly report

Write one scannable email a manager or client can read in about a minute: what moved, why it matters, what is stuck, and what happens next. Draft only. Never send, never CC anyone, never invent metrics.

Write in the language of the request (or `--lang`). If the language is unclear, ask once and wait.

Never use an em-dash (Unicode U+2014) in the subject, body, filenames, or chat. Use a comma, colon, semicolon, or parentheses. An en-dash (Unicode U+2013) is allowed only in date or number ranges.

## When to run

Only on explicit invoke (`disable-model-invocation: true`). Typical asks: "weekly report", "email with this week's achievements and next week's plan", "Friday update", "status for my manager".

Do not use this skill for a daily standup, a slide deck, a performance review, or a full sprint scorecard.

## Steps

### 1. Intake

Ask only for what is still missing. Ask together, then wait.

| Input | Required | Notes |
| --- | --- | --- |
| Audience | Yes | Manager, client, team, or a named person. This sets tone and detail. |
| Period | Yes | Default: the current work week in America/Sao_Paulo, Monday to Friday. State the dates in the email. |
| Author name | No | Default: the user's name if known, otherwise ask. |
| Achievements, WIP, plan | Yes* | Free-form bullets, tickets, or "use git". Confirm before treating git as the only source. |
| Blockers / risks / asks | No | If none, omit those sections. Do not invent them. |
| Repo paths and author emails | No | Only if gathering git history. Confirm each path and the email allowlist. |
| Last week's plan | No | If a prior draft exists, check which commitments were kept or slipped. |

* If the user gives no substance and no repo, ask for bullets or a repo path. Do not draft an empty week as if work happened.

Tone by audience:

- **Manager:** tactical, blockers and decisions up front, honest slippage.
- **Client:** outcomes and impact, less implementation detail, clear asks with dates.
- **Team:** what shipped, what is next, decisions that affect them.

### 2. Optional evidence (git, tickets, notes)

Use sources the user points to. Do not guess at private facts from a project name.

**Git (optional).** Confirm repo path, date range, and author emails first. Then gather, for each repo:

```bash
git -C "<repo>" log --since='YYYY-MM-DD' --until='YYYY-MM-DD 23:59' \
  --author='you@example.com' \
  --pretty=format:'%h|%ad|%ae|%s' --date=short --no-merges
```

Repeat `--author` for each address on the allowlist. A small wrapper is [scripts/gather-git.sh](scripts/gather-git.sh). On Windows, run it in Git Bash or WSL, or paste the `git log` command into PowerShell if `git` is on PATH.

Rules for git (and for ticket lists the user pastes):

- Cluster commits into 3 to 7 themes. Never write one bullet per commit.
- Skip noise: merges, typo-only, format-only, lockfile-only, "wip" with no meaning.
- Commits are evidence, not achievements. Translate each theme into an outcome and, if known, an impact. If impact is unknown, write the outcome and leave the impact off rather than guessing.
- If last week's email named commitments, mark each as kept or slipped, with a one-line reason for slips.

**Tickets or notes.** If the user pastes Linear, Jira, or GitHub items, use those IDs in the bullets. If a connector is available and the user asked you to look, read only what they authorized. If a source fails, say what is missing and continue with labeled gaps.

Done when you can name what shipped, what slipped, and what is planned, or when you have asked for the missing piece.

### 3. Assess, then draft

Before writing the email, state (for yourself, then reflect in the draft):

- **Status:** on track | at risk | blocked or behind
- **Shipped:** real outcomes, not spin
- **Slipped:** "X slipped because Y", never hidden as "still in progress"
- **Ask:** a named person and a date, or omit the section

Then write a complete email: subject line plus body, ready to copy. Save it under `./weekly-reports/<period-slug>.md` (create the folder if needed). `period-slug` looks like `2026-11-17-to-2026-11-21`. Also print the subject and body in the chat so the user can paste them into their mail client.

Do not send. Do not open a compose window unless the user explicitly asks for a draft in their mail app after reviewing the text.

### 4. Shape of the email

Keep it scannable: short bullets, no wall of prose, readable in about one minute. Lead with status and impact, not activity. Omit any section that would be empty, except Achievements and Next week (if there were no achievements, say so in the summary and lean on slipped work and the plan).

Impact-oriented bullets:

- Good: `Cut the checkout error rate from 3.1% to 0.4% after fixing the retry path, which unblocked the Friday release.`
- Bad: `Worked on checkout bugs and attended the release meeting.`

Start with a verb. Prefer a number when the user provided one. Link to a PR or ticket only when you have a real identifier. Never fabricate a metric, owner, or date. Use `[to confirm: ...]` when a figure is missing and it matters.

#### Subject

English: `Weekly update, {period}: {one short outcome or status}`

Portuguese: `Atualização da semana, {período}: {um resultado curto ou status}`

Examples: `Weekly update, 17 to 21 Nov: checkout errors down to 0.4%` or `Atualização da semana, 17 a 21 nov: release na sexta, risco no ambiente de homologação`.

#### Body (en-US)

```text
Subject: Weekly update, 17 to 21 Nov: {short outcome or status}

Hi {Name},

Status: On track. {One or two sentences: the week's point, not a tour of tasks.}

Achievements
- {Outcome}, so {impact or who benefits}.
- {Outcome}, so {impact}.

In progress and slipped
- {Item}: {status or "slipped because ..."}. Next step: {action}.

Blockers and risks
- {Item}. Impact: {what it delays}. Need: {specific help, from whom, by when}.

Next week
- {Outcome you will finish or meaningfully advance}.
- {Outcome}.
- {Outcome}.

Needs from you
- {Decision or unblock, owner, date.}

Thanks,
{First name}
```

#### Body (pt-BR)

```text
Assunto: Atualização da semana, 17 a 21 nov: {resultado curto ou status}

Olá {Nome},

Status: No prazo. {Uma ou duas frases com o ponto da semana, não a lista de tarefas.}

Conquistas
- {Resultado}, o que {impacto ou quem se beneficia}.
- {Resultado}, o que {impacto}.

Em andamento e o que escorregou
- {Item}: {status ou "escorregou porque ..."}. Próximo passo: {ação}.

Impedimentos e riscos
- {Item}. Impacto: {o que atrasa}. Preciso: {ajuda concreta, de quem, até quando}.

Próxima semana
- {Resultado que vou concluir ou avançar de forma visível}.
- {Resultado}.
- {Resultado}.

O que preciso de você
- {Decisão ou desbloqueio, responsável, data.}

Abraço,
{Primeiro nome}
```

Section notes:

- **Achievements:** 3 to 7 bullets. Outcomes and impact, clustered from evidence. Not a commit dump.
- **In progress and slipped:** include slippage in the open. If nothing slipped, you may title the section "In progress" / "Em andamento" only.
- **Blockers and risks:** each line has impact and a concrete need. If none, omit the section.
- **Next week:** 3 to 5 outcomes, not activities. "Ship the retry fix" or "Entregar o fix de retry", not "Work on retries" or "Trabalhar no retry". Stay inside a realistic capacity. Note a dependency or PTO if it changes the plan.
- **Needs from you:** omit entirely when empty.
- **Status words:** en-US: On track / At risk / Blocked. pt-BR: No prazo / Em risco / Bloqueado.

### 5. Check, then hand over

- [ ] Subject is specific and ready to send
- [ ] Summary states status in the first lines
- [ ] Achievements are impact-oriented, not a task or commit list
- [ ] Slippage is named with a reason
- [ ] Next week is 3 to 5 outcomes
- [ ] No invented metrics, owners, or dates
- [ ] Empty sections omitted
- [ ] Language matches the request
- [ ] No em-dash (U+2014)
- [ ] You have not sent the email

Tell the user the file path, remind them to review before sending, and point at any `[to confirm]` items or a "Needs from you" line they should look at first.
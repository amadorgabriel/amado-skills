# Context Map — Summarize CV

Glossários de domínio da skill **`summarize-cv`**. Vivem em `plugins/job/skills/summarize-cv/dictionary/`.

Dados do usuário (Summarize CV Output Root): `~/.job/` (local, fora do repositório).

Skills irmãs: `git-commits-to-cv`, `cv-md-to-docx`, `cover-letter`, `resume-ats-optimizer` (versionadas); `optimize-linkedin` (stub local em `skills/in-progress/_/`, gitignored) — ver [README do plugin](../../../README.md).

## Contexts (this skill)

- [CV](./cv/CONTEXT.md) — goals, inbox, experience memory, master/tailored CV, Pipeline A, adapt-cv-to-job

## Sibling dictionaries (not under this folder)

- [CV from Commits](../../git-commits-to-cv/dictionary/cv-from-commits/CONTEXT.md) — owned by `git-commits-to-cv`
- LinkedIn — local stub under `skills/in-progress/_/optimize-linkedin/` (gitignored)

## Relationships

- **summarize-cv** owns **Summarize CV Output Root** (`~/.job/` with `goals.md`, `cv/`, `experience/`, `inbox/`)
- **git-commits-to-cv** writes Hybrid Artefacts into **Experience Memory** (`~/.job/experience/`); does not consolidate masters
- **Consolidation** (`summarize-into-doc`) → **Master CV** + **Master CV EN**
- **adapt-cv-to-job** (Reference Module) → **Tailored CV** alongside masters; JD from **Career Inbox**
- **cv-md-to-docx** reads `~/.job/cv/master_cv*.md` and writes send-ready `.docx` next to them; template lives in `~/.job/templates/`
- **optimize-linkedin** (local stub under `skills/in-progress/_/`) may **read** `~/.job/**`; write only under its own output folder
- **cover-letter** e **resume-ats-optimizer** leem CV/JD quando o usuário pedir carta ou ATS; não escrevem masters
- LinkedIn / cover letter / ATS / Word-export requests are **not** executed inside `summarize-cv` — invoke the sibling skill

## Canonical paths

| Artefact | Path |
| --- | --- |
| Skill | `plugins/job/skills/summarize-cv/` |
| Output root | `~/.job/` |
| Experience | `~/.job/experience/` |
| Inbox | `~/.job/inbox/` |
| Masters | `~/.job/cv/master_cv.md`, `master_cv.en.md` |
| Confirmed Metrics | `~/.job/cv/confirmed_metrics.md` |
| Tailored | `~/.job/cv/master_cv.<job-slug>.md` |
| Word export | `~/.job/cv/master_cv*.docx` (via `cv-md-to-docx`) |
| Goals | `~/.job/goals.md` |

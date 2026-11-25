# Documentação

As skills de agente **não** ficam nesta pasta. A fonte (o `SKILL.md` que o agente executa) vive em `plugins/` e `skills/`. Aqui está a documentação humana do repositório e das skills.

## Onde está cada coisa

- **Fonte da skill:**
  - Publicadas em plugins: `plugins/<plugin>/skills/<skill>/`
  - Rascunhos em validação: `skills/in-progress/<skill>/`
  - Skills de terceiros: `skills/external/<autor>/<skill>/`
- **Docs humanas:** `docs/<plugin>/<skill>.md` para skills publicadas; `docs/in-progress/<skill>.md` opcional para rascunhos; skills externas não têm página.
- **ADRs:** [docs/adr/](./adr/) registra decisões de estrutura e instalação.
- **Guia de autoria:** [writing-skills.md](./writing-skills.md).

## Plugin diary

| Skill | Doc |
| --- | --- |
| [`diary`](../plugins/diary/skills/diary/SKILL.md) | [diary/diary.md](./diary/diary.md) |
| [`privacy-guardrail`](../plugins/diary/skills/privacy-guardrail/SKILL.md) | [diary/privacy-guardrail.md](./diary/privacy-guardrail.md) |

## Plugin job

| Skill | Doc |
| --- | --- |
| [`summarize-cv`](../plugins/job/skills/summarize-cv/SKILL.md) | [job/summarize-cv.md](./job/summarize-cv.md) |
| [`git-commits-to-cv`](../plugins/job/skills/git-commits-to-cv/SKILL.md) | [job/git-commits-to-cv.md](./job/git-commits-to-cv.md) |
| [`cv-md-to-docx`](../plugins/job/skills/cv-md-to-docx/SKILL.md) | [job/cv-md-to-docx.md](./job/cv-md-to-docx.md) |
| [`cover-letter`](../plugins/job/skills/cover-letter/SKILL.md) | [job/cover-letter.md](./job/cover-letter.md) |
| [`resume-ats-optimizer`](../plugins/job/skills/resume-ats-optimizer/SKILL.md) | [job/resume-ats-optimizer.md](./job/resume-ats-optimizer.md) |

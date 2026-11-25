# Documentação

As skills de agente **não** ficam nesta pasta. A fonte (o `SKILL.md` que o agente executa) vive em `skills/`. Aqui está a documentação humana do repositório e das skills em validação.

## Onde está cada coisa

- **Fonte da skill:** `skills/<bucket>/.../SKILL.md`
  - Rascunhos em validação: `skills/in-progress/<skill>/`
  - Skills de terceiros: `skills/external/<autor>/<skill>/`
  - Skills promovidas: `skills/<categoria>/<skill>/` (ainda não há nenhuma)
- **Docs humanas:** `docs/<categoria>/<skill>.md`
  - Skills em `in-progress/` podem ter página em [docs/in-progress/](./in-progress/).
  - Skills em `external/` **não** têm página em `docs/` até graduarem para uma categoria estável (veja o checklist em [writing-skills.md](./writing-skills.md)).
  - Quando uma skill for promovida, a doc acompanha em `docs/<categoria>/`.
- **ADRs:** [docs/adr/](./adr/) registra decisões de estrutura e instalação.

## Skills em progresso

| Skill | Doc |
| --- | --- |
| [`summarize-cv`](../skills/in-progress/summarize-cv/SKILL.md) | [in-progress/summarize-cv.md](./in-progress/summarize-cv.md) |
| [`git-commits-to-cv`](../skills/in-progress/git-commits-to-cv/SKILL.md) | [in-progress/git-commits-to-cv.md](./in-progress/git-commits-to-cv.md) |
| [`cv-md-to-docx`](../skills/in-progress/cv-md-to-docx/SKILL.md) | [in-progress/cv-md-to-docx.md](./in-progress/cv-md-to-docx.md) |
| [`cover-letter`](../skills/in-progress/cover-letter/SKILL.md) | [in-progress/cover-letter.md](./in-progress/cover-letter.md) |
| [`resume-ats-optimizer`](../skills/in-progress/resume-ats-optimizer/SKILL.md) | [in-progress/resume-ats-optimizer.md](./in-progress/resume-ats-optimizer.md) |
# in-progress

Rascunhos e skills em fase de validação no uso diário.

## Comportamento neste repositório

- **Instaladas localmente:** `scripts/install.ps1` e `scripts/install.sh` instalam todas as skills deste bucket em `~/.claude/skills` e `~/.cursor/skills` para que possam ser testadas em qualquer projeto.
- **Fora da vitrine:** ficam excluídas de `.claude-plugin/plugin.json` (hoje vazio) e do catálogo de skills promovidas do `README.md` até graduarem para uma categoria estável (seguindo o checklist de [docs/writing-skills.md](../../docs/writing-skills.md)).
- **Docs humanas:** podem existir em [docs/in-progress/](../../docs/in-progress/) enquanto a skill está em validação.

## Invocação explícita (usuário)

| Skill | Papel | Doc |
| --- | --- | --- |
| [`summarize-cv`](./summarize-cv/SKILL.md) | Pipeline de CV: goals, inbox/experience, masters e adaptação para vaga | [doc](../../docs/in-progress/summarize-cv.md) |
| [`git-commits-to-cv`](./git-commits-to-cv/SKILL.md) | Commits convertidos em artefatos em `summarize-cv/output/experience/` | [doc](../../docs/in-progress/git-commits-to-cv.md) |
| [`cv-md-to-docx`](./cv-md-to-docx/SKILL.md) | Master/Tailored MD para Word `.docx` (template em `assets/`) | [doc](../../docs/in-progress/cv-md-to-docx.md) |
| [`weekly-report`](./weekly-report/SKILL.md) | E-mail semanal pronto para copiar, com conquistas (impacto), impedimentos e plano da próxima semana | |

## Invocação automática (modelo)

| Skill | Papel | Doc |
| --- | --- | --- |
| [`cover-letter`](./cover-letter/SKILL.md) | Carta de apresentação personalizada para uma vaga | [doc](../../docs/in-progress/cover-letter.md) |
| [`resume-ats-optimizer`](./resume-ats-optimizer/SKILL.md) | Compatibilidade ATS e match de palavras-chave | [doc](../../docs/in-progress/resume-ats-optimizer.md) |

Stub local: `optimize-linkedin` fica em `in-progress/_/` (gitignored).
# portfolio

Skills de **carreira e portfólio**: currículo, experiência a partir de commits, cartas e LinkedIn.

Outputs pessoais ficam no `output/` de cada skill (gitignored).

## Invocação explícita (usuário)

Skills com `disable-model-invocation: true`, acionadas diretamente pelo nome (`/<skill>`).

| Skill | Papel | Doc |
| --- | --- | --- |
| [`summarize-cv`](./summarize-cv/SKILL.md) | Pipeline de CV: goals, inbox/experience, masters e adaptação para vaga | [doc](../../docs/portfolio/summarize-cv.md) |
| [`git-commits-to-cv`](./git-commits-to-cv/SKILL.md) | Commits convertidos em artefatos em `summarize-cv/output/experience/` | [doc](../../docs/portfolio/git-commits-to-cv.md) |
| [`cv-md-to-docx`](./cv-md-to-docx/SKILL.md) | Master/Tailored MD para Word `.docx` (template em `assets/`) | [doc](../../docs/portfolio/cv-md-to-docx.md) |

## Invocação automática (modelo)

Skills que o agente pode acionar sozinho conforme o contexto (também aceitam chamada direta).

| Skill | Papel | Doc |
| --- | --- | --- |
| [`cover-letter`](./cover-letter/SKILL.md) | Carta de apresentação personalizada para uma vaga | [doc](../../docs/portfolio/cover-letter.md) |
| [`resume-ats-optimizer`](./resume-ats-optimizer/SKILL.md) | Compatibilidade ATS e match de palavras-chave | [doc](../../docs/portfolio/resume-ats-optimizer.md) |

Stub local: `optimize-linkedin` fica em `portfolio/_/` (gitignored).
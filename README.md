# agentic-ai

Vitrine das minhas **skills de agentes de IA** — workflows reutilizáveis para Cursor, Claude Code e ferramentas compatíveis.

> **Descrição sugerida (GitHub About):**  
> Vitrine de skills de agentes de IA: engenharia, educação e portfolio. Workflows reutilizáveis para Cursor/Claude.

## Estrutura

```
.agents/skills/
├── engineering/   # skills de desenvolvimento
├── education/     # aulas visuais de um conceito
├── portfolio/     # carreira, CV, LinkedIn, portfólio
└── deprecated/    # arquivo histórico: agentes devem ignorar
```

Cada categoria tem um `README.md` explicando o propósito. Skills ativas têm um `SKILL.md` na pasta da skill.

## Categorias

| Categoria | O que tem |
| --- | --- |
| [engineering](.agents/skills/engineering/) | `code-review` (CodeRabbit via WSL). Spec-driven, grilling, domain modeling e autofix estão em `~/.cursor/skills/` |
| [education](.agents/skills/education/) | `lesson` (aula HTML de um conceito; origem em `skills-lock.json`) |
| [portfolio](.agents/skills/portfolio/) | `summarize-cv`, `git-commits-to-cv`, `cv-md-to-docx`, `cover-letter`, `cover-letter-generator`, `resume-ats-optimizer` (+ stub local `optimize-linkedin` em `portfolio/_/`) |
| [deprecated](.agents/skills/deprecated/) | Skills antigas (não usar) |

## Como os agentes devem se comportar

Ver [AGENTS.md](./AGENTS.md): carregar só skills ativas; **nunca** usar `deprecated/`.

## Licença

[MIT](./LICENSE)

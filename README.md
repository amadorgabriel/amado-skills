# amado-skills

Skills reutilizáveis para agentes de IA (Claude Code, Cursor e ferramentas compatíveis), cobrindo engenharia, educação, trabalho, portfólio e finanças.

## Estrutura

```text
skills/
├── engineering/   # desenvolvimento de software
├── education/     # aulas visuais de um conceito
├── job/           # apresentações e relatórios semanais
├── portfolio/     # carreira, CV, cartas e portfólio
└── financial/     # finanças pessoais e PJ (em construção)
scripts/
├── install.ps1    # instalador Windows (PowerShell)
└── install.sh     # instalador WSL / Linux / macOS
docs/
└── adr/           # decisões de arquitetura do repositório
```

## Skills

| Categoria | Skills |
| --- | --- |
| [engineering](skills/engineering/) | `code-review` (CodeRabbit via WSL) |
| [education](skills/education/) | `lesson` (aula HTML autocontida de um conceito, adaptada de [ganeko-skills](https://github.com/YudiG12/ganeko-skills)) |
| [job](skills/job/) | `slide-presentation` (roteiro e deck Marp Markdown com notas de fala), `weekly-report` (e-mail semanal de conquistas e plano, com coleta opcional via git) |
| [portfolio](skills/portfolio/) | `summarize-cv`, `git-commits-to-cv`, `cv-md-to-docx`, `cover-letter`, `resume-ats-optimizer` |
| [financial](skills/financial/) | Reservada para futuras skills financeiras |

## Instalação

Os scripts copiam todas as skills ativas de `skills/` para `~/.claude/skills` e `~/.cursor/skills`, deixando elas disponíveis em qualquer projeto. É seguro rodar de novo sempre que atualizar o repositório.

**Windows (PowerShell):**

```powershell
.\scripts\install.ps1                         # instala todas para Claude Code e Cursor
.\scripts\install.ps1 lesson code-review      # instala só skills específicas
.\scripts\install.ps1 -Agents cursor lesson   # escolhe o agente (claude, cursor)
```

**WSL / Linux / macOS:**

```sh
scripts/install.sh                            # instala todas para Claude Code e Cursor
scripts/install.sh lesson code-review         # instala só skills específicas
AGENTS=cursor scripts/install.sh lesson       # escolhe o agente (claude, cursor)
```

## Regras e decisões

- [AGENTS.md](./AGENTS.md) (referenciado por [CLAUDE.md](./CLAUDE.md)): regras agnósticas de agente para trabalhar neste repositório, incluindo a política de estilo sem travessão.
- [docs/adr/](./docs/adr/): registro curto das decisões de estrutura e instalação.

## Licença

[MIT](./LICENSE)
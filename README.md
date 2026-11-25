# amado-skills

Marketplace pessoal de plugins para agentes de IA (Claude Code e Cursor), com skills de diário de trabalho e de busca de emprego, rascunhos em evolução e uma curadoria de skills externas.

## Estrutura

```text
.claude-plugin/marketplace.json   # marketplace para Claude Code (amadorgabriel)
.cursor-plugin/marketplace.json   # mesmo catálogo para Cursor
plugins/
├── diary/                        # plugin: diário de trabalho anonimizado
└── job/                          # plugin: CV, conquistas, cover letter e ATS
skills/
├── in-progress/                  # rascunhos autorais ainda fora de plugins
└── external/                     # cópias congeladas de skills de terceiros, por autor
scripts/
├── install.ps1                   # instalador Windows (PowerShell)
└── install.sh                    # instalador WSL / Linux / macOS / Git Bash
docs/
├── adr/                          # decisões de arquitetura do repositório
├── diary/                        # docs humanas do plugin diary
├── job/                          # docs humanas do plugin job
└── writing-skills.md             # guia de autoria e publicação de skills
```

Cada plugin é uma pasta autocontida com `.claude-plugin/plugin.json`, `.cursor-plugin/plugin.json` e `skills/<skill>/SKILL.md`. Dados pessoais nunca ficam dentro dos plugins: o `diary` grava em `~/.diary/` e o `job` em `~/.job/`.

## Plugins

### diary

| Skill | Invocação | O que entrega | Documentação |
| --- | --- | --- | --- |
| [`diary`](plugins/diary/skills/diary/SKILL.md) | Usuário (`/diary`) | Diário em `~/.diary/AAAA-MM-DD.md` e `.html`: recap, conquistas, desafios e soluções, alterações por projeto, papéis, STAR/XYZ e próximos passos | [docs/diary/diary.md](docs/diary/diary.md) |
| [`privacy-guardrail`](plugins/diary/skills/privacy-guardrail/SKILL.md) | Modelo | Anonimiza registros: pessoas viram cargos, empresas viram descrições, sem dados da LGPD | [docs/diary/privacy-guardrail.md](docs/diary/privacy-guardrail.md) |

### job

| Skill | Invocação | O que entrega | Documentação |
| --- | --- | --- | --- |
| [`summarize-cv`](plugins/job/skills/summarize-cv/SKILL.md) | Usuário | Pipeline de CV: metas, experiência, masters PT/EN e versão por vaga | [docs/job/summarize-cv.md](docs/job/summarize-cv.md) |
| [`git-commits-to-cv`](plugins/job/skills/git-commits-to-cv/SKILL.md) | Usuário | Conquistas (XYZ + STAR) a partir de histórico git | [docs/job/git-commits-to-cv.md](docs/job/git-commits-to-cv.md) |
| [`cv-md-to-docx`](plugins/job/skills/cv-md-to-docx/SKILL.md) | Usuário | Masters e CVs adaptados de Markdown para Word `.docx` | [docs/job/cv-md-to-docx.md](docs/job/cv-md-to-docx.md) |
| [`cover-letter`](plugins/job/skills/cover-letter/SKILL.md) | Modelo | Carta de apresentação para vaga, indicação ou transição | [docs/job/cover-letter.md](docs/job/cover-letter.md) |
| [`resume-ats-optimizer`](plugins/job/skills/resume-ats-optimizer/SKILL.md) | Modelo | Compatibilidade ATS e cobertura de palavras-chave | [docs/job/resume-ats-optimizer.md](docs/job/resume-ats-optimizer.md) |

## Outros buckets

- **Rascunhos ([skills/in-progress/](skills/in-progress/)):** skills autorais em validação que ainda não entraram em um plugin. Instaladas pelos scripts como skills soltas.
- **Skills externas ([skills/external/](skills/external/)):** cópias congeladas em `skills/external/<autor>/<skill>/` (`code-review`, `lesson`, `writing-for-agents`). Instaladas pelos scripts, nunca exportadas em plugins.

## Instalação

### Claude Code

```text
/plugin marketplace add amadorgabriel/amado-skills
/plugin install diary@amadorgabriel
/plugin install job@amadorgabriel
```

### Cursor

Para conta individual, o Cursor carrega plugins locais de `~/.cursor/plugins/local/`. Os scripts copiam os plugins para lá; depois, recarregue a janela (`Developer: Reload Window`).

### Scripts

Instalam os plugins no Cursor e as skills soltas (`in-progress/` e `external/`) em `~/.claude/skills` e `~/.cursor/skills`. Para o Claude Code, apenas mostram o comando do marketplace. É seguro rodar de novo.

**Windows (PowerShell):**

```powershell
.\scripts\install.ps1                         # tudo, para Claude Code e Cursor
.\scripts\install.ps1 diary lesson            # só um plugin e uma skill
.\scripts\install.ps1 -Agents cursor job      # só o plugin job, só no Cursor
```

**WSL / Linux / macOS / Git Bash:**

```sh
scripts/install.sh                            # tudo, para Claude Code e Cursor
scripts/install.sh diary lesson               # só um plugin e uma skill
AGENTS=cursor scripts/install.sh job          # só o plugin job, só no Cursor
```

> **Migração:** se você instalou versões antigas por cópia, apague `diary`, `privacy-guardrail`, `summarize-cv`, `git-commits-to-cv`, `cv-md-to-docx`, `cover-letter` e `resume-ats-optimizer` de `~/.claude/skills` e `~/.cursor/skills`. Os scripts avisam quando encontram essas cópias.

## Regras, autoria e decisões

- [AGENTS.md](./AGENTS.md) (referenciado por [CLAUDE.md](./CLAUDE.md)): regras agnósticas de agente para trabalhar neste repositório, incluindo a política sem travessão.
- [docs/writing-skills.md](./docs/writing-skills.md): guia de autoria e publicação de skills em plugins (junto de [writing-for-agents](skills/external/mattpocock/writing-for-agents/SKILL.md)).
- [docs/adr/](./docs/adr/): registro de decisões de arquitetura do repositório.

## Licença

[MIT](./LICENSE)

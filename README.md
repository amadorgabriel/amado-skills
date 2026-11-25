# amado-skills

Skills reutilizáveis para agentes de IA (Claude Code, Cursor e ferramentas compatíveis), com foco em carreira e portfólio, rascunhos em evolução e uma curadoria de skills externas creditadas.

## Estrutura

```text
.claude-plugin/
├── marketplace.json       # catálogo self-hosted (amadorgabriel)
└── plugin.json            # plugin amado-skills (apenas skills promovidas)
skills/
├── portfolio/             # skills autorais promovidas (carreira, CV, cartas, ATS)
├── in-progress/           # rascunhos autorais em validação (fora do plugin/vitrine)
└── external/              # skills de terceiros organizadas por autor + CREDITS.md
scripts/
├── install.ps1            # instalador completo Windows (PowerShell)
└── install.sh             # instalador completo WSL / Linux / macOS
docs/
├── adr/                   # decisões de arquitetura do repositório
├── portfolio/             # documentação humana por skill promovida
├── README.md             # onde ficam as skills vs as docs humanas
└── writing-skills.md      # guia de autoria e promoção de skills
```

## Onde ficam as skills e as docs

A fonte de cada skill (o `SKILL.md` que o agente executa) vive em `skills/<bucket>/...`: `skills/portfolio/` para skills autorais promovidas, `skills/in-progress/` para rascunhos e `skills/external/<autor>/<skill>/` para skills de terceiros.

As páginas humanas em `docs/<categoria>/<skill>.md` existem **somente** para skills promovidas (hoje, [docs/portfolio/](docs/portfolio/)). Skills em `external/` e `in-progress/` não têm página em `docs/` até graduarem. Veja também [docs/README.md](docs/README.md).

## Skills promovidas (`skills/portfolio/`)

Estas skills fazem parte da vitrine pública e do plugin do Claude Code.

### Invocação explícita (usuário)

Você chama diretamente pelo nome (`/<skill>`); o agente não dispara sozinho.

| Skill | O que entrega | Documentação |
| --- | --- | --- |
| [`summarize-cv`](skills/portfolio/summarize-cv/SKILL.md) | Pipeline de CV: metas, experiência, masters PT/EN e versão por vaga | [docs/portfolio/summarize-cv.md](docs/portfolio/summarize-cv.md) |
| [`git-commits-to-cv`](skills/portfolio/git-commits-to-cv/SKILL.md) | Extração de conquistas (XYZ + STAR) a partir de histórico git | [docs/portfolio/git-commits-to-cv.md](docs/portfolio/git-commits-to-cv.md) |
| [`cv-md-to-docx`](skills/portfolio/cv-md-to-docx/SKILL.md) | Exportação de masters e CVs adaptados de Markdown para Word `.docx` | [docs/portfolio/cv-md-to-docx.md](docs/portfolio/cv-md-to-docx.md) |

### Invocação automática (modelo)

O agente pode acionar automaticamente quando o pedido se encaixa, ou você pode chamar pelo nome.

| Skill | O que entrega | Documentação |
| --- | --- | --- |
| [`cover-letter`](skills/portfolio/cover-letter/SKILL.md) | Carta de apresentação personalizada para vaga, indicação ou transição | [docs/portfolio/cover-letter.md](docs/portfolio/cover-letter.md) |
| [`resume-ats-optimizer`](skills/portfolio/resume-ats-optimizer/SKILL.md) | Diagnóstico de compatibilidade ATS e cobertura de palavras-chave | [docs/portfolio/resume-ats-optimizer.md](docs/portfolio/resume-ats-optimizer.md) |

## Outros buckets

- **Skills externas ([skills/external/](skills/external/)):** `code-review` (CodeRabbit AI), `lesson` (YudiG12) e `writing-for-agents` (Matt Pocock). Instaladas localmente pelos scripts de cópia, fora do plugin, com licenças e atribuição em [CREDITS.md](skills/external/CREDITS.md).
- **Em progresso ([skills/in-progress/](skills/in-progress/)):** rascunhos como `weekly-report`, instalados localmente para uso diário até graduarem para a vitrine.

## Instalação

### 1. Claude Code (plugin, apenas skills promovidas)

Dentro do Claude Code:

```text
/plugin marketplace add amadorgabriel/amado-skills
/plugin install amado-skills@amadorgabriel
```

### 2. Cursor (via `skills.sh`)

```sh
npx skills@latest add amadorgabriel/amado-skills -a cursor
```

### 3. Instalação local completa (Windows + WSL)

Os scripts abaixo copiam todas as skills ativas (`portfolio/`, `in-progress/` e `external/`) para `~/.claude/skills` e `~/.cursor/skills`, falhando em caso de colisão de nomes. É seguro rodar de novo sempre que atualizar o repositório.

> **Atenção:** não use o plugin do Claude Code junto com o script de cópia para `claude`, para não duplicar as skills promovidas. Se instalar o plugin no Claude Code, rode o script apenas para o Cursor (`-Agents cursor` ou `AGENTS=cursor`).

**Windows (PowerShell):**

```powershell
.\scripts\install.ps1                         # instala todas para Claude Code e Cursor
.\scripts\install.ps1 lesson code-review      # instala só skills específicas
.\scripts\install.ps1 -Agents cursor          # instala só para o Cursor
```

**WSL / Linux / macOS:**

```sh
scripts/install.sh                            # instala todas para Claude Code e Cursor
scripts/install.sh lesson code-review         # instala só skills específicas
AGENTS=cursor scripts/install.sh              # instala só para o Cursor
```

## Regras, autoria e decisões

- [AGENTS.md](./AGENTS.md) (referenciado por [CLAUDE.md](./CLAUDE.md)): regras agnósticas de agente para trabalhar neste repositório, incluindo a política sem travessão.
- [docs/writing-skills.md](./docs/writing-skills.md): guia curto de autoria e promoção de skills (junto de [writing-for-agents](skills/external/mattpocock/writing-for-agents/SKILL.md)).
- [docs/adr/](./docs/adr/): registro de decisões de arquitetura do repositório.

## Licença

[MIT](./LICENSE) para o código e skills autorais. Skills em [skills/external/](skills/external/) preservam suas licenças originais por pasta.
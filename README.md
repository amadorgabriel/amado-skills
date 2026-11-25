# amado-skills

Skills reutilizáveis para agentes de IA (Claude Code, Cursor e ferramentas compatíveis), com foco em carreira e portfólio, rascunhos em evolução e uma curadoria de skills externas.

## Estrutura

```text
.claude-plugin/
├── marketplace.json       # catálogo self-hosted (amadorgabriel)
└── plugin.json            # plugin amado-skills (ainda sem skills promovidas)
skills/
├── in-progress/           # rascunhos autorais em validação (fora do plugin/vitrine)
└── external/              # cópias congeladas de skills de terceiros, por autor
scripts/
├── install.ps1            # instalador completo Windows (PowerShell)
└── install.sh             # instalador completo WSL / Linux / macOS
docs/
├── adr/                   # decisões de arquitetura do repositório
├── in-progress/           # documentação humana das skills em validação
├── README.md             # onde ficam as skills vs as docs humanas
└── writing-skills.md      # guia de autoria e promoção de skills
```

## Onde ficam as skills e as docs

A fonte de cada skill (o `SKILL.md` que o agente executa) vive em `skills/<bucket>/...`: `skills/in-progress/` para rascunhos autorais e `skills/external/<autor>/<skill>/` para skills de terceiros. Ainda não há skills autorais promovidas.

As páginas humanas das skills em validação ficam em [docs/in-progress/](docs/in-progress/). Skills em `external/` não têm página em `docs/` até graduarem. Quando uma skill for promovida, ela passa para `skills/<categoria>/` e a doc para `docs/<categoria>/`. Veja também [docs/README.md](docs/README.md).

## Skills promovidas

Nenhuma no momento. O plugin do Claude Code existe (`.claude-plugin/`), mas o array `skills` em `plugin.json` está vazio. Para usar as skills deste repositório, instale pelos scripts abaixo.

## Skills em progresso (`skills/in-progress/`)

Rascunhos autorais instalados localmente pelos scripts, fora do plugin e da vitrine, até graduarem.

### Invocação explícita (usuário)

Você chama diretamente pelo nome (`/<skill>`); o agente não dispara sozinho.

| Skill | O que entrega | Documentação |
| --- | --- | --- |
| [`summarize-cv`](skills/in-progress/summarize-cv/SKILL.md) | Pipeline de CV: metas, experiência, masters PT/EN e versão por vaga | [docs/in-progress/summarize-cv.md](docs/in-progress/summarize-cv.md) |
| [`git-commits-to-cv`](skills/in-progress/git-commits-to-cv/SKILL.md) | Extração de conquistas (XYZ + STAR) a partir de histórico git | [docs/in-progress/git-commits-to-cv.md](docs/in-progress/git-commits-to-cv.md) |
| [`cv-md-to-docx`](skills/in-progress/cv-md-to-docx/SKILL.md) | Exportação de masters e CVs adaptados de Markdown para Word `.docx` | [docs/in-progress/cv-md-to-docx.md](docs/in-progress/cv-md-to-docx.md) |
| [`weekly-report`](skills/in-progress/weekly-report/SKILL.md) | E-mail semanal de conquistas, impedimentos e plano da próxima semana | |

### Invocação automática (modelo)

O agente pode acionar automaticamente quando o pedido se encaixa, ou você pode chamar pelo nome.

| Skill | O que entrega | Documentação |
| --- | --- | --- |
| [`cover-letter`](skills/in-progress/cover-letter/SKILL.md) | Carta de apresentação personalizada para vaga, indicação ou transição | [docs/in-progress/cover-letter.md](docs/in-progress/cover-letter.md) |
| [`resume-ats-optimizer`](skills/in-progress/resume-ats-optimizer/SKILL.md) | Diagnóstico de compatibilidade ATS e cobertura de palavras-chave | [docs/in-progress/resume-ats-optimizer.md](docs/in-progress/resume-ats-optimizer.md) |

## Outros buckets

- **Skills externas ([skills/external/](skills/external/)):** cópias congeladas em `skills/external/<autor>/<skill>/` (`code-review`, `lesson`, `writing-for-agents`). Instaladas localmente pelos scripts de cópia, fora do plugin.

## Instalação

Enquanto não houver skills promovidas, use os scripts de cópia. É seguro rodar de novo sempre que atualizar o repositório.

> **Atenção:** o plugin ainda não entrega skills. Não use `/plugin install` esperando o conjunto deste repositório; instale com os scripts. Quando houver skills promovidas, evite usar o plugin e o script de cópia juntos no Claude Code, para não duplicar skills.

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

O plugin (reservado para quando houver skills promovidas) e o caminho via `npx` ficam assim:

```text
/plugin marketplace add amadorgabriel/amado-skills
/plugin install amado-skills@amadorgabriel
```

```sh
npx skills@latest add amadorgabriel/amado-skills -a cursor
```

## Regras, autoria e decisões

- [AGENTS.md](./AGENTS.md) (referenciado por [CLAUDE.md](./CLAUDE.md)): regras agnósticas de agente para trabalhar neste repositório, incluindo a política sem travessão.
- [docs/writing-skills.md](./docs/writing-skills.md): guia curto de autoria e promoção de skills (junto de [writing-for-agents](skills/external/mattpocock/writing-for-agents/SKILL.md)).
- [docs/adr/](./docs/adr/): registro de decisões de arquitetura do repositório.

## Licença

[MIT](./LICENSE)
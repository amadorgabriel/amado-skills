# AGENTS

Regras para qualquer agente de IA (Claude Code, Cursor e ferramentas compatíveis) trabalhando neste repositório.

## Onde vivem as skills

As skills versionadas ficam organizadas em três buckets sob `skills/`:

| Pasta | Uso | Instalada localmente? | No plugin / vitrine? |
| --- | --- | --- | --- |
| `skills/portfolio/` | Carreira, CV, cartas e portfólio (skills autorais promovidas) | Sim | Sim |
| `skills/in-progress/` | Rascunhos autorais em validação no uso diário | Sim | Não |
| `skills/external/<autor>/<skill>/` | Cópias congeladas de skills de terceiros, organizadas por autor | Sim | Não |

Os scripts em `scripts/` (`install.ps1` e `install.sh`) copiam todas as skills ativas (`portfolio/`, `in-progress/` e `external/`) de forma achatada para `~/.claude/skills` e `~/.cursor/skills`, e falham em caso de colisão de nome.

O plugin do Claude Code em `.claude-plugin/plugin.json` expõe **apenas** as skills autorais promovidas (`skills/portfolio/`). Não use o plugin e o script de cópia apontando para `claude` ao mesmo tempo, para evitar skills duplicadas.

- Skills sob `_/` (gitignored) são locais e não fazem parte do repositório nem dos scripts de instalação.
- Outputs pessoais de carreira em `skills/portfolio/summarize-cv/output/` e templates `.docx` em `skills/portfolio/cv-md-to-docx/assets/` são gitignored.

## Como criar ou editar skills e documentação

Antes de criar uma nova skill, editar um `SKILL.md` ou atualizar `AGENTS.md`:

- Leia o guia de manutenção do repositório em [docs/writing-skills.md](./docs/writing-skills.md).
- Consulte a referência vendored [skills/external/mattpocock/writing-for-agents/SKILL.md](./skills/external/mattpocock/writing-for-agents/SKILL.md) e [SKILL-MECHANICS.md](./skills/external/mattpocock/writing-for-agents/SKILL-MECHANICS.md).

## Skills pessoais de engenharia fora do repo

Estas skills ficam apenas localmente em `~/.cursor/skills/` (ou `~/.claude/skills/`): `grilling`, `domain-modeling`, `grill-with-docs`, `tlc-spec-driven` e `autofix`. `code-review` fica versionada em `skills/external/coderabbitai/code-review/`.

## Regra de estilo: sem travessão (em-dash)

Nunca use o caractere travessão (U+2014) em nenhum conteúdo gerado: documentos, currículos, cover letters, textos de LinkedIn, comentários de código, mensagens de commit ou respostas no chat.

Motivo: travessão em texto corrido é percebido como marca de conteúdo gerado por IA.

### Como substituir

- Pausa ou aposto explicativo: use vírgula, dois-pontos, ponto e vírgula ou parênteses.
  - Ruim: `Entreguei o projeto [travessão] com todas as métricas [travessão] no prazo`
  - Bom: `Entreguei o projeto, com todas as métricas, no prazo`
- Separação empresa/cidade em CV: use vírgula (`Spott, São Paulo, Brasil`).
- Rótulo de projeto em CV: use dois-pontos (`Projeto QES: liderei...`).
- Seta em texto corrido: escreva por extenso (`KingHost para AWS`).

### Exceções permitidas

- En-dash (U+2013) somente em intervalos de datas e faixas numéricas: `2023–2026`, `70–90 mil`.
- Citação literal de texto de terceiros.
- Código que exija o caractere por restrição técnica (por exemplo, entidade HTML `&mdash;` com motivo documentado).
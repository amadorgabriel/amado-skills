# AGENTS

Regras para qualquer agente de IA (Claude Code, Cursor e ferramentas compatíveis) trabalhando neste repositório.

## Onde vivem as skills

O repositório é um marketplace de plugins para Claude Code (`.claude-plugin/marketplace.json`) e Cursor (`.cursor-plugin/marketplace.json`):

| Pasta | Uso | Exportada em plugin? |
| --- | --- | --- |
| `plugins/<plugin>/skills/<skill>/` | Skills autorais publicadas (`diary`, `job`) | Sim |
| `skills/in-progress/<skill>/` | Rascunhos autorais ainda fora de plugins | Não |
| `skills/external/<autor>/<skill>/` | Cópias congeladas de skills de terceiros, por autor | Nunca |

- Cada plugin é autocontido: `.claude-plugin/plugin.json`, `.cursor-plugin/plugin.json` e `skills/`. Links entre skills só valem dentro do mesmo plugin (sem `..` para fora dele).
- Ao adicionar ou remover um plugin, atualize os dois `marketplace.json` e valide com `claude plugin validate .`.
- Dados pessoais nunca ficam dentro de um plugin: `diary` grava em `~/.diary/`, `job` em `~/.job/` (`JOB_DATA_DIR`).
- Os scripts em `scripts/` copiam os plugins para `~/.cursor/plugins/local/` e as skills soltas (`in-progress/` e `external/`) para `~/.claude/skills` e `~/.cursor/skills`, falhando em colisão de nome.
- Skills sob `_/` (gitignored) são locais e não fazem parte do repositório nem dos scripts de instalação.

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
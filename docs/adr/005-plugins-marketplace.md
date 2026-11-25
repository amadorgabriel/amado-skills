# ADR 005: Repositório como marketplace de plugins (Claude Code e Cursor)

- **Status:** Aceita
- **Data:** 2026-11-25
- **Substitui:** a parte de plugin da [ADR 004](./004-plugin-external-and-in-progress-buckets.md) e o layout por categoria da [ADR 001](./001-categorized-skills-layout.md)

## Contexto

O plugin único `amado-skills` nunca entregou skills: as autorais ficaram todas em `in-progress/`. A meta passou a ser distribuir conjuntos coesos (diário de trabalho, busca de emprego) como plugins separados, instaláveis no Claude Code e no Cursor.

Restrições levantadas:

- Claude Code e Cursor copiam só a pasta do plugin para um cache; caminhos com `..` não funcionam.
- O Cursor lê `.cursor-plugin/` e não documenta fallback para `.claude-plugin/`.
- Para contas individuais, o Cursor carrega plugins de `~/.cursor/plugins/local/`; marketplaces importados do GitHub são recurso de Teams e Enterprise.
- As skills de carreira gravavam dados pessoais dentro da própria pasta, o que seria apagado a cada atualização do plugin.

## Decisão

1. A raiz é um marketplace com dois catálogos equivalentes: `.claude-plugin/marketplace.json` e `.cursor-plugin/marketplace.json`. O `plugin.json` da raiz foi removido.
2. Cada plugin é uma pasta autocontida em `plugins/<plugin>/`, com `.claude-plugin/plugin.json`, `.cursor-plugin/plugin.json` e `skills/<skill>/`.
3. Plugins iniciais: `diary` (`diary`, `privacy-guardrail`; futuro `/report` e hooks) e `job` (`summarize-cv`, `git-commits-to-cv`, `cv-md-to-docx`, `cover-letter`, `resume-ats-optimizer`).
4. Dados pessoais vivem fora dos plugins: `~/.diary/` e `~/.job/` (com override `JOB_DATA_DIR`).
5. `skills/in-progress/` continua para rascunhos ainda fora de plugins; `skills/external/` nunca é exportado.
6. Os scripts copiam plugins para `~/.cursor/plugins/local/` e skills soltas para `~/.claude/skills` e `~/.cursor/skills`; para o Claude Code, indicam o comando do marketplace.
7. `weekly-report` foi removida; o relatório semanal será o `/report` do plugin `diary`.

## Consequências

- Instalação no Claude Code: `/plugin marketplace add amadorgabriel/amado-skills` e `/plugin install <plugin>@amadorgabriel`.
- Instalação no Cursor individual: `scripts/install.ps1` ou `scripts/install.sh`, depois recarregar a janela.
- Toda mudança de plugin exige atualizar os dois catálogos e os dois `plugin.json`.
- Cópias antigas das skills em `~/.claude/skills` e `~/.cursor/skills` precisam ser apagadas uma vez; os scripts avisam.

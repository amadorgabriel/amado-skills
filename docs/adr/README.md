# Architecture Decision Records (ADRs)

Decisões curtas sobre como este repositório organiza, instala e mantém skills entre múltiplos agentes.

| ADR | Decisão | Status |
| --- | --- | --- |
| [001](./001-categorized-skills-layout.md) | Organizar skills em `skills/<categoria>/<nome>/` | Aceita |
| [002](./002-multi-agent-install-scripts.md) | Instalar por cópia em `~/.claude/skills` e `~/.cursor/skills` | Aceita |
| [003](./003-agent-agnostic-rules.md) | Centralizar regras do repo em `AGENTS.md` + `CLAUDE.md` | Aceita |
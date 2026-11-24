# ADR 002: Scripts de instalação por cópia para múltiplos agentes

- **Status:** Aceita
- **Data:** 2026-11-23

## Contexto

Claude Code e Cursor carregam skills globais de diretórios diferentes (`~/.claude/skills` e `~/.cursor/skills`). Além disso, o ambiente principal de trabalho é Windows (PowerShell) com WSL Ubuntu.

## Decisão

Manter dois scripts equivalentes e idempotentes em `scripts/`: `install.ps1` (PowerShell com `robocopy`) e `install.sh` (Bash com `rsync` ou `cp`). Ambos permitem instalar todas as skills ou filtrar por nome e por agente.

## Consequências

- Funciona nativamente no Windows e no WSL/Linux/macOS, sem dependências extras.
- Como a instalação faz cópia, alterações feitas no repo exigem rodar o script novamente para refletir nos agentes.
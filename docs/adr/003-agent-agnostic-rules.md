# ADR 003: Regras do repositório agnósticas de agente

- **Status:** Aceita
- **Data:** 2026-11-23

## Contexto

Regras em `.cursor/rules/*.mdc` só são lidas pelo Cursor. Como este repositório é mantido e usado tanto no Claude Code quanto no Cursor, regras específicas de um único editor criam divergência.

## Decisão

Centralizar todas as instruções do repositório (incluindo a regra de estilo sem travessão) em `AGENTS.md` e manter `CLAUDE.md` na raiz apontando para `@AGENTS.md`. Remover `.cursor/rules/`.

## Consequências

- Uma única fonte de verdade lida por Claude Code, Cursor e outros agentes compatíveis.
# ADR 001: Organizar skills em `skills/<categoria>/<nome>/`

- **Status:** Aceita
- **Data:** 2026-11-23

## Contexto

O repositório começou com `.agents/skills/<categoria>/<nome>/`. Pastas com ponto ficam escondidas na navegação do GitHub e criam a impressão de que o próprio agente lê direto do repo, quando na prática as skills precisam ser instaladas globalmente para valer em outros projetos.

## Decisão

Usar `skills/<categoria>/<nome>/SKILL.md` na raiz do repositório, agrupando por domínio (`engineering/`, `education/`, `portfolio/`). Não usamos uma pasta `skills/beta/` única porque a maioria das skills aqui já está em uso diário.

## Consequências

- Estrutura visível e fácil de navegar no GitHub.
- Os scripts de instalação achatam `<categoria>/<nome>` ao copiar para `~/.claude/skills/<nome>` e `~/.cursor/skills/<nome>`.
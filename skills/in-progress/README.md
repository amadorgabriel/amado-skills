# in-progress

Rascunhos e skills em fase de validação no uso diário.

## Comportamento neste repositório

- **Instaladas localmente:** `scripts/install.ps1` e `scripts/install.sh` instalam todas as skills deste bucket em `~/.claude/skills` e `~/.cursor/skills` para que possam ser testadas em qualquer projeto.
- **Fora da vitrine:** ficam excluídas de `.claude-plugin/plugin.json`, do catálogo principal do `README.md` e de `docs/` até amadurecerem e graduarem para uma categoria estável (seguindo o checklist de [docs/writing-skills.md](../../docs/writing-skills.md)).

## Skills atuais

| Skill | Invocação | Papel |
| --- | --- | --- |
| [`weekly-report`](./weekly-report/SKILL.md) | Usuário (`disable-model-invocation: true`) | Redige e-mail semanal pronto para copiar com conquistas (impacto), impedimentos e plano da próxima semana (com coleta opcional via `git log`) |
# Plugin diary

Diário de trabalho gerado a partir das sessões do agente, anonimizado antes de ser gravado. Dados em `~/.diary/` (fora do plugin).

| Skill | Invocação | O que entrega | Doc |
| --- | --- | --- | --- |
| [`diary`](./skills/diary/SKILL.md) | Usuário (`/diary`) | `~/.diary/AAAA-MM-DD.md` e `.html`: recap, conquistas, desafios e soluções, alterações por projeto, papéis, STAR/XYZ e próximos passos | [doc](../../docs/diary/diary.md) |
| [`privacy-guardrail`](./skills/privacy-guardrail/SKILL.md) | Modelo | Pessoas viram cargos, empresas viram descrições, sem dados da LGPD; mapa local em `~/.diary/.aliases.md` | [doc](../../docs/diary/privacy-guardrail.md) |

Próximos passos do plugin: skill `/report` (relatório semanal a partir dos diários) e um hook `sessionEnd` ou `preCompact` para gerar o diário automaticamente.

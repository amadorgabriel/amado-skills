# diary

## O que faz

Registra o dia de trabalho em `~/.diary/AAAA-MM-DD.md` a partir da sessão atual do agente: o que você alcançou, desafios e soluções, o que alterou em cada projeto, com quem trabalhou, notas de carreira no formato STAR/XYZ e próximos passos.

É um arquivo por dia, fora de qualquer repositório. Rodar de novo no mesmo dia, mesmo em outro projeto, complementa o arquivo em vez de sobrescrever. Inspirada no [claude-diary](https://github.com/rlancemartin/claude-diary), mas focada no seu registro, não na memória do agente.

## Quando usar

- **Modo de invocação:** explícita pelo usuário (`/diary`, com `disable-model-invocation: true`).
- **Use quando:** terminar uma sessão relevante ou o dia de trabalho.
- **Para o e-mail semanal pronto para enviar:** use [weekly-report](../../skills/in-progress/weekly-report/SKILL.md). O futuro `/report` vai ler os diários como fonte.
- **Para bullets de CV a partir de um repositório inteiro:** use [git-commits-to-cv](./git-commits-to-cv.md).

## Dúvidas comuns

**Por que os diários ficam em `~/.diary/` e não no repositório?**
Eles têm nomes de pessoas e detalhes de trabalho, e precisam juntar sessões de vários projetos e ferramentas (Cursor, Claude Code) no mesmo dia.

**Como ela sabe com quem trabalhei?**
Sugere nomes que apareceram na sessão e nos commits e pede sua confirmação. Reuniões fora da sessão entram pelas notas extras.

**E se eu não souber a métrica de uma conquista?**
Fica `[MÉTRICA A CONFIRMAR]` no texto, listado no final da execução para você completar depois.

**O que acontece com o que deixei em aberto ontem?**
A skill lê os próximos passos do último diário: o que foi resolvido vira conquista do dia, o que segue aberto é carregado com `(desde AAAA-MM-DD)`. Diários antigos não são alterados.

## Está funcionando se

- Existe um único arquivo por dia em `~/.diary/`, com frontmatter `date`, `sessions`, `projects`, `people` e `tags`.
- Cada projeto tem sua seção com conquistas, pares de desafio e solução, alterações (arquivos, commits, PRs) e pessoas.
- A seção de carreira traz XYZ com STAR, sem números inventados.
- Os próximos passos são checkboxes marcados com o projeto.

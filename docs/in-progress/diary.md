# diary

## O que faz

Registra o dia de trabalho a partir da sessão atual do agente em dois arquivos: `~/.diary/AAAA-MM-DD.md` (a fonte, lida pelo futuro `/report`) e `~/.diary/AAAA-MM-DD.html` (versão para leitura, autocontida). O conteúdo traz um recap do dia, um sumário com links e as seções: o que alcancei, desafios e soluções, o que alterei em cada projeto, com quem, carreira (STAR/XYZ) e próximos passos.

O diário é anonimizado pela skill [privacy-guardrail](./privacy-guardrail.md): pessoas aparecem como cargo e time, empresas como descrição genérica, sem dados pessoais da LGPD. Rodar de novo no mesmo dia complementa os arquivos em vez de sobrescrever. Inspirada no [claude-diary](https://github.com/rlancemartin/claude-diary), mas focada no seu registro, não na memória do agente.

## Quando usar

- **Modo de invocação:** explícita pelo usuário (`/diary`, com `disable-model-invocation: true`).
- **Use quando:** terminar uma sessão relevante ou o dia de trabalho.
- **Para o e-mail semanal pronto para enviar:** use [weekly-report](../../skills/in-progress/weekly-report/SKILL.md). O futuro `/report` vai ler os diários como fonte.
- **Para bullets de CV a partir de um repositório inteiro:** use [git-commits-to-cv](./git-commits-to-cv.md).

## Dúvidas comuns

**Por que os diários ficam em `~/.diary/` e não no repositório?**
Eles precisam juntar sessões de vários projetos e ferramentas (Cursor, Claude Code) no mesmo dia, e ficam fora de qualquer versionamento.

**Como ela registra com quem trabalhei sem citar nomes?**
Usa cargos e times ("PO do time de pagamentos"). Quando aparece um nome sem cargo conhecido, ela pergunta e guarda a resposta em `~/.diary/.aliases.md`, um mapa local que nunca é copiado para o diário.

**E se eu não souber a métrica de uma conquista?**
Fica `[MÉTRICA A CONFIRMAR]` no texto, listado no final da execução para você completar depois.

**O que acontece com o que deixei em aberto ontem?**
A skill lê os próximos passos do último diário: o que foi resolvido vira conquista do dia, o que segue aberto é carregado com `(desde AAAA-MM-DD)`. Diários antigos não são alterados.

**Posso acrescentar algo que não aconteceu na sessão?**
Sim. Passe notas como argumento (`/diary reunião de planejamento à tarde`) ou responda à pergunta final, que sempre pergunta se você quer adicionar mais alguma informação.

## Está funcionando se

- Existe um par `.md` e `.html` por dia em `~/.diary/`, com frontmatter `date`, `sessions`, `projects`, `roles` e `tags` no `.md`.
- Logo após o título há um recap curto e um sumário com links para todas as seções.
- Nenhum nome de pessoa, empresa, URL de PR ou dado pessoal aparece nos arquivos.
- A seção de carreira traz XYZ com STAR, sem números inventados.
- A execução termina perguntando se você quer adicionar mais alguma informação.

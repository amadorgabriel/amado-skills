# git-commits-to-cv

## O que faz

Lê o histórico de commits de um único repositório git dentro de uma janela de datas e sintetiza de 5 a 8 bullets no formato XYZ (para currículo) acompanhados de notas STAR (para entrevistas), gravando um artefato híbrido em `~/.job/experience/<company-slug>/<project-slug>.md`.

A skill nunca escreve dentro do repositório analisado, nunca altera `current_cv.md` e nunca assume autoria de commits sem confirmação explícita da lista de e-mails encontrados.

## Quando usar

- **Modo de invocação:** invocação explícita pelo usuário (`/git-commits-to-cv`, com `disable-model-invocation: true`).
- **Use quando:** quiser transformar entregas registradas em git em matéria-prima estruturada para o currículo antes da consolidação.
- **Para consolidar vários projetos nos masters PT/EN:** use [summarize-cv](./summarize-cv.md).

## Dúvidas comuns

**Ela pode misturar commits de outros desenvolvedores do time?**
Não. Antes de coletar o histórico, a skill lista os e-mails distintos do repositório e pede sua confirmação de quais pertencem a você.

**O que acontece quando os commits não trazem números de impacto?**
Em vez de estimar ou inventar métricas, a skill insere o marcador `[MÉTRICA A CONFIRMAR]` e reúne esses itens na checklist de validação para você preencher apenas o que tiver evidência.

**Posso rodar de novo no mesmo projeto depois de novas entregas?**
Sim. Quando o artefato já existe, ela aplica Smart Merge para incorporar evidências novas preservando métricas já confirmadas e notas STAR anteriores.

## Está funcionando se

- O artefato gerado agrupa entregas por tema de engenharia (APIs, autenticação, performance, infraestrutura), nunca um bullet para cada commit solto.
- Cada conquista traz um bullet XYZ em PT-BR e sua nota STAR correspondente.
- Métricas não comprovadas no git aparecem claramente marcadas para confirmação, sem números inventados.
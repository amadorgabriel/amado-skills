# privacy-guardrail

## O que faz

Anonimiza registros de trabalho antes de serem gravados: nomes de pessoas viram cargo e time ("gerente do time de plataforma"), nomes de empresas e clientes viram descrição genérica ("fintech de pagamentos"), links de PR viram `PR #n`, e dados pessoais da LGPD (CPF, e-mail, telefone, salário, saúde, dados de clientes) e segredos são removidos.

Os substitutos confirmados ficam em `~/.diary/.aliases.md`, um mapa local e privado que é o único lugar onde nomes reais podem existir.

## Quando usar

- **Modo de invocação:** automática pelo modelo, ao escrever diário, relatório de trabalho, notas de reunião ou qualquer registro compartilhável do seu trabalho.
- **Usada por:** [diary](./diary.md) e, no futuro, `/report`.
- **Fora do escopo:** currículo, cover letter e LinkedIn ([summarize-cv](./summarize-cv.md), [cover-letter](./cover-letter.md)), onde os nomes dos seus empregadores são intencionais.

## Dúvidas comuns

**O que acontece quando aparece alguém que ela não conhece?**
Ela pergunta o cargo e o time, sugerindo um quando o contexto deixa claro, e grava a resposta no mapa para não perguntar de novo.

**Tecnologias também são removidas?**
Não. Ferramentas públicas (React, AWS, Postgres, GitHub) continuam como estão.

**E se o dado removido for importante para a história?**
Ela descreve o tipo do dado em vez do valor, por exemplo "corrigi um vazamento de e-mails de usuários nos logs".

## Está funcionando se

- Nenhum nome do mapa de apelidos aparece no texto final.
- Pessoas aparecem sempre como cargo e time; empresas, como descrição de setor.
- Não há URLs de PR, e-mails, telefones nem documentos no resultado.

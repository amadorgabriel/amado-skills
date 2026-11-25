# summarize-cv

## O que faz

Orquestra o pipeline completo de currículo a partir de uma memória persistente no próprio repositório: definição de metas (`goals.md`), triagem de materiais brutos (`inbox/`), consolidação de experiências em dois currículos master (`master_cv.md` em PT e `master_cv.en.md` em EN) e adaptação direcionada para uma vaga (`master_cv.<job-slug>.md`).

Sua restrição central é a fidelidade factual: nenhum número ou métrica entra nos masters sem estar registrado em `output/cv/confirmed_metrics.md` ou nos artefatos de experiência, e a skill nunca sobrescreve o currículo publicado no portfólio nem executa etapas que pertencem às skills irmãs.

## Quando usar

- **Modo de invocação:** invocação explícita pelo usuário (`/summarize-cv`, com `disable-model-invocation: true`). O agente não aciona este fluxo sozinho em conversas casuais.
- **Use quando:** quiser estruturar objetivos de carreira, absorver materiais novos no currículo, consolidar experiências nos masters PT/EN ou adaptar o master para uma descrição de vaga.

| Precisa de outra etapa? | Skill indicada |
| --- | --- |
| Extrair conquistas de commits git | [git-commits-to-cv](./git-commits-to-cv.md) |
| Exportar Markdown do master para Word `.docx` | [cv-md-to-docx](./cv-md-to-docx.md) |
| Escrever carta de apresentação | [cover-letter](./cover-letter.md) |
| Avaliar compatibilidade ATS e palavras-chave | [resume-ats-optimizer](./resume-ats-optimizer.md) |

## Dúvidas comuns

**A skill sobrescreve meus masters ou varre repositórios sem avisar?**
Não. Etapas pesadas (varredura de repositórios git e reescrita de `master_cv.md` / `master_cv.en.md`) exigem confirmação explícita antes de executar.

**Onde os arquivos gerados são gravados?**
Tudo vai para `skills/in-progress/summarize-cv/output/` (gitignored), dividido entre `goals.md`, `inbox/`, `experience/` e `cv/`.

**Qual é a diferença entre consolidar e adaptar para vaga?**
A consolidação atualiza `master_cv.md` e `master_cv.en.md` a partir da memória de experiências. A adaptação cria um arquivo isolado `master_cv.<job-slug>.md` sem tocar nos masters.

## Está funcionando se

- Toda métrica numérica presente nos masters tem correspondência rastreável em `confirmed_metrics.md` ou em `experience/`.
- Ao adaptar para uma vaga, nasce `master_cv.<job-slug>.md` preservando os masters intactos.
- Pedidos de Word, carta ou ATS são redirecionados para as skills irmãs em vez de improvisados dentro do fluxo.
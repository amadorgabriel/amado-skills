# resume-ats-optimizer

## O que faz

Analisa a compatibilidade de um currículo com sistemas ATS (Applicant Tracking Systems) e mede o alinhamento com uma descrição de vaga. Verifica falhas estruturais que quebram leitores automáticos (tabelas, múltiplas colunas, texto em cabeçalho ou rodapé, imagens) e calcula a cobertura de hard skills, soft skills e termos do setor.

O resultado não reescreve seu currículo cegamente: entrega um relatório com nota estimada, lacunas críticas e sugestões exatas de posicionamento no resumo, na lista de habilidades e nos bullets.

## Quando usar

- **Modo de invocação:** invocação automática pelo modelo ao mencionar ATS, triagem automática, score de currículo ou match com vaga, ou explícita via `/resume-ats-optimizer`.
- **Use quando:** quiser auditar por que um currículo pode estar sendo filtrado antes da triagem humana ou ajustar termos antes de enviar.
- **Para manter os arquivos master do currículo e gerar versões sob medida:** use [summarize-cv](./summarize-cv.md).

## Dúvidas comuns

**A skill recomenda encher o currículo de palavras-chave repetidas?**
Não. Ela sinaliza keyword stuffing como padrão de falha e orienta usar os termos exatos da vaga de forma natural onde há experiência real (2 a 4 ocorrências para termos críticos).

**Qual é a meta de compatibilidade recomendada?**
O guia da skill adota 80% ou mais de cobertura dos termos requeridos pela vaga como referência de bom encaixe.

## Está funcionando se

- O diagnóstico lista separadamente problemas de layout para o parser e palavras-chave ausentes comparadas à vaga.
- Cada sugestão indica em qual seção entrar e propõe um antes e depois concreto sem inventar experiência.
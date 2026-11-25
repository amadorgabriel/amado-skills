# cv-md-to-docx

## O que faz

Converte um currículo em Markdown produzido pelo `summarize-cv` (`master_cv.md`, `master_cv.en.md` ou `master_cv.<job-slug>.md`) em um documento Word `.docx` pronto para envio usando `scripts/md_to_docx.py` e um template Word local em `~/.job/templates/`.

Ela preserva a estrutura tipográfica do modelo (seções, estilos e numeração) sem modificar os arquivos Markdown originais nem o currículo do portfólio.

## Quando usar

- **Modo de invocação:** invocação explícita pelo usuário (`/cv-md-to-docx`, com `disable-model-invocation: true`).
- **Use quando:** o conteúdo em Markdown já estiver revisado e você precisar do arquivo `.docx` formatado para enviar em candidaturas.
- **Para editar conteúdo, consolidar experiências ou adaptar para uma vaga:** use [summarize-cv](./summarize-cv.md) antes de exportar.

## Dúvidas comuns

**Por que os arquivos `.docx` de template não aparecem no GitHub?**
Os templates pessoais (`master_cv_pt_template.docx` e `master_cv_en_template.docx`) ficam em `~/.job/templates/`, fora do plugin e do repositório, para não versionar layout nem dados privados. A variável `JOB_DATA_DIR` muda a pasta raiz.

**A saída é `.docx` ou `.docm`?**
Sempre `.docx` (sem macros), na mesma pasta e com o mesmo nome base do Markdown de entrada, selecionando automaticamente o template PT ou EN conforme o idioma do arquivo.

**Precisa de alguma dependência Python?**
Sim: `python-docx`, listada em `plugins/job/skills/cv-md-to-docx/scripts/requirements.txt`.

## Está funcionando se

- O arquivo `.docx` é criado ao lado do Markdown de origem (`master_cv.docx`, `master_cv.en.docx` ou `master_cv.<job-slug>.docx`).
- Ao abrir no Word, cabeçalho de contato, seções em caixa alta e bullets mantêm o estilo do template sem perda de formatação.
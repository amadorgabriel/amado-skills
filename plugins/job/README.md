# Plugin job

Ferramentas de busca de emprego: CV, conquistas, exportação e candidaturas. Dados pessoais em `~/.job/` (fora do plugin; `JOB_DATA_DIR` muda o local):

```text
~/.job/
├── goals.md        # metas de carreira
├── inbox/          # material bruto e descrições de vaga
├── experience/     # artefatos XYZ + STAR por empresa e projeto
├── cv/             # masters PT/EN, CVs por vaga, métricas confirmadas, .docx
└── templates/      # templates Word do cv-md-to-docx
```

| Skill | Invocação | O que entrega | Doc |
| --- | --- | --- | --- |
| [`summarize-cv`](./skills/summarize-cv/SKILL.md) | Usuário | Pipeline de CV: metas, experiência, masters PT/EN e versão por vaga | [doc](../../docs/job/summarize-cv.md) |
| [`git-commits-to-cv`](./skills/git-commits-to-cv/SKILL.md) | Usuário | Conquistas (XYZ + STAR) a partir de histórico git | [doc](../../docs/job/git-commits-to-cv.md) |
| [`cv-md-to-docx`](./skills/cv-md-to-docx/SKILL.md) | Usuário | Masters e CVs adaptados de Markdown para Word `.docx` | [doc](../../docs/job/cv-md-to-docx.md) |
| [`cover-letter`](./skills/cover-letter/SKILL.md) | Modelo | Carta de apresentação personalizada para uma vaga | [doc](../../docs/job/cover-letter.md) |
| [`resume-ats-optimizer`](./skills/resume-ats-optimizer/SKILL.md) | Modelo | Compatibilidade ATS e match de palavras-chave | [doc](../../docs/job/resume-ats-optimizer.md) |

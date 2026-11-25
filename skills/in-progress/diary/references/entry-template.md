# Diary entry template

Contract between `diary` (writer) and `/report` (reader). Keep frontmatter keys, heading names, and heading levels stable; change them only together with every reader.

## Rules

- File: `~/.diary/YYYY-MM-DD.md`, one per day.
- `sessions`: one string per run, `"HH:MM <project>@<branch>"`.
- `projects`: repo folder names, same spelling as the `## <project>` headings.
- `people`: `"Nome (papel)"`, as confirmed by the user.
- `tags`: 1 to 5 lowercase topics (ex.: `auth`, `infra`, `docs`).
- One `## <project>` section per project, with all four `###` subsections; write `- Nada registrado.` when one is empty.
- `## Carreira (STAR/XYZ)` and `## Próximos passos` appear once, after all project sections.
- Next steps: `- [ ] (<project>) <ação>`, plus `(desde YYYY-MM-DD)` when carried over.

## Template

```markdown
---
date: 2026-11-25
sessions:
  - "15:47 amado-skills@feat/diary-skill"
projects: [amado-skills]
people: ["Fulano (PM, alinhamento)", "Ciclano (code review)"]
tags: [skills, docs]
---
# Diário, 25/11/2026

## amado-skills

### O que alcancei
- Criei a skill `diary`, que registra o dia de trabalho em um arquivo por dia.

### Desafios e soluções
- **Desafio:** /report precisa filtrar por semana e projeto sem índice.
  **Solução:** frontmatter fixo e um arquivo por dia em `~/.diary/`.
  **Por quê:** leitura simples por glob, sem banco de dados.

### O que alterei
- `skills/in-progress/diary/SKILL.md` (novo)
- Commit `abc1234`: Add diary skill
- PR: https://github.com/<owner>/<repo>/pull/<n>

### Com quem
- Fulano: alinhamos o escopo do relatório semanal.

## Carreira (STAR/XYZ)

- **XYZ:** Reduzi o tempo de montar o relatório semanal em [MÉTRICA A CONFIRMAR], medido por minutos por relatório, criando um diário estruturado consumido por automação.
  - **S:** Relatórios semanais montados de memória, sem histórico confiável.
  - **T:** Ter registro diário pesquisável por projeto.
  - **A:** Desenhei o formato do diário e a skill que o gera a partir da sessão.
  - **R:** [MÉTRICA A CONFIRMAR]

## Próximos passos
- [ ] (amado-skills) Criar a skill /report lendo `~/.diary/`
- [ ] (portfolio) Revisar textos da home (desde 2026-11-24)
```

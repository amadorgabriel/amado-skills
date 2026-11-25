# Diary entry template

Contract between `diary` (writer) and `/report` (reader). Keep frontmatter keys, heading names, and heading levels stable; change them only together with every reader.

## Rules

- File: `~/.diary/YYYY-MM-DD.md`, one per day. Content follows the `privacy-guardrail` skill.
- `sessions`: one string per run, `"HH:MM <project>@<branch>"`.
- `projects`: project names or aliases, same spelling as the `## <project>` headings.
- `roles`: `"Cargo (time)"`, never a person's name.
- `tags`: 1 to 5 lowercase topics (ex.: `auth`, `infra`, `docs`).
- Recap: 2 to 4 sentences right after the title, saying what the day was about and its main outcome. No bullets.
- `## Sumário`: one link per `##` section, in order, using GitHub anchors (lowercase, spaces as `-`, punctuation dropped).
- One `## <project>` section per project, with all four `###` subsections; write `- Nada registrado.` when one is empty.
- `## Carreira (STAR/XYZ)` and `## Próximos passos` appear once, after all project sections. `## Notas adicionais` only when the user added free text that fits nowhere else.
- Next steps: `- [ ] (<project>) <ação>`, plus `(desde YYYY-MM-DD)` when carried over.
- Changes: PRs as `PR #n`, commits as short hashes, no URLs.

## Template

```markdown
---
date: 2026-11-25
sessions:
  - "15:47 amado-skills@feat/diary-skill"
projects: [amado-skills]
roles: ["PO (time de pagamentos)", "dev sênior (time de plataforma)"]
tags: [skills, docs]
---
# Diário, 25/11/2026

Dia dedicado a estruturar o registro diário de trabalho no repositório de skills. A skill `diary` foi criada e passou a anonimizar pessoas e empresas, o que prepara o terreno para o relatório semanal.

## Sumário

- [amado-skills](#amado-skills)
- [Carreira (STAR/XYZ)](#carreira-starxyz)
- [Próximos passos](#próximos-passos)

## amado-skills

### O que alcancei
- Criei a skill `diary`, que registra o dia de trabalho em um arquivo por dia.

### Desafios e soluções
- **Desafio:** /report precisa filtrar por semana e projeto sem índice.
  **Solução:** frontmatter fixo e um arquivo por dia em `~/.diary/`.
  **Por quê:** leitura simples por glob, sem banco de dados.

### O que alterei
- `plugins/diary/skills/diary/SKILL.md` (novo)
- Commit `abc1234`: Add diary skill
- PR #9

### Com quem
- PO do time de pagamentos: alinhamos o escopo do relatório semanal.

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

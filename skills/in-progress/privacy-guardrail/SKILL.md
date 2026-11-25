---
name: privacy-guardrail
description: >-
  Anonymizes work records before they are written: people become role plus
  team, companies and clients become generic descriptions, and LGPD personal
  data and secrets are removed. Use when writing a diary entry, a work report,
  meeting notes, or any shareable record of the user's work that mentions
  people, companies, clients, or personal data.
---

# Privacy guardrail

A work record describes what happened, never who exactly or for which named company. Every person is a **role**, every company is a **description**, every personal datum is gone. Apply this while writing, then run the sweep before saving.

Out of scope: CV, cover letter, and LinkedIn artefacts, where the user's own employers are named on purpose.

## Substitutions

| Found | Write instead | Example |
| --- | --- | --- |
| Person's name | Role + team | "PO do time de pagamentos", "gerente do time de plataforma" |
| The user's own name | First person | "eu", or omit |
| Company, client, or employer name | Generic sector description | "fintech de pagamentos", "cliente do varejo" |
| Branded team or product name revealing the company | Function of the team or product | "time de checkout", "app de fidelidade" |
| Repo name revealing the company | Project alias | `checkout-web` in place of `acme-checkout-web` |
| PR or commit URL | Short reference | `PR #123`, commit `abc1234` |

Keep public tools and technologies as they are (React, AWS, Postgres, GitHub).

## Removed outright

LGPD personal data and anything that identifies a person or leaks access:

- CPF, RG, CNPJ, e-mail, phone, home address, bank data
- Salary, compensation, health, performance evaluations of named or identifiable people
- Data of clients or end users (records, logs with personal data, screenshots)
- Tokens, keys, passwords, internal hostnames and URLs

When a removed datum matters for the story, describe its kind: "corrigi um vazamento de e-mails de usuários nos logs".

## Alias map

`~/.diary/.aliases.md` is the local, private map from real names to their substitutes. It is the only file allowed to hold real names; never copy its left column anywhere else.

```markdown
## Pessoas
- Julia: PO do time de pagamentos

## Empresas e clientes
- Acme: fintech de pagamentos

## Projetos
- acme-checkout-web: checkout-web
```

1. Read the map before writing. Reuse every known substitute.
2. For a name not in the map, ask the user for the role and team (or the description, or the alias). Suggest a substitute when context makes one likely.
3. Append each confirmed substitute to the map, creating the file if missing.

## Sweep

Before saving, reread the full text (body, frontmatter, file paths shown, HTML) and check:

- [ ] No left-column entry from the alias map appears
- [ ] No capitalized word that reads as a person or company name remains unexplained
- [ ] No item from the removed list appears
- [ ] Links are short references only

Rewrite every hit, then sweep again. Done when a sweep finds nothing.

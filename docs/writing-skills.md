# Guia de autoria de skills e documentação

Guia prático de manutenção para criar, editar e publicar skills neste repositório. Para princípios de escrita para agentes (ponteiros de contexto, carga de contexto vs carga cognitiva, divulgação progressiva e corte de instruções redundantes), consulte a skill vendored [`writing-for-agents`](../skills/external/mattpocock/writing-for-agents/SKILL.md) e [`SKILL-MECHANICS.md`](../skills/external/mattpocock/writing-for-agents/SKILL-MECHANICS.md).

## Anatomia mínima de uma skill

Cada skill mora em uma pasta própria cujo nome é idêntico ao campo `name` no frontmatter de `SKILL.md`:

```yaml
---
name: minha-skill
description: >-
  Resumo objetivo do que faz e quando acionar (ou resumo curto se user-invoked).
disable-model-invocation: true # inclua quando for apenas por chamada explícita
---
```

- **Frontmatter obrigatório:** `name` e `description` como strings válidas em YAML, com `name` idêntico ao nome da pasta da skill.
- **Arquivos irmãos:** coloque referências extensas, templates ou estilos em arquivos separados (`STYLE.md`, `references/`, `scripts/`) e aponte para eles a partir de `SKILL.md`, carregando apenas quando o fluxo precisar.
- **Dados do usuário:** nunca dentro da pasta da skill. Plugins são copiados para um cache que é substituído a cada atualização; use uma pasta em `~` (`~/.diary/`, `~/.job/`).
- **Estilo:** siga a regra sem travessão (U+2014) definida em [AGENTS.md](../AGENTS.md).

## Escolha de invocação

| Modo | Frontmatter | Quando escolher |
| --- | --- | --- |
| **Usuário (explícita)** | `disable-model-invocation: true` | Fluxos sob demanda que o usuário chama pelo nome (`/skill`). Não consome janela de contexto até ser chamada. |
| **Modelo (automática)** | Omitir `disable-model-invocation` | Regras ou utilidades que o agente precisa acionar sozinho quando o assunto surgir. A `description` deve listar os gatilhos reais sem duplicar sinônimos. |

## Onde colocar cada skill

| Destino | Uso | Exportada em plugin? |
| --- | --- | --- |
| `plugins/<plugin>/skills/<skill>/` | Skill autoral publicada | Sim |
| `skills/in-progress/<skill>/` | Rascunho autoral em validação | Não |
| `skills/external/<autor>/<skill>/` | Cópia congelada de skill de terceiros | Nunca |
| `skills/_/` (gitignored) | Rascunho privado só da máquina local | Não |

Para skills externas, coloque a cópia congelada em `skills/external/<autor>/<skill>/`, só com os arquivos brutos da skill (por exemplo `SKILL.md`).

## Anatomia de um plugin

```text
plugins/<plugin>/
├── .claude-plugin/plugin.json   # name, version, description, author, repository, license, keywords
├── .cursor-plugin/plugin.json   # mesmos campos + displayName, category, tags
├── README.md                    # tabela das skills do plugin
├── skills/<skill>/SKILL.md      # descobertas automaticamente
└── hooks/hooks.json             # opcional
```

- O `name` do plugin é igual ao nome da pasta e aparece nos dois `marketplace.json` da raiz.
- Links relativos só podem apontar para dentro do próprio plugin.
- Suba `version` nos dois `plugin.json` quando o comportamento de uma skill mudar.

## Documentação por skill

- Skills em plugins têm página humana em `docs/<plugin>/<skill>.md`.
- Skills em `in-progress/` podem ter página em `docs/in-progress/<skill>.md`.
- Skills em `external/` não têm página em `docs/`.

A página orienta quem decide se deve usar a skill, sem repetir o passo a passo de `SKILL.md`, seguindo quatro seções:

1. `## O que faz`: tarefa principal e restrição que define o comportamento da skill.
2. `## Quando usar`: modo de invocação (usuário ou modelo) e fronteira com skills irmãs.
3. `## Dúvidas comuns`: perguntas reais e diretas sobre limites, saídas ou pré-requisitos.
4. `## Está funcionando se`: sinais observáveis no resultado sem precisar abrir `SKILL.md`.

## Checklist de publicação (de `in-progress/` para um plugin)

1. Mover a pasta de `skills/in-progress/<skill>/` para `plugins/<plugin>/skills/<skill>/` (ou criar o plugin, com os dois `plugin.json`, e registrá-lo nos dois `marketplace.json`).
2. Garantir que a skill não grava dados dentro da própria pasta e não tem links para fora do plugin.
3. Mover ou criar `docs/<plugin>/<skill>.md` com as quatro seções acima.
4. Listar a skill no `README.md` do plugin e no `README.md` da raiz, com link para `SKILL.md` e para a doc.
5. Subir `version` nos dois `plugin.json`, rodar `claude plugin validate .` e reexecutar o instalador.

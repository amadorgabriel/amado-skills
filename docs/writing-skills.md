# Guia de autoria de skills e documentação

Guia prático de manutenção para criar, editar e promover skills neste repositório. Para princípios de escrita para agentes (ponteiros de contexto, carga de contexto vs carga cognitiva, divulgação progressiva e corte de instruções redundantes), consulte a skill vendored [`writing-for-agents`](../skills/external/mattpocock/writing-for-agents/SKILL.md) e [`SKILL-MECHANICS.md`](../skills/external/mattpocock/writing-for-agents/SKILL-MECHANICS.md).

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
- **Estilo:** siga a regra sem travessão (U+2014) definida em [AGENTS.md](../AGENTS.md).

## Escolha de invocação

| Modo | Frontmatter | Quando escolher |
| --- | --- | --- |
| **Usuário (explícita)** | `disable-model-invocation: true` | Fluxos sob demanda que o usuário chama pelo nome (`/skill`). Não consome janela de contexto até ser chamada. |
| **Modelo (automática)** | Omitir `disable-model-invocation` | Regras ou utilidades que o agente precisa acionar sozinho quando o assunto surgir. A `description` deve listar os gatilhos reais sem duplicar sinônimos. |

## Onde colocar cada skill

| Destino | Uso | Instalada localmente? | Vai no plugin e vitrine? |
| --- | --- | --- | --- |
| `skills/<categoria>/<skill>/` | Skill autoral estável | Sim | Sim |
| `skills/in-progress/<skill>/` | Rascunho autoral em validação | Sim | Não |
| `skills/external/<autor>/<skill>/` | Cópia congelada de skill de terceiros | Sim | Não |
| `skills/_/` (gitignored) | Rascunho privado só da máquina local | Não | Não |

Para skills externas, coloque a cópia congelada em `skills/external/<autor>/<skill>/`, só com os arquivos brutos da skill (por exemplo `SKILL.md`).

## Documentação por skill promovida

Toda skill promovida em `skills/<categoria>/<skill>/` deve ter uma página humana em `docs/<categoria>/<skill>.md`. Ela orienta quem decide se deve usar a skill, sem repetir o passo a passo de `SKILL.md`, seguindo quatro seções:

1. `## O que faz`: tarefa principal e restrição que define o comportamento da skill.
2. `## Quando usar`: modo de invocação (usuário ou modelo) e fronteira com skills irmãs.
3. `## Dúvidas comuns`: perguntas reais e diretas sobre limites, saídas ou pré-requisitos.
4. `## Está funcionando se`: sinais observáveis no resultado sem precisar abrir `SKILL.md`.

## Checklist de promoção (de `in-progress/` para categoria estável)

1. Mover a pasta de `skills/in-progress/<skill>/` para `skills/<categoria>/<skill>/` e atualizar `skills/<categoria>/README.md`.
2. Adicionar `"./skills/<categoria>/<skill>"` em `.claude-plugin/plugin.json`.
3. Criar `docs/<categoria>/<skill>.md` com as quatro seções acima.
4. Listar a skill no grupo correto (**Usuário** ou **Modelo**) em `README.md` e `skills/<categoria>/README.md`, com link para `SKILL.md` e para a doc.
5. Remover a linha de `skills/in-progress/README.md` e reexecutar o instalador local.
## O que muda

<!-- Resuma a mudança em poucos pontos. -->

## Por quê

<!-- Por que esta mudança é necessária agora. -->

## Tipo

- [ ] Nova skill
- [ ] Ajuste de skill
- [ ] Docs
- [ ] Infra

## Checklist

- [ ] Frontmatter: `name` é igual ao nome da pasta
- [ ] Frontmatter: `description` diz o que a skill faz e quando usar
- [ ] `disable-model-invocation: true` quando a skill for apenas por invocação explícita
- [ ] Doc humana em `docs/<bucket>/<skill>.md` (promovida) ou `docs/in-progress/<skill>.md` (em validação)
- [ ] `.claude-plugin/plugin.json` atualizado se a skill for promovida
- [ ] `README.md` e o catálogo do bucket atualizados
- [ ] Nenhum travessão (U+2014)
- [ ] Testado com `scripts/install.ps1` ou `scripts/install.sh`
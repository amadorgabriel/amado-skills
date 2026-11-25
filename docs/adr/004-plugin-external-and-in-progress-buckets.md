# ADR 004: Plugin do Claude Code e buckets `external/` e `in-progress/`

- **Status:** Aceita
- **Data:** 2026-11-24

## Contexto

Com a adoção de skills de terceiros (`lesson`, `code-review`, `writing-for-agents`) e rascunhos em teste (`weekly-report`), misturar tudo nas mesmas pastas de categoria separa mal o que já está maduro e impede distribuir o repositório como plugin limpo do Claude Code sem incluir rascunhos instáveis ou cópias de terceiros no plugin.

## Decisão

1. **Plugin autocontido em `.claude-plugin/`:** publicar `plugin.json` (`amado-skills`) e `marketplace.json` (`amadorgabriel`) listando explicitamente apenas as skills autorais promovidas (atualmente `skills/portfolio/*`).
2. **Bucket `skills/external/<autor>/<skill>/`:** guardar cópias congeladas das skills de terceiros, apenas com os arquivos brutos da skill, organizadas pelo autor. Os scripts em `scripts/` instalam essas skills localmente e falham em caso de colisão de nome, enquanto o plugin as deixa de fora.
3. **Bucket `skills/in-progress/`:** guardar rascunhos autorais em iteração. Eles são instalados localmente pelos scripts para uso diário, mas ficam fora de `.claude-plugin/plugin.json`, da vitrine do `README.md` e de `docs/` até graduarem.
4. **Remoção de buckets vazios:** categorias sem skills (`education/`, `engineering/`, `financial/`, `job/`) são removidas em vez de mantidas com `.gitkeep`.

## Consequências

- Usuários externos podem instalar o plugin via `/plugin marketplace add amadorgabriel/amado-skills` ou Cursor via `npx skills@latest add amadorgabriel/amado-skills -a cursor` recebendo apenas skills autorais estáveis.
- O mantenedor continua usando rascunhos e skills externas normalmente no Claude Code e no Cursor via `scripts/install.ps1` e `scripts/install.sh` (evitando rodar plugin e script simultaneamente no Claude Code para não duplicar skills).
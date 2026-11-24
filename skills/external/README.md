# external

Bucket de skills mantidas ou adaptadas a partir de repositórios de terceiros, organizadas por autor em `skills/external/<autor>/<skill>/`.

## Convenção de créditos

- Cada pasta de skill externa deve conter o arquivo `LICENSE` original e um `SOURCE.md` com repositório, caminho upstream, commit ou hash e adaptações locais.
- Todas as entradas devem constar na tabela de [CREDITS.md](./CREDITS.md).

## Instalação e plugin

- **Instalação local:** `scripts/install.ps1` e `scripts/install.sh` incluem `external/` e achatam para `~/.claude/skills/<skill>` e `~/.cursor/skills/<skill>`. Em caso de colisão de nome com outra skill, o instalador interrompe com erro.
- **Claude Code plugin:** skills externas **não** entram em `.claude-plugin/plugin.json`. Quem quiser essas skills via plugin em outro ambiente deve instalar diretamente do repositório do autor original.

## Quando promover ou manter aqui

- Mantenha em `external/` cópias fiéis ou com ajustes mínimos de ambiente (como wrapper WSL).
- Se uma skill for profundamente reescrita para fluxo próprio, mova para uma categoria autoral mantendo a atribuição no `README.md` da categoria.

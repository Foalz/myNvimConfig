# zshrc

`.zshrc` de trabajo, orientado a desarrollo sobre Odoo 16 (repo `nx-ridery`). Además
de configuración estándar de zsh/p10k, define un set de aliases y funciones para:

- moverse rápido entre repos/servicios (aliases simples),
- ver logs de Odoo coloreados,
- crear ramas de release/feature con convención de nombre,
- correr una instancia de Odoo apuntando al código de un worktree sin tocar
  la instancia real (`owt`),
- actualizar módulos según lo que cambió en git (`oup`),
- correr tests de un módulo (`otest`),
- crear/gestionar git worktrees hermanos del repo con push bloqueado por
  defecto (`wt`).

Documentación técnica de cada función/alias no trivial, en `docs/`:

| Doc | Cubre |
|---|---|
| [`docs/wt.md`](docs/wt.md) | `wt` — crear/listar/bloquear/eliminar git worktrees |
| [`docs/owt.md`](docs/owt.md) | `owt` — correr Odoo con el addons_path de un worktree |
| [`docs/oup.md`](docs/oup.md) | `oup` — actualizar módulos Odoo según cambios de git |
| [`docs/otest.md`](docs/otest.md) | `otest` — correr tests de un módulo Odoo |
| [`docs/syp.md`](docs/syp.md) | `syp` — crear rama de ticket a partir de main |
| [`docs/release.md`](docs/release.md) | `today-main`/`today-stg`/etc — ramas de release por fecha |
| [`docs/misc.md`](docs/misc.md) | `obin`, `odoo()`, aliases simples y de logs |

## Aliases simples (sin doc propia)

```sh
alias cx="claude"
alias odir="cd /opt/odoo16/repos/nx-ridery"
alias l="ls"
alias la="ls -la"
alias gg='lazygit'
alias gs='git status'
alias gb="git branch | grep '*'"
alias gls="..."   # git log gráfico con formato
alias glo="git log --oneline"
alias on='cd /opt/odoo16/ && nvim'
alias cc="..."    # genera un commit con Claude a partir del diff staged
gc() { git checkout "$1" }
```

## Variables de entorno relevantes

- `ODOO_V=16` — versión de Odoo por defecto para `obin`/`oup`/`otest`.
- `ODOO_REPO` / `SYP_REPO_DIR` = `/opt/odoo16/repos/nx-ridery` — repo principal.
- `ODOO_DB` — db por defecto (si no se define, se lee `db_name` del `.conf`).
- `RELEASE_AUTHOR="pedro"` — sufijo de las ramas de release.
- `OWT_DEV_PORT=8070` — puerto por defecto de `owt start` (8069 lo usa el
  servicio real vía `systemctl odoo16`).

## Convención visual de los prompts interactivos

Las funciones que piden confirmación (`wt create`, `syp create`, `owt use`,
`owt dev`, `_release_create`) comparten helpers de output (`_syp_step`,
`_syp_box`, `_o_msg`/`_o_ok`/`_o_warn`/`_o_err`) que imprimen un spinner con
check/cruz al estilo Vite/Claude Code. Ver `docs/misc.md` si hace falta tocar
ese formato.

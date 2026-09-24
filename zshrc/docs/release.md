# `today-*` — ramas de release/update por fecha

Fuente: `.zshrc` líneas 77–127.

```sh
today-main [FECHA]     # main_release_YYYY_MM_DD_pedro     desde main
today-stg [FECHA]      # staging_update_YYYY_MM_DD_pedro   desde staging-ridery
today-qa [FECHA]       # qa_update_YYYY_MM_DD_pedro        desde qa
today-beta [FECHA]     # beta_update_YYYY_MM_DD_pedro      desde beta-ridery
today-preprod [FECHA]  # preprod_update_YYYY_MM_DD_pedro   desde preprod
```

Todas son wrappers de una línea sobre `_release_create <base_branch> <prefix>
<fecha_opcional>` (líneas 118–127). `FECHA` es opcional; si no se pasa, usa
hoy.

## `_release_create` (líneas 81–114)

1. `cd $SYP_REPO_DIR`.
2. Resuelve la fecha: si se pasó `$fecha`, la normaliza con
   `date -d "$fecha" +%Y_%m_%d` (acepta cualquier formato que entienda
   `date -d`, ej. `"yesterday"`, `"2026-09-20"`) — si `date` no puede
   parsearla, corta con error. Sin fecha, usa `date +%Y_%m_%d`.
3. Arma `branch="${prefix}_${d}_${RELEASE_AUTHOR}"` (`RELEASE_AUTHOR="pedro"`,
   línea 77 — a diferencia de `wt create`, que hardcodea `"Pedro"` en
   `_wt_create` en vez de leer esta variable).
4. `git checkout <base_branch>` → `git pull origin <base_branch>` →
   `git checkout -b <branch>`.
5. Pregunta (default sí) si pushear con `--set-upstream origin <branch>`.

## Por qué existe `unalias` antes de definir las funciones (línea 116)

```sh
unalias today-main today-stg today-qa today-beta 2>/dev/null
```

Si alguna vez estos nombres quedaron definidos como `alias` en una sesión
anterior (o en una versión previa de este archivo), un `alias` con el mismo
nombre que la función tiene prioridad y la función nunca se llegaría a
ejecutar. El `unalias` defensivo limpia eso antes de declarar las funciones;
el `2>/dev/null` evita el error si no existían.

## Reuso de helpers de output

Comparte `_syp_step` y `_syp_box` con `syp create`, `wt create` y `owt use`
— ver `docs/misc.md`.

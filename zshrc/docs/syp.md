# `syp` — crear rama de ticket a partir de main

Fuente: `.zshrc` líneas 649–728.

```sh
syp create [-n NUMERO] [-d "DESCRIPCION"] [-p]
```

- `-n/--number`: número del ticket (obligatorio salvo `-p`).
- `-d/--description`: descripción corta.
- `-p/--personal`: rama personal, sin prefijo `SYP-NUMERO`.

`create`/`-c`/`--create` son las únicas acciones válidas; cualquier otra cosa
imprime el uso y corta.

## Flujo (líneas 656–728)

1. `cd $SYP_REPO_DIR` (repo principal, `/opt/odoo16/repos/nx-ridery`).
2. Sin argumentos entra en modo interactivo: pregunta si es rama personal
   (default no), número si no es personal, y descripción.
3. Slug: igual criterio que `wt create` (ver `docs/wt.md`) — no-alfanumérico
   → espacio, Title-Case por palabra, unido con `-`.
4. Nombre de rama:
   - personal: `<Slug>-Pedro`.
   - con número: `SYP-<numero>-<Slug>`.
5. Siempre sincroniza antes de ramificar: `git checkout main` →
   `git pull origin main` → `git checkout -b <branch>`. A diferencia de
   `wt create` (que rama desde `origin/<base>` sin tocar el checkout local),
   `syp` deja al usuario parado en `main` actualizado y crea la rama desde
   ahí — porque `syp` opera sobre el propio checkout de `$SYP_REPO_DIR`, no
   crea un worktree nuevo.
6. Pregunta (default sí) si pushear con `--set-upstream origin <branch>`.

## Diferencia clave con `wt create`

`syp create` rama **dentro del mismo checkout** de `$SYP_REPO_DIR` (mueve el
`HEAD` actual). `wt create` crea un **worktree nuevo**, carpeta hermana,
dejando el checkout principal intacto. Se usa `syp` para trabajo secuencial
en el mismo directorio y `wt` cuando se quiere tener varias ramas
checkouteadas en paralelo (típicamente para que un agente trabaje en una sin
pisar el directorio de trabajo activo).

## Reuso de helpers de output

Comparte `_syp_step` y `_syp_box` con `wt create`, `owt use` y
`_release_create` — ver `docs/misc.md`.

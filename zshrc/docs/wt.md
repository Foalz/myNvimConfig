# `wt` — git worktrees hermanos con push bloqueado por defecto

Fuente: `.zshrc` líneas 730–949.

`wt` es un dispatcher (líneas 929–949) que delega en funciones `_wt_*` según
el primer argumento:

```
wt create [-d "DESCRIPCION"] [-b RAMA_BASE] [-r RUTA]
wt lock [ruta]
wt unlock [ruta]
wt list | ls
wt remove <ruta> [-f]
wt submodules | sub [ruta]
```

Todo corre sobre `$SYP_REPO_DIR` (`/opt/odoo16/repos/nx-ridery`), el repo
principal — los worktrees se crean como carpetas hermanas de ese repo.

## `wt create` — `_wt_create` (líneas 799–871)

1. Sin argumentos entra en modo interactivo: pide descripción y rama base
   (default `main`). Con flags, usa `-d/--description`, `-b/--base`,
   `-r/--ruta`.
2. Arma el nombre de rama a partir de la descripción:
   - reemplaza todo lo que no sea alfanumérico por espacios (`sed -E
     's/[^A-Za-z0-9]+/ /g'`),
   - Title-Case cada palabra y las une con `-` (`awk` con `OFS='-'`),
   - le agrega el sufijo `-Pedro` (variable `personal="Pedro"`, hardcodeada),
     salvo que la descripción ya termine en eso (case-insensitive).
   - Ej: `wt create -d "correos payslip"` → rama `Correos-Payslip-Pedro`.
3. Si no se pasó `-r`, la ruta del worktree se arma como
   `<carpeta-padre-del-repo>/<nombre-del-repo>-<slug-en-minúscula>`.
   Ej: repo en `/opt/odoo16/repos/nx-ridery` → worktree en
   `/opt/odoo16/repos/nx-ridery-correos-payslip-pedro`.
4. `git fetch origin <base>` y luego `git worktree add -b <branch> <ruta>
   origin/<base>` — la rama nueva sale de la punta remota de `base`, no del
   local (evita traer commits locales no pusheados de esa rama base).
5. Pregunta (default sí) si poblar submódulos → llama a
   `_wt_submodules_local` (ver abajo).
6. Pregunta (default sí) si bloquear el push → llama a `_wt_lock`.

## Bloqueo de push: `_wt_lock` / `_wt_unlock` (líneas 743–758)

No usa hooks ni permisos de filesystem. El truco es pisar la `pushurl` del
remoto **a nivel de worktree** (git ≥ 2.5 permite config por-worktree si se
habilita `extensions.worktreeConfig`):

```sh
git config extensions.worktreeConfig true
git config --worktree remote.origin.pushurl "DO-NOT-PUSH-blocked-by-wt-lock"
```

- `--worktree` hace que el valor solo aplique a *ese* worktree, no al repo
  principal ni a los demás worktrees (a diferencia de `git config` a secas,
  que escribiría en el `.git/config` compartido).
- `git push` intenta resolver esa URL falsa y falla con un error de
  "repository not found" — el fetch/pull normal no se ve afectado porque solo
  se pisa `pushurl`, no `url`.
- `_wt_unlock` simplemente hace `--unset` de esa key con `--worktree`.

`WT_PUSHURL_BLOCKED` (línea 730) es la constante con el string de la URL
falsa — solo importa que sea inválida, el texto es a fines de diagnóstico.

## `wt list` — `_wt_list` (líneas 761–771)

Recorre `git worktree list` y por cada línea chequea si esa ruta tiene seteado
`remote.origin.pushurl` a nivel `--worktree`; si existe, la marca con 🔒,
si no, con 🔓. No valida que el valor sea justo el de `WT_PUSHURL_BLOCKED` —
cualquier `pushurl` de worktree se muestra como bloqueado.

## Submódulos locales: `_wt_submodules_local` (líneas 773–794)

Los submódulos de `nx-ridery` (`queue`, `storage`, `server-env`, `nimetrix/*`)
normalmente se clonarían de GitHub, y los de `nimetrix` son privados por SSH
sin clave configurada en esta máquina. En vez de eso, este helper clona cada
submódulo **desde la copia ya presente en el repo principal**, vía URL
`file://`:

1. Lee `.gitmodules` del worktree con
   `git config -f .gitmodules --get-regexp '^submodule\..*\.path$'` para
   obtener cada `submodule.<name>.path`.
2. Por cada uno arma `-c submodule.<name>.url=$SYP_REPO_DIR/<path>` — el `-c`
   es clave: pasa la URL como override de sesión, no la persiste en el
   `.git/config` compartido con el repo principal (que sí compartiría el
   `.gitmodules`/config si se usara `git config` normal).
3. Agrega `-c protocol.file.allow=always`, necesario desde git 2.38
   (CVE-2022-39253 bloqueó por defecto los submódulos con URL `file://`).
4. Corre `submodule update --init --recursive` con esos overrides.

Resultado: submódulos poblados al instante, sin red ni credenciales, siempre
que el repo principal ya los tenga clonados.

`wt submodules <ruta>` (rama `sub` del dispatcher) expone este mismo helper
para poblar submódulos en un worktree que se creó sin poblarlos.

## `wt remove` — `_wt_remove` (líneas 874–927)

1. Resuelve la ruta y confirma con el usuario, mostrando la rama actual del
   worktree si se puede determinar.
2. `git submodule deinit -f --all` antes de remover: git se niega a borrar un
   worktree que tiene submódulos registrados, aunque estén vacíos/sin
   inicializar.
3. Intenta `git worktree remove <ruta>` a secas primero; si falla (típico
   cuando hubo submódulos), reintenta con `--force --force` — git exige el
   flag **dos veces** cuando el worktree tiene o tuvo submódulos.
4. Si había rama, pregunta (default sí) si borrarla con `git branch -D`.

## `_wt_resolve` (líneas 733–741)

Helper común: resuelve la ruta a absoluta con `cd ... && pwd` (default `.` si
no se pasa nada) y valida que sea un repo git con
`git rev-parse --is-inside-work-tree`. Todas las subfunciones de `wt` que
reciben una ruta pasan por acá antes de operar.

## Notas / gotchas

- El sufijo `-Pedro` está hardcodeado (`personal="Pedro"` en `_wt_create`),
  no usa `$RELEASE_AUTHOR`. Si se quiere reusar este script con otro usuario
  hay que tocar esa línea.
- `wt list` no distingue el bloqueo propio de `wt lock` de un `pushurl`
  de worktree configurado por otro motivo — cualquier valor cuenta como 🔒.
- El push bloqueado es solo una traba local (URL inválida); no impide un
  `git push --set-upstream` a otra URL explícita, ni protege del lado del
  remoto.

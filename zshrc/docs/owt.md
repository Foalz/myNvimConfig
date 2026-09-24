# `owt` — correr Odoo con el addons_path de un worktree

Fuente: `.zshrc` líneas 176–354. No confundir con `wt` (`docs/wt.md`), que
crea/gestiona los worktrees de git; `owt` es el que hace correr Odoo
apuntando al código de uno de esos worktrees.

Problema que resuelve: `odoo16.conf` tiene un `addons_path` fijo apuntando a
`$ODOO_REPO` (el checkout principal de `nx-ridery`). Para probar el código de
un worktree sin pisar ese `.conf` ni afectar la instancia real, `owt` arma un
`--addons-path` al vuelo sustituyendo solo la carpeta raíz de módulos propios,
y lo pasa a `obin` (ver `docs/misc.md`) como override de proceso.

## Uso

```sh
owt [ruta_worktree] <resto de args para obin/odoo-bin>
owt shell -d ridery
owt /opt/odoo16/repos/nx-ridery-correos-payslip-pedro -u ridery_custom_hr -d ridery
owt start [-p PUERTO] [-g PUERTO_GEVENT] ...
owt use [ruta]
owt reset
owt status
owt dev [ruta_worktree]
```

Si el primer argumento empieza con `/`, `./` o `../` se interpreta como la
ruta del worktree (default: `$PWD`); el resto de los argumentos son para
`obin`/`odoo-bin` tal cual.

## Armado del addons_path: `_owt_addons_path` (líneas 195–204)

`ODOO_ADDONS_PATH_BASE` (línea 182) es el addons_path real del `.conf`, con
las rutas separadas por coma:

```
.../odoo/odoo/addons,.../odoo/addons,/opt/odoo16/repos,/opt/odoo16/repos/enterprise,
$ODOO_REPO/nimetrix/l10n_ve_odoo_16,$ODOO_REPO/nimetrix/l10n_ve_nominav16,
$ODOO_REPO,$ODOO_REPO/storage,$ODOO_REPO/server-env,$ODOO_REPO/queue
```

`_owt_addons_path <target>` parte ese string por `,` y reemplaza **solo** el
segmento que es exactamente `$ODOO_REPO` por `$target` — los submódulos
(`nimetrix/*`, `storage`, `server-env`, `queue`) siempre se toman del repo
principal, porque ya están clonados ahí (o poblados vía `_wt_submodules_local`,
ver `docs/wt.md`) y no hace falta que el worktree los tenga.

Importante: esto **no lee ni escribe** `odoo16.conf`. El resultado se pasa
como flag de proceso (`--addons-path=...`), que en Odoo pisa al valor del
`.conf` solo para esa ejecución.

## Modo default: correr un subcomando puntual (líneas 325–326, 352–353)

Sin `start`/`use`/`reset`/`status`/`dev`, `owt` simplemente resuelve la ruta,
arma el addons_path y llama:

```sh
obin "$@" --addons-path="$addons_path"
```

Ej: `owt shell -d ridery` corre un shell de Odoo con el código del worktree
actual. Sirve para cualquier subcomando de `obin` que no sea `start`.

## `owt start` (líneas 328–350)

`start` es especial porque `odoo-bin start` (el quick-start de
`odoo/cli/start.py`) **pisa** cualquier `--addons-path`/`-d` que uno le pase
antes — arranca sin subcomando, igual que el servicio real. Por eso `owt`
parsea `-p/--port` y `-g/--gevent-port` a mano y arma el comando final así:

```sh
obin "${rest[@]}" --addons-path="$addons_path" --http-port="$port" --gevent-port="$gevent"
```

- Puerto default: `$OWT_DEV_PORT` (8070) — el 8069 real lo tiene tomado
  `systemctl odoo16`.
- Si no se pasa `-g`, el gevent-port se calcula como `port + 10000`. El
  comentario en el código aclara por qué hace falta pasarlo aparte: el
  longpolling/gevent (8072 por default) **no** lo pisa `--http-port`, así que
  dos instancias con `-p` distinto igual chocarían en el puerto de gevent si
  no se separa también ese.
- No toca el servicio real (`systemctl odoo16`): corre en foreground, se corta
  con Ctrl+C.

## `owt use` / `owt reset` — apuntar la instancia REAL a un worktree

Esto es lo único de `owt` que sí afecta la instancia compartida
(`systemctl odoo16`). `_owt_switch` (líneas 209–226):

1. Arma el addons_path para `$target` con `_owt_addons_path`.
2. Pide confirmación explícita (no hay default "sí"; hay que tipear `s`/`S`).
3. `sudo sed -i` reescribe la línea `addons_path = ...` de `odoo16.conf`.
4. `sudo systemctl restart odoo16`.

`owt use [ruta]` apunta la instancia real al worktree (default: `$wtpath`,
que es la ruta pasada al principio del comando o `$PWD`). `owt reset` es
`_owt_switch "$ODOO_REPO"` — vuelve la instancia real al repo principal.

⚠️ Afecta a cualquiera que use esa instancia; no es un proceso aparte como
`owt start`.

## `owt status` — `_owt_status` (líneas 246–250)

Lee el `addons_path` actual de `odoo16.conf` (`sudo grep -oP`) y lo imprime
una ruta por línea. Sirve para chequear a qué quedó apuntando la instancia
real después de un `owt use`.

## `owt dev` — asistente para preparar una DB de prueba

`_owt_dev` (líneas 256–294) no levanta ningún proceso — prepara todo lo
necesario y **imprime** el `owt start` final para que el usuario lo corra en
su propia sesión/pane (tmux, herdr, etc.):

1. Calcula un slug del worktree: nombre de carpeta sin el prefijo
   `nx-ridery-`, con `-` reemplazado por `_` (ej.
   `nx-ridery-correos-payslip-pedro` → `correos_payslip_pedro`).
2. Pregunta la DB origen a duplicar (default: `_odoo_db`, ver `docs/misc.md`)
   y el nombre de la DB nueva (default `<origen>_<slug>`).
3. Busca un puerto HTTP libre a partir de `$OWT_DEV_PORT` (`ss -ltn | grep`,
   incrementando hasta encontrar uno libre) y, con el mismo método, un puerto
   de gevent libre a partir de `puerto + 10000`.
4. Duplica la DB con `obin db duplicate`. Si falla porque el target ya existe,
   pregunta si borrarla y recrearla — el borrado usa `_owt_drop_db`, no
   `odoo-bin db drop`.
5. Imprime el comando final: `owt '<ruta>' start -d '<db>' -p <puerto> -g <gevent>`.

### Por qué el drop es un script propio: `_owt_drop_db` (líneas 231–244)

`odoo-bin db duplicate -f` sobre una DB ya existente **no la borra de
verdad**: en Odoo 16, `exp_drop()` filtra contra `list_dbs()`, y con
`db_name` fijo en el `.conf` y sin `dbfilter`, `list_dbs()` solo ve esa DB
fija — nunca ve la que se quiere duplicar/borrar. `_owt_drop_db` puentea esto
corriendo un script Python inline como el usuario `odoo16` que:

```python
odoo.tools.config.parse_config(["-c", conf])
odoo.tools.config["db_name"] = False   # sin esto, list_dbs() solo ve la db fija
from odoo.service.db import exp_drop
exp_drop(target)
```

## Relación con `wt`

`owt` y `wt` son independientes pero se usan en secuencia típica:
`wt create` crea el worktree y puebla submódulos → `owt dev <ruta>` prepara
DB y puertos → `owt <ruta> start -d <db> -p <puerto> -g <gevent>` levanta el
proceso de desarrollo contra ese código.

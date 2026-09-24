# `obin`, `odoo()`, aliases de logs y helpers de output compartidos

Fuente: `.zshrc` líneas 52–174 y 356–370, 618–647.

## `obin` (líneas 129–148)

Wrapper de `odoo-bin` que corre como el usuario del sistema operativo
correspondiente a la versión (`sudo -u odoo$v`), con el python de su pyenv
propio.

```sh
obin [versión] <subcomando> [args]
alias odoo-bin='obin'
```

- Si el primer argumento es todo dígitos, se toma como versión (`$v`) y se
  descarta del resto de args; si no, usa `$ODOO_V` (16).
- Tres grupos de subcomandos, porque no todos aceptan `-c <conf>` ni en el
  mismo lugar:
  - `scaffold|cloc|deploy|populate|neutralize`: van sin `-c` en absoluto.
  - `shell|start|db|tsconfig|obfuscate|genproxytoken`: aceptan `-c`, pero el
    subcomando debe ir **antes** que el flag (`odoo-bin shell -c conf.conf`,
    no `odoo-bin -c conf.conf shell`).
  - cualquier otro caso: `-c` va primero, sin subcomando explícito (el modo
    "servicio" normal).

`owt` y `oup`/`otest` corren siempre sobre `obin`, pasándole flags extra
(`--addons-path`, `--http-port`, `-u`, `-i`, etc.) — ver `docs/owt.md`,
`docs/oup.md`, `docs/otest.md`.

## `odoo()` (líneas 153–174)

Control simple del servicio systemd:

```sh
odoo restart | start | stop | logs
```

`start` además abre el navegador en `http://127.0.0.1:8069` con `xdg-open`.
No confundir con `owt start`, que levanta un proceso aparte en otro puerto
sin tocar el servicio real.

> Nota: hay un typo en el código (línea 164, `"$1" = "logs"]` sin espacio
> antes del `]`) — la rama `logs` nunca hace match y cae al `else` de
> "Command not recognized".

## `_odoo_db` (líneas 362–370)

Resuelve qué DB usar, con esta prioridad: `$2` (lo que le pase el caller,
típicamente el flag `-d`) > `$ODOO_DB` > `db_name` leído de
`/opt/odoo$v/odoo/odoo$v.conf` vía `sudo grep`. Devuelve error si no puede
determinar ninguna, o si el valor es literalmente `False`/`false`/`None`
(caso típico de un `.conf` sin `db_name` fijo). La usan `oup`, `otest` y
`_owt_dev`.

## `_odoo_module_of` (líneas 373–380)

Sube por el árbol de directorios desde la carpeta de un archivo hasta
encontrar un `__manifest__.py` bajo `$ODOO_REPO`; devuelve el nombre de esa
carpeta (el módulo). La usa `oup` para mapear archivos de git a módulos.

## Logs de Odoo coloreados

```sh
olog    # tail -f completo, coloreado por nivel
oloe    # solo ERROR (streaming)
oloi    # solo INFO (streaming)
olow    # solo WARNING (streaming)
oloec   # solo ERROR, filtrando ruido conocido (longpolling, puerto en uso, websocket)
```

Todos aplican el mismo patrón: `perl -pe 'BEGIN{$|=1} s/(NIVEL)/\e[COLORmNIVEL\e[0m/gi'`
sobre un `tail -F` o `sudo tail -f`. `$|=1` desactiva el buffering de salida
de perl para que el color aparezca línea por línea en tiempo real, no en
bloques. `oloec` es el único que encadena dos `grep --line-buffered` (nivel +
exclusión de ruido) antes de recolorear.

## `_o_msg` / `_o_ok` / `_o_warn` / `_o_err` (líneas 356–359)

Helpers de una línea para mensajes con ícono y color (`→` cyan, `✓` verde,
`⚠` amarillo, `✗` rojo) — los usan `oup` y `otest`.

## `_syp_step` / `_syp_box` (líneas 622–647)

Helpers de output compartidos por los flujos interactivos más largos
(`wt create`, `syp create`, `owt use`, `_release_create` — ver sus docs
respectivos):

- `_syp_step "<mensaje>" <comando...>`: imprime un spinner (`◌`) en gris,
  corre el comando capturando stdout+stderr, y reemplaza la línea (`\r\e[K`)
  con `✔` verde o `✘` rojo + el mensaje. Si falla, además imprime la salida
  capturada indentada, en rojo, y devuelve el código de error del comando
  para que el caller pueda cortar con `|| return 1`.
- `_syp_box "<texto>"`: dibuja una caja Unicode (`╭─╮`/`│ │`/`╰─╯`) alrededor
  del texto — se usa para resaltar el nombre de la rama recién creada al
  final de cada flujo.

## `gc()` (línea 618)

Atajo de una línea: `gc <rama>` → `git checkout <rama>`. No confundir con
`gc` de git (garbage collection) — acá pisa ese nombre.

## `cc` (línea 75)

```sh
alias cc="git diff --staged | claude -p \"/commit-changes-to-git IMPORTANT: DO NOT ADD THE 'CO AUTHORED BY'\" --model haiku --effort low --allowedTools \"\""
```

Genera el mensaje de commit a partir del diff staged usando Claude (modelo
haiku, esfuerzo bajo, sin tools habilitadas), explícitamente sin la línea de
co-autoría.

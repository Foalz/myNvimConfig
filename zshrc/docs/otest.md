# `otest` — correr tests de un módulo Odoo

Fuente: `.zshrc` líneas 539–616.

```sh
otest [versión] <db> <módulo> [Clase[.método]]
otest ridery_test nx_ridery_review_l10n_ve_nominav16_flow
otest ridery_test nx_ridery_review_l10n_ve_nominav16_flow TestEstimatedProfit
otest ridery_test nx_ridery_review_l10n_ve_nominav16_flow TestEstimatedProfit.test_confirm_recomputes_estimated_profit
```

⚠️ Usa `-i`/`-u` sobre la db pasada como argumento — no apuntar a producción.
Lo que revierte cada test es su propia transacción, no la instalación del
módulo (que sí queda instalado/actualizado en esa db al terminar).

## Armado de tags (líneas 560–567)

Sin tags, corre todo el módulo: `tags="/$mod"`.

Con un nombre suelto tipo `TestEstimatedProfit.test_x`, arma
`tags="/$mod:$tags"`. El separador de clase en el selector de tags de Odoo
(`odoo/tests/tag_selector.py`, formato `[-][tag][/module][:class][.method]`)
es `:`, no `.` — si se pasara con `.` en vez de `:` antes del nombre de la
clase, Odoo lo interpretaría como nombre de método suelto, no matchearía
nada, y correría 0 tests saliendo con código 0 (falso positivo). Por eso el
armado automático inserta el `:` en el lugar correcto.

Si `tags` ya empieza con `/` o `-`, se usa tal cual (el usuario ya pasó un
selector completo).

## Por qué `-i` y `-u` juntos (líneas 590, comentario 581–584)

`-u` solo toca módulos ya instalados y `-i` solo los desinstalados. Pasando
ambos con el mismo módulo se cubren los dos estados posibles sin tener que
saber de antemano si ya está instalado en esa db — si solo se usara `-u`
sobre un módulo desinstalado, Odoo no correría nada, en silencio.

## Filtrado de logs (líneas 572–598)

`--log-level=error` calla el ruido de carga de módulos (deprecation
warnings, "unknown parameter", etc.) sin perder errores reales — si falla la
instalación, el traceback igual sale.

El resultado de cada test lo emite el logger del propio módulo del test
(`OdooTestResult.log` hace `logging.getLogger(test.__module__)`), no
`odoo.tests.result` — por eso se sube a `INFO` explícitamente el logger
`odoo.addons.$mod.tests` junto con `odoo.tests.result` (resumen final) y
`odoo.tests.stats` (conteo + tiempo + queries) vía `--log-handler`.

La salida se manda a un archivo temporal con `tee` (necesario porque el pipe
mata la detección de tty de Odoo — `netsvc` solo colorea si `isatty`, así que
el archivo llega sin escapes ANSI, que es lo que después cuenta el `grep`) y
en paralelo se recolorea con `perl -pe` al vuelo (mismo patrón que `olog`,
ver `docs/misc.md`).

## Detección de "no corrió nada" (líneas 599–610)

Un tag mal escrito, o un archivo de test no importado en `tests/__init__.py`,
hace que Odoo corra 0 tests y salga con código 0 — éxito falso. `otest`
cuenta las líneas `Starting ` del logger de tests en el archivo temporal
(`grep -cE`); si `ran == 0`, reporta error explícito en vez de "OK" y corta
con código 1, aunque el proceso de Odoo haya salido con 0.

El código de salida real de `otest` (cuando sí corrieron tests) es el `rc`
del pipe (`${pipestatus[1]}`), no el de `tee`/`perl`.

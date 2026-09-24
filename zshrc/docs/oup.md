# `oup` — actualizar módulos Odoo según cambios de git

Fuente: `.zshrc` líneas 382–537.

Actualiza (`-u`) los módulos Odoo afectados por los cambios pendientes en
`$ODOO_REPO`, decidiendo automáticamente si hace falta reiniciar el servicio
o si alcanza con un update en caliente.

```sh
oup              # detecta cambios via git; XML/CSV/JS -> update en caliente, .py -> update + reinicio
oup -f           # fuerza actualizar todos los módulos detectados, aunque solo haya XML/CSV/JS
oup -r / -R      # fuerza reiniciar / fuerza NO reiniciar
oup -n           # dry-run: solo muestra qué haría
oup -d mi_base   # db explícita
oup mod1 mod2    # fuerza esos módulos puntuales, ignorando git
alias oupf='oup -f'
```

Flags combinables pegados (`-nf`, `-fr`, `-nfR`, ...) — el parser (líneas
398–408) itera carácter por carácter.

## Detección de módulos afectados (líneas 418–441)

Si se pasan nombres de módulo como argumentos, se usan directo y se fuerza
`force=1` (no se filtra por tipo de archivo).

Si no, junta los archivos afectados en `$ODOO_REPO`:

```sh
git diff --name-only
git diff --cached --name-only
git ls-files --others --exclude-standard
```
(diff sin stage + staged + untracked, deduplicado con `sort -u`).

Por cada archivo, `_odoo_module_of` (líneas 372–380) sube por el árbol de
carpetas buscando un `__manifest__.py` en `$ODOO_REPO/<dir>` — el nombre de
esa carpeta es el módulo dueño del archivo.

Clasifica cada módulo encontrado en dos sets (no excluyentes):
- `datamods`: el archivo es `.xml/.csv/.js/.scss/.css`, o es el
  `__manifest__.py` mismo.
- `codemods`: el archivo es `.py`.

## Decisión de qué actualizar y si reiniciar (líneas 444–462)

- `target` = `$mods` completo si `force=1`, si no solo `$datamods` (los que
  cambiaron algo que Odoo puede recargar sin reiniciar).
- `restart` se activa si hay algún `codemods` (el proceso tiene el `.py`
  cargado en memoria y no lo relee solo), salvo que `-r`/`-R` lo fuercen
  explícitamente en cualquier sentido.

## Ejecución (líneas 494–533)

La DB se resuelve con `_odoo_db` (ver `docs/misc.md`): `-d` explícito >
`$ODOO_DB` > `db_name` del `.conf`.

- **Con reinicio**: para el servicio, corre
  `obin $v -d $db -u $list --stop-after-init --no-http --logfile=`, y vuelve
  a arrancar el servicio pase lo que pase con el resultado del update.
- **Sin reinicio**: corre el mismo `obin ... -u $list --stop-after-init
  --no-http` con el servicio **corriendo** — Odoo recarga el registry al
  detectar el cambio por señalización, sin tocar el puerto.
- Caso "nada que actualizar" (`target` vacío): si además `restart=1`, hace
  un reinicio pelado del servicio sin pasar por `-u`; si no hay nada que
  hacer y tampoco toca reiniciar, avisa y sale con error.

`oup -n` (dry-run) imprime lo mismo que haría (módulos target, db, si
reiniciaría) sin ejecutar nada — usa el mismo cálculo de `target`/`restart`
de arriba.

## Gotchas

- Si `$ODOO_REPO` no tiene cambios (`git diff`/`ls-files` vacío), corta con
  error antes de intentar nada, salvo que se pasen módulos explícitos.
- Un archivo fuera de cualquier módulo (`_odoo_module_of` no encuentra
  `__manifest__.py`) se ignora en silencio — no cuenta ni para `mods` ni para
  el resumen.
- El chequeo `-d*` / `--database=*` en el parser permite `oup -dmibase` y
  `oup --database=mibase` además de `-d mibase` con espacio.

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PLUGINS
plugins=(
    git
    zsh-autosuggestions
)
# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit
zmodload zsh/complist

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Aliases
alias cx="claude"
alias odir="cd /opt/odoo16/repos/nx-ridery"
alias l="ls"
alias la="ls -la"
alias gg='lazygit'
alias gs='git status'
alias gb="git branch | grep '*'"
alias gls="git log --graph --pretty=format:'%C(yellow)%h%Creset - %C(bold blue)<%an>%Creset %C(green)(%ar)%Creset %s %C(red)%d%Creset'"
alias glo="git log --oneline"
alias olog="sudo tail -f /opt/odoo16/odoo/log/odoo16.log | perl -pe '
  s/CRITICAL/\e[1;41;97m$&\e[0m/g;
  s/ERROR/\e[31m$&\e[0m/g;
  s/WARNING/\e[33m$&\e[0m/g;
  s/INFO/\e[32m$&\e[0m/g;
  s/DEBUG/\e[1;95m$&\e[0m/g;
'"

alias oloe="sudo tail -F /opt/odoo16/odoo/log/odoo16.log | grep --line-buffered -i 'ERROR' | perl -pe 'BEGIN{\$|=1} s/(ERROR)/\e[31m\$1\e[0m/gi'"
alias oloi="sudo tail -F /opt/odoo16/odoo/log/odoo16.log | grep --line-buffered -i 'INFO'  | perl -pe 'BEGIN{\$|=1} s/(INFO)/\e[32m\$1\e[0m/gi'"
alias olow="sudo tail -F /opt/odoo16/odoo/log/odoo16.log | grep --line-buffered -i 'WARNING' | perl -pe 'BEGIN{\$|=1} s/(WARNING)/\e[33m\$1\e[0m/gi'"
alias oloec='sudo tail -F /opt/odoo16/odoo/log/odoo16.log | grep --line-buffered -i ERROR | grep --line-buffered -vE "longpolling|Address already in use|bind the websocket" | GREP_COLORS="mt=01;31" grep --line-buffered -i --color=always ERROR'
alias on='cd /opt/odoo16/ && nvim'
alias cc="git diff --staged | claude -p \"/commit-changes-to-git IMPORTANT: DO NOT ADD THE 'CO AUTHORED BY'\" --model haiku --effort low --allowedTools \"\""

RELEASE_AUTHOR="pedro"

# Crea y pushea una rama de release/update: <prefix>_YYYY_MM_DD_<RELEASE_AUTHOR>
# a partir de <base_branch>, con fecha opcional (default: hoy).
_release_create() {
  local base_branch=$1 prefix=$2 fecha=$3
  local d

  cd "$SYP_REPO_DIR" || { print -P "%F{red}✘%f No pude entrar a $SYP_REPO_DIR"; return 1; }

  if [[ -n "$fecha" ]]; then
    d=$(date -d "$fecha" +%Y_%m_%d 2>/dev/null) || { print -P "%F{red}✘%f Fecha inválida: $fecha"; return 1; }
  else
    d=$(date +%Y_%m_%d)
  fi

  local branch="${prefix}_${d}_${RELEASE_AUTHOR}"

  print -P "\n  %F{magenta}◆%f  %Brelease%b %F{245}· ${base_branch} → ${branch}%f\n"

  _syp_step "posicionando en ${base_branch}" git checkout "$base_branch" || return 1
  _syp_step "actualizando ${base_branch} (pull)" git pull origin "$base_branch" || return 1
  _syp_step "creando rama" git checkout -b "$branch" || return 1

  print ""
  print -Pn "  %F{cyan}?%f ¿Hacer push de %B${branch}%b a origin? %F{245}(S/n)%f: "
  read "REPLY"
  if [[ "$REPLY" == "n" || "$REPLY" == "N" ]]; then
    print -P "\n  %F{yellow}⚠%f Rama creada localmente, sin pushear.\n"
    return 0
  fi

  _syp_step "pusheando a origin" git push --set-upstream origin "$branch" || return 1

  print ""
  _syp_box "$branch"
  print -P "\n  %F{green}Listo%f, rama publicada en origin. %F{yellow}🚀%f\n"
}

unalias today-main today-stg today-qa today-beta 2>/dev/null

# today-main [FECHA]  -> main_release_YYYY_MM_DD_pedro
today-main() { _release_create main main_release "$1" }
# today-stg [FECHA]   -> staging_update_YYYY_MM_DD_pedro
today-stg()  { _release_create staging-ridery staging_update "$1" }
# today-qa [FECHA]    -> qa_update_YYYY_MM_DD_pedro
today-qa()   { _release_create qa qa_update "$1" }
# today-beta [FECHA]  -> beta_update_YYYY_MM_DD_pedro
today-beta() { _release_create beta-ridery beta_update "$1" }
# today-preprod [FECHA] -> preprod_update_YYYY_MM_DD_pedro
today-preprod() { _release_create preprod preprod_update "$1" }

ODOO_V=16   # versión por defecto

obin() {
    local v=$ODOO_V
    [[ "$1" =~ '^[0-9]+$' ]] && { v=$1; shift; }   # obin 17 -u all
    local base=/opt/odoo$v/odoo
    local py=/home/odoo$v/.pyenv/versions/odoo$v/bin/python
    case "$1" in
        # subcomandos que NO aceptan -c y deben ir primeros
        scaffold|cloc|deploy|populate|neutralize)
            sudo -u odoo$v -H $py $base/odoo-bin "$@" ;;
        # subcomandos que SÍ aceptan -c, pero deben ir primeros
        shell|start|db|tsconfig|obfuscate|genproxytoken)
            local sub=$1; shift
            sudo -u odoo$v -H $py $base/odoo-bin $sub -c $base/odoo$v.conf "$@" ;;
        *)
            sudo -u odoo$v -H $py $base/odoo-bin -c $base/odoo$v.conf "$@" ;;
    esac
}
alias odoo-bin='obin'
alias oc='cd /opt/odoo16; claude'

# Functions

odoo() {
    if [ "$1" = "restart" ]; then
        echo "[+] Restarting Odoo service..."
        sudo systemctl restart odoo16
    elif [ "$1" = "start" ]; then
        echo "[+] Starting Odoo service..."
        sudo systemctl start odoo16
        xdg-open "http://127.0.0.1:8069"
    elif [ "$1" = "stop" ]; then
        echo "[-] Stoppig Odoo service..."
        sudo systemctl stop odoo16
    elif [ "$1" = "logs"]; then
        echo "[+] Opening logs..."
        sudo tail -f /opt/odoo16/odoo/log/odoo16.log | perl -pe '
          s/ERROR/\e[31m$&\e[0m/g;
          s/WARNING/\e[33m$&\e[0m/g;
          s/INFO/\e[32m$&\e[0m/g;
        '
    else
        echo "[!] Command not recognized. Did you mean 'odoo restart'?"
    fi
}

# ── Actualización de módulos Odoo según los cambios de git ───────────
ODOO_REPO=/opt/odoo16/repos/nx-ridery
ODOO_DB=ridery # opcional: si no se define, se lee db_name del .conf

# addons_path real del odoo16.conf (los tramos de nx-ridery se sustituyen
# dinámicamente por la ruta del worktree que le pases a owt)
ODOO_ADDONS_PATH_BASE="/opt/odoo16/odoo/odoo/addons,/opt/odoo16/odoo/addons,/opt/odoo16/repos,/opt/odoo16/repos/enterprise,${ODOO_REPO}/nimetrix/l10n_ve_odoo_16,${ODOO_REPO}/nimetrix/l10n_ve_nominav16,${ODOO_REPO},${ODOO_REPO}/storage,${ODOO_REPO}/server-env,${ODOO_REPO}/queue"

# owt [ruta_worktree] <resto de args para obin/odoo-bin>
# Corre Odoo con el addons_path apuntando al código de ese worktree
# (default: directorio actual) en vez de $ODOO_REPO, sin tocar odoo16.conf.
#   owt shell -d ridery
#   owt /opt/odoo16/repos/nx-ridery-correos-payslip-pedro -u ridery_custom_hr -d ridery
OWT_DEV_PORT=8070   # puerto por defecto para 'owt start' (el 8069 real ya está tomado por systemctl odoo16)
ODOO_CONF="/opt/odoo16/odoo/odoo16.conf"

# Arma el addons_path real, sustituyendo solo la carpeta raíz de módulos
# propios de nx-ridery por $1; los submódulos (queue, storage, server-env,
# nimetrix) siempre apuntan al repo principal, que ya los tiene clonados.
_owt_addons_path() {
  local target=$1
  local -a parts wt_parts
  IFS=',' read -rA parts <<< "$ODOO_ADDONS_PATH_BASE"
  for p in "${parts[@]}"; do
    [[ "$p" == "$ODOO_REPO" ]] && p=$target
    wt_parts+=("$p")
  done
  print -- "${(j:,:)wt_parts}"
}

# Reescribe el addons_path de odoo16.conf y reinicia la instancia REAL
# (systemctl odoo16) para que sirva el código de $1. Pide confirmación:
# afecta a cualquiera que use esa instancia, no es un proceso aparte.
_owt_switch() {
  local target=$1
  local addons_path=$(_owt_addons_path "$target")

  print -P "\n  %F{magenta}◆%f  %Bowt use%b %F{245}· instancia real → ${target}%f\n"
  print -Pn "  %F{yellow}⚠%f Esto reescribe %Bodoo16.conf%b y reinicia %Bsystemctl odoo16%b (afecta a todo el que use esa instancia). ¿Continuar? %F{245}(s/N)%f: "
  read "REPLY"
  if [[ "$REPLY" != "s" && "$REPLY" != "S" ]]; then
    print -P "\n  %F{yellow}⚠%f Cancelado.\n"
    return 0
  fi

  _syp_step "actualizando odoo16.conf" sudo sed -i "s|^addons_path[[:space:]]*=.*|addons_path = ${addons_path}|" "$ODOO_CONF" || return 1
  _syp_step "reiniciando odoo16" sudo systemctl restart odoo16 || return 1

  print ""
  print -P "  %F{green}Listo%f, la instancia real ahora sirve código desde %F{245}${target}%f. %F{yellow}🚀%f\n"
}

# Borra una DB puenteando el chequeo de exp_drop() (que en Odoo 16 usa
# list_dbs(), la cual con 'db_name' fijo en el conf y sin 'dbfilter' solo
# ve esa DB — por eso 'odoo-bin db duplicate -f' no llega a borrar nada).
_owt_drop_db() {
  local target=$1 py="/home/odoo16/.pyenv/versions/odoo16/bin/python"
  sudo -u odoo16 -H "$py" -c '
import sys
sys.path.insert(0, "/opt/odoo16/odoo")
import odoo
target, conf = sys.argv[1], sys.argv[2]
odoo.tools.config.parse_config(["-c", conf])
odoo.tools.config["db_name"] = False  # si no, list_dbs() solo ve la db fija del conf
from odoo.service.db import exp_drop
if not exp_drop(target):
    sys.exit(f"{target} no existe")
' "$target" "$ODOO_CONF"
}

_owt_status() {
  sudo grep -oP '^addons_path\s*=\s*\K.*' "$ODOO_CONF" 2>/dev/null | tr ',' '\n' | while read -r p; do
    print -P "  %F{245}${p}%f"
  done
}

# owt dev [ruta_worktree]
# Asistente interactivo: duplica una DB para este worktree y elige puerto +
# gevent-port libres. No levanta el proceso (eso lo hacés vos en tu propio
# pane/sesión, ej. herdr): solo prepara todo e imprime el 'owt start' final.
_owt_dev() {
  local wtpath=$1
  local name=${wtpath:t}
  local slug=${${name#nx-ridery-}//-/_}

  print -P "\n  %F{magenta}◆%f  %Bowt dev%b %F{245}· ${wtpath}%f\n"

  local src_default=$(_odoo_db)
  print -Pn "  %F{cyan}?%f DB origen a duplicar %F{245}(${src_default})%f: "
  read "src"; src=${src:-$src_default}
  [[ -z "$src" ]] && { print -P "%F{red}✘%f Falta la DB origen"; return 1; }

  local target_default="${src}_${slug}"
  print -Pn "  %F{cyan}?%f Nombre de la DB nueva %F{245}(${target_default})%f: "
  read "target"; target=${target:-$target_default}

  local port=$OWT_DEV_PORT
  while ss -ltn 2>/dev/null | grep -q ":${port} "; do (( port++ )); done
  print -Pn "  %F{cyan}?%f Puerto %F{245}(${port}, libre)%f: "
  read "REPLY"; [[ -n "$REPLY" ]] && port=$REPLY

  local gevent=$(( port + 10000 ))
  while ss -ltn 2>/dev/null | grep -q ":${gevent} "; do (( gevent++ )); done

  if ! _syp_step "duplicando ${src} → ${target}" obin db duplicate "$src" "$target"; then
    print -Pn "  %F{yellow}⚠%f ¿${target} ya existe? ¿Borrarla y recrear? %F{245}(s/N)%f: "
    read "REPLY"
    [[ "$REPLY" != "s" && "$REPLY" != "S" ]] && return 1
    _syp_step "borrando ${target}" _owt_drop_db "$target" || return 1
    _syp_step "recreando ${target}" obin db duplicate "$src" "$target" || return 1
  fi

  local cmd="owt '${wtpath}' start -d '${target}' -p ${port} -g ${gevent}"

  print ""
  print -P "  %F{green}Listo%f, db lista. Corré esto en tu pane/sesión (herdr, tmux, lo que uses): %F{yellow}🚀%f\n"
  print -P "  %F{245}${cmd}%f"
  print -P "\n  %F{245}url:%f    http://127.0.0.1:${port}  %F{245}(gevent ${gevent})%f\n"
}

owt() {
  local wtpath=$PWD
  if [[ "$1" == /* || "$1" == ./* || "$1" == ../* ]]; then
    wtpath=$1; shift
  fi

  case "$1" in
    use)
      shift
      local target=${1:-$wtpath}
      target=$(cd "$target" 2>/dev/null && pwd) || { print -P "%F{red}✘%f Ruta inválida: $target"; return 1; }
      _owt_switch "$target"
      return $?
      ;;
    reset)
      _owt_switch "$ODOO_REPO"
      return $?
      ;;
    status)
      _owt_status
      return $?
      ;;
    dev)
      wtpath=$(cd "$wtpath" 2>/dev/null && pwd) || { print -P "%F{red}✘%f Ruta inválida: $wtpath"; return 1; }
      _owt_dev "$wtpath"
      return $?
      ;;
  esac

  wtpath=$(cd "$wtpath" 2>/dev/null && pwd) || { print -P "%F{red}✘%f Ruta inválida: $wtpath"; return 1; }
  local addons_path=$(_owt_addons_path "$wtpath")

  if [[ "$1" == "start" ]]; then
    shift
    local port=$OWT_DEV_PORT
    local gevent=""
    local -a rest
    while [[ $# -gt 0 ]]; do
      case "$1" in
        -p|--port) port=$2; shift 2 ;;
        -g|--gevent-port) gevent=$2; shift 2 ;;
        *) rest+=("$1"); shift ;;
      esac
    done
    # El longpolling/gevent (8072 por default) NO lo pisa --http-port: si no
    # se pasa aparte, dos instancias chocan ahí aunque tengan -p distinto.
    [[ -z "$gevent" ]] && gevent=$(( port + 10000 ))
    print -P "\n  %F{magenta}◆%f  %Bowt start%b %F{245}· ${wtpath}%f"
    print -P "  %F{green}➜%f  http://127.0.0.1:${port}%F{245} (gevent ${gevent}; Ctrl+C para detener; no toca el servicio real)%f\n"
    # OJO: 'odoo-bin start' es el quick-start (odoo/cli/start.py) y pisa
    # nuestro --addons-path/-d con los suyos propios; se arranca sin
    # subcomando, igual que lo hace el servicio real (systemctl odoo16).
    obin "${rest[@]}" --addons-path="$addons_path" --http-port="$port" --gevent-port="$gevent"
    return $?
  fi

  print -P "  %F{magenta}◆%f  %Bowt%b %F{245}· addons desde ${wtpath}%f"
  obin "$@" --addons-path="$addons_path"
}

_o_msg()  { print -P "%F{cyan}→%f $*" }
_o_ok()   { print -P "%F{green}✓%f $*" }
_o_warn() { print -P "%F{yellow}⚠%f $*" }
_o_err()  { print -P "%F{red}✗%f $*" }

# Base de datos a usar: $2 (flag -d) > $ODOO_DB > db_name del odoo$v.conf
_odoo_db() {
    local v=${1:-$ODOO_V} db=${2:-$ODOO_DB}
    if [[ -z $db ]]; then
        db=$(sudo -u odoo$v grep -oP '^\s*db_name\s*=\s*\K\S+' \
             /opt/odoo$v/odoo/odoo$v.conf 2>/dev/null)
    fi
    [[ -z $db || $db == (False|false|None) ]] && return 1
    print -- $db
}

# Sube por el árbol desde una ruta hasta el dir con __manifest__.py
_odoo_module_of() {
    local d=${1:h}
    while [[ -n $d && $d != "." && $d != "/" ]]; do
        [[ -f $ODOO_REPO/$d/__manifest__.py ]] && { print -- ${d:t}; return 0 }
        d=${d:h}
    done
    return 1
}

# Por defecto: actualiza los módulos con cambios de datos/assets, y solo
# reinicia el servicio si además cambió algún .py (el código vive en memoria).
#   oup            -> solo XML/CSV/JS ? update en caliente : update + reinicio
#   oup -f         -> actualiza siempre todos los módulos tocados
#   oup -r / -R    -> fuerza reiniciar / fuerza NO reiniciar
#   oup -n         -> dry-run, solo enseña qué detectó
#   oup -d mi_base -> usa esa db (si no, $ODOO_DB y si no, db_name del .conf)
#   oup mod1 mod2  -> fuerza esos módulos, ignorando git
oup() {
    local force=0 dry=0 rflag=-1 v=$ODOO_V dbopt=""
    while [[ $1 == -* ]]; do
        case "$1" in
            -f|--force) force=1; shift ;;
            -n|--dry-run) dry=1; shift ;;
            -r|--restart) rflag=1; shift ;;
            -R|--no-restart) rflag=0; shift ;;
            -[fnrR][fnrR]*)                  # flags juntos: -nf, -fr, -nfR…
                local c
                for c in ${(s::)${1#-}}; do
                    case $c in
                        f) force=1 ;;
                        n) dry=1 ;;
                        r) rflag=1 ;;
                        R) rflag=0 ;;
                    esac
                done
                shift ;;
            -d|--database)
                [[ -n $2 ]] || { _o_err "-d necesita el nombre de la db"; return 2 }
                dbopt=$2; shift 2 ;;
            -d*) dbopt=${1#-d}; shift ;;
            --database=*) dbopt=${1#--database=}; shift ;;
            *) _o_err "Opción desconocida: $1"; return 2 ;;
        esac
    done

    local -a mods datamods codemods target
    if (( $# )); then
        mods=($@); datamods=($@); codemods=($@); force=1
    else
        local -a files
        files=("${(@f)$(cd $ODOO_REPO && { git diff --name-only
                                           git diff --cached --name-only
                                           git ls-files --others --exclude-standard
                                         } | sort -u)}")
        files=(${files:#})
        (( ${#files} )) || { _o_warn "Sin cambios en $ODOO_REPO"; return 1 }
        local f m
        for f in $files; do
            m=$(_odoo_module_of $f) || continue
            mods+=($m)
            # datos/assets -> basta con actualizar el módulo
            case ${f:l} in
                *.xml|*.csv|*.js|*.scss|*.css) datamods+=($m) ;;
            esac
            # python -> el proceso tiene el código en memoria, hay que reiniciar
            [[ $f == *.py ]] && codemods+=($m)
            [[ ${f:t} == __manifest__.py ]] && datamods+=($m)
        done
        mods=(${(u)mods}); datamods=(${(u)datamods}); codemods=(${(u)codemods})
    fi

    if (( ${#mods} )); then
        _o_msg "Módulos con cambios: ${(j:, :)mods}"
    else
        _o_warn "Los cambios no pertenecen a ningún módulo"
    fi
    (( ${#datamods} )) && _o_msg "Datos/assets (XML,CSV,JS,SCSS): ${(j:, :)datamods}"
    (( ${#codemods} )) && _o_msg "Python (requiere reinicio): ${(j:, :)codemods}"

    if (( force )); then
        target=($mods)
    else
        target=($datamods)
    fi

    # ¿Hace falta reiniciar? -r/-R mandan; si no, solo si cambió python
    local restart=0
    (( ${#codemods} )) && restart=1
    (( rflag == 1 )) && restart=1
    (( rflag == 0 )) && restart=0

    if (( dry )); then
        if (( ${#target} )); then
            _o_msg "[dry-run] actualizaría: ${(j:, :)target}"
            _o_msg "[dry-run] db: ${dbopt:-${ODOO_DB:-<db_name del .conf>}}"
        fi
        if (( restart )); then
            _o_msg "[dry-run] con reinicio de odoo$v"
        elif (( ${#target} )); then
            _o_msg "[dry-run] en caliente, sin reiniciar odoo$v"
        else
            _o_warn "[dry-run] no haría nada"
        fi
        return 0
    fi

    # Nada que actualizar -> reinicio pelado (o nada)
    if (( ${#target} == 0 )); then
        if (( restart == 0 )); then
            _o_warn "Nada que hacer: usa -f para actualizar igual, o -r para reiniciar"
            return 1
        fi
        _o_msg "Sin cambios de datos: reinicio simple de odoo$v"
        if sudo systemctl restart odoo$v; then
            _o_ok "odoo$v reiniciado"
        else
            _o_err "No se pudo reiniciar odoo$v"; return 1
        fi
        return 0
    fi

    local db
    db=$(_odoo_db $v $dbopt) || {
        _o_err "No pude determinar la db: usa 'oup -d <base>' o define ODOO_DB en ~/.zshrc"
        return 1
    }

    local list=${(j:,:)target} rc=0
    _o_msg "Actualizando [$list] en la db '$db'"

    if (( restart )); then
        _o_msg "Parando odoo$v…"
        sudo systemctl stop odoo$v

        obin $v -d $db -u $list --stop-after-init --no-http --logfile=
        rc=$?

        _o_msg "Arrancando odoo$v…"
        sudo systemctl start odoo$v
    else
        # --no-http + --stop-after-init: no toca el puerto, el servicio sigue vivo
        # y recarga el registry por señalización al detectar el cambio
        _o_msg "En caliente, sin parar odoo$v…"
        obin $v -d $db -u $list --stop-after-init --no-http --logfile=
        rc=$?
    fi

    if (( rc == 0 )); then
        if (( restart )); then
            _o_ok "Módulos actualizados: $list"
        else
            _o_ok "Módulos actualizados en caliente: $list (recarga el navegador)"
        fi
    else
        if (( restart )); then
            _o_err "La actualización falló (código $rc) — odoo$v se levantó igual"
        else
            _o_err "La actualización falló (código $rc) — odoo$v sigue con la versión anterior"
        fi
    fi
    return $rc
}

# Siempre actualiza, aunque solo hayas tocado .py
alias oupf='oup -f'

# otest [versión] <db> <módulo> [tags]
#   otest ridery_test nx_ridery_review_l10n_ve_nominav16_flow
#   otest ridery_test nx_ridery_review_l10n_ve_nominav16_flow TestEstimatedProfit
#   otest ridery_test nx_ridery_review_l10n_ve_nominav16_flow TestEstimatedProfit.test_confirm_recomputes_estimated_profit
#
# Del log solo salen las líneas de los tests y cualquier WARNING/ERROR:
# --log-level=warn calla el ruido de carga de módulos, y el --log-handler
# vuelve a subir a INFO el logger que imprime un "Starting …" por test.
#
# Usa -u: actualiza el módulo en esa db de verdad (lo que revierte cada test
# es su propia transacción, no la instalación). No apuntar a producción.
otest() {
    local v=$ODOO_V
    [[ "$1" =~ '^[0-9]+$' ]] && { v=$1; shift; }
    local db=$1 mod=$2 tags=$3

    if [[ -z "$db" || -z "$mod" ]]; then
        _o_err "uso: otest [versión] <db> <módulo> [Clase[.método]]"
        return 2
    fi

    # Sin tags corre todo el módulo; un nombre suelto es la Clase[.método].
    # El separador de clase es ':' — con '.' Odoo lo lee como nombre de
    # método, no matchea nada, corre 0 tests y sale con código 0
    # (odoo/tests/tag_selector.py: [-][tag][/module][:class][.method]).
    if [[ -z "$tags" ]]; then
        tags="/$mod"
    elif [[ "$tags" != /* && "$tags" != -* ]]; then
        tags="/$mod:$tags"
    fi

    _o_msg "Tests de [$mod] en la db '$db' (tags: $tags)"

    # --log-level=error calla el ruido de carga (los "unknown parameter
    # 'tracking'", los DeprecationWarning, etc.) sin perder los errores
    # reales: si falla la instalación, el traceback sale igual.
    #
    # El "Starting <test> ..." lo emite el logger del módulo del test, no
    # odoo.tests.result: OdooTestResult.log hace
    # logging.getLogger(test.__module__). Los fallos de los tests también
    # salen por ahí, a ERROR. odoo.tests.result da el resumen final y
    # odoo.tests.stats el conteo con tiempo y queries.
    # -i y -u juntos: '-u' solo toca módulos ya instalados y '-i' solo los
    # desinstalados, así que la combinación cubre los dos casos y no hay que
    # saber de antemano en qué estado está en esa db. Con solo -u sobre un
    # módulo desinstalado no corre nada, en silencio.
    #
    # tee mata la detección de tty de Odoo (netsvc solo colorea si isatty),
    # así que el color se repone en el pipe, al estilo de olog. El archivo
    # recibe el texto sin escapes, que es lo que después cuenta el grep.
    local out=$(mktemp)
    obin $v -d $db -i $mod -u $mod \
        --test-enable --test-tags "$tags" \
        --stop-after-init --no-http --workers=0 --logfile= \
        --log-level=error \
        --log-handler="odoo.addons.$mod.tests:INFO" \
        --log-handler=odoo.tests.result:INFO \
        --log-handler=odoo.tests.stats:INFO 2>&1 \
        | tee "$out" \
        | perl -pe 'BEGIN{$|=1} s/(ERROR|FAIL|Traceback)/\e[31m$1\e[0m/g; s/(WARNING)/\e[33m$1\e[0m/g; s/(Starting|\d+ tests)/\e[36m$1\e[0m/g; s/(INFO)/\e[32m$1\e[0m/g'
    local rc=${pipestatus[1]}
    local ran=$(grep -cE "odoo\.addons\.${mod}\.tests.*: Starting " "$out")
    rm -f "$out"

    # Cero tests sale con código 0, así que sin este chequeo un tag mal
    # escrito o un archivo sin importar en tests/__init__.py se reportaría
    # como éxito
    if (( ran == 0 )); then
        _o_err "No corrió ningún test (tags: $tags)"
        _o_err "Revisá el nombre de la clase/método y que el archivo esté en tests/__init__.py"
        return 1
    fi

    (( rc == 0 )) \
        && _o_ok "$ran test(s) OK" \
        || _o_err "Falló algún test ($ran corrieron, código $rc)"
    return $rc
}

gc () {
  git checkout "$1"
}

# Corre un paso mostrando spinner -> check/cruz, al estilo Vite/Claude Code
_syp_step() {
  local msg=$1; shift
  local out
  print -Pn "  %F{240}◌%f %F{245}${msg}...%f"
  if out=$("$@" 2>&1); then
    print -P "\r\e[K  %F{green}✔%f ${msg}"
  else
    print -P "\r\e[K  %F{red}✘%f ${msg}"
    print -P "%F{red}${out}%f" | sed 's/^/    /'
    return 1
  fi
}

_syp_box() {
  local text=$1
  local len=${#text}
  local pad=$((len + 2))
  local top="╭"; local bot="╰"
  local i
  for ((i = 0; i < pad; i++)); do top+="─"; bot+="─"; done
  top+="╮"; bot+="╯"
  print -P "%F{green}${top}%f"
  print -P "%F{green}│%f %B${text}%b %F{green}│%f"
  print -P "%F{green}${bot}%f"
}

SYP_REPO_DIR="/opt/odoo16/repos/nx-ridery"

# syp create -n <numero> -d "<descripcion>" [-p]
#   -n/--number       número del ticket (obligatorio, salvo con -p)
#   -d/--description  descripción corta
#   -p/--personal      omite el prefijo SYP-NUMERO y arma DESCRIPCION-PEDRO
# Siempre se ubica en $SYP_REPO_DIR y sincroniza con main antes de crear la rama.
syp() {
  local action="$1"
  shift

  cd "$SYP_REPO_DIR" || { print -P "%F{red}✘%f No pude entrar a $SYP_REPO_DIR"; return 1; }

  if [[ "$action" != "create" && "$action" != "-c" && "$action" != "--create" ]]; then
    print -P "%F{cyan}Uso:%f syp create [-n NUMERO] [-d \"DESCRIPCION\"] [-p]"
    return 1
  fi

  local number="" description="" personal=0

  if [[ $# -eq 0 ]]; then
    print -P "\n  %F{magenta}◆%f  %Bsyp%b %F{245}· nueva rama de trabajo%f\n"
    print -Pn "  %F{cyan}?%f ¿Rama personal sin prefijo SYP? %F{245}(s/N)%f: "
    read "REPLY"
    [[ "$REPLY" == "s" || "$REPLY" == "S" ]] && personal=1
    if [[ $personal -eq 0 ]]; then
      print -Pn "  %F{cyan}?%f Número: "
      read "number"
    fi
    print -Pn "  %F{cyan}?%f Descripción: "
    read "description"
    print ""
  else
    while [[ $# -gt 0 ]]; do
      case "$1" in
        -n|--number) number="$2"; shift 2 ;;
        -d|--description) description="$2"; shift 2 ;;
        -p|--personal) personal=1; shift ;;
        *) print -P "%F{red}✘%f Opción desconocida: $1"; return 1 ;;
      esac
    done
  fi

  if [[ -z "$description" ]]; then
    print -P "%F{red}✘%f Descripción es obligatoria"
    return 1
  fi
  if [[ $personal -eq 0 && -z "$number" ]]; then
    print -P "%F{red}✘%f Número es obligatorio (o usá -p para omitirlo)"
    return 1
  fi

  local slug branch
  slug=$(echo "$description" | sed -E 's/[^A-Za-z0-9]+/ /g' \
    | awk '{for(i=1;i<=NF;i++)$i=toupper(substr($i,1,1)) tolower(substr($i,2)); print}' OFS='-')

  if [[ $personal -eq 1 ]]; then
    branch="${slug}-Pedro"
  else
    branch="SYP-${number}-${slug}"
  fi

  _syp_step "sincronizando main" git checkout main || return 1
  _syp_step "actualizando main (pull)" git pull origin main || return 1
  _syp_step "creando rama" git checkout -b "$branch" || return 1

  print ""
  print -Pn "  %F{cyan}?%f ¿Hacer push de %B${branch}%b a origin? %F{245}(S/n)%f: "
  read "REPLY"
  if [[ "$REPLY" == "n" || "$REPLY" == "N" ]]; then
    print -P "\n  %F{yellow}⚠%f Rama creada localmente, sin pushear.\n"
    return 0
  fi

  _syp_step "pusheando a origin" git push --set-upstream origin "$branch" || return 1

  print ""
  _syp_box "$branch"
  print -P "\n  %F{green}Listo%f, ya estás en tu nueva rama. %F{yellow}🚀%f\n"
}

WT_PUSHURL_BLOCKED="DO-NOT-PUSH-blocked-by-wt-lock"

# Resuelve la ruta absoluta de un worktree y valida que sea un repo git.
_wt_resolve() {
  local target=$1
  [[ -z "$target" ]] && target=.
  local abs
  abs=$(cd "$target" 2>/dev/null && pwd) || { print -P "%F{red}✘%f Ruta inválida: $target" >&2; return 1; }
  git -C "$abs" rev-parse --is-inside-work-tree &>/dev/null \
    || { print -P "%F{red}✘%f No es un repo git: $abs" >&2; return 1; }
  print -- "$abs"
}

# wt lock [ruta]  -> bloquea el push (pushurl inválido, solo para ese worktree)
_wt_lock() {
  local abs
  abs=$(_wt_resolve "$1") || return 1
  git -C "$abs" config extensions.worktreeConfig true
  git -C "$abs" config --worktree remote.origin.pushurl "$WT_PUSHURL_BLOCKED"
  print -P "  %F{yellow}🔒%f Push bloqueado en %F{245}${abs}%f"
}

# wt unlock [ruta] -> restaura el push normal en ese worktree
_wt_unlock() {
  local abs
  abs=$(_wt_resolve "$1") || return 1
  git -C "$abs" config --worktree --unset remote.origin.pushurl 2>/dev/null
  print -P "  %F{green}🔓%f Push habilitado en %F{245}${abs}%f"
}

# wt list -> lista los worktrees e indica cuáles tienen el push bloqueado
_wt_list() {
  cd "$SYP_REPO_DIR" || return 1
  git worktree list | while read -r line; do
    local p=${line%% *}
    if git -C "$p" config --worktree --get remote.origin.pushurl &>/dev/null; then
      print -P "  %F{yellow}🔒%f ${line}"
    else
      print -P "  %F{green}🔓%f ${line}"
    fi
  done
}

# Puebla los submódulos de un worktree clonándolos de las copias locales del
# repo principal en vez de GitHub: instantáneo y sin red ni credenciales (los
# de nimetrix son privados por SSH y no hay clave configurada acá).
#   - las URLs van con -c para no persistirlas en el .git/config compartido
#     con el repo principal, que es donde escribiría 'git config' normal.
#   - protocol.file.allow hace falta desde git 2.38 (CVE-2022-39253), y va
#     con -c porque solo debe aplicar a estas URLs que armamos nosotros.
_wt_submodules_local() {
  local ruta=$1
  local key spath name
  local -a cargs
  cargs=(-c protocol.file.allow=always)

  # ojo: no usar 'path' como variable, en zsh está ligada a $PATH
  while read -r key spath; do
    name=${key#submodule.}
    name=${name%.path}
    cargs+=(-c "submodule.${name}.url=${SYP_REPO_DIR}/${spath}")
  done < <(git -C "$ruta" config -f .gitmodules --get-regexp '^submodule\..*\.path$')

  git -C "$ruta" "${cargs[@]}" submodule update --init --recursive
}

# wt create -d "<descripcion>" [-b <rama base>] [-r <ruta>]
# Crea un worktree hermano del repo, con rama <Descripcion-Title-Case>-Pedro
# a partir de origin/<base> (default main), y por defecto bloquea el push.
_wt_create() {
  local description="" base="main" ruta="" personal="Pedro"

  if [[ $# -eq 0 ]]; then
    print -P "\n  %F{magenta}◆%f  %Bwt create%b %F{245}· nuevo worktree%f\n"
    print -Pn "  %F{cyan}?%f Descripción: "
    read "description"
    print -Pn "  %F{cyan}?%f Rama base %F{245}(main)%f: "
    read "base"; base=${base:-main}
    print ""
  else
    while [[ $# -gt 0 ]]; do
      case "$1" in
        -d|--description) description="$2"; shift 2 ;;
        -b|--base) base="$2"; shift 2 ;;
        -r|--ruta|--path) ruta="$2"; shift 2 ;;
        *) print -P "%F{red}✘%f Opción desconocida: $1"; return 1 ;;
      esac
    done
  fi

  if [[ -z "$description" ]]; then
    print -P "%F{red}✘%f Descripción es obligatoria"
    return 1
  fi

  local slug branch
  slug=$(echo "$description" | sed -E 's/[^A-Za-z0-9]+/ /g' \
    | awk '{for(i=1;i<=NF;i++)$i=toupper(substr($i,1,1)) tolower(substr($i,2)); print}' OFS='-')
  if [[ "${slug:l}" == *-${personal:l} ]]; then
    branch="$slug"
  else
    branch="${slug}-${personal}"
  fi

  cd "$SYP_REPO_DIR" || { print -P "%F{red}✘%f No pude entrar a $SYP_REPO_DIR"; return 1; }

  if [[ -z "$ruta" ]]; then
    local repo_name=${SYP_REPO_DIR:t} parent=${SYP_REPO_DIR:h}
    local kebab=${slug:l}
    ruta="${parent}/${repo_name}-${kebab}"
  fi

  print -P "\n  %F{magenta}◆%f  %Bwt%b %F{245}· ${branch} ← origin/${base}%f\n"

  _syp_step "sincronizando origin/${base} (fetch)" git fetch origin "$base" || return 1
  _syp_step "creando worktree en ${ruta}" git worktree add -b "$branch" "$ruta" "origin/${base}" || return 1

  print ""
  # Por defecto se poblan: si quedan vacíos, un agente trabajando en el
  # worktree no ve el código de queue/storage/server-env/nimetrix y termina
  # reimplementando cosas que ya existen.
  print -Pn "  %F{cyan}?%f ¿Poblar submódulos en este worktree? %F{245}(S/n)%f: "
  read "REPLY"
  if [[ "$REPLY" == "n" || "$REPLY" == "N" ]]; then
    print -P "  %F{yellow}⚠%f Submódulos vacíos: ojo que un agente puede reimplementar código que ya existe ahí."
  else
    _syp_step "poblando submódulos desde el repo principal" _wt_submodules_local "$ruta"
  fi

  print ""
  print -Pn "  %F{cyan}?%f ¿Bloquear push en este worktree? %F{245}(S/n)%f: "
  read "REPLY"
  if [[ "$REPLY" == "n" || "$REPLY" == "N" ]]; then
    print -P "\n  %F{yellow}⚠%f Push sin bloquear en este worktree."
  else
    _wt_lock "$ruta"
  fi

  print ""
  _syp_box "$branch"
  print -P "\n  %F{green}Listo%f, worktree en %F{245}${ruta}%f. %F{yellow}🚀%f\n"
}

# wt remove <ruta> [-f]  -> elimina el worktree y, si confirmás, su rama
_wt_remove() {
  local ruta=$1; shift
  local force=0
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -f|--force) force=1; shift ;;
      *) shift ;;
    esac
  done

  if [[ -z "$ruta" ]]; then
    print -P "%F{red}✘%f Uso: wt remove <ruta> [-f]"
    return 1
  fi

  local abs
  abs=$(_wt_resolve "$ruta") || return 1

  local branch
  branch=$(git -C "$abs" rev-parse --abbrev-ref HEAD 2>/dev/null)

  print -Pn "  %F{cyan}?%f Vas a eliminar el worktree %F{245}${abs}%f${branch:+ (rama %B$branch%b)}. ¿Continuar? %F{245}(S/n)%f: "
  read "REPLY"
  if [[ "$REPLY" == "n" || "$REPLY" == "N" ]]; then
    print -P "\n  %F{yellow}⚠%f Cancelado.\n"
    return 0
  fi

  # git se niega a borrar un worktree con submódulos registrados (aunque
  # estén vacíos/sin inicializar), hay que desregistrarlos primero.
  git -C "$abs" submodule deinit -f --all &>/dev/null

  cd "$SYP_REPO_DIR" || return 1

  if (( force )); then
    # git exige --force DOS veces cuando el worktree tiene (o tuvo) submódulos
    _syp_step "eliminando worktree" git worktree remove --force --force "$abs" || return 1
  else
    git worktree remove "$abs" &>/dev/null \
      && print -P "  %F{green}✔%f eliminando worktree" \
      || _syp_step "eliminando worktree (con submódulos)" git worktree remove --force --force "$abs" \
      || return 1
  fi

  if [[ -n "$branch" ]]; then
    print -Pn "  %F{cyan}?%f ¿Borrar también la rama %B${branch}%b? %F{245}(S/n)%f: "
    read "REPLY"
    if [[ "$REPLY" != "n" && "$REPLY" != "N" ]]; then
      _syp_step "borrando rama ${branch}" git branch -D "$branch" || return 1
    fi
  fi

  print -P "\n  %F{green}Listo%f, worktree eliminado.\n"
}

wt() {
  local action=$1; shift 2>/dev/null
  case "$action" in
    create|-c|--create) _wt_create "$@" ;;
    lock)               _wt_lock "$1" ;;
    unlock)             _wt_unlock "$1" ;;
    list|ls)            _wt_list ;;
    remove|rm)          _wt_remove "$@" ;;
    submodules|sub)
      local abs
      abs=$(_wt_resolve "$1") || return 1
      _syp_step "poblando submódulos desde el repo principal" _wt_submodules_local "$abs"
      ;;
    *)
      print -P "%F{cyan}Uso:%f wt create [-d \"DESCRIPCION\"] [-b RAMA_BASE] [-r RUTA]"
      print -P "     wt lock [ruta]   wt unlock [ruta]   wt list   wt remove <ruta> [-f]"
      print -P "     wt submodules [ruta]"
      return 1
      ;;
  esac
}

export PATH="$HOME/.local/bin:$PATH"

# Sugerencias en gris desde el historial (-> para aceptar)
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
setopt interactivecomments

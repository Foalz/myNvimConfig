#!/usr/bin/env bash
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[+]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; }

NVIM_CONFIG="$HOME/.config/nvim"
PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

# ---------- Detectar distro / gestor de paquetes ----------

install_pkg() {
    if command -v apt-get &>/dev/null; then
        sudo apt-get install -y "$@"
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y "$@"
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm "$@"
    elif command -v brew &>/dev/null; then
        brew install "$@"
    else
        error "No se detectó un gestor de paquetes soportado (apt/dnf/pacman/brew)"
        exit 1
    fi
}

# ---------- 1. Neovim ----------

if command -v nvim &>/dev/null; then
    NVIM_VER=$(nvim --version | head -1)
    info "Neovim ya instalado: $NVIM_VER"
else
    info "Instalando Neovim..."
    install_pkg neovim
fi

# ---------- 2. Node.js (requerido por coc.nvim) ----------

if command -v node &>/dev/null; then
    info "Node.js ya instalado: $(node --version)"
else
    info "Instalando Node.js..."
    if command -v apt-get &>/dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        sudo apt-get install -y nodejs
    else
        install_pkg nodejs
    fi
fi

# ---------- 3. Ripgrep (requerido por Telescope) ----------

if command -v rg &>/dev/null; then
    info "Ripgrep ya instalado: $(rg --version | head -1)"
else
    info "Instalando Ripgrep..."
    install_pkg ripgrep
fi

# ---------- 4. LazyGit ----------

if command -v lazygit &>/dev/null; then
    info "LazyGit ya instalado: $(lazygit --version | head -1)"
else
    info "Instalando LazyGit..."
    if command -v brew &>/dev/null; then
        brew install lazygit
    else
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
        sudo install /tmp/lazygit /usr/local/bin
        rm -f /tmp/lazygit /tmp/lazygit.tar.gz
    fi
fi

# ---------- 5. Ruff (linter Python) ----------

if command -v ruff &>/dev/null; then
    info "Ruff ya instalado: $(ruff --version)"
else
    info "Instalando Ruff..."
    if command -v pipx &>/dev/null; then
        pipx install ruff
    else
        pip install --user ruff
    fi
fi

# ---------- 6. Glow (renderizador de Markdown en terminal) ----------

if command -v glow &>/dev/null; then
    info "Glow ya instalado: $(glow --version 2>/dev/null | head -1)"
else
    info "Instalando Glow..."
    if command -v brew &>/dev/null; then
        brew install glow
    elif command -v apt-get &>/dev/null; then
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
        echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
        sudo apt-get update && sudo apt-get install -y glow
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm glow
    else
        go install github.com/charmbracelet/glow@latest
    fi
fi

# ---------- 7. Herdr (multiplexor de terminal) ----------

if command -v herdr &>/dev/null; then
    info "Herdr ya instalado: $(herdr --version 2>/dev/null || echo 'OK')"
else
    info "Instalando Herdr..."
    curl -fsSL https://herdr.dev/install.sh | sh
fi

# ---------- 7. Packer.nvim ----------

if [ -d "$PACKER_DIR" ]; then
    info "Packer.nvim ya instalado"
else
    info "Instalando Packer.nvim..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
fi

# ---------- 7. Copiar configuración ----------

if [ "$(cd "$NVIM_CONFIG" 2>/dev/null && pwd)" = "$(pwd)" ]; then
    info "Ya estás en $NVIM_CONFIG, no es necesario copiar"
else
    if [ -d "$NVIM_CONFIG" ]; then
        BACKUP="$NVIM_CONFIG.bak.$(date +%Y%m%d%H%M%S)"
        warn "Configuración existente encontrada, respaldando en $BACKUP"
        mv "$NVIM_CONFIG" "$BACKUP"
    fi
    info "Copiando configuración a $NVIM_CONFIG..."
    cp -r "$(pwd)" "$NVIM_CONFIG"
fi

# ---------- 8. Instalar plugins y CoC extensions ----------

info "Instalando plugins con Packer..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2>&1 | tail -5 || true

info "Instalando extensiones de CoC..."
nvim --headless -c 'CocInstall -sync coc-json coc-tsserver coc-snippets coc-html coc-xml coc-yaml coc-html-css-support coc-pyright coc-diagnostic' -c 'qall' 2>&1 | tail -5 || true

# ---------- Listo ----------

echo ""
info "Instalación completa."
warn "Recuerda configurar una Nerd Font en tu terminal (JetBrainsMono, FiraCode, Hack, etc.)"
warn "Descarga desde: https://www.nerdfonts.com/font-downloads"

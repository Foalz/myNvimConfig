# Configuracion Neovim 0.7.2 con Lua 

## Screenshots

![mi configuracion con un proyecto de react-typescript](./images/nvim.png)

![utilizando Ag + FZF](./images/ag_finder.png)

## Requisitos Previos

### Fuente Nerd Font (Requerida para iconos)

Esta configuración utiliza iconos especiales que requieren una **Nerd Font**. Si los iconos aparecen como signos de interrogación (?) o cuadros vacíos, debes:

1. **Descargar una Nerd Font** desde [nerdfonts.com](https://www.nerdfonts.com/font-downloads)
   - Recomendadas: `JetBrainsMono Nerd Font`, `FiraCode Nerd Font`, o `Hack Nerd Font`

2. **Instalar la fuente en tu sistema**:
   - **Windows**: Descarga el archivo `.zip`, extrae y haz doble clic en los archivos `.ttf` para instalar
   - **Linux**: Copia los archivos `.ttf` a `~/.local/share/fonts/` y ejecuta `fc-cache -fv`
   - **macOS**: Copia los archivos `.ttf` a `~/Library/Fonts/`

3. **Configurar tu terminal para usar la Nerd Font**:
   - **Windows Terminal (WSL)**: Settings → Profiles → Defaults → Appearance → Font face → Selecciona tu Nerd Font
   - **iTerm2**: Preferences → Profiles → Text → Font → Selecciona tu Nerd Font
   - **Alacritty**: Edita `alacritty.yml` y configura `font.normal.family`

## Importante

- Instalar el gestor de paquetes [packer.nvim](https://github.com/wbthomason/packer.nvim)<br>
- Instalar las dependencias de [the_silver_searcher](https://github.com/ggreer/the_silver_searcher)<br>
- Instalar [Ripgrep](https://github.com/burntsushi/ripgrep) para que Telescope y FZF (los buscadores) puedan funcionar correctamente.
- Instalar [LazyGit](https://github.com/jesseduffield/lazygit#installation) para que funcione el plugin de git.
- Instalar [ruff](https://docs.astral.sh/ruff/) para el linter PEP8 de Python (ver sección "Python Linting").
- Reemplazar siempre este archivo desde https://github.com/johnstef99/vim-nerdtree-syntax-highlight/blob/master/after/syntax/nerdtree.vim
ya que las versiones mas actuales de Neovim generan errores con este plugin.
- Recordar siempre colocar este comando para que el plugin CoC funcione correctamente: :CocInstall coc-json coc-tsserver.

## Instalación

1. Clona este repositorio en tu carpeta de configuración de Neovim:
   ```bash
   git clone https://github.com/Foalz/myNvimConfig.git ~/.config/nvim
   ```

2. Abre Neovim y ejecuta:
   ```vim
   :PackerSync
   ```

3. Reinicia Neovim para aplicar todos los plugins.

## Python Linting (PEP8)

Esta configuración incluye linting PEP8 para Python usando **Pyright** (autocompletado y tipos) + **Ruff** (linter y formateador), integrados vía CoC.

### Dependencias

| Herramienta | Rol | Instalación |
|---|---|---|
| `coc-pyright` | LSP de Python (autocompletado, tipos, go-to-definition) | `:CocInstall coc-pyright` |
| `coc-diagnostic` | Puente entre linters externos y CoC | `:CocInstall coc-diagnostic` |
| `ruff` | Linter PEP8 + formateador | `pipx install ruff` |

### Instalación

1. Instalar `ruff`:
   ```bash
   # Opción recomendada (aislado con pipx)
   sudo apt install -y pipx && pipx ensurepath && pipx install ruff

   # Alternativa directa
   pip install --break-system-packages ruff
   ```

2. Instalar las extensiones de CoC dentro de Neovim:
   ```vim
   :CocInstall coc-pyright coc-diagnostic
   ```

3. Reiniciar Neovim. Al abrir un archivo `.py`, los errores PEP8 aparecerán inline.

### Uso

- **Errores inline**: se muestran automáticamente al abrir/guardar archivos `.py`.
- **Formatear con Ruff**: `:call CocAction('format')` aplica el formateador de Ruff al buffer actual.
- **Ver diagnósticos**: `:CocDiagnostics` lista todos los errores del archivo.

### Reglas activas por defecto

La configuración en `coc-settings.json` activa las siguientes reglas de ruff:

| Código | Descripción |
|---|---|
| **E** | Errores PEP8 (incluye `E501` line too long, default 88 chars) |
| **W** | Warnings PEP8 |
| **F** | Pyflakes (variables/imports sin usar, etc.) |
| **I** | isort (orden de imports) |

### Configuración personalizada de Ruff por proyecto

Para ajustar las reglas de linting en un proyecto específico, crear un archivo `ruff.toml` o `pyproject.toml` en la raíz del proyecto:

```toml
# ruff.toml
line-length = 120

[lint]
select = ["E", "W", "F", "I"]
ignore = ["E501"]               # ignorar largo de línea si ya usás 120
```

## Solución de Problemas

### Error: `module 'nvim-treesitter.configs' not found`

Este error ocurre cuando los plugins aún no están instalados. Ejecuta:
```vim
:PackerSync
```
Luego reinicia Neovim.

### Iconos no se muestran correctamente

Asegúrate de tener instalada y configurada una Nerd Font en tu terminal (ver sección "Requisitos Previos").

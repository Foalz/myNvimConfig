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
- Reemplazar siempre este archivo desde https://github.com/johnstef99/vim-nerdtree-syntax-highlight/blob/master/after/syntax/nerdtree.vim
ya que las versiones mas actuales de Neovim generan errores con este plugin
- Recordar siempre colocar este comando para que el plugin CoC funcione correctamente: :CocInstall coc-json coc-tsserver

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

## Solución de Problemas

### Error: `module 'nvim-treesitter.configs' not found`

Este error ocurre cuando los plugins aún no están instalados. Ejecuta:
```vim
:PackerSync
```
Luego reinicia Neovim.

### Iconos no se muestran correctamente

Asegúrate de tener instalada y configurada una Nerd Font en tu terminal (ver sección "Requisitos Previos").

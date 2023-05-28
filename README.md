# Configuracion Neovim 0.7.2 con Lua 

## Screenshots

![mi configuracion con un proyecto de react-typescript](./images/nvim.png)

![utilizando Ag + FZF](./images/ag_finder.png)

## Importante

- Instalar el gestor de paquetes [packer.nvim](https://github.com/wbthomason/packer.nvim)<br>
- Instalar las dependencias de [the_silver_searcher](https://github.com/ggreer/the_silver_searcher)<br>
- Reemplazar siempre este archivo desde https://github.com/johnstef99/vim-nerdtree-syntax-highlight/blob/master/after/syntax/nerdtree.vim
ya que las versiones mas actuales de Neovim generan errores con este plugin
- Recordar siempre colocar este comando para que el plugin CoC funcione correctamente: :CocInstall coc-json coc-tsserver

return require('packer').startup(function()
	--Packer can manage itself
	use 'wbthomason/packer.nvim'

	--Autocomplete
    use {
      'neoclide/coc.nvim',
      branch = 'release',
      run = ':CocInstall coc-json coc-tsserver coc-snippets coc-html coc-xml coc-yaml coc-html-css-support'
    }

	--Typing
    use 'tpope/vim-surround'

	--IDE
    use 'christoomey/vim-tmux-navigator'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'terryma/vim-multiple-cursors'
    use 'yggdroot/indentline'
    use 'scrooloose/nerdcommenter'
    use 'mhinz/vim-signify'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate | :TSInstall bash c css c_sharp dockerfile glimmer html javascript json jsonc lua markdown prisma python query tsx typescript vim vimdoc yaml' }
    use 'tiagofumo/vim-nerdtree-syntax-highlight'
    -- This fork is useful to fix tiagofumo colorscheme bug on icons
    --use 'johnstef99/vim-nerdtree-syntax-highlight/tree/master'
    use 'David-Kunz/markid'
    use 'ryanoasis/vim-devicons'
    --CSV files
    use 'chrisbra/csv.vim'


	--Themes 
    use 'morhetz/gruvbox'
    use 'tomasiser/vim-code-dark'
    use 'tomasr/molokai'
    use 'arcticicestudio/nord-vim'

	-- File Explorer
    use 'scrooloose/NERDTree'

	-- Auto pairs for '(' '[' '{'
    use 'jiangmiao/auto-pairs'
    use 'windwp/nvim-autopairs'

	--Finding words in project
    use 'ggreer/the_silver_searcher'    

	--statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
  end)

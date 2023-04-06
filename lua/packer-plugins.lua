return require('packer').startup(function()
	-- packer can manage itself
	use 'wbthomason/packer.nvim'

	--autocomplete
	use {
		'neoclide/coc.nvim',
		branch = 'release'
	}

	--typing
	use 'tpope/vim-surround'

	--IDE
	use 'christoomey/vim-tmux-navigator'
	use 'junegunn/fzf'
	use 'junegunn/fzf.vim'
	use 'terryma/vim-multiple-cursors'
	use 'yggdroot/indentline'
	use 'scrooloose/nerdcommenter'
	use 'mhinz/vim-signify'
  use 'ryanoasis/vim-devicons'

	--Themes 
  use 'morhetz/gruvbox'
  use 'tomasiser/vim-code-dark'
  use 'tomasr/molokai'

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

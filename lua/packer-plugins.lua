return require('packer').startup(function()
	--Packer can manage itself
	use 'wbthomason/packer.nvim'

	--Autocomplete
    use {
      'neoclide/coc.nvim',
      branch = 'release',
      run = ':CocInstall coc-json coc-tsserver coc-snippets coc-html coc-xml coc-yaml coc-html-css-support'
    }
  --Terminal
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
      require("toggleterm").setup()
    end}

	--Typing
    use 'tpope/vim-surround'

	--IDE
    --use 'christoomey/vim-tmux-navigator'
    use { "alexghergh/nvim-tmux-navigation" }
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'terryma/vim-multiple-cursors'
    use 'yggdroot/indentline'
    use 'scrooloose/nerdcommenter'
    use 'mhinz/vim-signify'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate | :TSInstall bash c css c_sharp dockerfile glimmer html javascript json jsonc lua markdown prisma python query tsx typescript vim vimdoc yaml arduino' }
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
    --use 'scrooloose/NERDTree'
    use {
    "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      requires = { 
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        {
          -- only needed if you want to use the commands with "_with_window_picker" suffix
          's1n7ax/nvim-window-picker',
          tag = "v1.*",
          config = function()
            require'window-picker'.setup({
              autoselect_one = true,
              include_current = false,
              filter_rules = {
                -- filter using buffer options
                bo = {
                  -- if the file type is one of following, the window will be ignored
                  filetype = { 'neo-tree', "neo-tree-popup", "notify" },

                  -- if the buffer type is one of following, the window will be ignored
                  buftype = { 'terminal', "quickfix" },
                },
              },
              other_win_hl_color = '#e35e4f',
            })
          end,
        }
      },
      config = function ()
        -- If you want icons for diagnostic errors, you'll need to define them somewhere:
        vim.fn.sign_define("DiagnosticSignError",
          {text = " ", texthl = "DiagnosticSignError"})
        vim.fn.sign_define("DiagnosticSignWarn",
          {text = " ", texthl = "DiagnosticSignWarn"})
        vim.fn.sign_define("DiagnosticSignInfo",
          {text = " ", texthl = "DiagnosticSignInfo"})
        vim.fn.sign_define("DiagnosticSignHint",
          {text = "󰌵", texthl = "DiagnosticSignHint"})
        vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
      end
  }

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

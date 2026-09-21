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

  --Searcher
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

	--IDE
    --use 'christoomey/vim-tmux-navigator'
  
    use {
    'sindrets/diffview.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("diffview").setup({
        -- Aquí puedes poner configuraciones extra si lo deseas
      })
    end
  }

  -- 2. GITSIGNS (Para los indicadores de color en el margen y GitLens)
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        current_line_blame = true, -- Muestra quién editó la línea (estilo GitLens)
        -- Puedes mapear un atajo rápido para previsualizar cambios individuales
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = 'Previsualizar cambio' })
        end
      })
    end
  }
  -- 3. GIT-CONFLICT (Resolver conflictos de merge dentro del buffer)
  -- OJO: upstream tiene un bug (PR #94 sin mergear) que rompe el plugin cuando
  -- neo-tree esta abierto: pinta los conflictos en el buffer equivocado y aborta.
  -- El fix esta aplicado a mano en ~/.local/share/nvim/site/pack/packer/start/
  -- git-conflict.nvim/lua/git-conflict.lua -> por eso PackerUpdate falla ahi.
  use {
    'akinsho/git-conflict.nvim',
    config = function()
      require('git-conflict').setup()
    end
  }

    use { "alexghergh/nvim-tmux-navigation" }
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'terryma/vim-multiple-cursors'
    use 'yggdroot/indentline'
    use 'scrooloose/nerdcommenter'
    use 'mhinz/vim-signify'
    --use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate | :TSInstall bash c css c_sharp dockerfile glimmer html javascript json jsonc lua markdown prisma python query tsx typescript vim vimdoc yaml arduino' }
    use 'tiagofumo/vim-nerdtree-syntax-highlight'
    -- This fork is useful to fix tiagofumo colorscheme bug on icons
    --use 'johnstef99/vim-nerdtree-syntax-highlight/tree/master'
    --use { 'David-Kunz/markid', requires = { 'nvim-treesitter/nvim-treesitter' } }
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

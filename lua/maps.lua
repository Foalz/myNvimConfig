local keymap = vim.api

--[TERMINAL MODE]
  
  --Escape from terminal mode to normal mode
  vim.cmd[[tnoremap <Esc> <C-\><C-n>]] --Lua gives error with \ bar 

--[NORMAL MODE]

  --Open a terminal
  --keymap.nvim_set_keymap('n', '<Leader>t', ':50vsp <bar> :terminal <CR>', { noremap = true })

	--Saving and quit
	keymap.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true })
	keymap.nvim_set_keymap('n', '<Leader>q', ':q<CR>', { noremap = true })
	keymap.nvim_set_keymap('n', '<Leader>e', ':q!<CR>', { noremap = true })

	--Find and replace
	keymap.nvim_set_keymap('n', '<Leader>h', ':%s/', { noremap = true })

	--Not yank with x
	keymap.nvim_set_keymap('n', 'x', '"_x', { noremap = true })

	-- Increment/decrement
	keymap.nvim_set_keymap('n', '+', '<C-a>', { noremap = true })
	keymap.nvim_set_keymap('n', '-', '<C-x>', { noremap = true })

	-- Delete a word backwards
	keymap.nvim_set_keymap('n', 'dq', 'vb"_d', { noremap = true })

	-- Select all
	keymap.nvim_set_keymap('n', '<Leader>aa', 'gg<S-v>G', { noremap = true })

	-- Select all & copy
	keymap.nvim_set_keymap('n', '<Leader>ac', 'ggVGy', { noremap = true })

	-- Select all & delete 
	keymap.nvim_set_keymap('n', '<Leader>ad', 'ggVGd', { noremap = true })

	-- Copy	
  keymap.nvim_set_keymap('n', 'cc', 'yy', { noremap = true })

	-- Faster Scrolling 
	keymap.nvim_set_keymap('n', '<C-e>', '10<C-e>', { noremap = true })
	keymap.nvim_set_keymap('n', '<C-w>', '10<C-y>', { noremap = true })

	-- Quick semi-colon
	keymap.nvim_set_keymap('n', '<Leader>;', '$a;<Esc>', { noremap = true })

	-- Toggle NERDTREE
	keymap.nvim_set_keymap('n', '<Leader>nn', ':NERDTree<CR>', { noremap = true })

	-- Toggle AG 
	keymap.nvim_set_keymap('n', '<Leader>p', ':Ag<CR>', { noremap = true })

  -- Open new tab in NERDTREE 
	keymap.nvim_set_keymap('n', ';', ':tabnew<bar> :NERDTree<CR>', { noremap = true })

  -- Open terminal in new tab in NERDTREE 
	--keymap.nvim_set_keymap('n', 'tm', ':tabnew<bar> :terminal <CR> <bar> i', { noremap = true })

  keymap.nvim_set_keymap('n', '1<Leader>t', ':1:ToggleTerm<CR>i', { noremap = true })
  keymap.nvim_set_keymap('n', '2<Leader>t', ':2:ToggleTerm<CR>i', { noremap = true })
  keymap.nvim_set_keymap('n', '3<Leader>t', ':3:ToggleTerm<CR>i', { noremap = true })
  keymap.nvim_set_keymap('n', '1<Leader>t', ':1:ToggleTerm<CR>i', { noremap = true })
  keymap.nvim_set_keymap('n', '<C-5>', ':1:ToggleTerm<CR>i', { noremap = true })

  -- Left tab in NERDTREE 
	keymap.nvim_set_keymap('n', ',', ':tabprevious<CR>', { noremap = true })

  -- Right tab in NERDTREE 
	keymap.nvim_set_keymap('n', '.', ':tabnext<CR>', { noremap = true })

  -- Close current tab in NERDTREE 
  keymap.nvim_set_keymap('n', '=', ':tabclose<CR>', { noremap = true })

  -- Find
	keymap.nvim_set_keymap('n', '<Leader>f', '/', { noremap = true })

  --Show filepath
	keymap.nvim_set_keymap('n', 'z', '1<C-g>', { noremap = true })
	
--[VISUAL MODE]

	-- Copy selected text
	keymap.nvim_set_keymap('v', 'c', 'y', { noremap = true })

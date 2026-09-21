local keymap = vim.api
local builtin = require('telescope.builtin')

--[TERMINAL MODE]
  
  --Escape from terminal mode to normal mode
  vim.cmd[[tnoremap <Esc> <C-\><C-n>]] --Lua gives error with \ bar 

--[NORMAL MODE]

  --Open a terminal
  --keymap.nvim_set_keymap('n', '<Leader>t', ':50vsp <bar> :terminal <CR>', { noremap = true })
  --
  
-- ---------------------------------------------------------------------
-- 1. Diffview (Para ver los cambios de todo el proyecto estilo VS Code)
-- ---------------------------------------------------------------------

-- Abrir la interfaz gráfica del Diff de Git (Ver todos los archivos modificados)
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git: Abrir Diffview" })

-- Cerrar la interfaz del Diff y volver a tus archivos normales
vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Git: Cerrar Diffview" })

-- Ver el historial de cambios del archivo actual (Súper útil para auditorías)
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Git: Historial de este archivo" })

-- ---------------------------------------------------------------------
-- 2. Gitsigns (Navegación y acciones rápidas línea por línea)
-- ---------------------------------------------------------------------

-- Saltars al siguiente cambio (hunk)
vim.keymap.set("n", "]c", function()
  if vim.wo.diff then return "]c" end
  vim.schedule(function() require("gitsigns").next_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Git: Siguiente cambio" })

-- Retroceder al cambio anterior (hunk)
vim.keymap.set("n", "[c", function()
  if vim.wo.diff then return "[c" end
  vim.schedule(function() require("gitsigns").prev_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Git: Cambio anterior" })

-- Previsualizar el cambio de la línea actual en un popup flotante (Estilo VS Code peek)
vim.keymap.set("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Git: Previsualizar línea" })

-- Ver quién modificó la línea actual en un popup flotante (Git Blame / GitLens)
vim.keymap.set("n", "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Git: Mostrar Blame" })

-- Deshacer/Resetear solo el cambio de la línea actual (¡Cuidado, esto borra el cambio físico!)
vim.keymap.set("n", "<leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "Git: Resetear línea actual" })

-- Preparar (Stage/git add) solo el cambio de la línea actual
vim.keymap.set("n", "<leader>gs", function() require("gitsigns").stage_hunk() end, { desc = "Git: Stage de la línea actual" })

	--Saving and quit
	keymap.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true })
	keymap.nvim_set_keymap('n', '<Leader>q', ':q<CR>', { noremap = true })
	keymap.nvim_set_keymap('n', '<Leader>e', ':q!<CR>', { noremap = true })

  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  vim.keymap.set('n', '<leader>fx', ':Telescope live_grep glob_pattern=*.{}<Left>', {})

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
	keymap.nvim_set_keymap('n', '<Leader>,', '$a,<Esc>', { noremap = true })

	-- Toggle NERDTREE
	keymap.nvim_set_keymap('n', '<Leader>nn', ':Neotree<CR>', { noremap = true })

	-- Toggle AG 
	keymap.nvim_set_keymap('n', '<Leader>p', ':Ag<CR>', { noremap = true })

  -- Open new tab in NERDTREE 
	--keymap.nvim_set_keymap('n', ';', ':tabnew<bar> :NERDTree<CR>', { noremap = true })

  -- Open terminal in new tab in NERDTREE 
	--keymap.nvim_set_keymap('n', 'tm', ':tabnew<bar> :terminal <CR> <bar> i', { noremap = true })

  keymap.nvim_set_keymap('n', '1<Leader>t', ':1:ToggleTerm direction=vertical size=45<CR>', { noremap = true })
  keymap.nvim_set_keymap('n', '2<Leader>t', ':2:ToggleTerm direction=horizontal size=12<CR>', { noremap = true })
  keymap.nvim_set_keymap('n', '3<Leader>t', ':3:ToggleTerm direction=float<CR>', { noremap = true })

  -- Lazygit: ver plugin/toggleterm.lua (<Leader>lg)

  -- Validar XML actual usando ToggleTerm flotante
  keymap.nvim_set_keymap('n', '<Leader>xv', ':w <bar> TermExec cmd="xmllint --noout %" direction=float<CR><esc>', { noremap = true, silent = true })

  -- Left tab in NERDTREE 
	keymap.nvim_set_keymap('n', ',', ':tabprevious<CR>', { noremap = true })

  -- Right tab in NERDTREE 
	keymap.nvim_set_keymap('n', '.', ':tabnext<CR>', { noremap = true })

  -- Close current tab in NERDTREE 
  keymap.nvim_set_keymap('n', '=', ':tabclose<CR>', { noremap = true })

  -- Find
	--keymap.nvim_set_keymap('n', '<Leader>f', '/', { noremap = true })

  --Show filepath
	keymap.nvim_set_keymap('n', 'z', '1<C-g>', { noremap = true })
	
--[VISUAL MODE]

	-- Copy selected text
	keymap.nvim_set_keymap('v', 'c', 'y', { noremap = true })

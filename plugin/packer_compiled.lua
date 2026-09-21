-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/jesus/.cache/nvim/packer_hererocks/2.1.1761786044/share/lua/5.1/?.lua;/home/jesus/.cache/nvim/packer_hererocks/2.1.1761786044/share/lua/5.1/?/init.lua;/home/jesus/.cache/nvim/packer_hererocks/2.1.1761786044/lib/luarocks/rocks-5.1/?.lua;/home/jesus/.cache/nvim/packer_hererocks/2.1.1761786044/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/jesus/.cache/nvim/packer_hererocks/2.1.1761786044/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  ["csv.vim"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/csv.vim",
    url = "https://github.com/chrisbra/csv.vim"
  },
  ["diffview.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rdiffview\frequire\0" },
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  fzf = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["git-conflict.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17git-conflict\frequire\0" },
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/git-conflict.nvim",
    url = "https://github.com/akinsho/git-conflict.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n®\1\0\1\b\0\v\0\r6\1\0\0009\1\1\0019\1\2\0016\2\3\0009\2\4\0029\2\5\2'\4\6\0'\5\a\0009\6\b\0015\a\t\0=\0\n\aB\2\5\1K\0\1\0\vbuffer\1\0\2\vbuffer\0\tdesc\25Previsualizar cambio\17preview_hunk\15<leader>hp\6n\bset\vkeymap\bvim\rgitsigns\vloaded\fpackageo\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0003\3\4\0=\3\5\2B\0\2\1K\0\1\0\14on_attach\0\1\0\2\23current_line_blame\2\14on_attach\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  indentline = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/indentline",
    url = "https://github.com/yggdroot/indentline"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  molokai = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/molokai",
    url = "https://github.com/tomasr/molokai"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\nõ\3\0\0\4\0\r\0\0296\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\t\0005\3\n\0B\0\3\0016\0\0\0009\0\v\0'\2\f\0B\0\2\1K\0\1\0#nnoremap \\ :Neotree reveal<cr>\bcmd\1\0\2\ttext\tÛ∞åµ\vtexthl\23DiagnosticSignHint\23DiagnosticSignHint\1\0\2\ttext\tÔÅö \vtexthl\23DiagnosticSignInfo\23DiagnosticSignInfo\1\0\2\ttext\tÔÅ± \vtexthl\23DiagnosticSignWarn\23DiagnosticSignWarn\1\0\2\ttext\tÔÅó \vtexthl\24DiagnosticSignError\24DiagnosticSignError\16sign_define\afn\bvim\0" },
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/nerdcommenter",
    url = "https://github.com/scrooloose/nerdcommenter"
  },
  ["nord-vim"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/nord-vim",
    url = "https://github.com/arcticicestudio/nord-vim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-tmux-navigation"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/nvim-tmux-navigation",
    url = "https://github.com/alexghergh/nvim-tmux-navigation"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["nvim-window-picker"] = {
    config = { "\27LJ\2\n£\2\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\t\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\4=\4\n\3=\3\v\2B\0\2\1K\0\1\0\17filter_rules\abo\1\0\1\abo\0\fbuftype\1\3\0\0\rterminal\rquickfix\rfiletype\1\0\2\fbuftype\0\rfiletype\0\1\4\0\0\rneo-tree\19neo-tree-popup\vnotify\1\0\4\17filter_rules\0\20include_current\1\19autoselect_one\2\23other_win_hl_color\f#e35e4f\nsetup\18window-picker\frequire\0" },
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/nvim-window-picker",
    url = "https://github.com/s1n7ax/nvim-window-picker"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  the_silver_searcher = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/the_silver_searcher",
    url = "https://github.com/ggreer/the_silver_searcher"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["vim-code-dark"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/vim-code-dark",
    url = "https://github.com/tomasiser/vim-code-dark"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-multiple-cursors"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors",
    url = "https://github.com/terryma/vim-multiple-cursors"
  },
  ["vim-nerdtree-syntax-highlight"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/vim-nerdtree-syntax-highlight",
    url = "https://github.com/tiagofumo/vim-nerdtree-syntax-highlight"
  },
  ["vim-signify"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/vim-signify",
    url = "https://github.com/mhinz/vim-signify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/jesus/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\nõ\3\0\0\4\0\r\0\0296\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\t\0005\3\n\0B\0\3\0016\0\0\0009\0\v\0'\2\f\0B\0\2\1K\0\1\0#nnoremap \\ :Neotree reveal<cr>\bcmd\1\0\2\ttext\tÛ∞åµ\vtexthl\23DiagnosticSignHint\23DiagnosticSignHint\1\0\2\ttext\tÔÅö \vtexthl\23DiagnosticSignInfo\23DiagnosticSignInfo\1\0\2\ttext\tÔÅ± \vtexthl\23DiagnosticSignWarn\23DiagnosticSignWarn\1\0\2\ttext\tÔÅó \vtexthl\24DiagnosticSignError\24DiagnosticSignError\16sign_define\afn\bvim\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n®\1\0\1\b\0\v\0\r6\1\0\0009\1\1\0019\1\2\0016\2\3\0009\2\4\0029\2\5\2'\4\6\0'\5\a\0009\6\b\0015\a\t\0=\0\n\aB\2\5\1K\0\1\0\vbuffer\1\0\2\vbuffer\0\tdesc\25Previsualizar cambio\17preview_hunk\15<leader>hp\6n\bset\vkeymap\bvim\rgitsigns\vloaded\fpackageo\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0003\3\4\0=\3\5\2B\0\2\1K\0\1\0\14on_attach\0\1\0\2\23current_line_blame\2\14on_attach\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: nvim-window-picker
time([[Config for nvim-window-picker]], true)
try_loadstring("\27LJ\2\n£\2\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\t\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\4=\4\n\3=\3\v\2B\0\2\1K\0\1\0\17filter_rules\abo\1\0\1\abo\0\fbuftype\1\3\0\0\rterminal\rquickfix\rfiletype\1\0\2\fbuftype\0\rfiletype\0\1\4\0\0\rneo-tree\19neo-tree-popup\vnotify\1\0\4\17filter_rules\0\20include_current\1\19autoselect_one\2\23other_win_hl_color\f#e35e4f\nsetup\18window-picker\frequire\0", "config", "nvim-window-picker")
time([[Config for nvim-window-picker]], false)
-- Config for: git-conflict.nvim
time([[Config for git-conflict.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17git-conflict\frequire\0", "config", "git-conflict.nvim")
time([[Config for git-conflict.nvim]], false)
-- Config for: diffview.nvim
time([[Config for diffview.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rdiffview\frequire\0", "config", "diffview.nvim")
time([[Config for diffview.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

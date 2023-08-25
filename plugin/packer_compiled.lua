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
local package_path_str = "/home/foalz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/foalz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/foalz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/foalz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/foalz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  ["csv.vim"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/csv.vim",
    url = "https://github.com/chrisbra/csv.vim"
  },
  fzf = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  indentline = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/indentline",
    url = "https://github.com/yggdroot/indentline"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  markid = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/markid",
    url = "https://github.com/David-Kunz/markid"
  },
  molokai = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/molokai",
    url = "https://github.com/tomasr/molokai"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\n�\23\0\0\a\0K\0o6\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\t\0005\3\n\0B\0\3\0016\0\v\0'\2\f\0B\0\2\0029\0\r\0005\2\14\0005\3\15\0=\3\16\0025\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\29\0005\5\28\0=\5\30\4=\4\31\3=\3 \0024\3\0\0=\3!\0025\3\"\0005\4#\0=\4$\0035\4&\0005\5%\0=\5'\0045\5(\0005\6)\0=\6*\5=\5+\0045\5,\0005\6-\0=\6*\5=\5.\4=\4/\3=\0030\0024\3\0\0=\0031\0025\0038\0005\0042\0004\5\0\0=\0053\0044\5\0\0=\0054\0044\5\0\0=\0055\0044\5\0\0=\0056\0044\5\0\0=\0057\4=\0049\0035\4:\0=\4;\0035\4=\0005\5<\0=\5/\0045\5>\0=\5?\4=\0040\0034\4\0\0=\4!\3=\3@\0025\3B\0005\4A\0=\4;\0035\4D\0005\5C\0=\5/\4=\0040\3=\3E\0025\3H\0005\4F\0005\5G\0=\5/\4=\0040\3=\3\31\2B\0\2\0016\0\0\0009\0I\0'\2J\0B\0\2\1K\0\1\0#nnoremap \\ :Neotree reveal<cr>\bcmd\1\0\0\1\0\a\agr\20git_revert_file\agp\rgit_push\aga\17git_add_file\agg\24git_commit_and_push\agu\21git_unstage_file\agc\15git_commit\6A\16git_add_all\1\0\1\rposition\nfloat\fbuffers\1\0\0\1\0\3\t<bs>\16navigate_up\6.\rset_root\abd\18buffer_delete\1\0\2\21group_empty_dirs\2\18show_unloaded\2\1\0\2\fenabled\2\20leave_dirs_open\1\15filesystem\26fuzzy_finder_mappings\1\0\4\t<up>\19move_cursor_up\n<C-n>\21move_cursor_down\n<C-p>\19move_cursor_up\v<down>\21move_cursor_down\1\0\0\1\0\n\t<bs>\16navigate_up\a[g\22prev_git_modified\a]g\22next_git_modified\6/\17fuzzy_finder\6#\17fuzzy_sorter\n<c-x>\17clear_filter\6.\rset_root\6D\27fuzzy_finder_directory\6f\21filter_on_submit\6H\18toggle_hidden\24follow_current_file\1\0\2\fenabled\1\20leave_dirs_open\1\19filtered_items\1\0\3\27use_libuv_file_watcher\1\26hijack_netrw_behavior\17open_default\21group_empty_dirs\1\26never_show_by_pattern\15never_show\16always_show\20hide_by_pattern\17hide_by_name\1\0\4\fvisible\2\16hide_hidden\1\20hide_gitignored\1\18hide_dotfiles\1\18nesting_rules\vwindow\rmappings\6a\1\0\1\14show_path\tnone\1\2\0\0\badd\6P\vconfig\1\0\1\14use_float\2\1\2\0\0\19toggle_preview\f<space>\1\0\23\6t\16open_tabnew\6s\16open_vsplit\6y\22copy_to_clipboard\6r\vrename\6x\21cut_to_clipboard\6d\vdelete\6m\tmove\6A\18add_directory\6q\17close_window\6R\frefresh\6l\18focus_preview\6?\14show_help\6z\20close_all_nodes\6w\28open_with_window_picker\6C\15close_node\6S\15open_split\6>\16next_source\6<\16prev_source\n<esc>\vcancel\t<cr>\topen\18<2-LeftMouse>\topen\6c\tcopy\6p\25paste_from_clipboard\1\2\1\0\16toggle_node\vnowait\1\20mapping_options\1\0\2\fnoremap\2\vnowait\2\1\0\2\nwidth\3(\rposition\tleft\rcommands\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\frenamed\t󰁕\fdeleted\b✖\nadded\5\rconflict\b\vstaged\b\runstaged\t󰄱\rmodified\5\fignored\b\14untracked\b\tname\1\0\3\19trailing_slash\1\14highlight\20NeoTreeFileName\26use_git_status_colors\2\rmodified\1\0\2\vsymbol\b[+]\14highlight\20NeoTreeModified\ticon\1\0\5\14highlight\20NeoTreeFileIcon\16folder_open\b\18folder_closed\b\fdefault\6*\17folder_empty\t󰜌\vindent\1\0\t\18indent_marker\b│\17with_markers\2\fpadding\3\1\16indent_size\3\2\23expander_highlight\20NeoTreeExpander\22expander_expanded\b\14highlight\24NeoTreeIndentMarker\23expander_collapsed\b\23last_indent_marker\b└\14container\1\0\0\1\0\1\26enable_character_fade\2$open_files_do_not_replace_types\1\4\0\0\rterminal\ftrouble\aqf\1\0\6\23popup_border_style\frounded\25close_if_last_window\1\26sort_case_insensitive\1\"enable_normal_mode_for_inputs\1\23enable_diagnostics\2\22enable_git_status\2\nsetup\rneo-tree\frequire\1\0\2\ttext\t󰌵\vtexthl\23DiagnosticSignHint\23DiagnosticSignHint\1\0\2\ttext\t \vtexthl\23DiagnosticSignInfo\23DiagnosticSignInfo\1\0\2\ttext\t \vtexthl\23DiagnosticSignWarn\23DiagnosticSignWarn\1\0\2\ttext\t \vtexthl\24DiagnosticSignError\24DiagnosticSignError\16sign_define\afn\bvim\0" },
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/nerdcommenter",
    url = "https://github.com/scrooloose/nerdcommenter"
  },
  ["nord-vim"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/nord-vim",
    url = "https://github.com/arcticicestudio/nord-vim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-tmux-navigation"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/nvim-tmux-navigation",
    url = "https://github.com/alexghergh/nvim-tmux-navigation"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["nvim-window-picker"] = {
    config = { "\27LJ\2\n�\1\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\t\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\4=\4\n\3=\3\v\2B\0\2\1K\0\1\0\17filter_rules\abo\1\0\0\fbuftype\1\3\0\0\rterminal\rquickfix\rfiletype\1\0\0\1\4\0\0\rneo-tree\19neo-tree-popup\vnotify\1\0\3\23other_win_hl_color\f#e35e4f\20include_current\1\19autoselect_one\2\nsetup\18window-picker\frequire\0" },
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/nvim-window-picker",
    url = "https://github.com/s1n7ax/nvim-window-picker"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  the_silver_searcher = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/the_silver_searcher",
    url = "https://github.com/ggreer/the_silver_searcher"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["vim-code-dark"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/vim-code-dark",
    url = "https://github.com/tomasiser/vim-code-dark"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-multiple-cursors"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors",
    url = "https://github.com/terryma/vim-multiple-cursors"
  },
  ["vim-nerdtree-syntax-highlight"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/vim-nerdtree-syntax-highlight",
    url = "https://github.com/tiagofumo/vim-nerdtree-syntax-highlight"
  },
  ["vim-signify"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/vim-signify",
    url = "https://github.com/mhinz/vim-signify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/foalz/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\n�\23\0\0\a\0K\0o6\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\t\0005\3\n\0B\0\3\0016\0\v\0'\2\f\0B\0\2\0029\0\r\0005\2\14\0005\3\15\0=\3\16\0025\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\29\0005\5\28\0=\5\30\4=\4\31\3=\3 \0024\3\0\0=\3!\0025\3\"\0005\4#\0=\4$\0035\4&\0005\5%\0=\5'\0045\5(\0005\6)\0=\6*\5=\5+\0045\5,\0005\6-\0=\6*\5=\5.\4=\4/\3=\0030\0024\3\0\0=\0031\0025\0038\0005\0042\0004\5\0\0=\0053\0044\5\0\0=\0054\0044\5\0\0=\0055\0044\5\0\0=\0056\0044\5\0\0=\0057\4=\0049\0035\4:\0=\4;\0035\4=\0005\5<\0=\5/\0045\5>\0=\5?\4=\0040\0034\4\0\0=\4!\3=\3@\0025\3B\0005\4A\0=\4;\0035\4D\0005\5C\0=\5/\4=\0040\3=\3E\0025\3H\0005\4F\0005\5G\0=\5/\4=\0040\3=\3\31\2B\0\2\0016\0\0\0009\0I\0'\2J\0B\0\2\1K\0\1\0#nnoremap \\ :Neotree reveal<cr>\bcmd\1\0\0\1\0\a\agr\20git_revert_file\agp\rgit_push\aga\17git_add_file\agg\24git_commit_and_push\agu\21git_unstage_file\agc\15git_commit\6A\16git_add_all\1\0\1\rposition\nfloat\fbuffers\1\0\0\1\0\3\t<bs>\16navigate_up\6.\rset_root\abd\18buffer_delete\1\0\2\21group_empty_dirs\2\18show_unloaded\2\1\0\2\fenabled\2\20leave_dirs_open\1\15filesystem\26fuzzy_finder_mappings\1\0\4\t<up>\19move_cursor_up\n<C-n>\21move_cursor_down\n<C-p>\19move_cursor_up\v<down>\21move_cursor_down\1\0\0\1\0\n\t<bs>\16navigate_up\a[g\22prev_git_modified\a]g\22next_git_modified\6/\17fuzzy_finder\6#\17fuzzy_sorter\n<c-x>\17clear_filter\6.\rset_root\6D\27fuzzy_finder_directory\6f\21filter_on_submit\6H\18toggle_hidden\24follow_current_file\1\0\2\fenabled\1\20leave_dirs_open\1\19filtered_items\1\0\3\27use_libuv_file_watcher\1\26hijack_netrw_behavior\17open_default\21group_empty_dirs\1\26never_show_by_pattern\15never_show\16always_show\20hide_by_pattern\17hide_by_name\1\0\4\fvisible\2\16hide_hidden\1\20hide_gitignored\1\18hide_dotfiles\1\18nesting_rules\vwindow\rmappings\6a\1\0\1\14show_path\tnone\1\2\0\0\badd\6P\vconfig\1\0\1\14use_float\2\1\2\0\0\19toggle_preview\f<space>\1\0\23\6t\16open_tabnew\6s\16open_vsplit\6y\22copy_to_clipboard\6r\vrename\6x\21cut_to_clipboard\6d\vdelete\6m\tmove\6A\18add_directory\6q\17close_window\6R\frefresh\6l\18focus_preview\6?\14show_help\6z\20close_all_nodes\6w\28open_with_window_picker\6C\15close_node\6S\15open_split\6>\16next_source\6<\16prev_source\n<esc>\vcancel\t<cr>\topen\18<2-LeftMouse>\topen\6c\tcopy\6p\25paste_from_clipboard\1\2\1\0\16toggle_node\vnowait\1\20mapping_options\1\0\2\fnoremap\2\vnowait\2\1\0\2\nwidth\3(\rposition\tleft\rcommands\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\frenamed\t󰁕\fdeleted\b✖\nadded\5\rconflict\b\vstaged\b\runstaged\t󰄱\rmodified\5\fignored\b\14untracked\b\tname\1\0\3\19trailing_slash\1\14highlight\20NeoTreeFileName\26use_git_status_colors\2\rmodified\1\0\2\vsymbol\b[+]\14highlight\20NeoTreeModified\ticon\1\0\5\14highlight\20NeoTreeFileIcon\16folder_open\b\18folder_closed\b\fdefault\6*\17folder_empty\t󰜌\vindent\1\0\t\18indent_marker\b│\17with_markers\2\fpadding\3\1\16indent_size\3\2\23expander_highlight\20NeoTreeExpander\22expander_expanded\b\14highlight\24NeoTreeIndentMarker\23expander_collapsed\b\23last_indent_marker\b└\14container\1\0\0\1\0\1\26enable_character_fade\2$open_files_do_not_replace_types\1\4\0\0\rterminal\ftrouble\aqf\1\0\6\23popup_border_style\frounded\25close_if_last_window\1\26sort_case_insensitive\1\"enable_normal_mode_for_inputs\1\23enable_diagnostics\2\22enable_git_status\2\nsetup\rneo-tree\frequire\1\0\2\ttext\t󰌵\vtexthl\23DiagnosticSignHint\23DiagnosticSignHint\1\0\2\ttext\t \vtexthl\23DiagnosticSignInfo\23DiagnosticSignInfo\1\0\2\ttext\t \vtexthl\23DiagnosticSignWarn\23DiagnosticSignWarn\1\0\2\ttext\t \vtexthl\24DiagnosticSignError\24DiagnosticSignError\16sign_define\afn\bvim\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: nvim-window-picker
time([[Config for nvim-window-picker]], true)
try_loadstring("\27LJ\2\n�\1\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\t\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\4=\4\n\3=\3\v\2B\0\2\1K\0\1\0\17filter_rules\abo\1\0\0\fbuftype\1\3\0\0\rterminal\rquickfix\rfiletype\1\0\0\1\4\0\0\rneo-tree\19neo-tree-popup\vnotify\1\0\3\23other_win_hl_color\f#e35e4f\20include_current\1\19autoselect_one\2\nsetup\18window-picker\frequire\0", "config", "nvim-window-picker")
time([[Config for nvim-window-picker]], false)

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

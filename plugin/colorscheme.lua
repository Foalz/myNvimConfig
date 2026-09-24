--vim.cmd("colorscheme nord")
--vim.cmd("colorscheme dracula")

vim.g.gruvbox_transparent_bg = 1
vim.cmd("colorscheme gruvbox")

local groups = {
  "Normal", "NormalFloat", "NormalNC", "SignColumn",
  "StatusLine", "StatusLineNC", "LineNr", "CursorLineNr",
  "EndOfBuffer", "VertSplit", "WinSeparator",
  "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeEndOfBuffer",
}
for _, group in ipairs(groups) do
  vim.cmd("highlight " .. group .. " guibg=NONE ctermbg=NONE")
end

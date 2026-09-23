--vim.cmd("colorscheme nord")
--vim.cmd("colorscheme gruvbox")

require('dracula').setup({
  transparent_bg = true,
  italic_comment = true,
  overrides = {
    Normal = { bg = "NONE" },
    NormalFloat = { bg = "NONE" },
    NormalNC = { bg = "NONE" },
    SignColumn = { bg = "NONE" },
    StatusLine = { bg = "NONE" },
    StatusLineNC = { bg = "NONE" },
    NeoTreeNormal = { bg = "NONE" },
    NeoTreeNormalNC = { bg = "NONE" },
    NeoTreeEndOfBuffer = { bg = "NONE" },
    LineNr = { bg = "NONE" },
    CursorLineNr = { bg = "NONE" },
    EndOfBuffer = { bg = "NONE" },
    VertSplit = { bg = "NONE" },
    WinSeparator = { bg = "NONE" },
  },
})

vim.cmd("colorscheme dracula")

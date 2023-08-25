 require('nvim-tmux-navigation').setup {
    disable_when_zoomed = true, -- defaults to false
    keybindings = {
        left = "<C-g>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>",
    }
}

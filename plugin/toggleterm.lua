local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  float_opts = {
    border = "curved",
    width = function() return math.floor(vim.o.columns * 0.95) end,
    height = function() return math.floor(vim.o.lines * 0.92) end,
  },
})

-- Lazygit en un flotante propio (count alto para no chocar con las terminales 1/2/3)
local lazygit = require("toggleterm.terminal").Terminal:new({
  cmd = "lazygit",
  direction = "float",
  hidden = true,
  count = 99,
  on_open = function(term)
    vim.cmd("startinsert!")
    -- lazygit usa <Esc> para volver atras: no lo robe el tnoremap global
    vim.keymap.set("t", "<esc>", "<esc>", { buffer = term.bufnr, noremap = true })
  end,
})

vim.keymap.set("n", "<leader>lg", function() lazygit:toggle() end, { desc = "Git: LazyGit" })

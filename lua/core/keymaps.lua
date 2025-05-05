-- Change leader to a comma
vim.g.mapleader = " "

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
vim.keymap.set("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })

-- Recommended for Colemak (avoiding Ctrl+i, since it's Tab)
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true }) -- down
vim.keymap.set("n", "<C-n>", "<C-w>j", { noremap = true, silent = true }) -- down
vim.keymap.set("n", "<C-e>", "<C-w>k", { noremap = true, silent = true }) -- up
vim.keymap.set("n", "<C-i>", "<C-w>l", { noremap = true, silent = true }) -- right

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Common stuff
-- vim.keymap.set('n', '<leader>l', '<cmd> :set nu! <CR>')
vim.keymap.set("n", "<leader>rl", "<cmd> :set rnu! <CR>") -- relative line numbers

-- Nvim Spectre
vim.keymap.set("n", "<C-s>", '<cmd>lua require("spectre").open()<CR>')
vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word",
})
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})

vim.keymap.set("n", "<Esc>", function()
  vim.cmd(":noh") -- use ESC to turn off search highlighting
  require("noice").cmd("dismiss") -- Outlier for noice plugic
end)

-- Change words with `c` shortcuts without yanking the replaced text
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("n", "cc", '"_cc')

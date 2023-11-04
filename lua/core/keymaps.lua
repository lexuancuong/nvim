-- Change leader to a comma
vim.g.mapleader = " "

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
vim.keymap.set("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })

-- use ESC to turn off search highlighting
vim.keymap.set("n", "<Esc>", "<cmd> :noh <CR>")

-- move cursor within insert mode
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-a>", "<ESC>^i")

-- navigation between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-j>", "<C-w>j")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Common stuff
vim.keymap.set("n", "<C-c>", "<cmd> :%y+ <CR>") -- copy whole file content
vim.keymap.set("n", "<S-t>", "<cmd> :enew <CR>") -- new buffer
vim.keymap.set("n", "<C-t>b", "<cmd> :tabnew <CR>") -- new tabs
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
  vim.cmd(":noh")
  require("noice").cmd("dismiss") -- Outlier for noice plugic
end)

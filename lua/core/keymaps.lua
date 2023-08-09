local function map(mode, lhs, rhs, opts)
   local options = { noremap=true, silent=true }
   if opts then
     options = vim.tbl_extend('force', options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
 end
-- Change leader to a comma
vim.g.mapleader = ' '

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
map('v', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })

-- use ESC to turn off search highlighting
map('n', '<Esc>', '<cmd> :noh <CR>')

-- move cursor within insert mode
map('i', '<C-h>', '<Left>')
map('i', '<C-e>', '<End>')
map('i', '<C-l>', '<Right>')
map('i', '<C-j>', '<Down>')
map('i', '<C-k>', '<Up>')
map('i', '<C-a>', '<ESC>^i')

-- navigation between windows
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-j>', '<C-w>j')

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- buffer handling
local close_buffer = function(force)
   if vim.bo.buftype == "terminal" then
      vim.api.nvim_win_hide(0)
      return
   end

   local fileExists = vim.fn.filereadable(vim.fn.expand "%p")
   local modified = vim.api.nvim_buf_get_option(vim.fn.bufnr(), "modified")

   -- if file doesnt exist & its modified
   if fileExists == 0 and modified then
      print "no file name? add it now!"
      return
   end

   force = force or not vim.bo.buflisted or vim.bo.buftype == "nofile"

   -- if not force, change to prev buf and then close current
   local close_cmd = force and ":bd!" or ":bp | bd" .. vim.fn.bufnr()
   vim.cmd(close_cmd)
end
map('n', '<leader>x', ':bp<bar>sp<bar>bn<bar>bd<CR>')
map('n', '<leader>n', ':BufferLineCycleNext<CR>')
map('n', '<leader>p', ':BufferLineCyclePrev<CR>')

-- Common stuff
map('n', '<C-c>', '<cmd> :%y+ <CR>') -- copy whole file content
map('n', '<S-t>', '<cmd> :enew <CR>') -- new buffer
map('n', '<C-t>b', '<cmd> :tabnew <CR>') -- new tabs
-- map('n', '<leader>l', '<cmd> :set nu! <CR>')
map('n', '<leader>rl', '<cmd> :set rnu! <CR>') -- relative line numbers
map('n', '<C-s>', '<cmd> :w <CR>') -- ctrl + s to save file

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
map('n', '<leader>t', ':NvimTreeFocus<CR>')

-- Auto Comment
map('n', '<leader>/', '<cmd> :lua require("Comment.api").toggle.linewise.current()<CR>')
map('v', '<leader>/', '<esc><cmd> :lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- Hop
map("n", "gl", ":HopLine <CR>")
map("n", "gw", ":HopWord <CR>")

-- Telescope
map("n", "<leader>fb", ":Telescope buffers <CR>")
map("n", "<leader>ff", ":Telescope find_files no_ignore=true hidden=true<CR>")
map("n", "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>")
map("n", "<leader>cm", ":Telescope git_commits <CR>")
-- map("n", "<leader>gs", ":lua require('custom.plugins.telescope').my_git_status()<CR>", {noremap = true, silent = true})
map("n", "<leader>fh", ":Telescope help_tags <CR>")
-- map("n", "<leader>fw", ":Telescope live_grep no_ignore=true hidden=true <CR>")
map("n", "<leader>fw", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
map("n", "<leader>fo", ":Telescope oldfiles <CR>")
map("n", "<leader>r", ":Telescope resume <CR>")
map("n", "<leader>ft", ":lua require(\'telescope.builtin\').grep_string({search = vim.fn.expand('<cword>')})<cr>", {})
-- map("n", "<leader>W", ":Telescope terms <CR>") -- pick a hidden term

-- Nvim Spectre
map('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>')
map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
map('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})

-- gitlinker
map('n', '<leader>gl', '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {silent = true})

-- :LazyGit
map('n', '<leader>lg', ':LazyGit <CR>')

-- tmux navigation
map("n", "<C-h>", ":NvimTmuxNavigateLeft<CR>")
map("n", "<C-j>", ":NvimTmuxNavigateDown<CR>")
map("n", "<C-k>", ":NvimTmuxNavigateUp<CR>")
map("n", "<C-l>", ":NvimTmuxNavigateRight<CR>")

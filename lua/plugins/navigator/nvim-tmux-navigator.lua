return {
  "christoomey/vim-tmux-navigator",
  config = function()
    local keymap = vim.keymap
    keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>")
    keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>")
    keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>")
    keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>")
  end,
}

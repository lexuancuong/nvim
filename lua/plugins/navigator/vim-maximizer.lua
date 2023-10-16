return {
  'szw/vim-maximizer',
  config = function()
    vim.keymap.set("n", "<leader><space>", ":MaximizerToggle<CR>", { desc = "Maximize or minize the current pane" })
  end
}

return {
  "phaazon/hop.nvim",
  config = function()
    require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    local keymap = vim.keymap
    keymap.set("n", "gl", ":HopLine <CR>")
    keymap.set("n", "gw", ":HopWord <CR>")
  end,
}

return {
  "phaazon/hop.nvim",
  config = function()
    require("hop").setup({ keys = "arstdhxcvbumlypfwqneio" })
    local keymap = vim.keymap
    keymap.set("n", "sl", ":HopLine <CR>")
    keymap.set("n", "ss", ":HopWord <CR>")
  end,
}

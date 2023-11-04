return {
  "numToStr/Comment.nvim",
  config = function()
    vim.keymap.set("n", "<leader>/", '<cmd> :lua require("Comment.api").toggle.linewise.current()<CR>')
    vim.keymap.set("v", "<leader>/", '<esc><cmd> :lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
  end,
}

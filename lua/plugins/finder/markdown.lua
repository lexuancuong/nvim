return {
  "iamcco/markdown-preview.nvim",
  run = function()
    vim.fn["mkdp#util#install"]()
  end,
  -- NodeJs error: https://github.com/iamcco/markdown-preview.nvim/issues/552
}

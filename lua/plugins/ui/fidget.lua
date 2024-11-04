return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    notification = {
      override_vim_notify = true,
    },
    logger = {
      level = vim.log.levels.WARN,
      float_precision = 0.01,
      path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
    },
  },
} 
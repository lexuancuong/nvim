return {
  "windwp/nvim-spectre",
  lazy = true,
  enable = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- 'kyazdani42/nvim-web-devicons',
  },
  keys = {
    { "<leader>S", "<cmd>lua require('spectre').toggle()<CR>", desc = "Toggle Spectre" },
  },
  opts = {
    replace_engine = {
      ["sed"] = {
        cmd = "sed",
        args = {
          "-i",
          "",
          "-E",
        },
      },
    },
  },
}

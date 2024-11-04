return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  build = "make",
  opts = {
    provider = "claude",
    auto_suggestions_provider = "claude",
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20241022",
    },
    ui = {
      position = "right",
      width = 30,
      border = "rounded",
    },
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
    },
    keymaps = {
      toggle = "<leader>aa",
      refresh = "<leader>ar",
      focus = "<leader>af",
      edit = "<leader>ae",
    },
  },
  config = function(_, opts)
    local status_ok, avante = pcall(require, "avante")
    if not status_ok then
      print("Failed to load Avante:", avante)
      return
    end

    status_ok, err = pcall(avante.setup, opts)
    if not status_ok then
      print("Failed to setup Avante:", err)
      return
    end
  end,
}
-- Create dir manually for full writing on it
-- mkdir -p /Users/lexuancuong/.cache/nvim/avante

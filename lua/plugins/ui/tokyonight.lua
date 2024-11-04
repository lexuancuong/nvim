return {
  "folke/tokyonight.nvim",
  lazy = false,    -- make sure we load this during startup
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
    style = "storm",
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "dark",
      floats = "dark",
    },
    sidebars = {
      "qf",
      "vista_kind",
      "terminal",
      "packer",
      "spectre_panel",
      "NeogitStatus",
      "help",
    },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = false,
    on_colors = function(colors)
      colors.border = "#1A1B26"
    end,
    on_highlights = function(highlights, colors)
      highlights.TelescopeBorder = {
        fg = colors.border,
      }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    -- Fix: Use vim.cmd instead of calling colorscheme directly
    vim.cmd([[colorscheme tokyonight]])
  end,
}

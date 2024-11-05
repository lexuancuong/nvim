return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false, -- Load during startup
  priority = 1000, -- Load before other plugins
  opts = {
    flavour = "macchiato", -- Options: latte, frappe, macchiato, mocha
    transparent_background = false,
    term_colors = true,
    styles = {
      comments = { "italic" },
      keywords = { "italic" },
      functions = { "bold" },
      variables = {},
    },
    integrations = {
      telescope = true,
      nvimtree = { enabled = true, show_root = true },
    },
    highlight_overrides = {
      mocha = function(colors)
        return {
          -- Customize specific highlights
          CursorLine = { bg = colors.surface0 },
          Visual = { bg = colors.surface1 },
        }
      end,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin") -- Apply the Catppuccin colorscheme
  end,
}

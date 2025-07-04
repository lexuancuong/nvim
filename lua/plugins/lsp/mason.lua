return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    mason_tool_installer.setup({
      ensure_installed = {
        -- Python tools
        "isort",
        "black",
        "pyright",
        
        -- JavaScript/TypeScript tools
        "prettier",
        "eslint_d",
        "typescript-language-server",
        "js-debug-adapter",
        "deno",
        
        -- Web development
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "emmet-ls",
        "tailwindcss-language-server",
        "stylelint",
        
        -- Format & Lint
        "prettier",
        "prettierd",
        "eslint_d",
        "stylelint",
      }
    })
  end
}

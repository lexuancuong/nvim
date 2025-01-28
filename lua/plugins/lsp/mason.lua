return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      check_outdated_packages_on_open = true,
      },
    max_concurrent_installers = 4,
    pip = {
      upgrade_pip = true,
      install_args = {
        "--no-cache-dir",
      },
    },
    log_level = vim.log.levels.INFO,
        })
        -- Ensure mason directory exists and has correct permissions
        local mason_dir = vim.fn.stdpath("data") .. "/mason"
        if vim.fn.isdirectory(mason_dir) == 0 then
    vim.fn.mkdir(mason_dir, "p")
        end
        -- Set proper permissions
        vim.fn.system({"chmod", "-R", "755", mason_dir})

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        -- Python
        "pyright",
        
        -- Web Development
        "html",
        "cssls",
        "tailwindcss",
        "emmet_ls",
        "jsonls",
        
        -- JavaScript/TypeScript
        "tsserver",
        "eslint",
        
        -- Style/Format
        "prettier",
        "stylelint",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
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

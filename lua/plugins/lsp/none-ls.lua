return {
  "nvimtools/none-ls.nvim", -- configure formatters & linters
  -- event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local mason_null_ls = require("mason-null-ls")
    local null_ls = require("null-ls")
    mason_null_ls.setup({
      ensure_installed = {
        "black",
        "pylint",
        "isort",
      },
    })

    -- for conciseness
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- configure null_ls
    null_ls.setup({
      -- setup formatters & linters
      sources = {
        --  to disable file types use
        --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
        formatting.isort.with({ extra_args = { "--ca", "-m=3" } }),
        formatting.black.with({
          extra_args = { "--skip-string-normalization" },
        }),
        formatting.autopep8,
        diagnostics.pylint,
      },
    })
  end,
}

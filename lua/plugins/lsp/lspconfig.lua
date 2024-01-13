return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- set keybinds
      -- opts.desc = "Show LSP references"
      -- keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
      -- Important to show function from LSP diagnostic
      if client.supports_method("textDocument/documentSymbol") and client.name ~= "bashls" then
        require("nvim-navic").attach(client, bufnr)
      end

      opts.desc = "Go to declaration"
      vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      vim.keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", opts)
      vim.keymap.set("n", "ge", "<cmd>lua vim.diagnostic.open_float(nil, { focus = false })<CR>")

      -- opts.desc = "Show LSP implementations"
      -- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
      --
      -- opts.desc = "Show LSP type definitions"
      -- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
      --
      -- opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
      --
      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
      --
      -- opts.desc = "Show buffer diagnostics"
      -- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
      --
      -- opts.desc = "Show line diagnostics"
      -- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
      --
      -- opts.desc = "Go to previous diagnostic"
      -- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
      --
      -- opts.desc = "Go to next diagnostic"
      -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
      --
      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

      opts.desc = "Show error in detail"
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- configure html server
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure python server
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pyright = {
          autoImportCompletion = true,
        },
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly", -- Important to avoid analysing from third-party/python codes
            useLibraryCodeForTypes = true,
            -- This one is extremely important to show error diagnostics. Without it, only warnings and info are shown
            typeCheckingMode = "on",
          },
        },
      },
    })

    -- Diagnostic settings:
    -- see: `:help vim.diagnostic.config`
    -- Customizing how diagnostics are displayed
    vim.diagnostic.config({
      update_in_insert = true,
      virtual_text = false,
      signs = true,
      underline = false,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    local function lspSymbol(name, icon)
      local hl = "DiagnosticSign" .. name
      vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
    end
    lspSymbol("Error", "")
    lspSymbol("Info", "")
    lspSymbol("Hint", "")
    lspSymbol("Warn", "")

    -- -- suppress error messages from lang servers, redundant?
    -- vim.notify = function(msg, log_level)
    --   if msg:match("exit code") then
    --     return
    --   end
    --   if log_level == vim.log.levels.ERROR then
    --     vim.api.nvim_err_writeln(msg)
    --   else
    --     vim.api.nvim_echo({ { msg } }, true, {})
    --   end
    -- end
  end,
}

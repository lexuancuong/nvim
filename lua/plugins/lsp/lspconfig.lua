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
    vim.lsp.set_log_level("debug")

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
      keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
      keymap.set("n", "gD", vim.lsp.buf.definition)
      keymap.set("n", "ge", "<cmd>lua vim.diagnostic.open_float(nil, { focus = false })<CR>")
      keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
      keymap.set("n", "<leader>cl", vim.lsp.codelens.run)
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>") -- show lsp implementations
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>") -- show lsp type definitions
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action) -- see available code actions, in visual mode will apply to selection
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename) -- smart rename
      keymap.set("n", "K", vim.lsp.buf.hover) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()
    --================================
    -- Metals specific setup
    --================================
    local metals_config = require("metals").bare_config()
    metals_config.tvp = {
      icons = {
        enabled = true,
      },
    }

    --metals_config.cmd = { "cs", "launch", "tech.neader:langoustine-tracer_3:0.0.18", "--", "metals" }
    metals_config.settings = {
      defaultBspToBuildTool = true,
      enableSemanticHighlighting = false,
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      serverVersion = "latest.snapshot",
    }

    metals_config.init_options = {
      statusBarProvider = "on",
      icons = "unicode"
    }

    metals_config.capabilities = capabilities

    metals_config.on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        callback = vim.lsp.codelens.refresh,
        buffer = bufnr,
        group = lsp_group,
      })
    end
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt", "java" },
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })

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

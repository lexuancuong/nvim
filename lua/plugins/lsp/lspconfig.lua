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
    
    -- Initialize capabilities with nvim-cmp integration
    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    -- LSP Attach Keybindings
    local function on_attach(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      
      -- Enable navic (breadcrumbs) if available
      if client.supports_method("textDocument/documentSymbol") and client.name ~= "bashls" then
        require("nvim-navic").attach(client, bufnr)
      end

      -- Navigation
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
      vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
      vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Go to references" }))
      vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
      
      -- Workspace management
      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
      vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))
      
      -- Actions
      vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show hover documentation" }))
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
      vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, vim.tbl_extend("force", opts, { desc = "Run codelens" }))
      
      -- Diagnostics
      vim.keymap.set("n", "ge", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
      
      -- LSP Management
      vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", vim.tbl_extend("force", opts, { desc = "Restart LSP" }))
    end
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
      enableSemanticHighlighting = true,
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
    --end metals setup

    -- Python configuration
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pyright = {
          autoImportCompletion = true,
          typeCheckingMode = "basic",
          disableLanguageServices = false,
          disableOrganizeImports = false,
        },
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly", -- Important to avoid analysing from third-party/python codes
            useLibraryCodeForTypes = true,
            typeCheckingMode = "basic",
            indexing = false, -- Disable indexing of library files
            autoImportCompletions = true,
            stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
            typeshedPaths = {},
            exclude = {
              "**/node_modules",
              "**/__pycache__",
              "**/.*",
              "**/site-packages",
              "**/dist-packages",
            },
            ignore = {
              "**/site-packages/**",
              "**/dist-packages/**",
              "**/.venv/**",
              "**/venv/**",
              "**/env/**",
            },
            inlayHints = {
              variableTypes = true,
              functionReturnTypes = true,
            },
          },
        },
      },
    })

    -- TypeScript/JavaScript configuration
    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    })

    -- ESLint configuration
    lspconfig["eslint"].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- Enable formatting
        client.server_capabilities.documentFormattingProvider = true
        -- Format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
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


return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "Avante" },
      },
      ft = {"Avante" },
    },
  },
  opts = {
    debug = false,
    provider = "claude",
    auto_suggestions_provider = "claude",
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20241022",
      max_tokens = 8192,  -- Increase max tokens for longer responses
      temperature = 0.3,
    },
    ui = {
      position = "right",
      width = 35,
      border = "rounded",
    },
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      suggestion_context_size = 3000,
      suggestion_context_size = 8000,  -- Increase context size
      chunk_size = 4096,  -- Add chunk size for better handling of large responses
    },
    keymaps = {
      toggle = "<leader>aa",
      refresh = "<leader>ar",
      focus = "<leader>af",
      edit = "<leader>ae",
      load_project_context = "<leader>ap",
      accept_suggestion = "<Tab>",
      accept_suggestion_word = "<Right>",
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
    vim.api.nvim_set_keymap("n", "<leader>ap", ":lua require'avante'.load_context()<CR>", { noremap = true, silent = true })
  end,
}
-- Create dir manually for full writing on it
-- mkdir -p /Users/lexuancuong/.cache/nvim/avante

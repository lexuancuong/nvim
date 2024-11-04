return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      enabled = vim.fn.executable("make") == 1,
    },
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  opts = {
    defaults = {
      previewer = true,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      layout_strategy = "horizontal",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    -- Enable telescope fzf native if installed
    pcall(telescope.load_extension, "fzf")
    telescope.load_extension("live_grep_args")
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers <CR>")
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files no_ignore=true hidden=true<CR>")
    -- keymap.set("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>")
    vim.keymap.set("n", "<leader>gs", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>")
    vim.keymap.set("n", "<leader>gs", ":lua require('telescope.builtin').git_status()<CR>", {noremap = true, silent = true})
    vim.keymap.set("n", "<leader>fw", function()
      require("telescope").extensions.live_grep_args.live_grep_args()
    end)
    vim.keymap.set("n", "<leader>r", ":Telescope resume <CR>")
    vim.keymap.set("n", "<leader>mt", function()
      telescope.extensions.metals.commands()
    end)
    vim.keymap.set(
      "n",
      "<leader>ft",
      ":lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<cr>",
      {}
    ) -- Find the current word under cursor
  end,
}

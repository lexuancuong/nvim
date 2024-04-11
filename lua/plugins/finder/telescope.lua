return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    telescope = require("telescope")
    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = " 🔎 ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
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
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      },
    })
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

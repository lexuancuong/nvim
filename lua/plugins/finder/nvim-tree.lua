return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "NvimTreeToggle",
  keys = {
    {
      "<leader>e",
      function()
        require("nvim-tree.api").tree.find_file({ open = true, focus = true })
      end,
      desc = "Reveal current file in Nvim-tree",
    },
  },
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    respect_buf_cwd = true,
    sync_root_with_cwd = true,
    view = {
      float = {
        enable = true,
        quit_on_focus_loss = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * 0.6
          local window_h = screen_h * 0.6
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          return {
            border = "rounded",
            relative = "editor",
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
    filters = {
      exclude = {
        ".git",
        "node_modules",
        ".next",
        "dist",
        "build",
        "vendor",
      },
    },
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    git = {
      enable = true,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  },
}


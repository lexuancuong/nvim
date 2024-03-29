return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    require("bufferline").setup({
      options = {
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        show_close_icon = false,
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 25,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "thin",
        always_show_bufferline = true,
        diagnostics = false,
        themable = true,

        custom_areas = {
          right = function()
            return {
              { text = "%@Toggle_theme@" .. vim.g.toggle_theme_icon .. "%X" },
              { text = "%@Quit_vim@  %X" },
            }
          end,
        },

        custom_filter = function(buf_number)
          -- Func to filter out our managed/persistent split terms
          local present_type, type = pcall(function()
            return vim.api.nvim_buf_get_var(buf_number, "term_type")
          end)

          if present_type then
            if type == "vert" then
              return false
            elseif type == "hori" then
              return false
            end
            return true
          end

          return true
        end,
      },
    })
    vim.keymap.set("n", "<leader>x", ":bp<bar>sp<bar>bn<bar>bd<CR>")
    vim.keymap.set("n", "<leader>n", ":BufferLineCycleNext<CR>")
    vim.keymap.set("n", "<leader>p", ":BufferLineCyclePrev<CR>")
  end,
}

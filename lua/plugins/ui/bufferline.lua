return {
  "akinsho/bufferline.nvim",
  dependencies = {"nvim-tree/nvim-web-devicons"},
  versions = "*",
  config = function()
    require("bufferline").setup{
      options = {
        show_buffer_icons = true
      }
    }
    vim.keymap.set("n", "<leader>x", ":bp<bar>sp<bar>bn<bar>bd<CR>")
    vim.keymap.set("n", "<leader>n", ":BufferLineCycleNext<CR>")
    vim.keymap.set("n", "<leader>p", ":BufferLineCyclePrev<CR>")
  end,
}

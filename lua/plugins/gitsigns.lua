local is_gitsigns_ok, gitsigns = pcall(require, "gitsigns")

if not is_gitsigns_ok then
   return
end

gitsigns.setup {
  keymaps = {
     -- Default keymap options
     buffer = true,
     noremap = true,
     ["n <leader>wc"] = '<cmd>lua require"gitsigns".blame_line()<CR>', -- wc mean who coded
  },
   signs = {
      add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
   },
}

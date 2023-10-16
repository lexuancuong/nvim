-- A simple statusline/winbar component that uses LSP to show your current code context. Named after the Indian satellite navigation system.
return
{
  'SmiteshP/nvim-navic',
  dependencies = {'neovim/nvim-lspconfig'},
  opts = {
    icons = icons,
    highlight = true,
  }
}

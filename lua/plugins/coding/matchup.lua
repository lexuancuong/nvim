return {
  "andymass/vim-matchup",
  event = "BufReadPost",
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
    -- Disable treesitter integration if causing issues
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_delim_noskips = 2
    vim.g.matchup_matchparen_deferred_show_delay = 50
  end,
} 
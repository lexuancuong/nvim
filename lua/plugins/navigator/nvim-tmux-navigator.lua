return {
  "christoomey/vim-tmux-navigator",
  config = function()
    local keymap = vim.keymap
    -- Cannot map <C-h>, and not sure why
    -- https://stackoverflow.com/questions/32910188/cannot-map-c-h-and-not-sure-why
    -- infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
    -- tic $TERM.ti
    -- Symtoms:
    -- - Exit all Tmux sessions and open tmux again -> it works
    -- - On by default terminal without TMUX -> it works
    keymap.set("n", "<C-h>", "<cmd> :TmuxNavigateLeft <CR>")
    keymap.set("n", "<C-j>", "<cmd> :TmuxNavigateDown <CR>")
    keymap.set("n", "<C-k>", "<cmd> :TmuxNavigateUp <CR>")
    keymap.set("n", "<C-l>", "<cmd> :TmuxNavigateRight <CR>")
  end,
}

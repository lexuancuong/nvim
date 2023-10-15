local is_null_ls_ok, null_ls = pcall(require, "null-ls")

if not is_null_ls_ok then
  return
end

local b = null_ls.builtins

local sources = {
  -- black, isort, autopep8 must to be installed successfully in the environment
  -- you could use this PATH=$HOME/.local/bin:$PATH to let the environment know
  -- what is the black, isort, autopep8 and other python packages
  b.formatting.isort.with({ extra_args = { "--ca", "-m=3" } }),
  b.formatting.autopep8,
  b.formatting.black.with({
    extra_args = { "--skip-string-normalization" },
  }),
  b.formatting.trim_newlines,
  b.formatting.trim_whitespace,
  -- b.diagnostics.cspell.with({
  --   filetypes = {'python', 'markdown'}
  -- }),
  b.code_actions.cspell.with({
    filetypes = { "python", "markdown" },
  }),
}

null_ls.setup({
  sources = sources,
})

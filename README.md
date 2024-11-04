# Neovim Avante Configuration

This configuration sets up the Avante plugin for Neovim, integrating Claude AI assistance directly into your editor.

## Prerequisites
- Neovim (>= 0.8.0)
- Git
- Make (for building the plugin)
- [Lazy.nvim](https://github.com/folke/lazy.nvim) (plugin manager)
- An Anthropic API key for Claude access

## Installation

1. Ensure you have the prerequisites installed
2. Set up your Anthropic API key as an environment variable:
```bash
export ANTHROPIC_API_KEY="your-api-key-here"
```

3. Add the following to your Neovim configuration (usually in `~/.config/nvim/init.lua`):

```lua
{
  "mrcjkb/avante.nvim",
  dependencies = {
    "folke/lazy.nvim",
  },
  config = function()
    require("avante").setup({
      -- Optional: configure defaults here
    })
  end,
}
```

4. Restart Neovim and run:
```bash
:Lazy sync
```

5. Verify installation:
```bash
:AvanteStatus
```

The plugin should now be installed and ready to use. See Usage section below for next steps.

local function clock()
  return " " .. os.date("%H:%M")
end

local function lsp_progress(_, is_active)
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ""
  end
  local status = {}
  for _, msg in pairs(messages) do
    local title = ""
    if msg.title then
      title = msg.title
    end
    table.insert(status, (msg.percentage or 0) .. "%% " .. title)
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, "  ") .. " " .. spinners[frame + 1]
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {'neovim/nvim-lspconfig', 'SmiteshP/nvim-navic'},
  config = function()
    vim.cmd("au User LspProgressUpdate let &ro = &ro")
    lualine = require('lualine')
    lualine.setup({
      options = {
        theme = "tokyonight",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        icons_enabled = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "diagnostics", sources = { "nvim_diagnostic" } },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          {
            function()
              local navic = require("nvim-navic")
              if navic.is_available() then
                return navic.get_location({ highlight = false })
              end
            end,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_y = { "location" },
        lualine_z = { clock },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree" },
    })
  end
}

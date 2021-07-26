local function getTabStop()
  local label = "Tab Size: "
  if vim.api.nvim_buf_get_option(0, "expandtab") then
    label = "Spaces: "
  end
  return " " .. label .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local function getLspClient(msg)
  msg = msg or "  No Active Lsp"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return "  " .. client.name
    end
  end
  return msg
end

local plugin = {}

function plugin.setup()
  require("lualine").setup({
    options = { theme = "tokyonight" },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        {
          "diff",
          colored = true,
          symbols = { added = " ", modified = "柳", removed = " " },
        },
        {
          "diagnostics",
          sources = { "nvim_lsp" },
          sections = { "error", "warn", "info" },
          symbols = { error = " ", warn = " ", info = " " },
        },
        { "filename", symbols = { modified = "  ", readonly = "  " } },
      },
      lualine_x = { { "filetype", colored = true }, getLspClient },
      lualine_y = { getTabStop },
      lualine_z = { "location" },
    },
    extensions = { "fugitive", "nvim-tree" },
  })
end

return plugin

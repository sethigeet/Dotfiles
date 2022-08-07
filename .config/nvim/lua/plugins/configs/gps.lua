local Plugin = require("plugins.plugin")

local WINBAR_EXCLUDE_FT = {
  "help",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "Outline",
  "spectre_panel",
  "toggleterm",
}

local function get_filename()
  local filename = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")

  if filename == nil or filename == "" then return "" end

  local file_icon, file_icon_color =
    require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

  local hl_group = "FileIconColor" .. extension

  vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
  if file_icon == nil or file_icon == "" then
    file_icon = ""
    file_icon_color = ""
  end

  return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#LineNr#" .. filename .. "%*"
end

local function get_gps()
  local gps = require("nvim-gps")

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then return "" end

  if not gps.is_available() or gps_location == "error" then return "" end

  if not gps_location or gps_location == "" then return "" end

  return "  " .. gps_location
end

return Plugin:create({
  configure = function()
    local icons = require("lsp.kind")
    require("nvim-gps").setup({

      disable_icons = false, -- Setting it to true will disable all icons

      icons = {
        ["class-name"] = "%#CmpItemKindClass#" .. icons.Class .. "%* ",
        ["function-name"] = "%#CmpItemKindFunction#" .. icons.Function .. "%* ",
        ["method-name"] = "%#CmpItemKindMethod#" .. icons.Method .. "%* ",
        ["container-name"] = "%#CmpItemKindProperty#" .. icons.Object .. "%* ",
        ["tag-name"] = "%#CmpItemKindKeyword#" .. icons.Tag .. "%* ",
        ["mapping-name"] = "%#CmpItemKindProperty#" .. icons.Object .. "%* ",
        ["sequence-name"] = "%CmpItemKindProperty#" .. icons.Array .. "%* ",
        ["null-name"] = "%CmpItemKindField#" .. icons.Field .. "%* ",
        ["boolean-name"] = "%CmpItemKindValue#" .. icons.Boolean .. "%* ",
        ["integer-name"] = "%CmpItemKindValue#" .. icons.Number .. "%* ",
        ["float-name"] = "%CmpItemKindValue#" .. icons.Number .. "%* ",
        ["string-name"] = "%CmpItemKindValue#" .. icons.String .. "%* ",
        ["array-name"] = "%CmpItemKindProperty#" .. icons.Array .. "%* ",
        ["object-name"] = "%CmpItemKindProperty#" .. icons.Object .. "%* ",
        ["number-name"] = "%CmpItemKindValue#" .. icons.Number .. "%* ",
        ["table-name"] = "%CmpItemKindProperty#" .. icons.Table .. "%* ",
        ["date-name"] = "%CmpItemKindValue#" .. icons.Calendar .. "%* ",
        ["date-time-name"] = "%CmpItemKindValue#" .. icons.Table .. "%* ",
        ["inline-table-name"] = "%CmpItemKindProperty#" .. icons.Calendar .. "%* ",
        ["time-name"] = "%CmpItemKindValue#" .. icons.Watch .. "%* ",
        ["module-name"] = "%CmpItemKindModule#" .. icons.Module .. "%* ",
      },

      separator = "  ",

      -- limit for amount of context shown
      -- 0 means no limit
      -- Note: to make use of depth feature properly, make sure your separator isn't something that can appear
      -- in context names (eg: function names, class names, etc)
      depth = 0,

      -- indicator used when context is hits depth limit
      depth_limit_indicator = "..",
    })
  end,

  utils = {
    set_winbar = function()
      if vim.tbl_contains(WINBAR_EXCLUDE_FT, vim.opt_local.filetype:get()) then
        vim.opt_local.winbar = nil
        return
      end

      local val = get_filename()
      if val then
        local gps_val = get_gps()
        val = val .. gps_val
      end

      local _, _ = pcall(vim.api.nvim_set_option_value, "winbar", val, { scope = "local" })
    end,
  },

  augroups = {
    gps_winbar = {
      {
        { "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" },
        "*",
        cb = function() require("plugins.configs.gps").utils.set_winbar() end,
      },
    },
  },
})

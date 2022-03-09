local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    local colors = require("tokyonight.colors").setup()

    require("scrollbar").setup({
      show = true,
      set_highlights = true,
      handle = {
        text = " ",
        color = colors.bg_highlight,
        cterm = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
      },
      marks = {
        Search = {
          text = { "" },
          priority = 0,
          color = colors.orange,
          cterm = nil,
          highlight = "Search",
        },
        Error = {
          text = { "" },
          priority = 1,
          color = colors.error,
          cterm = nil,
          highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
          text = { "" },
          priority = 2,
          color = colors.warning,
          cterm = nil,
          highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
          text = { "" },
          priority = 3,
          color = colors.info,
          cterm = nil,
          highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
          text = { "" },
          priority = 4,
          color = colors.hint,
          cterm = nil,
          highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
          text = { "" },
          priority = 5,
          color = colors.purple,
          cterm = nil,
          highlight = "Normal",
        },
      },
      excluded_buftypes = {
        "terminal",
      },
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "dashboard",
      },
      autocmd = {
        render = {
          "BufWinEnter",
          "TabEnter",
          "TermEnter",
          "WinEnter",
          "CmdwinLeave",
          "TextChanged",
          "VimResized",
          "WinScrolled",
        },
      },
      handlers = {
        diagnostic = true,
        search = false, -- Handled manually in the `hlslens` plugin config
      },
    })

    -- Integration with `nvim-hlslens` plugin
    require("scrollbar.handlers.search").setup({
      calm_down = true,
      nearest_only = true,
    })
  end,
})

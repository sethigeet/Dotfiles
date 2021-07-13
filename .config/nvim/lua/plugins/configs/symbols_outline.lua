local plugin = {}

function plugin.setup()
  vim.g.symbols_outline = Opts.plugin.symbols_outline.config
end

function plugin.config()
  Opts.plugin["symbols_outline"] = {
    enabled = true,
    config = {
      highlight_hovered_item = true,
      show_guides = true,
      auto_preview = true,
      position = "right",
      keymaps = {
        close = "<Esc>",
        goto_location = "<CR>",
        focus_location = "o",
        hover_symbol = "K",
        rename_symbol = "r",
        code_actions = "a",
      },
      lsp_blacklist = {},
    },
  }
end

return plugin

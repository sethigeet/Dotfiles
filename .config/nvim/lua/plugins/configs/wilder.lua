local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    local wilder = require("wilder")

    wilder.setup({
      enabled = true,
      modes = { ":", "/", "?" },
      next_key = "<Tab>",
      previous_key = "<S-Tab>",

      -- HACK: Add "" as filetype for `winbar`
      exclude_filetype = { "", "winbar" },
      enable_cmdline_enter = true,
    })
    wilder.set_option("exclude_filetype", { "" })

    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline({
          language = "python",
          fuzzy = 1,
        }),
        wilder.python_search_pipeline({
          pattern = wilder.python_fuzzy_pattern(),
          sorter = wilder.python_difflib_sorter(),
          engine = "re",
        })
      ),
    })

    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer({
        highlighter = wilder.basic_highlighter(),
        highlights = {
          accent = wilder.make_hl("WilderAccent", "Pmenu", { {}, {}, { foreground = "#2ac3de" } }),
        },
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
      })
    )
  end,
})

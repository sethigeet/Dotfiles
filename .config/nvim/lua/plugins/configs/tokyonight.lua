local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    require("tokyonight").setup({
      style = "night",

      on_highlights = function(hl, c)
        local util = require("tokyonight.util")

        local bg_95 = util.lighten(c.bg, 0.95)
        local bg_85 = util.lighten(c.bg, 0.85)

        hl.TelescopeBorder = { bg = bg_95, fg = bg_95 }
        hl.TelescopePromptBorder = { bg = bg_85, fg = bg_85 }
        hl.TelescopeResultsBorder = { bg = bg_95, fg = bg_95 }
        hl.TelescopePreviewBorder = { bg = bg_95, fg = bg_95 }

        hl.TelescopePromptNormal = { bg = bg_85, fg = c.fg }
        hl.TelescopePromptPrefix = { bg = bg_85, fg = c.blue }

        hl.TelescopeNormal = { bg = bg_95 }
        hl.TelescopeResultsNormal = { bg = bg_95 }
        hl.TelescopePreviewNormal = { bg = bg_95 }

        hl.TelescopeTitle = { bg = c.blue, fg = c.bg_dark }
        hl.TelescopePreviewTitle = { bg = c.blue, fg = c.bg_dark }
        hl.TelescopePromptTitle = { bg = c.blue, fg = c.bg_dark }
        hl.TelescopeResultsTitle = { bg = bg_95, fg = bg_95 }

        hl.TelescopeSelection = { bg = util.darken(c.blue, 0.25) }
      end,
    })
    vim.cmd("colorscheme tokyonight")
  end,
})

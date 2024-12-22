return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "night",
      on_highlights = function(hl, c)
        local util = require("tokyonight.util")

        local bg_98 = util.lighten(c.bg, 0.98)
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

        hl.CmpItemMenu = { fg = bg_98, italic = true }
        hl.CmpItemKind = { bg = bg_95, fg = c.blue }
        hl.CmpPmenu = { bg = bg_98 }
        hl.CmpDoc = { bg = c.bg_dark }
        hl.CmpDocBorder = { fg = c.bg_dark, bg = c.bg_dark }

        hl.CursorLineNr = { fg = c.yellow }

        hl.LspReferenceText = { bg = "#464646" }
        hl.LspReferenceRead = { bg = "#464646" }
        hl.LspReferenceWrite = { bg = "#464646" }
      end,
    },
    init = function() vim.cmd.colorscheme("tokyonight") end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    opts = {
      { "*" },
      {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        names = true, -- "Name" codes like Blue
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      },
    },
    config = function(_, opts) require("colorizer").setup(opts[1], opts[2]) end,
  },

  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
    dependencies = {
      { "nvzone/volt", lazy = true },
    },
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todos" },
    },
  },
}

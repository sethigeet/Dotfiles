return {
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  {
    "famiu/bufdelete.nvim",
    cmd = "Bdelete",
    keys = {
      { "<leader>bd", "<Cmd>Bdelete", desc = "Delete buffer" },
      { "X", "<Cmd>Bdelete<CR>", desc = "Delete buffer" },
    },
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",

    opts = {
      auto_resize_height = true,
    },
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },

    opts = {
      auto_preview = false, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
      use_diagnostic_signs = true, -- use the signs defined in lsp client
    },

    keys = {
      { "<C-q>", "<Cmd>TroubleToggle quickfix<CR>", desc = "Show quickfix list" },
      -- {"<C-l>", "<Cmd>TroubleToggle loclist<CR>"}

      { "gr", "<Cmd>TroubleToggle lsp_references<CR>", desc = "Goto references" },
    },
  },

  {
    "karb94/neoscroll.nvim",
    event = "BufEnter",

    opts = {
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = {
        "<C-u>",
        "<C-d>",
        -- "<C-b>",
        -- "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
      hide_cursor = false, -- Hide cursor while scrolling
      easing_function = "sine", -- Default easing function
    },
  },

  {
    "monaqa/dial.nvim",
    event = "BufRead",

    opts = function()
      local augend = require("dial.augend")
      return {
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%d/%m/%Y"], -- date (19/02/2022, etc.)
          augend.constant.alias.bool,
          augend.constant.new({
            elements = { "True", "False" },
            word = true,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "and", "or" },
            word = true,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          }),
        },
      }
    end,
    config = function(_, opts) require("dial.config").augends:register_group(opts) end,

    init = function()
      local maps = require("dial.map")
      local map = require("utils.wrappers").map

      map("n", "<C-a>", maps.inc_normal())
      map("n", "<C-x>", maps.dec_normal())

      map("v", "<C-a>", maps.inc_visual())
      map("v", "<C-x>", maps.dec_visual())

      map("v", "g<C-a>", maps.inc_gvisual())
      map("v", "g<C-x>", maps.dec_gvisual())
    end,

    -- TODO: Figure out why this won't work
    -- keys = function()
    --   local maps = require("dial.map")
    --   return {
    --     { "<C-a>", maps.inc_normal() },
    --     { "<C-x>", maps.dec_normal() },

    --     { mode = "v", "<C-a>", maps.inc_visual() },
    --     { mode = "v", "<C-x>", maps.dec_visual() },

    --     { mode = "v", "g<C-a>", maps.inc_gvisual() },
    --     { mode = "v", "g<C-x>", maps.dec_gvisual() },
    --   }
    -- end,
  },

  {
    "nacro90/numb.nvim",
    event = "BufRead",

    opts = {
      show_numbers = true,
      show_cursorline = true,
    },
  },

  {
    "kevinhwang91/nvim-hlslens",

    keys = {
      { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },

      { "*", [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { "#", [[#<Cmd>lua require('hlslens').start()<CR>]] },
      { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]] },

      { mode = "x", "*", [[:<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR><Cmd>lua require('hlslens').start()<CR>]] },
      { mode = "x", "#", [[:<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR><Cmd>lua require('hlslens').start()<CR>]] },
      { mode = "x", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { mode = "x", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]] },
    },
  },
}

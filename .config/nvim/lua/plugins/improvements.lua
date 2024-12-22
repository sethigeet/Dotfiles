return {
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    init = function(_)
      require("utils.wrappers").highlight_groups({
        GlanceListMatch = { link = "Visual" },
        GlancePreviewMatch = { link = "Visual" },
      })
    end,
    opts = {
      use_trouble_qf = true,
      hooks = {
        before_open = function(results, open, jump, _method)
          if #results == 1 then
            local uri = vim.uri_from_bufnr(0)
            local target_uri = results[1].uri or results[1].targetUri

            if target_uri == uri then
              jump(results[1])
            else
              open(results)
            end
          else
            open(results)
          end
        end,
      },
    },
    keys = {
      { "gr", "<Cmd>Glance references<CR>", desc = "Goto reference" },
      { "gd", "<Cmd>Glance definitions<CR>", desc = "Goto definition" },
      { "gD", "<Cmd>Glance type_definitions<CR>", desc = "Goto declaration" },
      { "gI", "<Cmd>Glance implementations<CR>", desc = "Goto implementation" },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp_base = {
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.5,
          },
        },
      },
    },
    keys = {
      -- stylua: ignore
      { "<C-q>", "<Cmd>Trouble qflist toggle<CR>", desc = "Toggle quickfix list" },
      { "<C-l>", "<Cmd>Trouble loclist toggle<CR>", desc = "Toggle loclist" },
      -- { "gr", "<Cmd>Trouble lsp_references toggle<CR>", desc = "Goto reference" },
      -- { "gd", "<Cmd>Trouble lsp_definitions toggle<CR>", desc = "Goto definition" },
      -- { "gD", "<Cmd>Trouble lsp_declarations toggle<CR>", desc = "Goto declaration" },
      -- { "gI", "<Cmd>Trouble lsp_implementations toggle<CR>", desc = "Goto implementation" },
      { "gL", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Show buffer diagnostics" },
      {
        "<leader>lo",
        "<Cmd>Trouble lsp_document_symbols toggle win.position=right<CR>",
        desc = "Show document outline",
      },
    },
  },

  {
    "monaqa/dial.nvim",
    opts = function()
      local augend = require("dial.augend")
      return {
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
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
        misc = {
          augend.hexcolor.new({ case = "upper" }),
          augend.hexcolor.new({ case = "lower" }),
          augend.case.new({
            types = { "PascalCase", "SCREAMING_SNAKE_CASE", "camelCase", "kebab-case", "snake_case" },
            cyclic = true,
          }),
        },
      }
    end,
    config = function(_, opts) require("dial.config").augends:register_group(opts) end,
    keys = function()
      local maps = require("dial.map")
      return {
        { "<C-a>", maps.inc_normal(), desc = "Increment", noremap = true },
        { "<M-a>", maps.inc_normal("misc"), desc = "Increment (Misc)", noremap = true },
        { "<C-x>", maps.dec_normal(), desc = "Decrement", noremap = true },

        { mode = "v", "<C-a>", maps.inc_visual(), desc = "Increment", noremap = true },
        { mode = "v", "<C-x>", maps.dec_visual(), desc = "Decrement", noremap = true },

        { mode = "v", "g<C-a>", maps.inc_gvisual(), desc = "Increment", noremap = true },
        { mode = "v", "g<C-x>", maps.dec_gvisual(), desc = "Decrement", noremap = true },
      }
    end,
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
      {
        mode = "x",
        "*",
        [[:<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR><Cmd>lua require('hlslens').start()<CR>]],
      },
      {
        mode = "x",
        "#",
        [[:<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR><Cmd>lua require('hlslens').start()<CR>]],
      },
      { mode = "x", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { mode = "x", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]] },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = true,
    opts = {
      provider_selector = function() return { "treesitter", "indent" } end,
    },
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local gen_spec = require("mini.ai").gen_spec
      return {
        n_lines = 500,
        custom_textobjects = {
          b = gen_spec.treesitter({ a = "@block.outer", i = "@block.inner" }), -- code block
          f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          l = gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }), -- loop
          I = gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }), -- conditional
          a = gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }), -- parameter
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          e = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to, vis_mode = "V" }
          end,
          C = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          u = gen_spec.function_call(), -- u for "Usage"
        },
      }
    end,
  },

  {
    "chrisgrieser/nvim-puppeteer",
    lazy = false, -- plugin lazy-loads itself
  },

  {
    "folke/flash.nvim",
    opts = {
      jump = {
        -- clear highlight after jump
        nohlsearch = true,
      },
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "<M-s>", mode = { "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash " },
      { "f" },
      { "F" },
      { "t" },
      { "T" },
    },
  },

  {
    "cshuaimin/ssr.nvim",
    opts = {
      border = "rounded",
      min_width = 50,
      min_height = 5,
      max_width = 120,
      max_height = 25,
      adjust_window = true,
      keymaps = {
        close = "q",
        next_match = "n",
        prev_match = "N",
        replace_confirm = "<cr>",
        replace_all = "<leader><cr>",
      },
    },
    keys = {
      { "R", mode = { "n", "x" }, function() require("ssr").open() end, desc = "Structured Search & Replace" },
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80, enabledReplacementInterpreters = { "default", "lua" } },
    cmd = "GrugFar",
    keys = {
      {
        "g/",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}

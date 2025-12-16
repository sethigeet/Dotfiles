local function make_snips(snips, ls)
  local result = {}
  for trig, exp in pairs(snips) do
    local expansion
    if type(exp) == "string" then
      expansion = { ls.text_node({ exp }), ls.insert_node(0) }
    elseif type(exp) == "table" then
      for k, v in ipairs(exp) do
        if type(v) == "string" then exp[k] = ls.text_node({ v }) end
      end
      expansion = exp
    end

    table.insert(result, ls.s(trig, expansion))
  end

  return result
end

return {
  {
    "saghen/blink.cmp",
    version = "1.*", -- Use a fixed version to be able to download pre-built binaries
    dependencies = {
      "LuaSnip",

      -- Extra sources
      "moyiz/blink-emoji.nvim",
      "ribru17/blink-cmp-spell",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    ---@type blink.cmp.Config
    opts = {
      snippets = {
        preset = "luasnip",
      },

      appearance = {
        use_nvim_cmp_as_default = false,
      },

      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },

      keymap = {
        preset = "none",

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "accept", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },

        ["<C-u>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji", "spell" },

        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },

        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
            opts = {
              insert = true, -- Insert emoji (default) or complete its name
              ---@type string|table|fun():table
              trigger = function() return { ":" } end,
            },
            should_show_items = function()
              return vim.tbl_contains(
                -- Enable emoji completion only for git commits and markdown.
                -- By default, enabled for all file-types.
                { "gitcommit", "markdown" },
                vim.o.filetype
              )
            end,
          },
          spell = {
            name = "Spell",
            module = "blink-cmp-spell",
            opts = {},
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
          },
        },
      },

      fuzzy = {
        sorts = {
          -- Use the `label` sorter for the `spell` entries
          function(a, b)
            local sort = require("blink.cmp.fuzzy.sort")
            if a.source_id == "spell" and b.source_id == "spell" then return sort.label(a, b) end
          end,
          -- This is the normal default order, which we fall back to
          "score",
          "kind",
          "label",
        },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "cmdline",
          ["<Right>"] = false,
          ["<Left>"] = false,
        },
        completion = {
          list = { selection = { preselect = false } },
          menu = {
            auto_show = function(_ctx) return vim.fn.getcmdtype() == ":" end,
          },
          ghost_text = { enabled = true },
        },
      },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      updateevents = "TextChanged,TextChangedI",
    },
    init = function()
      local luasnip = require("luasnip")

      -- Load custom snippets
      for _, file in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
        local name = vim.fn.fnamemodify(file, ":t:r")
        local contents = require("snippets." .. name)

        local fts, snips = contents["filetypes"], contents["snippets"]
        local final_snips = make_snips(snips, luasnip)
        for _, ft in ipairs(fts) do
          luasnip.add_snippets(ft, vim.deepcopy(final_snips))
        end
      end
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function(_, _)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      -- Setup
      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" }, -- it will not add pair on that treesitter node
          javascript = { "template_string" },
        },
        fast_wrap = {
          map = "<M-f>",
          end_key = "f",
          keys = "qwertyuiopzxcvbnmasdghjkl",
          -- highlight = "BufferCurrentTarget",
          highlight = "SelectNextKey",
        },
      })

      local rules = {}

      -- Add spaces between parentheses
      table.insert(
        rules,
        Rule(" ", " "):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ "()", "[]", "{}" }, pair)
        end)
      )
      local parens = { { "(", ")" }, { "{", "}" }, { "[", "]" } }
      for _, paren in ipairs(parens) do
        table.insert(
          rules,
          Rule(paren[1] .. " ", " " .. paren[2])
            :with_pair(function() return false end)
            :with_move(function(opts) return opts.prev_char:match(".%" .. paren[2]) ~= nil end)
            :use_key(paren[2])
        )
      end

      -- Endwise
      local endwise = require("nvim-autopairs.ts-rule").endwise
      for _, rule in ipairs({
        -- HACK: Pass in `nil` instead of the treesitter node in some places as it does not work properly right now

        -- Lua
        endwise("if .* then$", "end", "lua", nil), -- "if_statement"
        endwise("function.*%(.*%)$", "end", "lua", nil), -- { "function_definition", "local_function", "function" }
        endwise("for .* do$", "end", "lua", nil), -- { "for_in_statement", "for_statement" }
        endwise("while .* do$", "end", "lua", nil), -- "while_statement"

        -- Shell
        endwise("if .*; then$", "fi", "sh", nil), -- "if_statement"
        endwise("while .*; do$", "done", "sh", nil), -- "while_statement"
        endwise("for .*; do$", "done", "sh", nil), -- { "c_style_for_statement", "for_statement" }
        endwise("until .*; do$", "done", "sh", nil), -- { "c_style_for_statement", "for_statement" }
        endwise("case .* in$", "esac", "sh", nil), -- "case_statement"
      }) do
        table.insert(rules, rule)
      end

      -- Language specific stuff
      -- JavaScript/TypeScript
      table.insert(
        rules,
        Rule("%(.*%)%s*%=>$", " {  }", { "javascript", "javascriptreact", "typescript", "typescriptreact" })
          :use_regex(true)
          :set_end_pair_length(2)
      )

      -- Add all the rules
      npairs.add_rules(rules)
    end,
  },
}

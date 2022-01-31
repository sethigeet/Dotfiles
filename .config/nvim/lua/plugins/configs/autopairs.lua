local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
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
          :with_pair(function()
            return false
          end)
          :with_move(function(opts)
            return opts.prev_char:match(".%" .. paren[2]) ~= nil
          end)
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

  apply_integrations = function()
    -- compe integration
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
})

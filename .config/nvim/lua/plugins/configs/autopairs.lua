local plugin = {}

function plugin.setup()
  local npairs = require("nvim-autopairs")

  -- Setup
  npairs.setup({
    check_ts = true,
    ts_config = {
      lua = { "string" }, -- it will not add pair on that treesitter node
      javascript = { "template_string" },
    },
  })

  -- compe integration
  require("nvim-autopairs.completion.compe").setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` after select function or method item
  })

  -- Endwise
  local endwise = require("nvim-autopairs.ts-rule").endwise

  npairs.add_rules({
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
  })
end

return plugin

local plugin = {}

function plugin.setup()
  local npairs = require("nvim-autopairs")

  -- Setup
  npairs.setup(Opts.plugin.autopairs.config)

  -- compe integration
  require("nvim-autopairs.completion.compe").setup(Opts.plugin.autopairs.compe_integration)
end

function plugin.config()
  Opts.plugin["autopairs"] = {
    enabled = true,
    config = {
      check_ts = true,
      ts_config = {
        lua = { "string" }, -- it will not add pair on that treesitter node
        javascript = { "template_string" },
      },
    },
    compe_integration = {
      map_cr = true, --  map <CR> on insert mode
      map_complete = true, -- it will auto insert `(` after select function or method item
    },
  }
end

return plugin

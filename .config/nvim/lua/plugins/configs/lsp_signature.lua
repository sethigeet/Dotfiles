local plugin = {}

function plugin.setup()
  require("lsp_signature").on_attach(Opts.plugin.lsp_signature.config)
end

function plugin.config()
  Opts.plugin["lsp_signature"] = {
    enabled = true,
    config = {
      bind = false, -- This is mandatory, otherwise border config won't get registered.
      -- If you want to hook lspsaga or other signature handler, pls set to false
      doc_lines = 10, -- only show one line of comment set to 0 if you do not want API comments be shown

      hint_enable = true, -- virtual hint enable
      -- hint_prefix = "🐼 ",  -- Panda for parameter
      -- hint_scheme = "String",
      use_lspsaga = true, -- set to true if you want to use lspsaga popup
      handler_opts = {
        border = "none", -- double, single, shadow, none
      },
      decorator = { "`", "`" }, -- or decorator = {"***", "***"}  decorator = {"**", "**"} see markdown help
    },
  }
end

return plugin

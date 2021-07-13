local plugin = {}

function plugin.setup()
  vim.g.db_ui_save_location = Opts.plugin.dadbod.config.save_location
  vim.g.db_ui_auto_execute_table_helpers = Opts.plugin.dadbod.config.auto_execute_table_helpers
end

function plugin.config()
  Opts.plugin["dadbod"] = {
    enabled = true,
    config = {
      save_location = DATA_PATH .. "/dadbod.db",
      auto_execute_table_helpers = true,
    },
  }
end

return plugin

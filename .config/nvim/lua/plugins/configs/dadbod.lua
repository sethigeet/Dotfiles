local plugin = {}

function plugin.setup()
  vim.g.db_ui_save_location = DATA_PATH .. "/dadbod.db"
  vim.g.db_ui_auto_execute_table_helpers = true
end

return plugin

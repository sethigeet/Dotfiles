local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    vim.g.db_ui_save_location = DATA_PATH .. "/dadbod.db"
    vim.g.db_ui_auto_execute_table_helpers = true
  end,
})

local plugin = {}

function plugin.setup()
  if vim.fn.exists("g:tabular_loaded") == 1 then
    vim.cmd([[
AddTabularPattern! nvar /nvarchar(\w*)/l1r0
AddTabularPattern! f_comma /^[^,]*\zs,/
AddTabularPattern! f_colon /^[^:]*\zs:/
AddTabularPattern! f_equal /^[^=]*\zs=/
AddTabularPattern! f_quote /^[^"]*\zs"/l1r0
]])
  end
end

function plugin.config()
  Opts.plugin["tabular"] = {
    enabled = true,
  }
end

return plugin

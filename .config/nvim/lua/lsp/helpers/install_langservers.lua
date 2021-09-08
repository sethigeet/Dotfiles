LspInstall = require("lspinstall")

local function install_lang_servers(langs)
  for _, lang in ipairs(langs) do
    if not LspInstall.is_server_installed(lang) then
      LspInstall.install_server(lang)
    end
  end
end

return install_lang_servers

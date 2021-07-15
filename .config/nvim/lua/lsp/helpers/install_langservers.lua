LspInstall = require("lspinstall")

local function InstallLangServers(langs)
  for _, lang in ipairs(langs) do
    if not LspInstall.is_server_installed(lang) then
      LspInstall.install_server(lang)
    end
  end
end

return InstallLangServers

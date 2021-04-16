LspInstall = require("lspinstall")
InstalledServers = LspInstall.installed_servers()

local function HasValue(tab, val)
    for _, value in ipairs(tab) do if value == val then return true end end

    return false
end

local function InstallLangServer(lang)
    if not HasValue(InstalledServers, lang) then
        LspInstall.install_server(lang)
    end
end

return InstallLangServer

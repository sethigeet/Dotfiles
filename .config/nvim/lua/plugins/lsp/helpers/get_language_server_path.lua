local function GetLanguageServerPath(lang_name, server_name, type)
    local path_switch = {}
    path_switch["standalone"] = "."
    path_switch["node"] = "node_modules/.bin"
    path_switch["vscode"] = "vscode-" .. lang_name .. "/" .. lang_name ..
                                "-language-features/server/dist/node"

    return
        DATA_PATH .. "/lspinstall/" .. lang_name .. "/" .. path_switch[type] ..
            "/" .. server_name
end

return GetLanguageServerPath

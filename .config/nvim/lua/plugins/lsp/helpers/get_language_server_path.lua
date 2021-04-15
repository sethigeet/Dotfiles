function GetLanguageServerPath(lang_name, server_name, type)
    local path_switch = {}
    path_switch["node"] = "node_modules/.bin"
    path_switch["go"] = "."

    return DATA_PATH .. "/language-servers/" .. lang_name .. "-ls/" .. path_switch[type] .. "/" ..
               server_name
end

return GetLanguageServerPath

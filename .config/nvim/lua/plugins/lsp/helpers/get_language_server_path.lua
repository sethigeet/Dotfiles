function GetLanguageServerPath(lang_name, server_name)
    DATA_PATH = vim.fn.stdpath("data")
    return DATA_PATH .. "/language-servers/" .. lang_name .. "-ls/node_modules/.bin/" .. server_name
end

return GetLanguageServerPath

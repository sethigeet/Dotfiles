local map = require("utils.map")

local function FormatOnSave(client)
  if client.resolved_capabilities.document_formatting then
    map.nnoremap("<C-s>", ":lua SaveFile(true)<CR>", { buffer = true })
    map.nnoremap("<M-s>", ":lua SaveFile(false)<CR>", { buffer = true })

    map.vnoremap("<C-s>", ":lua SaveFile(true, true)<CR>", { buffer = true })
    map.vnoremap("<M-s>", ":lua SaveFile(false, true)<CR>", { buffer = true })
  end
end

return FormatOnSave

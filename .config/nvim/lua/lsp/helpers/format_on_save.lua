local map = require("utils.map")

local function format_on_save(client)
  if client.resolved_capabilities.document_formatting then
    map.nnoremap("<C-s>", "<cmd>lua SaveFile(true)<CR>", { buffer = true })
    map.nnoremap("<M-s>", "<cmd>lua SaveFile(false)<CR>", { buffer = true })

    map.vnoremap("<C-s>", "<cmd>lua SaveFile(true, true)<CR>", { buffer = true })
    map.vnoremap("<M-s>", "<cmd>lua SaveFile(false, true)<CR>", { buffer = true })
  end
end

return format_on_save

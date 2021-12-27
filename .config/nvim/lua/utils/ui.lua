local M = {}

local quit_keys = { n = { "<Esc>", "<C-c>", "q" }, i = { "<C-c>" } }

function M.apply_default_keymaps(popup, on_close)
  -- cancel operation if <quit-key> is pressed
  for mode, keys in pairs(quit_keys) do
    for _, key in ipairs(keys) do
      popup:map(mode, key, on_close, { noremap = true, nowait = true })
    end
  end
end

return M

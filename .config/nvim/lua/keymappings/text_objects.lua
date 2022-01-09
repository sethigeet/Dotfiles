local map = require("utils").map

local chars = { "_", ".", ":", ",", ";", "<bar>", "/", "<bslash>", "*", "+", "%", "-", "#" }

for _, char in ipairs(chars) do
  map("x", "i" .. char, ":<C-u>normal! T" .. char .. "vt" .. char .. "<CR>")
  map("o", "i" .. char, ":normal vi" .. char .. "<CR>")

  map("x", "a" .. char, ":<C-u>normal! F" .. char .. "vf" .. char .. "<CR>")
  map("o", "a" .. char, ":normal va" .. char .. "<CR>")
end

map("x", "ae", ":<C-u>keepjumps normal! ggVG<CR>")
map("o", "ae", ":normal vae<CR>")

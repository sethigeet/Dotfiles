local map = require("utils.map")

local chars = { "_", ".", ":", ",", ";", "<bar>", "/", "<bslash>", "*", "+", "%", "-", "#" }

for _, char in ipairs(chars) do
  map.xnoremap("i" .. char, ":<C-u>normal! T" .. char .. "vt" .. char .. "<CR>")
  map.onoremap("i" .. char, ":normal vi" .. char .. "<CR>")

  map.xnoremap("a" .. char, ":<C-u>normal! F" .. char .. "vf" .. char .. "<CR>")
  map.onoremap("a" .. char, ":normal va" .. char .. "<CR>")
end

map.xnoremap("ae", ":<C-u>keepjumps normal! ggVG<CR>")
map.onoremap("ae", ":normal vae<CR>")

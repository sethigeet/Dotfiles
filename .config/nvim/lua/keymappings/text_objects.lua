local chars = { "_", ".", ":", ",", ";", "<bar>", "/", "<bslash>", "*", "+", "%", "-", "#" }

for _, char in ipairs(chars) do
  vim.api.nvim_set_keymap(
    "x",
    "i" .. char,
    ":<C-u>normal! T" .. char .. "vt" .. char .. "<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap("o", "i" .. char, ":normal vi" .. char .. "<CR>", { noremap = true, silent = true })

  vim.api.nvim_set_keymap(
    "x",
    "a" .. char,
    ":<C-u>normal! F" .. char .. "vf" .. char .. "<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap("o", "a" .. char, ":normal va" .. char .. "<CR>", { noremap = true, silent = true })
end

vim.api.nvim_set_keymap("x", "ae", ":<C-u>keepjumps normal! ggVG<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("o", "ae", ":normal vae<CR>", { noremap = true, silent = true })

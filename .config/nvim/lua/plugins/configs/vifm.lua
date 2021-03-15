-- Replace netrw with vifm
vim.g.vifm_replace_netrw = 1
vim.g.vifm_replace_netrw_cmd = "Vifm"

-- Disable netrw since it is no longer being used
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- This is enabled by default in nvim
-- vim.g.vifm_embed_term = 1

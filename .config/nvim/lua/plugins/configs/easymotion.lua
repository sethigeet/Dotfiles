local plugin = {}

function plugin.setup()
  vim.g.EasyMotion_do_mapping = Opts.plugin.easymotion.config.disable_default_mappings and 1 or 0

  -- Custom prompt
  vim.g.EasyMotion_prompt = Opts.plugin.easymotion.config.prompt

  -- Turn on case-insensitive feature
  vim.g.EasyMotion_smartcase = Opts.plugin.easymotion.config.smartcase and 1 or 0

  -- Some other settings
  vim.g.EasyMotion_verbose = 0
  vim.g.EasyMotion_do_shade = 0

  -- Repeat last motion
  vim.api.nvim_set_keymap("", "<leader><leader>.", "<Plug>(easymotion-repeat)", {})

  -- Move to char
  vim.api.nvim_set_keymap("", "<leader><leader>f", "<Plug>(easymotion-overwin-f)", {})

  -- Move to line
  vim.api.nvim_set_keymap("", "<leader><leader>j", "<Plug>(easymotion-overwin-line)", {})
  vim.api.nvim_set_keymap("", "<leader><leader>k", "<Plug>(easymotion-overwin-line)", {})

  -- s{char}{char} to move to {char}{char}
  vim.api.nvim_set_keymap("n", "s", "<Plug>(easymotion-s2)", { silent = true })

  -- Move to word
  vim.api.nvim_set_keymap("n", "<leader><leader>w", "<Plug>(easymotion-overwin-w)", {})
end

function plugin.config()
  Opts.plugin["easymotion"] = {
    enabled = true,
    config = {
      disable_default_mappings = false,
      prompt = " ",
      smartcase = true,
    },
  }
end

return plugin

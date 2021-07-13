local plugin = {}

function plugin.setup()
  require("compe").setup(Opts.plugin.compe.config)

  -- Dadbod completion
  vim.g["compe.source.vim_dadbod_completion"] = Opts.plugin.compe.vim_dadbod_completion

  vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.TabComplete()", { expr = true })
  vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.TabComplete()", { expr = true })
  vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.STabComplete()", { expr = true })
  vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.STabComplete()", { expr = true })
  vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", { expr = true, silent = true })
  vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { expr = true, silent = true })
end

function plugin.config()
  Opts.plugin["compe"] = {
    enabled = true,
    vim_dadbod_completion = true,
    config = {
      enabled = true,
      autocomplete = true,
      debug = false,
      min_length = 1,
      preselect = "enable",
      throttle_time = 80,
      source_timeout = 200,
      incomplete_delay = 400,
      allow_prefix_unmatch = false,
      max_abbr_width = 1000,
      max_kind_width = 1000,
      max_menu_width = 1000000,
      documentation = true,

      source = {
        path = { kind = "  " },
        buffer = { kind = "  " },
        calc = { kind = "  " },
        vsnip = { kind = "  " },
        nvim_lsp = { kind = "  " },
        nvim_lua = { kind = "  " },
        spell = { kind = "  " },
        tags = false,
        snippets_nvim = { kind = "  " },
        treesitter = { kind = "  " },
        emoji = { kind = " ﲃ " },
      },
    },
  }
end

return plugin

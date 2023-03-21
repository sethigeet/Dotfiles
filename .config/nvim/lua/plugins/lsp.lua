return {
  "neovim/nvim-lspconfig",

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lspconfig", "mason.nvim" },
    event = "BufReadPre",
  },

  {
    "williamboman/mason.nvim",
    dependencies = { "nvim-lspconfig", "williamboman/mason-lspconfig.nvim" },
    opts = function()
      local lsps = {}
      for _, file in ipairs(vim.api.nvim_get_runtime_file("lua/lsp/language_servers/*.lua", true)) do
        local name = vim.fn.fnamemodify(file, ":t:r")
        if name ~= "init" and name ~= "null_ls" then table.insert(lsps, name) end
      end

      return {
        general = {
          ui = {
            icons = {
              package_installed = "﫟",
              package_pending = "ﳁ",
              package_uninstalled = "",
            },
          },
        },
        lspconfig = { ensure_installed = lsps },
      }
    end,
    config = function(_, opts)
      require("mason").setup(opts.config)
      require("mason-lspconfig").setup(opts.lspconfig)

      -- Load all the language servers
      for _, lsp in ipairs(opts.lspconfig.ensure_installed) do
        require("lsp.language_servers." .. lsp):setup()
      end

      require("lsp.language_servers.null_ls"):setup()
    end,

    keys = {
      { "<leader>lI", "<Cmd>Mason<CR>", desc = "Manage language servers" },
    },
  },

  "nvim-lua/lsp_extensions.nvim",
  "j-hui/fidget.nvim",

  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = true,
  },

  -- Language specific plugins
  "folke/neodev.nvim", -- For Nvim development
  {
    "fatih/vim-go",
    ft = { "go" },
    build = ":GoUpdateBinaries",
  },
  "b0o/schemastore.nvim", -- JSON Schemas provider
  {
    "mattn/emmet-vim",
    event = "InsertEnter",

    config = function() vim.g.user_emmet_leader_key = "<M-e>" end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = {
      "SymbolsOutline",
      "SymbolsOutlineOpen",
      "SymbolsOutlineClose",
    },

    config = function(_, _)
      vim.g.symbols_outline = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = true,
        position = "right",
        keymaps = {
          close = "<Esc>",
          goto_location = "<CR>",
          focus_location = "o",
          hover_symbol = "K",
          rename_symbol = "r",
          code_actions = "a",
        },
        lsp_blacklist = {},
      }
    end,

    keys = {
      { "<leader>lo", "<Cmd>SymbolsOutline<CR>", desc = "Show outline" },
    },
  },

  {
    "SmiteshP/nvim-navic",
    lazy = true,

    opts = function()
      local icons = vim.deepcopy(require("lsp.kind"))
      for name, icon in pairs(icons) do
        icons[name] = icon .. " "
      end

      return {
        icons = icons,
        highlight = true,
        separator = "  ",
        depth_limit = 0,
        depth_limit_indicator = "",
        safe_output = true,
      }
    end,
  },
}

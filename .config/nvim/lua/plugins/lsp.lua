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
    "utilyre/barbecue.nvim",
    dependencies = { "SmiteshP/nvim-navic" },
    opts = {
      attach_navic = false, -- NOTE: This is done manually in lanugage_server setup
    },
  },

  {
    "tzachar/local-highlight.nvim",
    config = function()
      require("utils.wrappers").highlight("LocalHighlight", { bg = "#464646" })
      require("local-highlight").setup({
        disable_file_types = { "NvimTree" },
        hlgroup = "LocalHighlight",
        cw_hlgroup = "LocalHighlight",
      })
    end,
  },
}

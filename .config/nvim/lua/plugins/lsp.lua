return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "﫟",
              package_pending = "ﳁ",
              package_uninstalled = "",
            },
          },
        },
        keys = {
          { "<leader>lI", "<Cmd>Mason<CR>", desc = "Manage language servers" },
        },
      },

      "schemastore.nvim",
    },

    opts = {
      servers = {
        "basedpyright",
        "bashls",
        "cssls",
        "dockerls",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "rust_analyzer",
        "tailwindcss",
        "ts_ls",
        "yamlls",
      },
    },

    config = function(_, opts)
      -- Setup custom capabilities added via different plugins such as `snippetSupport`
      local defaultCapabilities = {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true,
            },
          },
        },
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      }
      vim.lsp.config("*", {
        capabilities = defaultCapabilities,
      })

      local lsp_utils = require("utils.lsp")
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client == nil then return end

          -- Setup custom keybinds
          lsp_utils.setup_keybindings(ev.buf)

          lsp_utils.setup_inlay_hints(ev.buf)

          local customConfig = client.config.custom
          if customConfig == nil then return end

          if customConfig.enable_codelens == true then lsp_utils.setup_codelens() end

          if customConfig.enable_formatting == false then
            client.server_capabilities.documentFormattingProvider = false
          end
        end,
      })

      vim.lsp.enable(opts.servers)
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        { "lua", { "stylua" } },
        { "python", { "ruff_format" } },
        { "rust", { "rustfmt", lsp_format = "fallback" } },
        { { "sh", "bash", "zsh" }, { "shfmt", lsp_format = "fallback" } },
        {
          { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "yaml", "json", "jsonc" },
          { "prettierd", "prettier", stop_after_first = true },
        },
      },
    },
    config = function(_, opts)
      require("conform").formatters.shfmt = {
        prepend_args = { "-ci", "-i", "2", "-s", "-bn" },
      }

      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })

      local config = vim.deepcopy(opts)
      local formatters_by_ft = {}
      for _, formatter in ipairs(opts.formatters_by_ft) do
        local fts = formatter[1]
        local fmt = formatter[2]
        if vim.islist(fts) then
          for _, ft in ipairs(fts) do
            formatters_by_ft[ft] = fmt
          end
        else
          formatters_by_ft[fts] = fmt
        end
      end
      config.formatters_by_ft = formatters_by_ft
      require("conform").setup(config)
    end,
    keys = {
      {
        "<leader>lf",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        desc = "Format",
      },
      {
        "<C-s>",
        function()
          require("conform").format({ lsp_format = "fallback" })
          vim.cmd.write()
        end,
        desc = "Format and Save File",
      },
    },
  },

  -- Language specific plugins
  -- For Nvim development
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  {
    "fatih/vim-go",
    ft = { "go" },
    build = ":GoUpdateBinaries",
  },
  "b0o/schemastore.nvim", -- JSON Schemas provider

  {
    "Bekaboo/dropbar.nvim",
    opts = {
      fzf = {
        prompt = "%#DiagnosticInfo# ",
      },
    },
    config = function(_, opts)
      require("dropbar").setup(opts)

      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })

      require("utils.wrappers").highlight("DropBarMenuHoverEntry", { link = "CursorLine" })
    end,
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
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

      "williamboman/mason-lspconfig.nvim",

      "schemastore.nvim",
    },

    opts = function()
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
      defaultCapabilities =
        vim.tbl_deep_extend("force", require("cmp_nvim_lsp").default_capabilities(), defaultCapabilities)

      return {
        capabilities = defaultCapabilities,

        servers = {
          -- linters = { "shellcheck", extra_args = { "-e", "1090" } },
          -- linters = "flake8",

          bashls = {},
          cssls = {},
          dockerls = {},

          gopls = {
            settings = {
              gopls = {
                analyses = { unusedparams = true },
                staticcheck = true,
                codelenses = {
                  generate = true, -- show the `go generate` lens.
                  gc_details = true, -- Show a code lens toggling the display of gc's choices.
                },
                usePlaceholders = true,
                completeUnimported = true,
                matcher = "fuzzy",
                symbolMatcher = "fuzzy",
                gofumpt = false,
              },
            },
          },

          html = {},
          jsonls = {
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          },

          lua_ls = {
            settings = {
              Lua = {
                type = {
                  castNumberToInteger = true,
                  inferParamType = true,
                },
                diagnostics = {
                  -- Get the language server to recognize the global vars
                  globals = {},
                  unusedLocalExclude = { "_*" },
                },
                codeLens = {
                  enable = true,
                },
                hint = {
                  enable = true,
                },
                format = {
                  enable = false,
                },
                workspace = {
                  library = {},
                  maxPreload = 100000,
                  preloadFileSize = 100000,
                },
              },
            },
          },

          pyright = {
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  diagnosticMode = "workspace",
                },
              },
            },
          },

          rust_analyzer = {},
          tailwindcss = {},

          taplo = {
            cmd_args = { "--default-schema-catalogs" },
          },

          ts_ls = {
            formatting = false,
          },

          yamlls = {
            settings = {
              yaml = {
                hover = true,
                completion = true,
                validate = true,
                schemaStore = {
                  enable = false,
                  -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                  url = "",
                },
                schemas = require("schemastore").yaml.schemas(),
              },
            },
          },
        },
      }
    end,

    config = function(_, opts)
      local lsp_utils = require("utils.lsp")

      local function setup(server)
        local _server_opts = opts.servers[server]
        if _server_opts.enabled == false then return end

        local server_opts = {
          capabilities = vim.tbl_deep_extend("force", vim.deepcopy(opts.capabilities), _server_opts.capabilities or {}),
          settings = _server_opts.settings,
        }

        server_opts.on_attach = function(client, bufnr)
          lsp_utils.setup_keybindings(bufnr)

          if _server_opts.formatting == false then client.server_capabilities.documentFormattingProvider = false end

          if _server_opts.code_lens == true then lsp_utils.setup_codelens() end
        end

        -- Add custom args if specified
        if _server_opts.cmd_args and not vim.tbl_isempty(_server_opts.cmd_args) then
          local cmd = require("lspconfig.configs." .. server).default_config.cmd
          for _, arg in ipairs(_server_opts.cmd_args) do
            table.insert(cmd, arg)
          end
        end

        require("lspconfig")[server].setup(server_opts)
      end

      local ensure_installed = {}
      for server, server_opts in pairs(opts.servers) do
        if server_opts.enabled ~= false then
          setup(server)
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      require("mason-lspconfig").setup({ ensure_installed = ensure_installed, automatic_installation = false })
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
    "mattn/emmet-vim",
    event = "InsertEnter",
    config = function() vim.g.user_emmet_leader_key = "<M-e>" end,
  },

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

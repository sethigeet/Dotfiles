return {
  { "MunifTanjim/nui.nvim", lazy = true },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "tummetott/reticle.nvim",
    event = "VeryLazy",
    config = true,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      -- Animation style
      stages = "slide",
    },
    config = function(_, opts)
      local notify = require("notify")

      notify.setup(opts)

      vim.notify = notify
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    opts = function()
      local colors = require("tokyonight.colors").setup()

      return {
        show = true,
        set_highlights = true,
        handle = {
          text = " ",
          color = colors.bg_highlight,
          cterm = nil,
          highlight = "CursorColumn",
          hide_if_all_visible = true, -- Hides handle if all lines are visible
        },
        marks = {
          Search = {
            text = { "" },
            priority = 0,
            color = colors.orange,
            cterm = nil,
            highlight = "Search",
          },
          Error = {
            text = { "" },
            priority = 1,
            color = colors.error,
            cterm = nil,
            highlight = "DiagnosticVirtualTextError",
          },
          Warn = {
            text = { "" },
            priority = 2,
            color = colors.warning,
            cterm = nil,
            highlight = "DiagnosticVirtualTextWarn",
          },
          Info = {
            text = { "" },
            priority = 3,
            color = colors.info,
            cterm = nil,
            highlight = "DiagnosticVirtualTextInfo",
          },
          Hint = {
            text = { "" },
            priority = 4,
            color = colors.hint,
            cterm = nil,
            highlight = "DiagnosticVirtualTextHint",
          },
          Misc = {
            text = { "" },
            priority = 5,
            color = colors.purple,
            cterm = nil,
            highlight = "Normal",
          },
        },
        excluded_buftypes = {
          "terminal",
        },
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
          "alpha",
          "neo-tree",
        },
        autocmd = {
          render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
          },
        },
        handlers = {
          diagnostic = true,
          search = false, -- Handled manually in the `hlslens` plugin config
        },
      }
    end,
    config = function(_, opts)
      require("scrollbar").setup(opts)

      -- Integration with `nvim-hlslens` plugin
      require("scrollbar.handlers.search").setup({
        calm_down = true,
        nearest_only = true,
      })

      -- Integration with `gitsigns.nvim` plugin
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    utils = {
      get_tab_stop = function()
        local label = "Tab Size: "
        if vim.api.nvim_get_option_value("expandtab", {}) then label = "Spaces: " end
        return " " .. label .. vim.api.nvim_get_option_value("shiftwidth", {})
      end,
      get_lsp_client = function()
        local msg = "  No Active Lsp"
        local buf_ft = vim.api.nvim_get_option_value("filetype", {})
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then return msg end

        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
            return "  " .. client.name
          end
        end
        return msg
      end,
    },
    opts = function(self)
      return {
        options = {
          theme = "tokyonight",
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
            },
            "branch",
          },
          lualine_c = {
            {
              "diff",
              colored = true,
              symbols = { added = " ", modified = " ", removed = " " },
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              sections = { "error", "warn", "info" },
              symbols = { error = " ", warn = " ", info = " " },
            },
            { "filename", symbols = { modified = "  ", readonly = "  " } },
          },
          lualine_x = { { "filetype", colored = true }, self.utils.get_lsp_client },
          lualine_y = { self.utils.get_tab_stop },
          lualine_z = { "location" },
        },
        extensions = { "nvim-tree", "quickfix", "toggleterm", "symbols-outline" },
      }
    end,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { { "tiagovla/scope.nvim", config = true } },
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none",
        close_command = "Bdelete %d",
        right_mouse_command = "Bdelete! %d",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diagnostics_dict)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym
            if e == "error" then
              sym = " "
            elseif e == "warning" then
              sym = " "
            elseif e == "info" then
              sym = " "
            else
              sym = " "
            end
            s = s .. n .. sym
          end
          return s
        end,
        offsets = { { filetype = "neo-tree", text = "File Explorer", highlight = "Directory", text_align = "center" } },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "thin",
      },
    },
    keys = function()
      local maps = {
        -- Goto any buffer instantly
        { "<M-b>", "<Cmd>BufferLinePick<CR>" },

        -- Move between buffers using Tab and Shift + Tab
        { "<TAB>", "<Cmd>BufferLineCycleNext<CR>" },
        { "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>" },

        -- Move between buffers using Shift + Arrow Keys
        { "<S-Left>", "<Cmd>BufferLineCyclePrev<CR>" },
        { "<S-Right>", "<Cmd>BufferLineCycleNext<CR>" },

        -- Move between buffers using Ctrl + h,l Keys
        { "<C-h>", "<Cmd>BufferLineCyclePrev<CR>" },
        { "<C-l>", "<Cmd>BufferLineCycleNext<CR>" },

        -- Move buffers using Ctrl + Arrow Keys
        { "<C-Left>", "<Cmd>BufferLineMovePrev<CR>" },
        { "<C-Right>", "<Cmd>BufferLineMoveNext<CR>" },
        { "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close left" },
        { "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Close right" },
        { "<leader>bH", "<Cmd>BufferLineMovePrev<CR>", desc = "Move to previous" },
        { "<leader>bL", "<Cmd>BufferLineMoveNext<CR>", desc = "Move to next" },
        { "<leader>bp", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },
      }

      -- Move to a buffer using Alt+number
      local goto_buf = require("bufferline").go_to_buffer
      for i = 1, 9, 1 do
        table.insert(maps, {
          string.format("<M-%d>", i),
          function() goto_buf(i) end,
          desc = "Goto buffer " .. i,
        })
      end

      return maps
    end,
  },

  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
        segments = {
          {
            sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = false },
            click = "v:lua.ScSa",
          },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 1, auto = false },
            click = "v:lua.ScSa",
          },
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        },
      }
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        "<Cmd>Neotree toggle<CR>",
        desc = "Show file explorer",
      },
    },
    deactivate = function() vim.cmd.Neotree("close") end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        ---@diagnostic disable-next-line: param-type-mismatch
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then require("neo-tree") end
      end
    end,
    opts = {
      sources = { "filesystem", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf" },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = { "node_modules", "target", "__pycache__" },
        },
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none",
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_empty = "",
          folder_empty_open = "",
        },
        git_status = {
          symbols = {
            renamed = "󰁕",
            unstaged = "󰄱",
          },
        },
      },
      document_symbols = {
        kinds = {
          File = { icon = "󰈙", hl = "Tag" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Property = { icon = "󰆧", hl = "@property" },
          Enum = { icon = "󰒻", hl = "@number" },
          Function = { icon = "󰊕", hl = "Function" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Key = { icon = "󰌋", hl = "" },
          Struct = { icon = "󰌗", hl = "Type" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },
          StaticMethod = { icon = "󰠄 ", hl = "Function" },
        },
      },
      source_selector = {
        winbar = true,
        -- statusline = false,
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "buffers", display_name = "  Files " },
          { source = "document_symbols", display_name = "  Doc Symbols " },
          { source = "git_status", display_name = " 󰊢 Git " },
        },
      },
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        width = 0.8,
        options = {
          number = true,
          relativenumber = true,
          cursorline = true,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = false },
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      buftype_exclude = { "help", "terminal" },
      bufname_exclude = { "vifm*" },
      filetype_exclude = {
        "vimwiki",
        "NvimTree",
        "help",
        "undotree",
        "diff",
        "git",
        "alpha",
        "neogitstatus",
        "packer",
      },
      char = "▏",
      use_treesitter = true,
      show_trailing_blankline_indent = false,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
      context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
      },
    },
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      -- Header
      dashboard.section.header.val = {
        "                                              ",
        "       ███████████           █████      ██",
        "      ███████████             █████ ",
        "      ████████████████ ███████████ ███   ███████",
        "     ████████████████ ████████████ █████ ██████████████",
        "    █████████████████████████████ █████ █████ ████ █████",
        "  ██████████████████████████████████ █████ █████ ████ █████",
        " ██████  ███ █████████████████ ████ █████ █████ ████ ██████",
        " ██████   ██  ███████████████   ██ █████████████████",
        " ██████   ██  ███████████████   ██ █████████████████ ",
      }

      -- Buttons
      dashboard.section.buttons.val = {
        dashboard.button("f", " Find File", ":Telescope find_files<CR>"),
        dashboard.button("r", " Recently Used Files", ":Telescope oldfiles<CR>"),
        dashboard.button("w", " Find Word", ":Telescope live_grep<CR>"),
        dashboard.button("m", " Marks", ":Telescope marks<CR>"),
        dashboard.button("c", " Nvim Config", "cd " .. CONFIG_PATH .. " | edit $MYVIMRC"),
        dashboard.button("p", " Projects", ":Telescope projects<CR>"),
      }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8

      dashboard.section.footer.val = "by Geet Sethi (sethigeet)"

      return dashboard
    end,
    config = function(_, dashboard) require("alpha").setup(dashboard.opts) end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        format = {
          shell = { pattern = "^:!", icon = "", ft = "sh" },
          filter = { pattern = "^:%s*!", icon = "", lang = "bash" },
        },
        view = "cmdline",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d+ fewer lines" },
              { find = "%d+ more lines" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        -- command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
      },
    },
    keys = {
      {
        "<S-Enter>",
        function() require("noice").redirect(vim.fn.getcmdline()) end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
    },
  },
}

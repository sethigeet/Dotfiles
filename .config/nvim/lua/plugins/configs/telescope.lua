local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    local actions = require("telescope.actions")
    local actions_layout = require("telescope.actions.layout")
    local actions_state = require("telescope.actions.state")
    local trouble = require("trouble.providers.telescope")
    local previewers = require("telescope.previewers")
    local sorters = require("telescope.sorters")

    require("telescope").setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "  ",
        selection_caret = "  ", -- " ❯ "
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = { mirror = false },
          vertical = { mirror = false },
          height = 0.75,
          width = 0.75,
          preview_cutoff = 120,
          prompt_position = "top",
        },
        file_sorter = sorters.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = sorters.get_generic_fuzzy_sorter,
        -- path_display = { "shorten" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { COLORTERM = "truecolor" }, -- default = nil,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        history = {
          limit = 10000000, -- `nil` = unlimited history
        },

        mappings = {
          i = {
            ["<C-c>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<c-t>"] = trouble.open_with_trouble,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-y>"] = function(prompt_bufnr)
              local entry = actions_state.get_selected_entry()
              if not entry or not type(entry) == "table" then
                return
              end

              actions_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
            end,
            ["<M-p>"] = actions_layout.toggle_preview,
            ["<M-m>"] = actions_layout.toggle_mirror,
            ["<CR>"] = actions.select_default + actions.center,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<M-p>"] = actions_layout.toggle_preview,
            ["<M-m>"] = actions_layout.toggle_mirror,
            ["<Esc>"] = actions.close,
          },
        },
      },
      extensions = {
        media_files = {
          filetypes = { "png", "webp", "jpg", "jpeg" },
          find_cmd = "fd",
        },
        fzy_native = { override_generic_sorter = true, override_file_sorter = true },
        frecency = {
          show_scores = false,
          show_unindexed = true,
          ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*", "*/env/*", "*/venv/*" },
          workspaces = {
            ["configs"] = os.getenv("XDG_CONFIG_DIR"),
            ["scripts"] = os.getenv("HOME") .. "/Scripts",
            ["repos"] = os.getenv("HOME") .. "/Repos",
          },
        },
      },
    })
  end,

  highlight_groups = function(_, colors, util)
    local bg_95 = util.lighten(colors.bg, 0.95)
    local bg_85 = util.lighten(colors.bg, 0.85)
    return {
      TelescopeBorder = { bg = bg_95, fg = bg_95 },
      TelescopePromptBorder = { bg = bg_85, fg = bg_85 },

      TelescopePromptNormal = { bg = bg_85, fg = colors.fg },
      TelescopePromptPrefix = { bg = bg_85, fg = colors.blue },

      TelescopeNormal = { bg = bg_95 },

      TelescopeTitle = { bg = colors.blue, fg = colors.bg_dark },
      TelescopePreviewTitle = { bg = colors.blue, fg = colors.bg_dark },
      TelescopePromptTitle = { bg = colors.blue, fg = colors.bg_dark },
      TelescopeResultsTitle = { bg = bg_95, fg = bg_95 },

      TelescopeSelection = { bg = util.darken(colors.blue, 0.25) },
    }
  end,

  keymaps = function(self)
    return {
      n = {
        { "<C-f>", self.utils.grep_current_buf },
        { "<C-b>", "<Cmd>Telescope buffers<CR>" },
        { "<C-p>", "<Cmd>Telescope find_files<CR>" },
      },
    }
  end,

  utils = {
    load_extensions = function()
      local load_extension = require("telescope").load_extension

      local extensions = {
        "media_files",
        -- "fzy_native",
        -- "projects",
        "frecency",
      }
      for _, ext in ipairs(extensions) do
        load_extension(ext)
      end
    end,

    find_files = function()
      local opts = require("telescope.themes").get_ivy({
        winblend = 10,
        border = true,
        previewer = false,
        shorten_path = false,
      })

      require("telescope.builtin").find_files({
        hidden = true,
        file_ignore_patterns = { ".git" },
      })
    end,

    grep_current_buf = function()
      local opts = require("telescope.themes").get_ivy({
        winblend = 10,
        border = true,
        previewer = false,
        shorten_path = false,
      })

      require("telescope.builtin").current_buffer_fuzzy_find(opts)
    end,

    cur_buf_symbols = function()
      local opts = require("telescope.themes").get_ivy({
        winblend = 10,
        layout_config = {
          height = 10,
        },
        border = true,
        shorten_path = false,
      })

      require("telescope.builtin").treesitter(opts)
    end,

    code_actions = function(ranged)
      local opts = require("telescope.themes").get_cursor({
        winblend = 10,
        layout_config = {
          height = 5,
        },
        border = true,
        shorten_path = false,
        previewer = false,
      })

      if ranged then
        require("telescope.builtin").lsp_range_code_actions(opts)
      else
        require("telescope.builtin").lsp_code_actions(opts)
      end
    end,
  },
})

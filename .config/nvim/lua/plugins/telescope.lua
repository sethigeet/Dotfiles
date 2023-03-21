local utils = require("utils")

local CUSTOM_PICKERS = {
  find_files = function()
    require("telescope.builtin").find_files({
      hidden = true,
      file_ignore_patterns = { ".git" },
    })
  end,

  grep_selected_text = function(mode)
    local text
    if mode == "v" then
      text = utils.get_visual_selection(true, true)
    else
      text = vim.fn.expand("<cword>")
    end

    -- escape special characters
    -- text = text:gsub("%(", "\\%(")
    -- text = text:gsub("%)", "\\%)")
    -- text = text:gsub("%[", "\\%[")
    -- text = text:gsub("%]", "\\%]")
    -- text = text:gsub('"', '\\"')

    require("telescope.builtin").grep_string({ search = text })
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
}

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-telescope/telescope-media-files.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-symbols.nvim",
      { "nvim-telescope/telescope-frecency.nvim", dependencies = "tami5/sql.nvim" },
    },

    opts = function()
      local actions = require("telescope.actions")
      local actions_layout = require("telescope.actions.layout")
      local actions_state = require("telescope.actions.state")
      local trouble = require("trouble.providers.telescope")
      local previewers = require("telescope.previewers")
      local sorters = require("telescope.sorters")

      return {
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
                if not entry or not type(entry) == "table" then return end

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
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
          },
        },
        extensions = {
          media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "fd",
          },
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
          },
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
      }
    end,

    init = function()
      local load_extension = require("telescope").load_extension

      local extensions = {
        "media_files",
        "fzf",
        -- "projects",
        "frecency",
      }
      for _, ext in ipairs(extensions) do
        load_extension(ext)
      end
    end,

    keys = function()
      local PICKERS = require("telescope.builtin")

      return {
        { "<C-f>", CUSTOM_PICKERS.grep_current_buf, desc = "Search current file" },
        { "<C-b>", PICKERS.buffers, desc = "Search buffers" },
        { "<C-p>", CUSTOM_PICKERS.find_files, desc = "Find files" },

        { "<leader>f", CUSTOM_PICKERS.find_files, desc = "Find files" },

        { "<leader>gb", PICKERS.git_branches, desc = "Branches" },
        { "<leader>gco", PICKERS.git_commits, desc = "Checkout commit" },
        { "<leader>gcu", PICKERS.git_commits, desc = "Checkout commit (for current file)" },

        { "<leader>lb", CUSTOM_PICKERS.cur_buf_symbols, desc = "Search buffer symbols" },
        { "<leader>ls", PICKERS.lsp_document_symbols, desc = "Search document symbols" },
        { "<leader>lS", PICKERS.lsp_workspace_symbols, desc = "Search workspace symbols" },

        { "<leader>sA", PICKERS.builtin, desc = "Search builtin searchers" },
        { "<leader>sd", function() PICKERS.diagnostics({ bufnr = 0 }) end, desc = "Search document diagnostics" },
        { "<leader>sD", PICKERS.diagnostics, desc = "Search workspace diagnostics" },
        { "<leader>se", PICKERS.symbols, desc = "Search emojis" },
        { "<leader>sF", PICKERS.git_files, desc = "Search git files" },
        { "<leader>sg", PICKERS.live_grep, desc = "Search workspace" },
        { "<leader>sG", CUSTOM_PICKERS.grep_current_buf, desc = "Search current buffer" },
        { "<leader>sl", PICKERS.loclist, desc = "Search loclist" },
        { "<leader>sm", PICKERS.marks, desc = "Search marks" },
        { "<leader>sr", PICKERS.resume, desc = "Resume last search" },
        { "<leader>sR", PICKERS.registers, desc = "Search registers" },
        { "<leader>ss", CUSTOM_PICKERS.grep_selected_text, desc = "Search for selected text" },
        {
          mode = "v",
          "<leader>ss",
          function() CUSTOM_PICKERS.grep_selected_text("v") end,
          desc = "Search for selected text",
        },
      }
    end,
  },
}

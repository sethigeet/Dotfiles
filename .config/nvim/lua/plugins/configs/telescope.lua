local plugin = {}

function plugin.setup()
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
      selection_caret = " ❯ ",
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

  plugin.keymappings()
  plugin.load_extensions()
end

function plugin.keymappings()
  local map = require("utils").map

  map("n", "<C-f>", plugin.grep_current_buf)
  map("n", "<C-b>", "<Cmd>Telescope buffers<CR>")
  map("n", "<C-p>", "<Cmd>Telescope find_files<CR>")
end

function plugin.load_extensions()
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
end

function plugin.grep_current_buf()
  local opts = require("telescope.themes").get_ivy({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })

  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function plugin.cur_buf_symbols()
  local opts = require("telescope.themes").get_ivy({
    winblend = 10,
    layout_config = {
      height = 10,
    },
    border = true,
    shorten_path = false,
  })

  require("telescope.builtin").treesitter(opts)
end

function plugin.code_actions(ranged)
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
end

return plugin

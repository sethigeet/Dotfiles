local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local load_extension = require("telescope").load_extension
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

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
    selection_caret = "  ",
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
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    -- path_display = { "shorten" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { COLORTERM = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    history = {
      limit = 10000000, -- `nil` = unlimited history
    },

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<c-t>"] = trouble.open_with_trouble,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<CR>"] = actions.select_default + actions.center,
      },
      n = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<esc>"] = actions.close,
      },
    },
  },
  extensions = {
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "fd",
    },
    fzy_native = { override_generic_sorter = true, override_file_sorter = true },
    fzf_writer = {
      -- minimum_grep_characters = 2,
      -- minimum_files_characters = 2,
      use_highlighter = true,
    },
    frecency = {
      show_scores = false,
      show_unindexed = true,
      ignore_patterns = { "*.git/*", "*/tmp/*" },
      workspaces = {
        ["configs"] = os.getenv("XDG_CONFIG_DIR"),
        ["scripts"] = os.getenv("HOME") .. "/Scripts",
        ["repos"] = os.getenv("HOME") .. "/Repos",
      },
    },
  },
})

-- Load all the extensions
local extensions = {
  "media_files",
  "fzy_native",
  "project",
  "fzf_writer",
  "frecency",
}
for _, ext in ipairs(extensions) do
  load_extension(ext)
end

local fns = {}

function fns.grep_current_buf()
  local opts = themes.get_dropdown({
    winblend = 10,
    layout_strategy = "bottom_pane",
    border = true,
    previewer = false,
    shorten_path = false,
  })

  builtin.current_buffer_fuzzy_find(opts)
end

function fns.cur_buf_symbols()
  local opts = themes.get_dropdown({
    winblend = 10,
    layout_strategy = "bottom_pane",
    border = true,
    previewer = false,
    shorten_path = false,
  })

  builtin.treesitter(opts)
end

function temp()
  -- builtin.find_files(themes.get_dropdown())
  -- builtin.find_files(themes.get_ivy())
  builtin.find_files(themes.get_cursor({
    layout_config = {
      horizontal = { mirror = false },
      vertical = { mirror = false },
      -- height = 0.75,
      -- width = 0.75,
    },
    previewer = false,
  }))
end

return fns

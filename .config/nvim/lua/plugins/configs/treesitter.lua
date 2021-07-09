local treesitter_leader = "<leader>t"

local function getTextObjectKeymaps(leader, uppercase)
  local objects = {
    f = "@function.outer",
    c = "@class.outer",
    l = "@loop.outer",
    i = "@conditional.outer",
    p = "@parameter.inner",
    b = "@block.outer",
  }

  local keymaps = {}
  for key, obj in pairs(objects) do
    local actual_key = uppercase and string.upper(key) or key
    keymaps[string.format("%s%s", leader, actual_key)] = obj
  end

  return keymaps
end

require("nvim-treesitter.configs").setup({
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {},
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<A-a>",
      node_incremental = "<A-a>",
      scope_incremental = "<A-s>",
      node_decremental = "<A-d>",
    },
  },
  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = treesitter_leader .. "r",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = treesitter_leader .. "d",
        list_definitions = treesitter_leader .. "l",
        list_definitions_toc = treesitter_leader .. "t",
        goto_next_usage = treesitter_leader .. "*",
        goto_previous_usage = treesitter_leader .. "#",
      },
    },
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aC"] = "@comment.outer",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["aP"] = "@parameter.outer",
        ["iP"] = "@parameter.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = getTextObjectKeymaps(treesitter_leader .. "s", false),
      swap_previous = getTextObjectKeymaps(treesitter_leader .. "s", true),
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist

      goto_next_start = getTextObjectKeymaps("]", false),
      goto_next_end = getTextObjectKeymaps("]", true),
      goto_previous_start = getTextObjectKeymaps("[", false),
      goto_previous_end = getTextObjectKeymaps("[", true),
    },
  },
  rainbow = { enable = true, max_file_lines = 1000 }, -- Rainbow brackets
  context_commentstring = { enable = true }, -- Comment strings
  autotag = { enable = true },
  indent = { enable = true },
  autopairs = { enable = true },
  matchup = { enable = true }, -- Extend vim's '%' functionality
  project = { base_dir = { "~/Repos", "~/Programming" }, max_depth = 3 },
})

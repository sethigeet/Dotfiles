local function get_text_object_keymaps(leader, uppercase)
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

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      ignore_install = { "phpdoc", "smali" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<M-Right>",
          node_incremental = "<M-Right>",
          scope_incremental = false,
          node_decremental = "<M-Left>",
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      textobjects = {
        swap = {
          enable = true,
          -- NOTE: These keybindings are defined in the `hydra` config
          -- swap_next = get_text_object_keymaps(treesitter_leader .. "s", false),
          -- swap_previous = get_text_object_keymaps(treesitter_leader .. "s", true),
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = get_text_object_keymaps("]", false),
          goto_next_end = get_text_object_keymaps("]", true),
          goto_previous_start = get_text_object_keymaps("[", false),
          goto_previous_end = get_text_object_keymaps("[", true),
        },
      },
      autotag = { enable = true },
      autopairs = { enable = true },
      matchup = { enable = true }, -- Extend vim's '%' functionality
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },

  "nvim-treesitter/nvim-treesitter-textobjects",
  { "nvim-treesitter/nvim-treesitter-context", opts = { mode = "cursor", max_lines = 3 } },
  "windwp/nvim-ts-autotag",

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },

  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    init = function(_) vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
    dependencies = { "nvim-treesitter" },
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      { "gSs", function() require("treesj").split() end, desc = "Split node at cursor" },
      {
        "gSS",
        function() require("treesj").split({ recursive = true }) end,
        desc = "Split node at cursor (recursively)",
      },
      { "gSj", function() require("treesj").join() end, desc = "Join node at cursor" },
      {
        "gSJ",
        function() require("treesj").join({ recursive = true }) end,
        desc = "Join node at cursor (recursively)",
      },
      {
        "gSt",
        function() require("treesj").toggle({ split = { recursive = true } }) end,
        desc = "Toggle node at cursor (split/join)",
      },
    },
  },
}

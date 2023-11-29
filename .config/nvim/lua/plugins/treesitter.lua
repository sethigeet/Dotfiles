local treesitter_leader = "<leader>t"

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
    -- build = ":TSUpdate",

    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
    opts = {
      ensure_installed = "all",
      ignore_install = { "phpdoc", "smali" },
      highlight = {
        enable = true, -- false will disable the whole extension
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<A-a>",
          node_incremental = "<A-a>",
          scope_incremental = "<A-w>",
          node_decremental = "<A-S-a>",
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
            goto_next_usage = "]r",
            goto_previous_usage = "[r",
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
        -- TODO: Move this part into `PeekDefinition` code and use it as a fallback if `lsp` client does not support it!
        -- lsp_interop = {
        -- enable = true,
        -- border = "none",
        -- peek_definition_code = {
        -- ["df"] = "@function.outer",
        -- ["dF"] = "@class.outer",
        -- },
        -- },
      },
      autotag = { enable = true },
      indent = { enable = true },
      autopairs = { enable = true },
      matchup = { enable = true }, -- Extend vim's '%' functionality
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-refactor",
    keys = {
      -- NOTE: These are automatically defined by the plugin
      { "<leader>tr", desc = "Rename" },
      { "<leader>td", desc = "Goto definition" },
      { "<leader>tl", desc = "List definitions" },
      { "<leader>tt", desc = "List definitions TOC" },
      { "[r", desc = "Goto previous reference" },
      { "]r", desc = "Goto next reference" },
    },
  },

  "nvim-treesitter/nvim-treesitter-textobjects",
  "windwp/nvim-ts-autotag",

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {},
    config = function(_, opts)
      require("ts_context_commentstring").setup(opts)
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },

  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function(_, _) vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
    dependencies = { "nvim-treesitter" },
  },
}

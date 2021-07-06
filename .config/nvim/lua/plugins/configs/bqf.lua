require("bqf").setup({
  -- enable nvim-bqf in quickfix window automatically
  auto_enable = true,

  -- give the window magic, when the window is splited horizontally, keep
  -- the distance between the current line and the top/bottom border of neovim unchanged.
  -- It's a bit like a floating window, but the window is indeed a normal window, without
  -- any floating attributes.
  magic_window = true,

  -- resize quickfix window height automatically.
  -- Shrink higher height to size of list in quickfix window, otherwise extend height
  -- to size of list or to default height (10)
  auto_resize_height = true,

  preview = {
    -- enable preview in quickfix window automatically
    auto_preview = true,

    -- border and scroll bar chars, they respectively represent:
    -- vline, vline, hline, hline, ulcorner, urcorner, blcorner, brcorner, sbar
    border_chars = { "│", "│", "─", "─", "╭", "╮", "╰", "╯", "█" },

    -- delay time, to do syntax for previewed buffer, unit is millisecond
    delay_syntax = 50,

    -- the height of preview window for horizontal layout
    win_height = 15,

    -- the height of preview window for vertical layout
    win_vheight = 15,
  },

  -- the table for {function = key}
  -- func_map = {},

  filter = {
    fzf = {
      action_for = {
        -- press ctrl-t to open up the item in a new tab
        ["ctrl-t"] = "tabedit",

        -- press ctrl-v to open up the item in a new vertical split
        ["ctrl-v"] = "vsplit",

        -- press ctrl-x to open up the item in a new horizontal split
        ["ctrl-x"] = "split",

        -- press ctrl-s to toggle sign for the selected items
        ["ctrl-s"] = "signtoggle",
      },

      -- "extra options for fzf",
      extra_opts = { "--bind", "ctrl-o:toggle-all" },
    },
  },
})

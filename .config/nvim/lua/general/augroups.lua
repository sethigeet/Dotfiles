require("utils.wrappers").define_augroups({
  general_settings = {
    {
      "TextYankPost",
      "*",
      cb = function() vim.hl.on_yank({ higroup = "IncSearch", timeout = 500 }) end,
    },

    -- Get back to the place from where you left the file
    --  Builtin vim way: (NOTE: can be fixed for other plugins by setting the `viewoptions`)
    -- { "BufWinEnter", "*.*", "silent!", "loadview" }, -- Load the state save state
    -- { "BufWinLeave", "*.*", "mkview" }, -- Save the state for the next time
    -- Custom implementation to not interfere with plugins
    { "BufReadPost", "*", cb = require("utils").restore_last_place },
  },
})

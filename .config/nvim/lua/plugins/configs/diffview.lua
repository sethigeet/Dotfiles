local plugin = {}

function plugin.setup()
  local cb = require("diffview.config").diffview_callback

  require("diffview").setup({
    diff_binaries = false, -- Show diffs for binaries
    use_icons = true, -- Requires nvim-web-devicons
    file_panel = {
      position = "left", -- One of 'left', 'right', 'top', 'bottom'
      width = 35, -- Only applies when position is 'left' or 'right'
      height = 10, -- Only applies when position is 'top' or 'bottom'
    },
    file_history_panel = {
      position = "bottom",
      width = 35,
      height = 16,
      log_options = {
        max_count = 256, -- Limit the number of commits
        follow = false, -- Follow renames (only for single file)
        all = false, -- Include all refs under 'refs/' including HEAD
        merges = false, -- List only merge commits
        no_merges = false, -- List no merge commits
        reverse = false, -- List commits in reverse order
      },
    },
    key_bindings = {
      disable_defaults = false, -- Disable the default key bindings
    },
  })
end

return plugin

local plugin = {}

function plugin.setup()
  require("todo-comments").setup(Opts.plugin.todo_comments.config)
end

function plugin.config()
  Opts.plugin["todo_comments"] = {
    enabled = true,
    config = {
      -- list of named colors where we try to extract the guifg from the
      -- list of hilight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "TodoError", "#DC2626" },
        warning = { "TodoWarning", "#FBBF24" },
        info = { "TodoInformation", "#2563EB" },
        hint = { "TodoHint", "#10B981" },
        default = { "TodoDefault", "#7C3AED" },
      },
    },
  }
end

return plugin

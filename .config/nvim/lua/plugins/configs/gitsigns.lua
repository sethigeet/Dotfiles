local plugin = {}

function plugin.setup()
  require("gitsigns").setup(Opts.plugin.gitsigns.config)
end
function plugin.config()
  Opts.plugin["gitsigns"] = {
    enabled = true,
    config = {
      signs = {
        add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = {
          hl = "GitSignsChange",
          text = "▎",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        delete = {
          hl = "GitSignsDelete",
          text = "契",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = "契",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = "▎",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
      },
      numhl = false,
      linehl = false,
      keymaps = {},
      watch_index = { interval = 1000 },
      sign_priority = 6,
      update_debounce = 200,
      status_formatter = nil, -- Use default
      use_decoration_api = false,
    },
  }
end

return plugin

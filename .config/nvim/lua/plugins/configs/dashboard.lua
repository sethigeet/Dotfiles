local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    vim.g.dashboard_default_executive = "telescope"
    vim.g.dashboard_custom_section = {
      a = { description = { " Find File          " }, command = "Telescope find_files" },
      b = { description = { " Recently Used Files" }, command = "Telescope oldfiles" },
      c = { description = { " Load Last Session  " }, command = "SessionLoad" },
      d = { description = { " Find Word          " }, command = "Telescope live_grep" },
      e = { description = { " Marks              " }, command = "Telescope marks" },
      i = {
        description = { " Nvim Config        " },
        command = "cd " .. CONFIG_PATH .. " | edit $MYVIMRC",
      },
      p = { description = { " Projects           " }, command = "Telescope projects" },
    }
    vim.g.dashboard_preview_command = "cat"
    vim.g.dashboard_preview_pipeline = "lolcat"
    vim.g.dashboard_preview_file = "~/.config/nvim/logo.txt"
    vim.g.dashboard_preview_file_height = 12
    vim.g.dashboard_preview_file_width = 80
    vim.g.dashboard_session_directory = "~/.cache/nvim/session"
    vim.g.dashboard_custom_footer = { "by Geet Sethi (sethigeet)" }
  end,

  augroups = {
    dashboard = {
      { "FileType", "dashboard", cmd = "set showtabline=0" },
      { "WinLeave", "<buffer>", cmd = "set showtabline=2" },
      { "FileType", "dashboard", cmd = "setlocal nocursorline" },
      {
        "FileType",
        "dashboard",
        cb = function()
          vim.keymap("n", "q", ":q<CR>", { silent = true, buffer = true })
        end,
      },
    },
  },
})

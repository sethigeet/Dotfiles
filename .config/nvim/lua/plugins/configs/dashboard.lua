local plugin = {}

function plugin.setup()
  vim.g.dashboard_default_executive = Opts.plugin.dashboard.config.default_executive
  vim.g.dashboard_custom_section = Opts.plugin.dashboard.config.custom_section
  vim.g.dashboard_preview_command = Opts.plugin.dashboard.config.preview_command
  vim.g.dashboard_preview_pipeline = Opts.plugin.dashboard.config.preview_pipeline
  vim.g.dashboard_preview_file = Opts.plugin.dashboard.config.preview_file
  vim.g.dashboard_preview_file_height = Opts.plugin.dashboard.config.preview_file_height
  vim.g.dashboard_preview_file_width = Opts.plugin.dashboard.config.preview_file_width
  vim.g.dashboard_session_directory = Opts.plugin.dashboard.config.session_directory
  vim.g.dashboard_custom_footer = Opts.plugin.dashboard.config.custom_footer

  require("general.functions").DefineAugroups({
    dashboard = {
      { "FileType", "dashboard", "set showtabline=0" },
      { "WinLeave", "<buffer>", "set showtabline=2" },
      { "FileType", "dashboard", "setlocal nocursorline" },
      { "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<CR>" },
    },
  })
end

function plugin.config()
  Opts.plugin["dashboard"] = {
    enabled = true,
    config = {
      default_executive = "telescope",
      custom_section = {
        a = { description = { " Find File          " }, command = "Telescope find_files" },
        b = { description = { " Recently Used Files" }, command = "Telescope oldfiles" },
        c = { description = { " Load Last Session  " }, command = "SessionLoad" },
        d = { description = { " Find Word          " }, command = "Telescope live_grep" },
        e = { description = { " Marks              " }, command = "Telescope marks" },
        i = {
          description = { " Nvim Config        " },
          command = "cd " .. CONFIG_PATH .. " | edit $MYVIMRC",
        },
      },
      preview_command = "cat",
      preview_pipeline = "lolcat",
      preview_file = "~/.config/nvim/logo.txt",
      preview_file_height = 12,
      preview_file_width = 80,
      session_directory = "~/.cache/nvim/session",
      custom_footer = { "by Geet Sethi (sethigeet)" },
    },
  }
end

return plugin

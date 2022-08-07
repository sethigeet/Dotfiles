local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Header
    dashboard.section.header.val = {
      "                                              ",
      "       ███████████           █████      ██",
      "      ███████████             █████ ",
      "      ████████████████ ███████████ ███   ███████",
      "     ████████████████ ████████████ █████ ██████████████",
      "    █████████████████████████████ █████ █████ ████ █████",
      "  ██████████████████████████████████ █████ █████ ████ █████",
      " ██████  ███ █████████████████ ████ █████ █████ ████ ██████",
      " ██████   ██  ███████████████   ██ █████████████████",
      " ██████   ██  ███████████████   ██ █████████████████ ",
    }

    -- Buttons
    dashboard.section.buttons.val = {
      dashboard.button("f", " Find File", ":Telescope find_files<CR>", nil),
      dashboard.button("r", " Recently Used Files", ":Telescope oldfiles<CR>", nil),
      dashboard.button("w", " Find Word", ":Telescope live_grep<CR>", nil),
      dashboard.button("m", " Marks", ":Telescope marks<CR>", nil),
      dashboard.button("c", " Nvim Config", "cd " .. CONFIG_PATH .. " | edit $MYVIMRC", nil),
      dashboard.button("p", " Projects", ":Telescope projects<CR>", nil),
    }

    dashboard.section.footer.val = "by Geet Sethi (sethigeet)"
    dashboard.opts.opts.noautocmd = true

    alpha.setup(dashboard.opts)
  end,

  augroups = {
    alpha = {
      { "FileType", "alpha", cmd = "set showtabline=0" },
      { "WinLeave", "<buffer>", cmd = "set showtabline=2" },
      { "FileType", "alpha", cmd = "setlocal nocursorline" },
      {
        "FileType",
        "alpha",
        cb = function() vim.keymap("n", "q", ":q<CR>", { silent = true, buffer = true }) end,
      },
    },
  },
})

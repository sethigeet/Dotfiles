return {
  {
    "anuvyklack/hydra.nvim",

    menu_names = { "options", "swap" },
    menus = {},

    init = function(self)
      for _, menu_name in ipairs(self.menu_names) do
        require("plugins.hydra." .. menu_name).init()
        self.menus[menu_name] = require("plugins.hydra." .. menu_name).menu
      end
    end,

    keys = function(self)
      return {
        -- NOTE: These functions have to be defined like this because the
        -- functions to create the menus are set on `self.menu` later (in init)
        { "<leader>o", function() self.menus.options() end, desc = "Show options menu" },
        { "<leader>ts", function() self.menus.swap() end, desc = "Show swap menu" },
      }
    end,
  },
}

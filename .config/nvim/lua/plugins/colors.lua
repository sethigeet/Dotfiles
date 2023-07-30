return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    opts = {
      { "*" },
      {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        names = true, -- "Name" codes like Blue
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      },
    },
    config = function(_, opts) require("colorizer").setup(opts[1], opts[2]) end,
  },

  {
    "nvim-colortils/colortils.nvim",
    cmd = { "Colortils" },
    config = true,
    keys = {
      { "<leader>Cp", "<Cmd>Colortils picker", desc = "Open picker" },
      { "<leader>Cl", "<Cmd>Colortils lighten", desc = "Lighten" },
      { "<leader>Cd", "<Cmd>Colortils darken", desc = "Darken" },
      { "<leader>Cg", "<Cmd>Colortils gradient", desc = "Gradient" },
      { "<leader>CG", "<Cmd>Colortils greyscale", desc = "Greyscale" },
      { "<leader>Cc", "<Cmd>Colortils css list", desc = "List css colors" },
    },
  },
}

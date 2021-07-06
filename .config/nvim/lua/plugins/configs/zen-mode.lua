require("zen-mode").setup({
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    width = 0.8, -- width of the Zen window
    height = 1, -- height of the Zen window
  },
  plugins = {
    gitsigns = false, -- disables git signs
    tmux = false, -- disables the tmux statusline
  },
})

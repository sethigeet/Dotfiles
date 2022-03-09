local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    -- NOTE: This setup is being done in the `nvim-scrollbar` config
    -- require("hlslens").setup({
    --   calm_down = true,
    --   nearest_only = true,
    -- })
  end,
  keymaps = {
    n = {
      { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },

      { "*", [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { "#", [[#<Cmd>lua require('hlslens').start()<CR>]] },
      { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]] },
    },
    x = {
      { "*", [[:<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR><Cmd>lua require('hlslens').start()<CR>]] },
      { "#", [[:<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR><Cmd>lua require('hlslens').start()<CR>]] },
      { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]] },
    },
  },
})

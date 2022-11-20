local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    local comment = require("Comment")
    local U = require("Comment.utils")
    local TSU = require("ts_context_commentstring.utils")
    local TSI = require("ts_context_commentstring.internal")

    comment.setup({
      ---Add a space b/w comment and the line
      padding = true,

      ---Whether the cursor should stay at its position
      sticky = true,

      ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
      mappings = {
        ---Operator-pending mapping
        ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        basic = true,
        ---Extra mapping
        ---Includes `gco`, `gcO`, `gcA`
        extra = true,
      },

      ---Pre-hook, called before commenting the line
      -- This hook is used to use nvim-ts-context-commentstring API for calculating the `commentstring`
      pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if vim.bo.filetype == "typescriptreact" then
          -- Detemine whether to use linewise or blockwise commentstring
          local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

          -- Determine the location where to calculate commentstring from
          local location = nil
          if ctx.ctype == U.ctype.block then
            location = TSU.get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = TSU.get_visual_start_location()
          end

          return TSI.calculate_commentstring({
            key = type,
            location = location,
          })
        end
      end,

      ---Post-hook, called after commenting is done
      post_hook = nil,

      ---Lines to be ignored while comment/uncomment.
      ignore = nil,
    })
  end,

  keymaps = function()
    local api = require("Comment.api")
    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

    return {
      n = {
        { "g>", api.call("comment.linewise", "g@"), { expr = true, desc = "Comment region linewise" } },
        { "g>c", api.call("comment.linewise.current", "g@$"), { expr = true, desc = "Comment current line" } },
        { "g>b", api.call("comment.blockwise.current", "g@$"), { expr = true, desc = "Comment current block" } },

        { "g<", api.call("uncomment.linewise", "g@"), { expr = true, desc = "Uncomment region linewise" } },
        { "g<c", api.call("uncomment.linewise.current", "g@$"), { expr = true, desc = "Uncomment current line" } },
        { "g<b", api.call("uncomment.blockwise.current", "g@$"), { expr = true, desc = "Uncomment current block" } },
      },

      x = {
        {
          "g>",
          function()
            vim.api.nvim_feedkeys(esc, "nx", false)
            api.locked("comment.linewise")(vim.fn.visualmode())
          end,
          { desc = "Comment region linewise (visual)" },
        },

        {
          "g<",
          function()
            vim.api.nvim_feedkeys(esc, "nx", false)
            api.locked("uncomment.linewise")(vim.fn.visualmode())
          end,
          { desc = "Uncomment region linewise (visual)" },
        },
      },
    }
  end,
})

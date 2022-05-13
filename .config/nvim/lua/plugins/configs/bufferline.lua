local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none",
        close_command = "Bdelete %d",
        right_mouse_command = "Bdelete! %d",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diagnostics_dict)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym
            if e == "error" then
              sym = " "
            elseif e == "warning" then
              sym = " "
            elseif e == "info" then
              sym = " "
            else
              sym = " "
            end
            s = s .. n .. sym
          end
          return s
        end,
        offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "thin",
      },
    })
  end,

  keymaps = function()
    local maps = {
      n = {
        -- Goto any buffer instantly
        { "<M-b>", "<Cmd>BufferLinePick<CR>" },

        -- Move between buffers using Tab and Shift + Tab
        { "<TAB>", "<Cmd>BufferLineCycleNext<CR>" },
        { "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>" },

        -- Move between buffers using Shift + Arrow Keys
        { "<S-Left>", "<Cmd>BufferLineCyclePrev<CR>" },
        { "<S-Right>", "<Cmd>BufferLineCycleNext<CR>" },

        -- Move between buffers using Ctrl + h,l Keys
        { "<C-h>", "<Cmd>BufferLineCyclePrev<CR>" },
        { "<C-l>", "<Cmd>BufferLineCycleNext<CR>" },

        -- Move buffers using Ctrl + Arrow Keys
        { "<C-Left>", "<Cmd>BufferLineMovePrev<CR>" },
        { "<C-Right>", "<Cmd>BufferLineMoveNext<CR>" },
      },
    }

    -- Move to a buffer using Alt+number
    local goto_buf = require("bufferline").go_to_buffer
    for i = 1, 9, 1 do
      table.insert(maps["n"], {
        string.format("<M-%d>", i),
        function()
          goto_buf(i)
        end,
      })
    end

    return maps
  end,
})

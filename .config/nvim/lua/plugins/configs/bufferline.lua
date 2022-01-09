local plugin = {}

function plugin.setup()
  require("bufferline").setup({
    options = {
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
      separator_style = "thick",
    },
  })

  plugin.keymaps()
end

function plugin.keymaps()
  local map = require("utils").map

  -- Goto any buffer instantly
  map("n", "<M-b>", "<Cmd>BufferLinePick<CR>")

  -- Move between buffers using Tab and Shift + Tab
  map("n", "<TAB>", "<Cmd>BufferLineCycleNext<CR>")
  map("n", "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>")

  -- Move between buffers using Shift + Arrow Keys
  map("n", "<S-Left>", "<Cmd>BufferLineCyclePrev<CR>")
  map("n", "<S-Right>", "<Cmd>BufferLineCycleNext<CR>")

  -- Move between buffers using Ctrl + h,l Keys
  map("n", "<C-h>", "<Cmd>BufferLineCyclePrev<CR>")
  map("n", "<C-l>", "<Cmd>BufferLineCycleNext<CR>")

  -- Move buffers using Ctrl + Arrow Keys
  map("n", "<C-Left>", "<Cmd>BufferLineMovePrev<CR>")
  map("n", "<C-Right>", "<Cmd>BufferLineMoveNext<CR>")

  -- Move to a buffer using Alt+number
  for i = 1, 9, 1 do
    map("n", "<M-" .. i .. ">", function() require("bufferline").go_to_buffer(i) end)
  end
end

return plugin

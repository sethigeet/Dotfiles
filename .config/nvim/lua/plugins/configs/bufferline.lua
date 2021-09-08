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
  local map = require("utils.map")

  -- Goto any buffer instantly
  map.nnoremap("<M-b>", "<cmd>BufferLinePick<CR>")

  -- Move between buffers using Tab and Shift + Tab
  map.nnoremap("<TAB>", "<cmd>BufferLineCycleNext<CR>")
  map.nnoremap("<S-TAB>", "<cmd>BufferLineCyclePrev<CR>")

  -- Move between buffers using Shift + Arrow Keys
  map.nnoremap("<S-Left>", "<cmd>BufferLineCyclePrev<CR>")
  map.nnoremap("<S-Right>", "<cmd>BufferLineCycleNext<CR>")

  -- Move between buffers using Ctrl + h,l Keys
  map.nnoremap("<C-h>", "<cmd>BufferLineCyclePrev<CR>")
  map.nnoremap("<C-l>", "<cmd>BufferLineCycleNext<CR>")

  -- Move buffers using Ctrl + Arrow Keys
  map.nnoremap("<C-Left>", "<cmd>BufferLineMovePrev<CR>")
  map.nnoremap("<C-Right>", "<cmd>BufferLineMoveNext<CR>")

  -- Move to a buffer using Alt+number
  for i = 1, 9, 1 do
    map.nnoremap("<M-" .. i .. ">", "<cmd>lua require('bufferline').go_to_buffer(" .. i .. ")<CR>")
  end
end

return plugin

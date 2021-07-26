local plugin = {}

function plugin.setup()
  require("bufferline").setup({
    options = {
      numbers = "none",
      number_style = "",
      mappings = false,
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
  map.nnoremap("<M-b>", ":BufferLinePick<CR>")

  -- Move between buffers using Tab and Shift + Tab
  map.nnoremap("<TAB>", ":BufferLineCycleNext<CR>")
  map.nnoremap("<S-TAB>", ":BufferLineCyclePrev<CR>")

  -- Move between buffers using Shift + Arrow Keys
  map.nnoremap("<S-Left>", ":BufferLineCyclePrev<cr>")
  map.nnoremap("<S-Right>", ":BufferLineCycleNext<cr>")

  -- Move buffers using Ctrl + Arrow Keys
  map.nnoremap("<C-Left>", ":BufferLineMovePrev<cr>")
  map.nnoremap("<C-Right>", ":BufferLineMoveNext<cr>")

  -- Move to a buffer using Alt+number
  for i = 1, 9, 1 do
    vim.api.nvim_set_keymap(
      "n",
      "<M-" .. i .. ">",
      ":lua require('bufferline').go_to_buffer(" .. i .. ")<CR>",
      { noremap = true, silent = true }
    )
  end
end

return plugin

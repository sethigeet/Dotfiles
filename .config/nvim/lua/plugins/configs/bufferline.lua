local plugin = {}

function plugin.setup()
  require("bufferline").setup(Opts.plugin.bufferline.config)

  vim.api.nvim_set_keymap("n", "<M-b>", ":BufferLinePick<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<TAB>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

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

function plugin.config()
  Opts.plugin["bufferline"] = {
    enabled = true,
    config = {
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
    },
  }
end

return plugin

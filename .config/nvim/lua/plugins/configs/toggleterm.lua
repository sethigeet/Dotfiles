local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    require("toggleterm").setup({
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = "`",
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 0.01, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        border = "rounded",
        width = math.floor(vim.o.columns * 0.75),
        height = math.floor(vim.o.lines * 0.75),
        winblend = 0,
        highlights = {
          border = "FloatBorder",
          background = "Normal",
        },
      },
    })

    local Terminal = require("toggleterm.terminal").Terminal
    local floating = Terminal:new({ direction = "float", hidden = true })

    function TermToggle(type)
      local terminals = {
        default = function()
          vim.cmd("ToggleTerm")
        end,
        floating = function()
          floating:toggle()
        end,
      }

      type = type or "default"
      terminals[type]()
    end

    -- NOTE: A lot of this functionality has been ripped off from the
    --       `toggleterm` plugin's code and slightly modified
    function TermSend()
      local contents = require("utils").get_visual_selection(true)

      local terms = require("toggleterm.terminal")
      local num = terms.get_toggled_id()
      local term, _ = terms.get_or_create_term(num, "")
      if not term:is_open() then
        vim.notify(
          [[No terminal was found to be open. Pleas open a
terminal first]],
          vim.log.levels.INFO,
          {
          title = "No terminal is open!",
        }
        )

        return
      end

      for _, line in ipairs(contents) do
        term:send(line, false)
      end

      -- Go back to the original window
      local ui = require("toggleterm.ui")
      ui.scroll_to_bottom()
      ui.goto_previous()
      ui.stopinsert()
    end
  end,

  keymaps = function()
    return {
      n = {
        { "`", TermToggle },
        {
          "<F1>",
          function()
            TermToggle("floating")
          end,
        },
      },
      t = {
        { "`", TermToggle },
        {
          "<F1>",
          function()
            TermToggle("floating")
          end,
        },
      },
    }
  end,
})

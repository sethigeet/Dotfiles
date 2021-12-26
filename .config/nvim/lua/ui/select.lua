local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event

local apply_default_keymaps = require("ui.apply_keymaps")

local select_ui = nil

return function(items, opts, on_choice, custom)
  vim.validate({
    items = { items, "table", false },
    on_choice = { on_choice, "function", false },
  })

  if select_ui then
    -- ensure single ui.select operation
    vim.notify(
      [[Another select is pending!
Please close all other selects first]],
      vim.log.levels.ERROR,
      { title = "An error occurred while opening the select popup!" }
    )
    return
  end

  local function on_done(item, index)
    if select_ui then
      -- if it's still mounted, unmount it
      select_ui:unmount()
    end

    -- HACK: Return to the original position as entering the popup window and then exiting it moves the cursor to the left
    vim.cmd("norm l")

    -- pass the select value
    if not item then
      on_choice(nil, nil)
    else
      local return_item = custom and item or item.text
      on_choice(return_item, index)
    end

    -- indicate the operation is done
    select_ui = nil
  end

  local function on_close()
    on_done(nil, nil)
  end

  local kind = opts.kind or "unknown"
  local format_item = opts.format_item or tostring

  local relative = opts.relative or "editor"
  local position = opts.position or "50%"

  if kind == "codeaction" then
    -- change position for codeaction selection
    relative = "cursor"
    position = {
      row = 1,
      col = 0,
    }
  end

  local max_width = vim.api.nvim_win_get_width(0)

  local menu_items = {}
  if not custom then
    for i, item in ipairs(items) do
      local item_text = string.sub(format_item(item), 0, max_width - 2)
      table.insert(menu_items, Menu.item(item_text, { index = i }))
    end
  else
    for i, item in ipairs(items) do
      table.insert(menu_items, Menu.item(item, { index = i }))
    end
  end

  select_ui = Menu({
    relative = relative,
    position = position,
    border = opts.border or {
      style = "rounded",
      highlight = "FloatBorder",
      text = {
        top = string.format(" %s ", opts.prompt) or " Choose Item ",
        top_align = "left",
      },
    },
    size = opts.size,
    zindex = opts.zindex,
    enter = opts.enter,
    focusable = opts.focusable,
    win_options = opts.win_options or {
      winhighlight = "FloatBorder:FloatBorder",
    },
  }, {
    lines = menu_items,
    min_width = opts.min_width or 20,
    keymap = opts.keymap or {
      close = { "<Esc>", "<C-c>" },
      focus_next = { "j", "<Down>", "<Tab>", "<C-n>" },
      focus_prev = { "k", "<Up>", "<S-Tab>", "<C-p>" },
      submit = { "<CR>", "<Space>" },
    },
    on_close = function()
      on_done(nil, nil)
    end,
    on_submit = function(item)
      on_done(item, item.index)
    end,
  })

  select_ui:mount()

  -- cancel operation if cursor leaves select
  select_ui:on(event.BufLeave, function()
    on_done(nil, nil)
  end, { once = true })

  apply_default_keymaps(select_ui, on_close)
end

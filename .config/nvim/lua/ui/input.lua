local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local apply_default_keymaps = require("utils.ui").apply_default_keymaps

local prompt_prefix = "➤ "

local input_ui = nil

return function(opts, on_confirm)
  vim.validate({
    on_confirm = { on_confirm, "function", false },
  })

  if input_ui then
    -- ensure single ui.input operation
    vim.notify(
      [[Another input is pending!
Please close all other inputs first]],
      vim.log.levels.ERROR,
      { title = "An error occurred while opening the input field!" }
    )
    return
  end

  local function on_done(value)
    if input_ui then
      -- if it's still mounted, unmount it
      input_ui:unmount()
    end

    -- HACK: Return to the original position as entering the popup window and then exiting it moves the cursor to the left
    vim.cmd("norm l")

    -- pass the input value
    on_confirm(value)

    -- indicate the operation is done
    input_ui = nil
  end

  local function on_close()
    on_done(nil)
  end

  input_ui = Input({
    relative = "cursor",
    position = {
      row = 1,
      col = 0,
    },
    size = {
      -- minimum width 20
      width = math.max(30, type(opts.default) == "string" and #opts.default or 0),
    },
    border = {
      style = "rounded",
      highlight = "FloatBorder",
      -- padding = { 1, 1 },
      text = {
        top = string.format(" %s ", opts.prompt) or " Input ",
        top_align = "left",
      },
    },
    win_options = {
      winhighlight = "FloatBorder:FloatBorder",
    },
  }, {
    prompt = prompt_prefix,
    default_value = opts.default,
    on_close = on_close,
    on_submit = function(value)
      on_done(value)
    end,
  })

  input_ui:mount()

  -- cancel operation if cursor leaves input
  input_ui:on(event.BufLeave, on_close, { once = true })

  apply_default_keymaps(input_ui, on_close)
end

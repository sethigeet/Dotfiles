local diagnostic_wrapper = {}

-- diagnostic
function diagnostic_wrapper.get_all()
  vim.diagnostic.get()
end

function diagnostic_wrapper.get_next()
  vim.diagnostic.get_next()
end

function diagnostic_wrapper.get_prev()
  vim.diagnostic.get_prev()
end

function diagnostic_wrapper.goto_next()
  vim.diagnostic.goto_next()
end

function diagnostic_wrapper.goto_prev()
  vim.diagnostic.goto_prev()
end

function diagnostic_wrapper.populate_location_list()
  vim.diagnostic.set_loclist({ open_loclist = false })
end

local show_virtual_text = true
function diagnostic_wrapper.toggle_virtual_text()
  show_virtual_text = not show_virtual_text

  vim.diagnostic.config({
    virtual_text = show_virtual_text and { spacing = 4, prefix = "" } or false,
  })
end

return diagnostic_wrapper

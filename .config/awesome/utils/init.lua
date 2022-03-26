local M = {}

function M.format(text, props)
  local open_tag = "<span"
  if props.bg then
    open_tag = open_tag .. string.format(" bgcolor='%s' ", props.bg)
  end

  if props.fg then
    open_tag = open_tag .. string.format(" fgcolor='%s' ", props.fg)
  end

  if props.font then
    open_tag = open_tag .. string.format(" font='%s' ", props.font)
  end

  if props.size then
    open_tag = open_tag .. string.format(" size='%s' ", props.size)
  end

  if props.bold then
    open_tag = open_tag .. " weight='bold' "
  end

  if props.style then
    open_tag = open_tag .. string.format(" style='%s' ", props.style)
  end

  if props.underline then
    open_tag = open_tag .. " underline='single' "
  end

  open_tag = open_tag .. ">"

  return string.format("%s%s</span>", open_tag, text)
end

function M.split(str, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}

  for s in string.gmatch(str, "([^" .. sep .. "]+)") do
    table.insert(t, s)
  end

  return t
end

return M

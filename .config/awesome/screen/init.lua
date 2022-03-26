local awful = require("awful")

local bar = require("bar")

local num_tags = 9 -- the number of tags
local rep_tag = "" -- the tag that is repeated
local tags = { "", "﬏", "", "", "漣" }
while #tags < num_tags do
  table.insert(tags, rep_tag)
end

awful.screen.connect_for_each_screen(function(s)
  -- Each screen has its own tag table.
  awful.tag(tags, s, awful.layout.layouts[1])

  bar.setup(s)
end)

-- Setup the signals
require("screen.signals")

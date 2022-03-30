local xresources = require("beautiful.xresources")
local gears = require("gears")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local colors = {
  bg = "#1F2335",
  bg_alt = "#1A1B26",
  bg_alt_2 = "#292E42",
  fg = "#C0CAF5",

  gray = "#8C8C8C",
  red = "#F7768E",
  green = "#9ECE6A",
  yellow = "#E0AF68",
  blue = "#7DCFFF",
  purple = "#BB9AF7",
  cyan = "#73DACA",
  amber = "#E0AF68",
  orange = "#FF9E64",
  pink = "#F7768E",
  lime = "#D7DD91",
  indigo = "#7AA2F7",
}

local theme = {
  font = "Hack Nerd Font 10",
  font_icon = "Iosevka Nerd Font 12",

  bg_normal = colors.bg,
  bg_focus = colors.indigo,
  bg_urgent = colors.bg,
  bg_minimize = colors.gray,
  bg_systray = colors.bg_alt,
  bg_bar = colors.bg_alt,
  bg_alt = colors.bg_alt_2,

  fg_normal = colors.fg,
  fg_focus = colors.indigo,
  fg_urgent = colors.red,
  fg_minimize = colors.fg,
  fg_disabled = colors.gray,

  useless_gap = dpi(4),
  gap_single_client = false,
  border_width = dpi(1),
  border_normal = colors.gray,
  border_focus = colors.indigo,
  border_marked = colors.red,

  colors = colors,
}

-- There are other variable sets overriding the default one when defined, the sets are:
-- titlebar_[bg|fg]_[normal|focus]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

-- Wibar
-- wibar_[stretch|border_width|border_color|ontop|cursor|opacity|type|width|height|bg|bgimage|fg|shape]
theme.wibar_bg = theme.bg_bar

-- Tooltip
-- tooltip_[font|opacity|fg|bg|border_width|border_color]
theme.tooltip_bg = theme.bg_focus
theme.tooltip_fg = theme.bg_normal
theme.tooltip_opacity = 0.75
theme.tooltip_shape = gears.shape.rounded_rect

-- Taglist
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
--   BG
theme.taglist_bg_occupied = theme.bg_alt
theme.taglist_bg_focus = theme.bg_alt
theme.taglist_bg_urgent = theme.bg_alt
theme.taglist_bg_empty = theme.bg_alt
theme.taglist_bg_volatile = theme.bg_alt
--   FG
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_fg_urgent = theme.fg_urgent
theme.taglist_fg_empty = colors.gray
theme.taglist_fg_volatile = theme.fg_urgent
--   Others
theme.taglist_font = theme.font_icon
theme.taglist_shape = gears.shape.rectangle

-- Tasklist
-- tasklist_[bg|fg]_[focus|urgent]
theme.tasklist_fg_focus = theme.fg_normal
-- TODO: set good icons here
theme.tasklist_sticky = ""
theme.tasklist_ontop = ""
theme.tasklist_above = "禎"
theme.tasklist_below = "穀"
theme.tasklist_floating = ""
theme.tasklist_maximized = ""

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "default/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path .. "default/background.png"

theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

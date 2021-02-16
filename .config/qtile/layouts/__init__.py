from libqtile import layout

from defaults.layout_theme import layout_theme

from .floating import floating_layout

layouts = [
    layout.Max,
    layout.Bsp,
    layout.MonadTall,
    layout.Floating
]

layouts_defn = [
    Layout(**layout_theme) for Layout in layouts
]

floating_layout_defn = floating_layout

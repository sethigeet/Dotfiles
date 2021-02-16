from libqtile import layout
from libqtile.config import Match

from defaults.layout_theme import layout_theme

float_rules = [
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
]

floating_layout = layout.Floating(float_rules=float_rules, **layout_theme)

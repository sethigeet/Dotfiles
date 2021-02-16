from libqtile import widget
import os

from defaults.colors import colors


def current_layout():
    return widget.CurrentLayout(
        foreground=colors["widget"]["color"]["text"],
        background=colors["widget"]["bg"],
        padding=5
    )


def current_layout_icon():
    return widget.CurrentLayoutIcon(
        custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
        foreground=colors["widget"]["color"]["text"],
        background=colors["widget"]["bg"],
        padding=0,
        scale=0.5
    )

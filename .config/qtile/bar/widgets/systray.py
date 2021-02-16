from libqtile import widget

from defaults.colors import colors


def systray():
    return widget.Systray(
        background=colors["widget"]["bg"],
        padding=5
    )

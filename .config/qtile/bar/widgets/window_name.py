from libqtile import widget

from defaults.colors import colors


def windowName():
    return widget.WindowName(
        foreground=colors["panel"]["windowName"],
        background=colors["panel"]["bg"],
        padding=0,
        fontsize=16
    )

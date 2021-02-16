from libqtile import widget

from defaults.colors import colors


def seperator():
    return widget.Sep(
        linewidth=0,
        padding=6,
        foreground=colors["panel"]["color"],
        background=colors["panel"]["bg"]
    )

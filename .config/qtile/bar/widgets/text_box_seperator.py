from libqtile import widget

from defaults.colors import colors


def textBoxSeperator():
    return widget.TextBox(
        text=' | ',
        background=colors["widget"]["bg"],
        foreground=colors["widget"]["color"]["seperator"],
        padding=1,
        fontsize=9,
        margin_y=2,
    )

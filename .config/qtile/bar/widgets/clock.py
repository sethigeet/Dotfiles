from libqtile import widget

from defaults.colors import colors


def clock():
    return widget.Clock(
        foreground=colors["widget"]["color"]["text"],
        background=colors["widget"]["bg"],
        format=" %I:%M %p     %A, %B %d"
    )

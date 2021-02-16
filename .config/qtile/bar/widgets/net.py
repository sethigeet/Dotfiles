from libqtile import widget

from defaults.colors import colors


def net():
    return widget.Net(
        interface="enp0s31f6",
        format="{down} ↓↑ {up}",
        foreground=colors["widget"]["color"]["text"],
        background=colors["widget"]["bg"],
        padding=5
    )

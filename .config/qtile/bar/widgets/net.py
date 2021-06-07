from libqtile import widget, qtile

from constants import scripts_dir
from defaults.colors import colors


def net():
    return widget.Net(
        interface="enp0s31f6",
        format="{down} ↓↑ {up}",
        foreground=colors["widget"]["color"]["text"],
        background=colors["widget"]["bg"],
        padding=5,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(scripts_dir + "rofi/network")
        }
    )

from libqtile import widget, qtile

from constants import scripts_dir
from defaults.colors import colors


def logo():
    return widget.TextBox(
        text="",
        foreground=colors["widget"]["color"]["text"],
        background=colors["widget"]["accentBg"],
        fontsize=20,
        padding=12,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(scripts_dir + "rofi/menu")
        }
    )

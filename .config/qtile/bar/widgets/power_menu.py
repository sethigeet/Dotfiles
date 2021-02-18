from libqtile import widget, qtile

from constants import scripts_dir
from defaults.colors import colors


def power_menu():
    return widget.TextBox(
        text="襤",
        foreground=colors["widget"]["color"]["text"],
        background=colors["widget"]["bg"],
        fontsize=20,
        padding=5,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(scripts_dir + "rofi/power-menu")
        }
    )

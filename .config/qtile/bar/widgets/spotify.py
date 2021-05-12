from libqtile import widget, qtile

from constants import scripts_dir
from defaults.colors import colors


def spotify():
    return widget.Mpris2(
        name="spotify",
        fmt=" {}",
        objname="org.mpris.MediaPlayer2.spotify",
        display_metadata=["xesam:title", "xesam:artist"],
        scroll_chars=None,
        stop_pause_text="Paused",
        foreground=colors["widget"]["color"]["text"],
        background=colors["widget"]["bg"],
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(scripts_dir + "rofi/spotify-control")
        }
    )


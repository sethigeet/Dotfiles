from libqtile.config import Key
from libqtile.lazy import lazy

from constants import mod, terminal, scripts_dir

general_key_bindings = [
    # Launch the terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch the terminal"),

    # Show the run launcher
    Key([mod], "space", lazy.spawn("rofi -show drun"),
        desc="Show the run launcher"),

    # Show edit-config launcher
    Key([mod], "c", lazy.spawn(scripts_dir + "rofi/edit-config"),
        desc="Show the edit-config launcher"),

    # Show power menu
    Key([mod], "x", lazy.spawn(scripts_dir + "rofi/sysmenu"),
        desc="Show the power menu"),

    # Media keys
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%"),
        desc="Increase the volume by 10%"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%"),
        desc="Decrease the volume by 10%"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        desc="Mutes the sound"),

    # Restart qtile
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    # Kill qtile
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
]

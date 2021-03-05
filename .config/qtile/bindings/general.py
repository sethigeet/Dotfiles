from libqtile.config import Key
from libqtile.lazy import lazy

from constants import mod, terminal

general_key_bindings = [
    # Launch the terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch the terminal"),

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

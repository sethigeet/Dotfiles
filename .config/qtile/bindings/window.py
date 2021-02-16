from libqtile.config import Key
from libqtile.lazy import lazy

from constants import mod

window_key_bindings = [
    # Switch focus between windows
    Key([mod], "h", lazy.layout.left(),
        desc="Move focus to the left window"),
    Key([mod], "j", lazy.layout.down(),
        desc="Move focus to the down window"),
    Key([mod], "k", lazy.layout.up(),
        desc="Move focus to the up window"),
    Key([mod], "l", lazy.layout.right(),
        desc="Move focus to the right window"),

    # Move windows
    Key([mod, "control"], "h", lazy.layout.shuffle_left(),
        desc="Move window left"),
    Key([mod, "control"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "control"], "k", lazy.layout.shuffle_up(),
        desc="Move window up"),
    Key([mod, "control"], "l", lazy.layout.shuffle_right(),
        desc="Move window right"),

    # Change the size of the windows
    Key([mod, "shift"], "h", lazy.layout.grow_left(), lazy.layout.shrink(),
        desc="Increase the size of the windows in the left direction"),
    Key([mod, "shift"], "j", lazy.layout.grow_down(), lazy.layout.shrink(),
        desc="Increase the size of the windows in the down direction"),
    Key([mod, "shift"], "k", lazy.layout.grow_up(),  lazy.layout.grow(),
        desc="Increase the size of the windows in the up direction"),
    Key([mod, "shift"], "l", lazy.layout.grow_right(), lazy.layout.grow(),
        desc="Increase the size of the windows in the right direction"),

    # Toggle the spilt between the windows
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between vertical and horizontal splits"),

    # Toggle between different layouts
    Key([mod, "control"], "Return", lazy.next_layout(),
        desc="Toggle between layouts"),

    # Toggle maximized
    Key([mod], "f", lazy.window.toggle_maximize(),
        desc="Toggle fullscreen"),

    # Toggle minimized
    Key([mod], "m", lazy.window.toggle_minimize(),
        desc="Toggle fullscreen"),

    # Toggle floating
    Key([mod, "shift"], "f", lazy.window.toggle_floating(),
        desc="Toggle floating"),

    # Kill the focused window
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
]

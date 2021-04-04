from libqtile.config import Key
from libqtile.lazy import lazy

from constants import mod

window_key_bindings = [
    # Toggle the spilt between the windows
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between vertical and horizontal splits"),

    # Toggle between different layouts
    Key([mod, "control"], "Return", lazy.next_layout(),
        desc="Toggle between layouts"),

    # Toggle maximized
    Key([mod], "f", lazy.window.toggle_maximize(),
        desc="Toggle maximized"),

    # Toggle fullscreen
    Key([mod, "control"], "f", lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen"),

    # Toggle minimized
    Key([mod], "m", lazy.window.toggle_minimize(),
        desc="Toggle minimized"),

    # Toggle floating
    Key([mod, "shift"], "f", lazy.window.toggle_floating(),
        desc="Toggle floating"),

    # Kill the focused window
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
]

# Add keybindings for left keys
for key in ["h", "Left"]:
    window_key_bindings.extend([
        # Switch focus between windows
        Key([mod], key, lazy.layout.left(),
            desc="Move focus to the left window"),

        # Move windows
        Key([mod, "control"], key, lazy.layout.shuffle_left(),
            desc="Move window left"),

        # Change the size of the windows
        Key([mod, "shift"], key, lazy.layout.grow_left(), lazy.layout.shrink(),
            desc="Increase the size of the windows in the left direction"),
    ])

# Add keybindings for down keys
for key in ["j", "Down"]:
    window_key_bindings.extend([
        # Switch focus between windows
        Key([mod], key, lazy.layout.down(),
            desc="Move focus to the down window"),

        # Move windows
        Key([mod, "control"], key, lazy.layout.shuffle_down(),
            desc="Move window down"),

        # Change the size of the windows
        Key([mod, "shift"], key, lazy.layout.grow_down(), lazy.layout.shrink(),
            desc="Increase the size of the windows in the down direction"),
    ])

# Add keybindings for up keys
for key in ["k", "Up"]:
    window_key_bindings.extend([
        # Switch focus between windows
        Key([mod], key, lazy.layout.up(),
            desc="Move focus to the up window"),

        # Move windows
        Key([mod, "control"], key, lazy.layout.shuffle_up(),
            desc="Move window up"),

        # Change the size of the windows
        Key([mod, "shift"], key, lazy.layout.grow_up(), lazy.layout.grow(),
            desc="Increase the size of the windows in the up direction"),
    ])

# Add keybindings for right keys
for key in ["l", "Right"]:
    window_key_bindings.extend([
        # Switch focus between windows
        Key([mod], key, lazy.layout.right(),
            desc="Move focus to the right window"),

        # Move windows
        Key([mod, "control"], key, lazy.layout.shuffle_right(),
            desc="Move window right"),

        # Change the size of the windows
        Key([mod, "shift"], key, lazy.layout.grow_right(), lazy.layout.grow(),
            desc="Increase the size of the windows in the right direction"),
    ])

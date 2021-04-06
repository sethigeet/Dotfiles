from libqtile.config import Key
from libqtile.lazy import lazy

from utils.display_kb import display_kb
from constants import mod, scripts_dir

scripts_key_bindings = [
    # Show the run launcher
    Key([mod], "space", lazy.spawn("rofi -show drun"),
        desc="Show the run launcher"),

    # Show the edit-config launcher
    Key([mod], "c", lazy.spawn(scripts_dir + "rofi/edit-config"),
        desc="Show the edit-config launcher"),

    # Show the power menu
    Key([mod], "x", lazy.spawn(scripts_dir + "rofi/power-menu"),
        desc="Show the power menu"),

    # Show the file browser
    Key([mod], "z", lazy.spawn(scripts_dir + "rofi/file-browser"),
        desc="Show the file browser"),

    # screenshot tool
    Key([mod], "p", lazy.spawn(scripts_dir + "rofi/screenshot"),
        desc="Run the screenshot launcher"),

    # clipboard tool
    Key([mod, "shift"], "v", lazy.spawn(scripts_dir + "rofi/clipboard"),
        desc="Run the clipboard manager"),

    # scripts runner
    Key([mod], "s", lazy.spawn(scripts_dir + "rofi/rofi-bang"),
        desc="Run the script to run any other script"),

    # scripts editor
    Key([mod, "shift"], "s", lazy.spawn(scripts_dir + "rofi/edit-script"),
        desc="Run the script to edit any other script"),

    # Display the keybindings
    Key([mod], "F1", lazy.function(display_kb),
        desc="Display all the keybindings"),

    # terminal file manager
    Key([mod], "v", lazy.spawn(scripts_dir + "misc/start-vifm"),
        desc="Run vifm"),
]

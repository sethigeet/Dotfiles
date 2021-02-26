from libqtile.config import Key
from libqtile.lazy import lazy

from constants import mod
from groups import group_names

group_key_bindings = [
    Key([mod], "backslash", lazy.screen.toggle_group(),
        desc="Switch to the last visited group"),
    Key([mod], "Tab", lazy.screen.next_group(),
        desc="Switch to the next group"),
    Key([mod, "shift"], "Tab", lazy.screen.prev_group(),
        desc="Switch to the previous group"),

    Key([mod], "t", lazy.group["scratchpad"].dropdown_toggle(
        "terminal"), desc="Toggle the scratchpad with the terminal"),
    Key([mod], "0", lazy.group["scratchpad"].dropdown_toggle(
        "emacs"), desc="Toggle the scratchpad with emacs"),
]

for i, item in enumerate(group_names, 1):
    name = item[0]

    # Switch to another group
    group_key_bindings.append(
        Key([mod], str(i), lazy.group[name].toscreen(), desc=f"Switch to group {i}"))

    # Send the focused window to another group
    group_key_bindings.append(Key([mod, "shift"], str(i), lazy.window.togroup(
        name), desc=f"Move focused window to group {i}"))

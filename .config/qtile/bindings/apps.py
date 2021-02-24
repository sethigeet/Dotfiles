from libqtile.config import Key
from libqtile.lazy import lazy

from constants import mod, terminal

apps_key_bindings = [
    # alsa mixer
    Key([mod], "a", lazy.spawn([terminal, "-e", "alsamixer"]),
        desc="Run alsamixer"),

    # bpytop
    Key([mod], "b", lazy.spawn([terminal, "-e", "bpytop"]),
        desc="Run bpytop"),

    # graphical file manager
    Key([mod], "e", lazy.spawn("nautilus"),
        desc="Run nautilus"),

    # terminal file manager
    Key([mod], "v", lazy.spawn([terminal, "-e", "vifm"]),
        desc="Run vifm"),

    # code editor
    Key([mod, "shift"], "e", lazy.spawn("code"),
        desc="Run VS Code"),

    # terminal file manager
    Key([mod], "w", lazy.spawn("brave"),
        desc="Run the Brave Browser"),
]

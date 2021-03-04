from libqtile.config import Key
from libqtile.lazy import lazy

from constants import mod, terminal, home_dir

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
    Key([mod], "v", lazy.spawn([terminal, "-e", "zsh", "-c", f'source <(awk \'NR!=1\' {home_dir}/.zshrc); {home_dir}/.config/vifm/scripts/vifmrun']),
        desc="Run vifm"),

    # code editor
    Key([mod, "shift"], "e", lazy.spawn("code"),
        desc="Run VS Code"),

    # terminal file manager
    Key([mod], "w", lazy.spawn("brave"),
        desc="Run the Brave Browser"),
]

from libqtile.config import Key
from libqtile.lazy import lazy

from constants import mod

general_key_bindings = [
    # Restart qtile
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    # Kill qtile
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
]

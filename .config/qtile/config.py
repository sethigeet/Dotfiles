from libqtile import hook
import subprocess

import constants
from bindings import key_bindings, mouse_bindings
from groups import groups_defn
from layouts import layouts_defn, floating_layout_defn
from defaults import defaults
from screens import screens_defn

# * DEFINE SOME CONSTANTS *
mod = constants.mod
terminal = constants.terminal

# * DEFINE THE KEYBINDINGS *
keys = key_bindings

# * DEFINE THE GROUPS *
groups = groups_defn

# * DEFINE THE LAYOUTS *
layouts = layouts_defn

# * DEFINE THE SCREENS *
screens = screens_defn

# * DEFINE SOME MOUSE ACTIONS *
mouse = mouse_bindings

# * DEFINE THE DEFAULT SETTINGS FOR WIDGETS AND EXTENIONS *
widget_defaults = defaults["widget_defaults"]
extension_defaults = defaults["extension_defaults"]

# * DEFINE SOME SETTINGS *
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "LG3D"  # ! Required by some Java UI toolkits

# * DEFINE THE SETTINGS FOR THE FLOATING LAYOUT *
floating_layout = floating_layout_defn


# * CALL THE AUTOSTART SCRIPT *
@hook.subscribe.startup_once
def start_once():
    subprocess.call([constants.scripts_dir + "wm/autostart"])

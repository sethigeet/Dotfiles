from .window import window_key_bindings
from .group import group_key_bindings
from .general import general_key_bindings
from .mouse import mouse

key_bindings = []

# Add the window keybindings
key_bindings.extend(window_key_bindings)

# Add the group keybindings
key_bindings.extend(group_key_bindings)

# Add the general keybindings
key_bindings.extend(general_key_bindings)

mouse_bindings = mouse

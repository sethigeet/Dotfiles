import re

from constants import scripts_dir


def display_kb(qtile):
    # Get all the keybindings
    key_bindings = qtile.cmd_display_kb().split("\n")

    # Get all the headings
    seperators = re.split(r" {3}", key_bindings[1].strip())

    # Get the length of all the columns
    keySym_lenght = len(seperators[0]) + 3
    mod_lenght = len(seperators[1]) + 3
    command_lenght = len(seperators[2]) + 3
    desc_lenght = len(seperators[3])

    # Get the range of all the columns
    keySym_range = (0, keySym_lenght)
    mod_range = (keySym_range[1], keySym_range[1] + mod_lenght)
    command_range = (mod_range[1], mod_range[1] + command_lenght)
    desc_range = (command_range[1], command_range[1] + desc_lenght)

    # Filter out the empty lines from the keybindings
    key_bindings = [kb for kb in filter(lambda item: item != "", key_bindings)]

    # Format the keybindings for rofi
    kbs_for_rofi = ""
    for key_binding in key_bindings[2:]:
        keySym = key_binding[keySym_range[0]:keySym_range[1]].strip()
        keySym = keySym.replace("Tab", "\uf811")
        keySym = keySym.replace("Return", "\uf810")
        keySym = keySym.replace("backslash", "\\")
        keySym = keySym.upper()

        mod = key_binding[mod_range[0]:mod_range[1]
                          ].strip()
        for key in ["shift", "control"]:
            for modKey in ["mod4", "mod1"]:
                mod = mod.replace(f"{key}, {modKey}", f"{modKey} + {key}")
        mod = mod.replace("mod4", "\ue70f")
        mod = mod.replace("mod1", "Alt")
        mod = mod.replace("shift", "\ufb35")
        mod = mod.replace("control", "\ufb33")

        # command = key_binding[command_range[0]:command_range[1]].strip()
        desc = key_binding[desc_range[0]:desc_range[1]].strip()

        kb_for_rofi = ""

        if mod != "":
            kb_for_rofi = f"{mod} + {keySym}"
        else:
            kb_for_rofi = f"{keySym}"

        while len(kb_for_rofi) <= keySym_lenght:
            kb_for_rofi += " "

        kb_for_rofi += f"{desc}\n"

        kbs_for_rofi += kb_for_rofi

    # Open the formatted keybindings in rofi
    qtile.cmd_spawn([scripts_dir + "rofi/display-kb", kbs_for_rofi])

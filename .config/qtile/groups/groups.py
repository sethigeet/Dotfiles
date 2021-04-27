from libqtile.config import Group, ScratchPad, DropDown

from constants import terminal

from .group_names import group_names

groups = [Group(name, **kwargs) for name, kwargs in group_names]

def get_center_coordinates(width, height=None):
    centered_coordinate = 1 / 2

    actual_height = width
    if (height):
        actual_height = height

    return {
        "width": width,
        "height": actual_height,
        "x": centered_coordinate - (width / 2),
        "y": centered_coordinate - (actual_height / 2),
    }


groups.append(
    ScratchPad("scratchpad", [
        DropDown("terminal", f"{terminal}",
                 opacity=0.95, width=0.9, x=0.05, y=0.01),
        DropDown("emacs", "emacs",
                 opacity=0.95, **get_center_coordinates(3/4)),
        DropDown("calculator", "gnome-calculator",
                 opacity=1, **get_center_coordinates(1/3)),
    ])
)

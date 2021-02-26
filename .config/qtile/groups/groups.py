from libqtile.config import Group, ScratchPad, DropDown

from constants import terminal

from .group_names import group_names

groups = [Group(name, **kwargs) for name, kwargs in group_names]

groups.append(
    ScratchPad("scratchpad", [
        DropDown("terminal", f"{terminal}",
                 opacity=0.95, width=0.9, x=0.05, y=0.01),
        DropDown("emacs", "emacs",
                 opacity=0.95, height=0.75, width=0.75, x=0.125, y=0.125),
    ])
)

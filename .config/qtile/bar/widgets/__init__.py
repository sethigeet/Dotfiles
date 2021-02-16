from .clock import clock
from .current_layout import current_layout, current_layout_icon
from .group_box import groupBox
from .logo import logo
from .net import net
from .seperator import seperator
from .systray import systray
from .text_box_seperator import textBoxSeperator
from .volume import volume
from .window_name import windowName
from .spacer import spacer
from .power_menu import power_menu

widgets = [
    logo(),
    groupBox(),
    spacer(),
    windowName(),
    spacer(),
    net(),
    textBoxSeperator(),
    volume(),
    textBoxSeperator(),
    current_layout_icon(),
    current_layout(),
    textBoxSeperator(),
    clock(),
    textBoxSeperator(),
    power_menu(),
    textBoxSeperator(),
    seperator(),
    systray()
]

from .clock import clock
from .current_layout import current_layout, current_layout_icon
from .group_box import group_box
from .logo import logo
from .net import net
from .seperator import seperator
from .systray import systray
from .text_box_seperator import text_box_seperator
from .volume import volume
from .window_name import window_name
from .spacer import spacer
from .power_menu import power_menu
from .spotify import spotify

widgets = [
    logo(),
    group_box(),
    spacer(),
    window_name(),
    spacer(),
    spotify(),
    text_box_seperator(),
    net(),
    text_box_seperator(),
    volume(),
    text_box_seperator(),
    current_layout_icon(),
    current_layout(),
    text_box_seperator(),
    clock(),
    text_box_seperator(),
    power_menu(),
    text_box_seperator(),
    seperator(),
    systray(),
    seperator()
]

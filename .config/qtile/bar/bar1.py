from libqtile import bar
from .widgets import widgets

bar1 = bar.Bar(
    widgets=widgets,
    size=28,
    margin=[0, 5, 0, 5],  # N E S W
)

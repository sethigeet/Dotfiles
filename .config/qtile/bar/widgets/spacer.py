from libqtile import widget, bar

from defaults.colors import colors


def spacer():
    return widget.Spacer(
        length=bar.STRETCH,
        background=colors["widget"]["bg"]
    )

from libqtile import widget

from defaults.colors import colors


# Make a custom volume widget to show icons with percentage
class Volume(widget.Volume):
    def _update_drawer(self):
        if self.volume <= 0:
            self.text = "0%  ﱝ"
        elif self.volume <= 30:
            self.text = f"{self.volume}% 奄"
        elif self.volume < 50:
            self.text = f"{self.volume}% 奔"
        elif self.volume < 80:
            self.text = f"{self.volume}% 墳"
        elif self.volume >= 80:
            self.text = f"{self.volume}% "


def volume():
    return Volume(
        foreground=colors["widget"]["color"]["text"],
        background=colors["widget"]["bg"],
        padding=5,
        fontsize=15
    )

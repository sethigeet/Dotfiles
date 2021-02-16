from libqtile import widget

from defaults.colors import colors


class WindowName(widget.WindowName):
    def update(self, *args):
        if self.for_current_screen:
            w = self.qtile.current_screen.group.current_window
        else:
            w = self.bar.screen.group.current_window
        state = ''
        if w:
            if w.maximized:
                state = ' '
            elif w.minimized:
                state = ' '
            elif w.floating:
                state = ' '
            var = {}
            var["state"] = state
            var["name"] = w.name
            var["class"] = w.window.get_wm_class()[0] if len(
                w.window.get_wm_class()) > 0 else ""
            text = self.format.format(**var)
            unescaped = self.truncate(text)
        else:
            unescaped = self.empty_group_string
        self.text = unescaped
        self.bar.draw()


def windowName():
    return WindowName(
        foreground=colors["panel"]["windowName"],
        background=colors["panel"]["bg"],
        padding=0,
        fontsize=16
    )

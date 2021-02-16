from libqtile import widget

from defaults.colors import colors


def group_box():
    return widget.GroupBox(
        fontsize=16,
        padding_x=5,
        borderwidth=3,
        active=colors["group"]["color"]["active"],
        inactive=colors["group"]["color"]["inactive"],
        urgent_text=colors["group"]["urgent"],
        urgent_alert_method="text",
        rounded=False,
        highlight_color=colors["group"]["bg"],
        highlight_method="line",
        this_current_screen_border=colors["group"]["highlight"],
        background=colors["panel"]["bg"],
    )

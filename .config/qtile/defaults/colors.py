primary = "#7AA2F7"
danger = "#F7768E"
success = "#9ECE6A"
bg = "#1A1B26"
altText = "#9C9C9C"
text = "#FFFFFF"
dark_gray = "#5F676A"
light_gray = "#757575"

colors = {
    "window": {
        "border": {
            "active": primary,
            "inactive": dark_gray,
        },
    },

    "panel": {
        "bg": bg,
        "color": text,
        "windowName": text,
    },

    "group": {
        "bg": bg,
        "highlight": primary,
        "urgent": danger,
        "color": {
            "active": text,
            "inactive": altText,
        }
    },

    "widget": {
        "color": {
            "seperator": light_gray,
            "text": text,
        },
        "bg": bg,
        "accentBg": primary
    },
}

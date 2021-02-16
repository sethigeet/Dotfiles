primary = "FFCC66"
danger = "E53935"
success = "43A047"
bg = "1F2430"
altText = "9C9C9C"
text = "FFFFFF"
dark_gray = "5F676A"
light_gray = "757575"

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

local define_augroups = require("general.functions")

define_augroups({
    Lightbulb = {
        {
            "CursorHold,CursorHoldI", "*",
            'lua require("nvim-lightbulb").update_lightbulb()'
        }
    }
})

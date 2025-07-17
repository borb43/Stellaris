-- register placeholder atlas
SMODS.Atlas {
    key = "placeholder",
    path = "placeholder.png",
    px = 71,
    py = 95
}

SMODS.Rarity = {
    key = "stellar",
    loc_txt = {
        name = "Stellar"
    },
    badge_color = HEX("1f0d35"),
    default_weight = 0,
    get_weight = function(self, weight, object_type)
        return weight
    end
}
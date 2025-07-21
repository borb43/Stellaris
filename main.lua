--register mod icon
SMODS.Atlas({
    key = "modicon",
    path = "modicon.png",
    px = 32,
    py = 32
})
-- register all other atlases
SMODS.Atlas {
    key = "placeholder",
    path = "placeholder.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "common",
    path = "common.png",
    px = 71,
    py = 95
}

-- register custom rarities
SMODS.Rarity {
    key = "stellar",
    badge_color = HEX("1f0d35"),
    default_weight = 0,
    get_weight = function(self, weight, object_type)
        return weight
    end
}


--loads everything
assert(SMODS.load_file("items/common.lua"))()
assert(SMODS.load_file("items/uncommon.lua"))()
assert(SMODS.load_file("items/rare.lua"))()
assert(SMODS.load_file("items/legendary.lua"))()
assert(SMODS.load_file("items/spectral.lua"))()
assert(SMODS.load_file("items/wonder.lua"))()
assert(SMODS.load_file("items/booster.lua"))()
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
SMODS.Atlas {
    key = "spectral",
    path = "spectral.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "modifiers",
    path = "modifiers.png",
    px = 71,
    py = 95
}

--load optional features
SMODS.current_mod.optional_features = {
    post_trigger = true,
}

--loads everything
assert(SMODS.load_file("items/common.lua"))()
assert(SMODS.load_file("items/uncommon.lua"))()
assert(SMODS.load_file("items/rare.lua"))()
assert(SMODS.load_file("items/legendary.lua"))()
assert(SMODS.load_file("items/modifiers.lua"))()
assert(SMODS.load_file("items/spectral.lua"))()
assert(SMODS.load_file("items/wonder.lua"))()
assert(SMODS.load_file("items/booster.lua"))()
assert(SMODS.load_file("items/stellar.lua"))()
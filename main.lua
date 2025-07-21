--prepare for adding custom colours
loc_colour()
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

--for the HEX function, first 6 characters are RGB values, can add 2 more at the end for opacity
--define and load custom text colours
G.C.PINK = HEX("eb90e8")
--define colours in loc_colours
G.ARGS.LOC_COLOURS["pink"] = G.C.PINK

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
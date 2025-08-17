--jokers
assert(SMODS.load_file("items/common.lua"))()
assert(SMODS.load_file("items/uncommon.lua"))()
assert(SMODS.load_file("items/rare.lua"))()
assert(SMODS.load_file("items/legendary.lua"))()
--card modifiers, might split into seperate files in the future
--consumables
assert(SMODS.load_file("items/spectral.lua"))()
--misc content
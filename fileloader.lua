--important pre-content stuff
assert(SMODS.load_file("lib/funcs.lua"))() --loads functions
assert(SMODS.load_file("lib/game_globals.lua"))() --game globals resetting stuff
assert(SMODS.load_file("lib/pos_blinds.lua"))()
--jokers
assert(SMODS.load_file("items/common.lua"))()
assert(SMODS.load_file("items/uncommon.lua"))()
assert(SMODS.load_file("items/rare.lua"))()
assert(SMODS.load_file("items/legendary.lua"))()
--card modifiers, might split into seperate files in the future
assert(SMODS.load_file("items/modifier.lua"))()
--consumables
assert(SMODS.load_file("items/spectral.lua"))()
--misc content
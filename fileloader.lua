--important pre-content stuff
assert(SMODS.load_file("lib/funcs.lua"))() --loads functions
assert(SMODS.load_file("lib/game_globals.lua"))() --game globals resetting stuff
--jokers
assert(SMODS.load_file("items/joker/common.lua"))()
assert(SMODS.load_file("items/joker/uncommon.lua"))()
assert(SMODS.load_file("items/joker/rare.lua"))()
assert(SMODS.load_file("items/joker/legendary.lua"))()
assert(SMODS.load_file("items/joker/stellar.lua"))
--card modifiers, might split into seperate files in the future
assert(SMODS.load_file("items/modifier.lua"))()
--consumables
assert(SMODS.load_file("items/spectral.lua"))()
--misc content
assert(SMODS.load_file("items/blinds.lua"))()
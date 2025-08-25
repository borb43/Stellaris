---@diagnostic disable: duplicate-set-field
loc_colour() --required for adding colours

--for talisman compat
to_big = to_big or function(x) return x end

--mod globals table
STLR = {}

--for the HEX function, first 6 characters are RGB values, can add 2 more at the end for opacity
--define and load custom text colours, then add into loc_colours


--load optional features


--loading stuff
assert(SMODS.load_file("atlas.lua"))()      --loads atlases
assert(SMODS.load_file("fileloader.lua"))() --loads mod content files

loc_colour() --required for adding colours

--for talisman compat
to_big = to_big or function(x) return x end

--for the HEX function, first 6 characters are RGB values, can add 2 more at the end for opacity
--define and load custom text colours, then add into loc_colours
G.C.PINK = HEX("eb90e8")
G.ARGS.LOC_COLOURS["pink"] = G.C.PINK --for pink seals
G.C.CRIMSON = HEX("a52a2a")
G.ARGS.LOC_COLOURS["crimson"] = G.C.CRIMSON --for blind modifying stuff

--load optional features (none yet)

--loading stuff
assert(SMODS.load_file("atlas.lua"))() --loads atlases
assert(SMODS.load_file("fileloader.lua"))() --loads mod content files
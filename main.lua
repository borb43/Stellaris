--for talisman compat
to_big = to_big or function(x) return x end



--for the HEX function, first 6 characters are RGB values, can add 2 more at the end for opacity
--define and load custom text colours
G.C.PINK = HEX("eb90e8")
--define colours in loc_colours
G.ARGS.LOC_COLOURS["pink"] = G.C.PINK

--load optional features
SMODS.current_mod.optional_features = {
    post_trigger = true,
}

--loading stuff
assert(SMODS.load_file("atlas.lua"))() --loads atlases
assert(SMODS.load_file("fileloader.lua"))() --loads mod content files
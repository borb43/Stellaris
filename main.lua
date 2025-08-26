---@diagnostic disable: duplicate-set-field
loc_colour() --required for adding colours

--for talisman compat
to_big = to_big or function(x) return x end

--mod globals table
STLR = {}

--for the HEX function, first 6 characters are RGB values, can add 2 more at the end for opacity
--define and load custom text colours, then add into loc_colours
G.C.STLR_ETERNAL = HEX("c75985")
G.ARGS.LOC_COLOURS["stlr_eternal"] = G.C.STLR_ETERNAL

--load optional features
SMODS.current_mod.optional_features = {
    post_trigger = true
}

--loading stuff
assert(SMODS.load_file("atlas.lua"))()      --loads atlases
assert(SMODS.load_file("fileloader.lua"))() --loads mod content files

STLR.valid_returns = { --list of valid returns, used for singularity
        chips = { "chips", "h_chips", "chip_mod" },
        mult = { "mult", "h_mult", "mult_mod" },
        xchips = { "x_chips", "xchips", "Xchip_mod" },
        xmult = { "x_mult", "Xmult", "xmult", "x_mult_mod", "Xmult_mod" },
        dollars = { "p_dollars", "dollars", "h_dollars" },
    }
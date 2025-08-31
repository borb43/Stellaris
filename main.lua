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
G.C.STLR_DEEP_PURPLE = HEX("1a013b")

--load optional features
SMODS.current_mod.optional_features = {
    post_trigger = true
}

STLR.config = SMODS.current_mod.config

--loading stuff
assert(SMODS.load_file("atlas.lua"))() --loads atlases
assert(SMODS.load_file("fileloader.lua"))() --loads mod content files

STLR.valid_returns = { --list of valid returns, used for singularity
        chips = { "chips", "h_chips", "chip_mod" },
        mult = { "mult", "h_mult", "mult_mod" },
        xchips = { "x_chips", "xchips", "Xchip_mod" },
        xmult = { "x_mult", "Xmult", "xmult", "x_mult_mod", "Xmult_mod" },
        dollars = { "p_dollars", "dollars", "h_dollars" },
        balance = { "balance" },
        swap = { "swap" }
    }

STLR.playing_card_effects = {
    chips = { "bonus", "perma_bonus", "h_chips", "perma_h_chips" },
    mult = { "mult", "perma_mult", "h_mult", "perma_h_mult" },
    xchips = { "x_chips", "perma_x_chips", "h_x_chips", "perma_h_x_chips" },
    xmult = { "x_mult", "perma_x_mult", "h_x_mult", "perma_h_x_mult" },
    dollars = { "p_dollars", "perma_p_dollars", "h_dollars", "perma_h_dollars" }
}

SMODS.current_mod.calculate = function (self, context) --this tracks defeated bosses this run
    if context.end_of_round and G.GAME.blind:get_type() == "Boss" then
        G.GAME.stlr_superboss_flags[G.GAME.blind.config.blind.key] = true
    end
end

SMODS.Sound {
    key = "nuh_uh",
    path = "nuh_uh.ogg"
}
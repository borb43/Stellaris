local function reset_stlr_temple_card()
    G.GAME.current_round.stlr_temple_card = G.GAME.current_round.stlr_temple_card or { suit = "Spades" }
    local temple_suits = {}
    for k, v in ipairs({ "Spades", "Hearts", "Clubs", "Diamonds"}) do
        if v ~= G.GAME.current_round.stlr_temple_card then temple_suits[#temple_suits+1] = v end
    end
    local temple_card = pseudorandom_element(temple_suits, "stlr_temple" .. G.GAME.round_resets.ante)
    G.GAME.current_round.stlr_temple_card.suit = temple_card
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_stlr_temple_card()
end
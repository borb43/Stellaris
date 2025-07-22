--enhancements


--seals
SMODS.Seal { --pink seal, creates a wonder card if scored on first hand
    key = "pink",
    atlas = "modifiers",
    pos = { x = 0, y = 0 },
    discovered = true,
    badge_colour = G.C.PINK,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play and
        to_big(G.GAME.current_round.hands_played) <= 1 and to_big(#G.consumeables.cards + G.GAME.consumeable_buffer) < to_big(G.consumeables.config.card_limit) then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0,
                func = function()
                    SMODS.add_card( { set = "wonder" } )
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return {
                message = localize("k_plus_wonder"), colour = G.C.SET.wonder
            }
        end
    end
}

--editions
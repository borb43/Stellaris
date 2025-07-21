--enhancements


--seals
SMODS.Seal {
    key = "pink",
    atlas = "modifiers",
    pos = { x = 0, y = 0 },
    discovered = true,
    badge_colour = HEX("eb90b8"),
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card == card and
        G.GAME.current_round.hands_played == 0 and #G.consumables.cards + G.GAME.consumable_buffer < G.consumables.config.card_limit then
            G.GAME.consumable_buffer = G.GAME.consumable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0.0,
                func = function()
                    SMODS.add_card( { set = "wonder" } )
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
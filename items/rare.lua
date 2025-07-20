SMODS.Joker { --slappy hand, X1 mult for each card in your hand
    key = "slappyhand",
    config = { extra = { mult_per_card = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { math.max((((G.hand and G.hand.cards) and #G.hand.cards or 1) * card.ability.extra.mult_per_card) , 1), card.ability.extra.mult_per_card } }
    end,
    discovered = true,
    rarity = 3,
    atlas = "placeholder",
    pos = { x = 2, y = 0},
    blueprint_compat = true,
    cost = 8,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = math.max(#G.hand.cards*card.ability.extra.mult_per_card, 1)
            }
        end
    end
}
SMODS.Joker { --paint smear, gains x0.1 mult when a wild card is scored
    key = "paintsmear",
    config = { extra = { mult = 1, multgain = 0.1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return { vars = { card.ability.extra.mult, card.ability.extra.multgain } }
    end,
    discovered = true,
    rarity = 2,
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint
        and SMODS.has_enhancement(context.other_card, "m_wild") then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multgain
            return {
                message = localize { type = "variable", key = "a_xmult", vars = {card.ability.extra.mult} }
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.mult
            }
        end
    end
}
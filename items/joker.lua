SMODS.Joker {
    key = "silly",
    loc_txt = {
        name = "Silly Joker",
        text = {
            "{C:mult}+#1#{} Mult if played poker hand",
            "contains a {C:attention}Full House{}"
        }
    },
    config = { extra = { mult = 18 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    discovered = true,
    rarity = 1,
    atlas = "placeholder",
    pos = { x = 0, y = 0},
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hand[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

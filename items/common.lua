SMODS.Joker {
    key = "silly",
    config = { extra = { mult = 18, type = "Full House" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize( card.ability.extra.type, "poker_hands" ) } }
    end,
    discovered = true,
    rarity = 1,
    atlas = "placeholder",
    pos = { x = 0, y = 0},
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {
    key = "dubious",
    config = { extra = { chips = 140, type = "Full House" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, localize( card.ability.extra.type, "poker_hands" ) } }
    end,
    discovered = true,
    rarity = 1,
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
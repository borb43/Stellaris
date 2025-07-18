SMODS.Joker {
    key = "silly",
    loc_txt = {
        name = "Silly Joker",
        text = {
            "{C:mult}+#1#{} Mult if played poker hand",
            "contains a {C:attention}Full House{}"
        }
    },
    config = { extra = { mult = 18, type = "Full House" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.type } }
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
    loc_txt = {
        name = "Dubious Joker",
        text = {
            "{C:chips}+#1#{} Chips if played poker hand",
            "contains a {C:attention}Full House{}"
        }
    },
    config = { extra = { chips = 140, type = "Full House" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.type } }
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
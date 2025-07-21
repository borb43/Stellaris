SMODS.Joker { --silly joker, +18 mult if hand contains a full house
    key = "silly",
    config = { extra = { mult = 18, type = "Full House" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize( card.ability.extra.type, "poker_hands" ) } }
    end,
    discovered = true,
    rarity = 1,
    atlas = "common",
    pos = { x = 0, y = 0},
    blueprint_compat = true,
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {  --dubious joker, +140 chips if hand contains a full house
    key = "dubious",
    config = { extra = { chips = 140, type = "Full House" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, localize( card.ability.extra.type, "poker_hands" ) } }
    end,
    discovered = true,
    rarity = 1,
    atlas = "common",
    pos = { x = 1, y = 0 },
    blueprint_compat = true,
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker { --algebra albert, X1.1 mult when ace/face cards are scored
    key = "algebra",
    config = { extra = { mult = 1.1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    discovered = true,
    rarity = 1,
    atlas = "common",
    pos = { x = 2, y = 0 },
    blueprint_compat = true,
    cost = 4,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        (context.other_card:is_face() or context.other_card:get_id() == 14 ) then
            return {
                xmult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {
    key = "scales",
    config = { extra = { oddsboost = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.oddsboost, card.ability.oddsboost + 1, card.ability.oddsboost + 3 } }
    end,
    discovered = true,
    rarity = 1,
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    cost = 5,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator + 1,
                denominator = context.denominator + 1
            }
        end
    end
}
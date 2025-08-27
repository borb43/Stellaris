SMODS.Joker { --beanstalk, X1 mult for each card in your hand
    key = "beanstalk",
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
--[[ scrapped, most likely won't return
SMODS.Joker { --hypercoin, sets probabilities to 1 in 3. like hypercube but coin so 3 sides
    key = "hypercoin",
    config = { extra = { fixnum = 1, fixdenom = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fixnum, card.ability.extra.fixdenom } }
    end,
    discovered = true,
    rarity = 3,
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    cost = 9,
    calculate = function(self, card, context)
        if context.fix_probability and not context.blueprint then
            return {
                numerator = card.ability.extra.fixnum,
                denominator = card.ability.extra.fixdenom
            }
        end
    end
}
]]
SMODS.Joker { --singularity, eats other jokers and their effects
    key = "singularity",
    config = { extra = { chips = 0, mult = 0, xchips = 1, xmult = 1, dollars = 0 }},
    loc_vars = function (self, info_queue, card)
        if next(SMODS.find_mod("Talisman")) or next(SMODS.find_mod("Cryptlib")) then 
            info_queue[#info_queue+1] = { set = "Other", key = "i_hate_numberslop" }
        end
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xchips, card.ability.extra.xmult, card.ability.extra.dollars}}
    end,
    discovered = true,
    rarity = 3,
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    cost = 10,
    calculate = function (self, card, context)
        if context.post_trigger and not (context.other_card == card) then
            local other_ret = context.other_ret.jokers
            if STLR.get_return("chips", other_ret) ~= 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("chips", other_ret)
                })
            end
            if STLR.get_return("mult", other_ret) ~= 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("mult", other_ret)
                })
            end
            if STLR.get_return("xchips", other_ret) ~= 1 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xchips",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("xchips", other_ret)
                })
            end
            if STLR.get_return("xmult", other_ret) ~= 1 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("xmult", other_ret)
                })
            end
            if STLR.get_return("dollars", other_ret) ~= 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "dollars",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("dollars", other_ret)
                })
            end
            if STLR.get_return("balance", other_ret) then
                card.ability.extra.chips, card.ability.extra.mult = STLR.balance_vars(card.ability.extra.chips, card.ability.extra.mult)
                card.ability.extra.xchips, card.ability.extra.xmult = STLR.balance_vars(card.ability.extra.xchips, card.ability.extra.xmult)
                SMODS.calculate_effect({ message = localize("k_balanced"), colour = G.C.PURPLE }, card)
            end
            if STLR.get_return("swap", other_ret) then
                card.ability.extra.chips, card.ability.extra.mult = STLR.swap_vars(card.ability.extra.chips, card.ability.extra.mult)
                card.ability.extra.xchips, card.ability.extra.xmult = STLR.swap_vars(card.ability.extra.xchips, card.ability.extra.xmult)
                SMODS.calculate_effect({message = localize("k_swapped_ex")}, card)
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                xmult = card.ability.extra.xmult,
                xchips = card.ability.extra.xchips
            }
        end
    end,
    calc_dollar_bonus = function (self, card)
        if to_big(card.ability.extra.dollars) > to_big(0) then
            return card.ability.extra.dollars
        end
    end
}
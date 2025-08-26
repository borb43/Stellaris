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
            local other_ret = context.other_ret.jokers or {}
            local upgraded = false --true if the joker got stricly upgraded
            local did_stuff = false --true if anything happened at all
            for _, key in ipairs(STLR.valid_returns.chips) do
                if other_ret[key] then upgraded = true end
                card.ability.extra.chips = card.ability.extra.chips + (other_ret[key] or 0)
            end
            for _, key in ipairs(STLR.valid_returns.mult) do
                if other_ret[key] then upgraded = true end
                card.ability.extra.mult = card.ability.extra.mult + (other_ret[key] or 0)
            end
            for _, key in ipairs(STLR.valid_returns.xchips) do
                if other_ret[key] then upgraded = true end
                card.ability.extra.xchips = card.ability.extra.xchips + (other_ret[key] or 0)
            end
            for _, key in ipairs(STLR.valid_returns.xmult) do
                if other_ret[key] then upgraded = true end
                card.ability.extra.xmult = card.ability.extra.xmult + (other_ret[key] or 0)
            end
            for _, key in ipairs(STLR.valid_returns.dollars) do
                if other_ret[key] then upgraded = true end
                card.ability.extra.dollars = card.ability.extra.dollars + (other_ret[key] or 0)
            end
            if other_ret.balance then
                local new_add = (card.ability.extra.chips + card.ability.extra.mult)/2
                local new_mult = (card.ability.extra.xchips + card.ability.extra.xmult)/2
                card.ability.extra.chips = new_add; card.ability.extra.mult = new_add
                card.ability.extra.xchips = new_mult; card.ability.extra.xmult = new_mult
                SMODS.calculate_effect({ message = "k_balanced", colour = G.C.PURPLE }, card)
                did_stuff = true
            end
            if other_ret.swap then
                local old_chips = card.ability.extra.chips
                local old_mult = card.ability.extra.mult
                card.ability.extra.chips = old_mult; card.ability.extra.mult = old_chips
                local old_xchips = card.ability.extra.xchips
                local old_xmult = card.ability.extra.xmult
                card.ability.extra.xchips = old_xmult; card.ability.extra.xmult = old_xchips
                SMODS.calculate_effect({ message = "k_swapped_ex" }, card)
                did_stuff = true
            end
            if did_stuff or upgraded then
                G.E_MANAGER:add_event(Event({
                    context.other_card:start_dissolve()
                }))
            end
            if upgraded then
                return { message = "k_upgrade_ex" }
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
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
    config = { extra = { chips = 0, mult = 0, xchips = 1, xmult = 1, dollars = 0 }, future_events = { to_destroy = {}, dollars = 0 }},
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
        if context.post_trigger and context.other_card ~= card and not SMODS.is_eternal(context.other_card, card) then
            local other_ret = context.other_ret.jokers
            local did_stuff = false
            if STLR.get_return("chips", other_ret) ~= 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("chips", other_ret)
                })
                did_stuff = true
            end
            if STLR.get_return("mult", other_ret) ~= 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("mult", other_ret)
                })
                did_stuff = true
            end
            if STLR.get_return("xchips", other_ret) ~= 1 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xchips",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("xchips", other_ret)
                })
                did_stuff = true
            end
            if STLR.get_return("xmult", other_ret) ~= 1 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("xmult", other_ret)
                })
                did_stuff = true
            end
            if STLR.get_return("dollars", other_ret) ~= 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "dollars",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("dollars", other_ret)
                })
                did_stuff = true
            end
            if STLR.get_return("balance", other_ret) then
                card.ability.extra.chips, card.ability.extra.mult = STLR.balance_vars(card.ability.extra.chips, card.ability.extra.mult)
                card.ability.extra.xchips, card.ability.extra.xmult = STLR.balance_vars(card.ability.extra.xchips, card.ability.extra.xmult)
                SMODS.calculate_effect({ message = localize("k_balanced"), colour = G.C.PURPLE }, card)
                did_stuff = true
            end
            if STLR.get_return("swap", other_ret) then
                card.ability.extra.chips, card.ability.extra.mult = STLR.swap_vars(card.ability.extra.chips, card.ability.extra.mult)
                card.ability.extra.xchips, card.ability.extra.xmult = STLR.swap_vars(card.ability.extra.xchips, card.ability.extra.xmult)
                SMODS.calculate_effect({message = localize("k_swapped_ex")}, card)
                did_stuff = true
            end
            if did_stuff then
                context.other_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        G.GAME.joker_buffer = 0
                        card:juice_up(0.8, 0.8)
                        context.other_card:start_dissolve(G.C.STLR_DEEP_PURPLE)
                        return true
                    end
                }))
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
        if context.end_of_round and context.main_eval and context.game_over == false then
            for _, joker in G.jokers.cards do
                if joker.calculate_dollar_bonus and joker ~= card and to_big(joker:calculate_dollar_bonus()) > to_big(0) and not SMODS.is_eternal(joker, card) then
                    card.ability.future_events.dollars = card.ability.future_events.dollars + joker:calculate_dollar_bonus()
                    card.ability.future_events.to_destroy[#card.ability.future_events.to_destroy+1] = joker
                end
            end
        end
        if context.starting_shop and #card.ability.future_events.to_destroy > 0 then
            G.E_MANAGER:add_event(Event({
                func = function ()
                    local first_dissolve = nil
                    for i = 1, #card.ability.future_events.to_destroy do
                        if card.ability.future_events.to_destroy[i] ~= card and not SMODS.is_eternal(card.ability.future_events.to_destroy[i], card) then
                            card.ability.future_events.to_destroy[i]:start_dissolve(G.C.STLR_DEEP_PURPLE, first_dissolve)
                            first_dissolve = true
                        end
                    end
                    card.ability.future_events.to_destroy = {}
                    return true
                end
            }))
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_table = card.ability.future_events,
                scalar_value = "dollars"
            })
            card.ability.future_events.dollars = 0
        end
    end,
    calc_dollar_bonus = function (self, card)
        if to_big(card.ability.extra.dollars) > to_big(0) then
            return card.ability.extra.dollars
        end
    end
}

STLR.singularity_calc_lines = 112 --this is for spaghetti
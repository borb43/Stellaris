SMODS.Joker { --R key, sets ante to 1 when sold
    key = "rkey",
    config = { extra = { set_ante = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.set_ante } }
    end,
    discovered = true,
    rarity = 4,
    atlas = "placeholder",
    pos = { x = 3, y = 0 },
    soul_pos = { x = 4, y = 0 },
    blueprint_compat = true,
    eternal_compat = false,
    cost = 20,
    calculate = function(self, card, context)
        if context.selling_self then
            local ante_change = -G.GAME.round_resets.ante + card.ability.extra.set_ante
            ease_ante(ante_change)
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = card.ability.extra.set_ante
            if G.GAME.banned_keys and not G.GAME.banned_keys[card.config.center.key] and not context.blueprint then
                G.GAME.banned_keys[card.config.center.key] = true
            elseif context.blueprint and (G.GAME.banned_keys and not G.GAME.banned_keys[context.blueprint_card.config.center.key]) then
                G.GAME.banned_keys[context.blueprint_card.config.center.key] = true
            end
            return {
                message = localize("k_stlr_resetante")
            }
        end
    end
}

SMODS.Joker { --57-leaf clover, scales probabilities with scored clubs
    key = "clover",
    config = { extra = { oddsboost = 0, oddsgain = 0.1, suit = "Clubs" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.oddsboost, card.ability.extra.oddsgain, localize(card.ability.extra.suit, "suits_singular"), card.ability.extra.oddsboost + 1 } }
    end,
    discovered = true,
    rarity = 4,
    atlas = "placeholder",
    pos = { x = 3, y = 0 },
    soul_pos = { x = 4, y = 0 },
    perishable_compat = false,
    cost = 20,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint and
            context.other_card:is_suit(card.ability.extra.suit) then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "oddsboost",
                scalar_value = "oddsgain",
                scaling_message = {
                    message_key = "k_upgrade_ex",
                    colour = G.C.GREEN
                }
            })
        end
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator + card.ability.extra.oddsboost
            }
        end
    end
}

SMODS.Joker { --singularity, eats other jokers/enhanced cards and their effects
    key = "singularity",
    config = { extra = { chips = 0, mult = 0, xchips = 1, xmult = 1, dollars = 0, retrigger = 0 },
        immutable = { dollars = 0, chips = 0, mult = 0, xchips = 0, xmult = 0, retrigger = 0 },
        to_destroy = {} },
    loc_vars = function(self, info_queue, card)
        if next(SMODS.find_mod("Talisman")) or next(SMODS.find_mod("Cryptlib")) then
            info_queue[#info_queue + 1] = { set = "Other", key = "i_hate_numberslop" }
        end
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xchips, card.ability.extra.xmult, card.ability.extra.dollars } }
    end,
    discovered = true,
    rarity = 4,
    atlas = "placeholder",
    pos = { x = 3, y = 0 },
    soul_pos = { x = 4, y = 0 },
    cost = 10,
    calculate = function(self, card, context)
        if context.post_trigger and context.other_card ~= card and not SMODS.is_eternal(context.other_card, card) and not context.blueprint then
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
                card.ability.extra.chips, card.ability.extra.mult = STLR.balance_vars(card.ability.extra.chips,
                    card.ability.extra.mult)
                card.ability.extra.xchips, card.ability.extra.xmult = STLR.balance_vars(card.ability.extra.xchips,
                    card.ability.extra.xmult)
                SMODS.calculate_effect({ message = localize("k_balanced"), colour = G.C.PURPLE }, card)
                did_stuff = true
            end
            if STLR.get_return("swap", other_ret) then
                card.ability.extra.chips, card.ability.extra.mult = STLR.swap_vars(card.ability.extra.chips,
                    card.ability.extra.mult)
                card.ability.extra.xchips, card.ability.extra.xmult = STLR.swap_vars(card.ability.extra.xchips,
                    card.ability.extra.xmult)
                SMODS.calculate_effect({ message = localize("k_swapped_ex") }, card)
                did_stuff = true
            end
            if did_stuff then
                context.other_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
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
        if context.end_of_round and context.main_eval and context.game_over == false and not context.blueprint then
            for _, joker in G.jokers.cards do
                if joker.calculate_dollar_bonus and joker ~= card and to_big(joker:calculate_dollar_bonus()) > to_big(0) and not SMODS.is_eternal(joker, card) then
                    card.ability.immutable.dollars = card.ability.immutable.dollars +
                        joker:calculate_dollar_bonus()
                    card.ability.to_destroy[#card.ability.to_destroy + 1] = joker
                end
            end
        end
        if context.starting_shop and #card.ability.to_destroy > 0 and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local first_dissolve = nil
                    for i = 1, #card.ability.to_destroy do
                        if card.ability.to_destroy[i] ~= card and not SMODS.is_eternal(card.ability.to_destroy[i], card) then
                            card.ability.to_destroy[i]:start_dissolve(G.C.STLR_DEEP_PURPLE, first_dissolve)
                            first_dissolve = true
                        end
                    end
                    card.ability.to_destroy = {}
                    return true
                end
            }))
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_table = card.ability.immutable,
                scalar_value = "dollars"
            })
            card.ability.immutable.dollars = 0
        end
        if context.destroy_card and not context.blueprint then
            if next(SMODS.get_enhancements(context.destroy_card)) and not context.destroy_card.debuff and not context.destroy_card.vampired then
                local chips = context.destroy_card:get_chip_bonus() + context.destroy_card:get_chip_h_bonus()
                local mult = context.destroy_card:get_chip_mult() + context.destroy_card:get_chip_h_mult()
                local xchips = context.destroy_card:get_chip_x_bonus() * context.destroy_card:get_chip_h_x_bonus()
                local xmult = context.destroy_card:get_chip_h_x_mult() * context.destroy_card:get_chip_x_mult()
                local dollars = context.destroy_card:get_h_dollars() + context.destroy_card:get_p_dollars()
                local retriggers = context.destroy_card.ability.perma_repetitions or 0
                if chips ~= 0 then
                    card.ability.immutable.chips = chips
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "chips",
                        scalar_table = card.ability.immutable,
                        scalar_value = "chips"
                    })
                end
                if mult ~= 0 then
                    card.ability.immutable.mult = mult
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "mult",
                        scalar_table = card.ability.immutable,
                        scalar_value = "mult"
                    })
                end
                if xchips ~= 1 then
                    card.ability.immutable.xchips = xchips
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xchips",
                        scalar_table = card.ability.immutable,
                        scalar_value = "xchips"
                    })
                end
                if xmult ~= 1 then
                    card.ability.immutable.xmult = xmult
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_table = card.ability.immutable,
                        scalar_value = "xmult"
                    })
                end
                if dollars ~= 0 then
                    card.ability.immutable.dollars = dollars
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "dollars",
                        scalar_table = card.ability.immutable,
                        scalar_value = "dollars"
                    })
                end
                if retriggers ~= 0 then
                    card.ability.immutable.retrigger = retriggers
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "retrigger",
                        scalar_table = card.ability.immutable,
                        scalar_value = "retrigger"
                    })
                end
                for val, _ in pairs(card.ability.immutable) do
                    card.ability.immutable[val] = 0
                end
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        if to_big(card.ability.extra.dollars) > to_big(0) then
            return card.ability.extra.dollars
        end
    end
}

STLR.singularity_calc_lines = 184 --this is for spaghetti

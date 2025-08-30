SMODS.Gradient {
    key = "stellar_badge",
    colours = {
        HEX("100D35"),
        HEX("350D0D")
    }
}

SMODS.Rarity {
    key = "stellar",
    badge_colour = SMODS.Gradients.stlr_stellar_badge,
    default_weight = 0
}


SMODS.Joker { --singularity, eats other jokers/enhanced cards and their effects
    key = "singularity",
    config = { extra = { chips = 0, mult = 0, xchips = 1, xmult = 1, dollars = 0 },
        immutable = { dollars = 0 },
        to_destroy = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xchips, card.ability.extra.xmult, card.ability.extra.dollars } }
    end,
    rarity = "stlr_stellar",
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    cost = 40,
    calculate = function(self, card, context)
        if context.post_trigger and context.other_card ~= card and not SMODS.is_eternal(context.other_card, card) and not context.blueprint then
            local other_ret = context.other_ret.jokers
            local did_stuff = false
            if STLR.get_return("chips", other_ret, 0) ~= 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("chips", other_ret)
                })
                did_stuff = true
            end
            if STLR.get_return("mult", other_ret, 0) ~= 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("mult", other_ret)
                })
                did_stuff = true
            end
            if STLR.get_return("xchips", other_ret, 1) ~= 1 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xchips",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("xchips", other_ret)
                })
                did_stuff = true
            end
            if STLR.get_return("xmult", other_ret, 1) ~= 1 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("xmult", other_ret)
                })
                did_stuff = true
            end
            if STLR.get_return("dollars", other_ret, 0) ~= 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "dollars",
                    scalar_table = other_ret,
                    scalar_value = STLR.get_return_name("dollars", other_ret)
                })
                did_stuff = true
            end
            if STLR.get_return("balance", other_ret, false) then
                card.ability.extra.chips, card.ability.extra.mult = STLR.balance_vars(card.ability.extra.chips,
                    card.ability.extra.mult)
                card.ability.extra.xchips, card.ability.extra.xmult = STLR.balance_vars(card.ability.extra.xchips,
                    card.ability.extra.xmult)
                SMODS.calculate_effect({ message = localize("k_balanced"), colour = G.C.PURPLE }, card)
                did_stuff = true
            end
            if STLR.get_return("swap", other_ret, false) then
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
    end,
    calc_dollar_bonus = function(self, card)
        if to_big(card.ability.extra.dollars) > to_big(0) then
            return card.ability.extra.dollars
        end
    end
}

STLR.singularity_calc_lines = 112 --this is for spaghetti

SMODS.Joker {                     --multiplicare, gains Xmult when a joker gives +mult (i love cryptid parodies)
    key = "multiplicare",
    config = { extra = { xmult = 1, gain = 0.3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain } }
    end,
    rarity = "stlr_stellar",
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    cost = 40,
    calculate = function(self, card, context)
        if context.post_trigger then
            local other_ret = context.other_ret.jokers
            if STLR.get_return("mult", other_ret, 0) >= 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_value = "gain",
                    message_key = "a_xmult"
                })
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker {
    key = "collector",
    rarity = "stlr_stellar",
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    cost = 40,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind:get_type() == "Boss" then
            local blind_key = G.GAME.blind.config.blind.key
            if STLR.boss_jokers[blind_key] and G.P_CENTERS[STLR.boss_jokers[blind_key]] then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({
                            key = STLR.boss_jokers[blind_key],
                            edition = 'e_negative',
                            stickers = { 'eternal' }
                        })
                    end
                }))
            elseif next(SMODS.find_mod("aikoyorisshenanigans")) and STLR.blind_is_special_akyrs(G.GAME.blind.effect) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = 'Joker',
                            edition = 'e_negative',
                            rarity = 'Rare'
                        }
                    end
                }))
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = 'Joker',
                            edition = 'e_negative'
                        }
                    end
                }))
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        if next(SMODS.find_mod("aikoyorisshenanigans")) then
            info_queue[#info_queue + 1] = { set = "Other", key = "collector_word_blind_notice" }
        end
    end
}

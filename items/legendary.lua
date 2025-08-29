SMODS.Joker { --R key, sets ante to 1 when sold
    key = "rkey",
    config = { extra = { set_ante = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.set_ante } }
    end,
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

SMODS.Joker {
    key = "temple",
    rarity = 4,
    atlas = "placeholder",
    pos = { x = 3, y = 0},
    soul_pos = { x = 4, y = 0 },
    cost = 20,
    config = { extra = { current_effect = "chips" },
        effect_amounts = { chips = 30, mult = 7, xchips = 0.1, xmult = 0.1 },
        effect_names = { chips = "Chips", mult = "Mult", xchips = "Chips", xmult = "Mult" },
        effect_list = { "chips", "mult", "xchips", "xmult" }
    },
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.stlr_temple_card or {}).suit or "Spades"
        local background_colour
        local text_colour
        if card.ability.current_effect == "xchips" then
            background_colour = G.C.CHIPS
        elseif card.ability.current_effect == "xmult" then
            background_colour = G.C.MULT
        else
            background_colour = G.C.CLEAR
        end
        if card.ability.current_effect == "xchips" or card.ability.current_effect == "xmult" then
            text_colour = G.C.WHITE
        elseif card.ability.current_effect == "chips" then
            text_colour = G.C.BLUE
        elseif card.ability.current_effect == "mult" then
            text_colour = G.C.RED
        else
            text_colour = G.C.UI.TEXT_DARK
        end
        return {
            vars = { card.ability.effect_amounts[card.ability.current_effect],
                card.ability.effect_names[card.ability.current_effect],
                localize(suit, "suits_singular"),
                ((card.ability.current_effect == "xchips" or card.ability.current_effect == "xmult") and "X") or "+"
            },
            colours = {
                G.C.SUITS[suit],
                background_colour,
                text_colour
            }
        }
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.current_effect = pseudorandom_element(card.ability.effect_list, "stlr_temple"..G.GAME.round_resets.ante)
    end,
    calculate = function (self, card, context)
        if context.individual and context.other_card:is_suit(G.GAME.current_round.stlr_temple_card, false) then
            local msg_col
            if card.ability.extra.current_effect == "chips" then
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.effect_amounts.chips
                msg_col = G.C.CHIPS
            elseif card.ability.extra.current_effect == "mult" then
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.effect_amounts.mult
                msg_col = G.C.MULT
            elseif card.ability.extra.current_effect == "xchips" then
                context.other_card.ability.perma_x_chips = context.other_card.ability.perma_x_chips + card.ability.effect_amounts.xchips
                msg_col = G.C.CHIPS
            elseif card.ability.extra.current_effect == "xmult" then
                context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.effect_amounts.xmult
                msg_col = G.C.MULT
            end
            return {
                message = localize("k_upgrade_ex"),
                colour = msg_col
            }
        end
        if context.end_of_round and context.main_eval then
            card.ability.extra.current_effect = pseudorandom_element(card.ability.effect_list, "stlr_temple"..G.GAME.round_resets.ante)
            return {
                message = localize("k_reset"),
                colour = G.C.FILTER
            }
        end
    end
}

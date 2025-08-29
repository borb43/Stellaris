STLR.pos_blind_actives = { --positive blind effects for a future stellar. localization for infoqueues is under <blind key>.._pos
    bl_arm = function(card, context)
        if context.end_of_round and G.GAME.last_hand_played then
            level_up_hand(card, G.GAME.last_hand_played)
        end
    end,
    bl_club = function(card, context) 
        if context.individual and context.other_card:is_suit("Clubs") then
            SMODS.calculate_effect({
                mult = 12
            }, card)
        end
    end,
    bl_eye = function(card, context)
        if context.joker_main and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round <= 1 then
            SMODS.calculate_effect({
                xchips = 2,
                xmult = 2
            }, card)
        end
    end,
    bl_final_acorn = function(card, context) --come back to this later, theres probably a better effect
        if context.ante_change and context.ante_end then
            for i = 1, #G.jokers.cards do
                local joker = G.jokers.cards[i]
                for sticker, _ in pairs(SMODS.Stickers) do
                    SMODS.Stickers[sticker]:apply(joker, nil)
                end
            end
        end
    end,
    --cerluean bell is passive only
    bl_final_heart = function(card, context)
        if context.debuff_cards then
            SMODS.calculate_effect({
                prevent_debuff = true
            }, card)
        end
    end,
    bl_final_leaf = function(card, context)
        if context.repetition then
            SMODS.calculate_effect({
                repetitions = 1
            }, card)
        end
    end
}

STLR.enable_pos_blind_passives = { --passive positive blind effects for a future stellar. should be called for the blind when its effect is enabled and in add_to_deck
    bl_final_bell = function()
        SMODS.change_play_limit(1)
        SMODS.change_discard_limit(1)
    end
}

STLR.disable_pos_blind_passives = { --for disabling passive positive blind effects. should all be called in its remove_from_deck
    bl_final_bell = function()
        SMODS.change_play_limit(-1)
        SMODS.change_discard_limit(-1)
    end
}
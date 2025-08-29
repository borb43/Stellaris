STLR.pos_blind_actives = { --positive blind effects for a future stellar. localization for infoqueues is under <blind key>.._pos
    --#region vanilla
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
        if context.ante_change and context.ante_end and not context.blueprint then
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
        if context.debuff_cards and not context.blueprint then
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
    end,
    bl_final_vessel = function(card, context)
        if context.joker_main then
            SMODS.calculate_effect({
                xmult = 3
            }, card)
        end
    end,
    --fish is passive only
    bl_flint = function(card, context)
        if context.setting_blind and not context.blueprint then
            G.GAME.blind.chips = G.GAME.blind.chips * 0.75
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.HUD_blind:recalculate()
        end
    end,
    bl_goad = function(card, context)
        if context.individual and context.other_card:is_suit("Spades") then
            SMODS.calculate_effect({
                chips = 75
            }, card)
        end
    end,
    bl_head = function(card, context)
        if context.individual and context.other_card:is_suit("Hearts") then
            SMODS.calculate_effect({
                xmult = 1.5
            }, card)
        end
    end,
    --hook is passive only
    bl_house = function(card, context)
        if context.stay_flipped and not context.blueprint then
            SMODS.calculate_effect({
                stay_flipped = false
            }, card)
        end
    end,
    --manacle is passive only
    bl_mark = function(card, context)
        if context.repetition and context.other_card:is_face() then
            SMODS.calculate_effect({
                repetitions = 1
            }, card)
        end
    end,
    bl_mouth = function(card, context)
        if context.joker_main and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
            SMODS.calculate_effect({
                xchips = 2,
                xmult = 2
            }, card)
        end
    end,
    --needle is passive only
    bl_ox = function(card, context)
        if context.press_play then
            local _handname, _played = 'High Card', -1
            for hand_key, hand in pairs(G.GAME.hands) do
                if hand.played > _played then
                    _played = hand.played
                    _handname = hand_key
                end
            end
            if context.scoring_name == _handname then
                ease_dollars(8)
            end
        end
    end,
    bl_pillar = function(card, context)
        if context.repetition and context.other_card.ability.played_this_ante then
            SMODS.calculate_effect({
                repetitions = 1
            }, card)
        end
    end,
    bl_plant = function(card, context)
        if context.individual and context.other_card:is_face() then
            SMODS.calculate_effect({
                xmult = 2
            }, card)
        end
    end
    --#endregion
}

STLR.enable_pos_blind_passives = { --passive positive blind effects for a future stellar. should be called for the blind when its effect is enabled and in add_to_deck
    --#region vanilla
    bl_final_bell = function()
        SMODS.change_play_limit(1)
        SMODS.change_discard_limit(1)
    end,
    bl_fish = function()
        SMODS.change_play_limit(1)
    end,
    bl_hook = function()
        SMODS.change_discard_limit(1)
    end,
    bl_manacle = function()
        G.hand:change_size(1)
    end,
    bl_needle = function()
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
        ease_hands_played(1)
    end
    --#endregion
}

STLR.disable_pos_blind_passives = { --for disabling passive positive blind effects. should all be called in its remove_from_deck
    --#region vanilla
    bl_final_bell = function()
        SMODS.change_play_limit(-1)
        SMODS.change_discard_limit(-1)
    end,
    bl_fish = function()
        SMODS.change_play_limit(-1)
    end,
    bl_hook = function()
        SMODS.change_discard_limit(-1)
    end,
    bl_manacle = function()
        G.hand:change_size(-1)
    end,
    bl_needle = function()
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
        ease_hands_played(-1)
    end
    --#endregion
}


SMODS.Blind {
    key = "superboss_acorn",
    atlas = "blinds",
    pos = { x = 0, y = 2 },
    dollars = 12,
    debuff = {
        stlr_no_disable = true,
        stlr_no_reroll = true
    },
    boss = {
        min = 12
    },
    mult = 3,
    boss_colour = SMODS.Gradients.stlr_stellaris,
    calculate = function(self, blind, context)
        if context.press_play then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if #G.jokers.cards > 1 then G.jokers:shuffle("stlr") end
                    if #G.hand.cards > 1 then G.hand:shuffle("stlr") end
                    if #G.play.cards > 1 then G.play:shuffle("stlr") end
                    if #G.consumeables.cards > 1 then G.play:shuffle("stlr") end
                    play_sound("cardSlide1", 1)
                    return true
                end
            }))
        end
        if context.stay_flipped then
            return {
                stay_flipped = true
            }
        end
    end,
    set_blind = function(self)
        for _, card in ipairs(G.jokers.cards) do
            card:flip()
        end
        for _, card in ipairs(G.consumeables.cards) do
            card:flip()
        end
    end,
    defeat = function (self)
        for _, card in ipairs(G.jokers.cards) do
            card:flip()
        end
        for _, card in ipairs(G.consumeables.cards) do
            card:flip()
        end
    end,
    in_pool = function(self)
        return G.GAME.stlr_superboss_flags and G.GAME.stlr_superboss_flags.bl_final_acorn
    end
}

SMODS.Blind {
    key = "superboss_bell",
    atlas = "blinds",
    pos = { x = 0, y = 1 },
    dollars = 12,
    debuff = {
        stlr_no_disable = true,
        stlr_no_reroll = true
    },
    boss = {
        min = 12
    },
    mult = 3,
    boss_colour = SMODS.Gradients.stlr_stellaris,
    set_blind = function (self)
        SMODS.change_discard_limit(-2)
        SMODS.change_play_limit(-2)
    end,
    defeat = function (self)
        SMODS.change_discard_limit(2)
        SMODS.change_play_limit(2)
    end,
    in_pool = function (self)
        return G.GAME.stlr_superboss_flags and G.GAME.stlr_superboss_flags.bl_final_bell
    end
}

SMODS.Blind {
    key = "superboss_heart",
    atlas = "blinds",
    pos = { x = 0, y = 0 },
    dollars = 12,
    debuff = {
        stlr_no_disable = true,
        stlr_no_reroll = true
    },
    boss = {
        min = 12
    },
    mult = 3,
    boss_colour = SMODS.Gradients.stlr_stellaris,
    calculate = function (self, blind, context)
        if context.press_play and G.jokers.cards[1] then blind.prepped = true end
        if ((context.hand_drawn and blind.prepped) or context.first_hand_drawn) and G.jokers.cards[1] then
            local options = {}
            for i = 1, #G.jokers.cards do
                if not (G.jokers.cards[i].perma_debuff or G.jokers.cards[i].ability.perish_tally <= 0 ) then
                    options[#options+1] = G.jokers.cards[i]
                end
            end
            if #options > 0 then
                local target = pseudorandom_element(options, "stlr_super_heart") or G.jokers.cards[1]
                target.perma_debuff = true
                target:juice_up()
                blind:wiggle()
            end
            blind.prepped = nil
        end
    end,
    in_pool = function (self)
        return G.GAME.stlr_superboss_flags and G.GAME.stlr_superboss_flags.bl_final_heart
    end
}

SMODS.Blind {
    key = "superboss_leaf",
    atlas = "blinds",
    pos = { x = 0, y = 3 },
    dollars = 12,
    debuff = {
        stlr_no_disable = true,
        stlr_no_reroll = true
    },
    boss = {
        min = 12
    },
    mult = 3,
    boss_colour = SMODS.Gradients.stlr_stellaris,
    calculate = function (self, blind, context)
        if context.before and context.main_eval then
            for _, card in ipairs(context.full_hand) do
                card.vampired = true
                card:set_ability("c_base", nil, true)
                card:set_seal()
                card:set_edition("e_base")
                for _, sticker in SMODS.Stickers do
                    if card.ability[sticker] then card.ability[sticker] = nil end
                end
                card.ability.perma_bonus = 0; card.ability.perma_h_chips = 0
                card.ability.perma_mult = 0; card.ability.perma_h_mult = 0
                card.ability.perma_x_chips = 1; card.ability.perma_h_x_chips = 1
                card.ability.perma_x_mult = 1; card.ability.perma_h_x_mult = 1
                card.ability.perma_p_dollars = 0; card.ability.perma_h_dollars = 0
                card.ability.perma_repetitions = 0
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        card:juice_up()
                        card.vampired = nil
                        return true
                    end
                }))
            end
        end
        if context.debuff_card and context.debuff_card.area ~= G.jokers then
            return {
                debuff = true
            }
        end
    end,
    in_pool = function (self)
        return G.GAME.stlr_superboss_flags and G.GAME.stlr_superboss_flags.bl_final_leaf
    end
}
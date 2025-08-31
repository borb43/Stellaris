
SMODS.Blind {
    key = "superboss_acorn",
    atlas = "blinds",
    pos = { x = 0, y = 2 },
    dollars = 12,
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
    boss = {
        min = 12
    },
    mult = 3,
    boss_colour = SMODS.Gradients.stlr_stellaris,
    
}
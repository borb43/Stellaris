--superbosses (THESE STILL NEED SPRITES)
SMODS.Blind {
    key = "superboss_acorn",
    dollars = 12,
    boss = {
        showdown = true
    },
    debuff = {
        stlr_evil = true
    },
    mult = 3,
    boss_colour = SMODS.Gradients.stlr_stellaris,
    calculate = function(self, blind, context)
        if context.press_play then
            for _, card in ipairs(G.hand) do
                if SMODS.pseudorandom_probability(self, "stlr_super_acorn", 1, 2, "stlr_super_acorn", true) then
                    card:flip()
                end
            end
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
        if context.stay_flipped and SMODS.pseudorandom_probability(self, "stlr_super_acorn", 1, 2, "stlr_super_acorn", true) then
            return {
                stay_flipped = true
            }
        end
    end,
    set_blind = function(self)
        for _, card in ipairs(G.jokers.cards) do
            if card.facing == "front" then
                card:flip()
            end
        end
        for _, card in ipairs(G.hand.cards) do
            card:flip()
        end
        for _, card in ipairs(G.consumeables.cards) do
            card:flip()
        end
    end,
    in_pool = function (self)
        return false
    end
}

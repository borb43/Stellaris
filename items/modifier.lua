SMODS.Seal {
    key = "dice",
    atlas = "modifiers",
    pos = { x = 0, y = 0 },
    config = { extra = { mod = 3 } },
    badge_colour = G.C.GREEN,
    loc_vars = function (self, info_queue, card)
        return { vars = { self.config.extra.mod } }
    end,
    calculate = function (self, card, context)
        if context.mod_probability then
            local prev_context = SMODS.get_previous_context()
            if (prev_context and prev_context.other_card == card) or context.trigger_obj == card then
                return {
                    numerator = context.numerator * card.ability.seal.extra.mod
                }
            end
        end
    end
}
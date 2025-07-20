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
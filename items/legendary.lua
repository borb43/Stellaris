SMODS.Joker {
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
    blueprint_compat = false
}
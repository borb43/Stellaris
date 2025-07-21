SMODS.ConsumableType {
    key = "stlr_wonder",
    primary_colour = HEX("ffa3f8"),
    secondary_colour = HEX("ff69f1"),
    collection_rows = { 6, 6 },
    default = "c_stlr_dreamwheel",
    shop_rate = 0.0,
}

SMODS.Consumable {
    key = "dreamwheel",
    discovered = true,
    set = "stlr_wonder",
    atlas = "placeholder",
    pos = { x = 3, y = 3 },
    cost = 4,
    use = function(self, card, area, copier)
        local valid_targets = SMODS.Edition:get_edition_cards(G.jokers, true)
        local editions = {}
        for _, ed in pairs(G.P_CENTER_POOLS["Edition"]) do
            if not G.GAME.banned_keys[ed.key] then
                editions[#editions+1] = ed.key
            end
        end
        local target = pseudorandom_element(valid_targets, "dreamwheel")
        local target_edition = pseudorandom_element(editions, "dreamwheel")
        target:set_edition(target_edition, true)
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end
}
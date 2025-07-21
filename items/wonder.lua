SMODS.ConsumableType {
    key = "wonder",
    primary_colour = HEX("ffa3f8"),
    secondary_colour = HEX("ff69f1"),
    collection_rows = { 6, 6 },
    default = "c_stlr_dreamwheel",
}

SMODS.Consumable { --wheel of dreams, applies a random edition
    key = "dreamwheel",
    discovered = true,
    set = "wonder",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
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
        card:juice_up(0.3, 0.5)
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end
}

SMODS.Consumable { --sage, creates an editioned uncommon
    key = "sage",
    discovered = true,
    set = "wonder",
    atlas = "placeholder",
    pos = { x = 3, y = 2 },
    cost = 4,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger =  "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                SMODS.add_card({ set = "Joker", rarity = "Uncommon", edition = poll_edition(edition_generic, nil , nil, true )})
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
    end
}
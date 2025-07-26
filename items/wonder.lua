SMODS.ConsumableType {
    key = "wonder",
    primary_colour = HEX("ffa3f8"),
    secondary_colour = HEX("ff69f1"),
    collection_rows = { 6, 6 },
    default = "c_stlr_dreamwheel",
}

SMODS.Consumable { --stellaris, applies negative to all jokers (soul equivalent of wonder cards)
    key = "stellarstar",
    set = "Spectral",
    loc_vars =  function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
    end,
    atlas = "spectral",
    pos = { x = 0, y = 0 },
    hidden = true,
    soul_set = "wonder",
    soul_pos = { x = 1, y = 0 },
    cost = 4,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.15,
            func = function()
                for i = 1, #G.jokers.cards do
                    local next_card = G.jokers.cards[i]
                    next_card:set_edition( { negative = true } )
                end
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return to_big(#G.jokers.cards) > to_big(0)
    end
}

SMODS.Consumable { --wheel of dreams, applies a random edition to a random joker
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
---@diagnostic disable-next-line: need-check-nil
        target:set_edition(target_edition, true)
        card:juice_up(0.3, 0.5)
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
    loc_vars = function(self, info_queue, card)
        for _, ed in pairs(G.P_CENTER_POOLS["Edition"]) do
            if not G.GAME.banned_keys[ed.key] then
                info_queue[#info_queue+1] = ed
            end
        end
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
        return to_big(#G.jokers.cards) < to_big(G.jokers.config.card_limit) or card.area == G.jokers
    end
}

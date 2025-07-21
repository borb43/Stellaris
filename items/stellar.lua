SMODS.Rarity {
    key = "stellar",
    badge_color = HEX("1f0d35"),
    default_weight = 0,
    get_weight = function(self, weight, object_type)
        return weight
    end
}

SMODS.Consumable {
    key = "stellarstar",
    set = "Spectral",
    atlas = "spectral",
    pos = { x = 0, y = 0 },
    hidden = true,
    soul_set = "wonder",
    soul_pos = { x = 1, y = 0 },
    cost = 4,
    can_use = function(self, card)
        local eternal_count = 0
        for _, joker in pairs(G.jokers.cards) do
            if SMODS.is_eternal(joker, card) then eternal_count = eternal_count + 1 end
        end
        return G.jokers and eternal_count < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        local deletable_jokers = {}
        for _, joker in pairs(G.jokers.cards) do
            if SMODS.is_eternal(joker, card) then
                deletable_jokers[#deletable_jokers+1] = joker
            end
        end
        local _first_dissolve = nil
        G.E_MANAGER:add_event(Event({
            trigger = "before",
            delay = 0.75,
            func = function()
                for _, joker in pairs(deletable_jokers) do
                    joker:start_dissolve(nil, _first_dissolve)
                    _first_dissolve = true
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                SMODS.add_card( { set = "Joker", rarity = "stlr_stellar" } )
                card:juice_up(0.3, 0.5)
            end
        }))
    end
}